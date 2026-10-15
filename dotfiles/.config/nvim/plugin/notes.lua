---------------
--- General ---
---------------

--- Local aliases ---

local api = vim.api
local fn = vim.fn
local fs = vim.fs
local list_extend = vim.list_extend
local log = vim.log
local map = vim.keymap.set
local startswith = vim.startswith
local trim = vim.trim
local uv = vim.uv

--- Log levels ---

local ERROR = log.levels.ERROR
local WARN = log.levels.WARN

--- Notes directory ---

local notes_dir = vim.env.NOTES_DIR

if not notes_dir or notes_dir == "" then
  notes_dir = "~/Documents/Notes"
end

notes_dir = fs.normalize(notes_dir)
notes_dir = fs.normalize(fs.abspath(notes_dir), { expand_env = false })

local notes_dir_prefix = notes_dir:gsub("/$", "") .. "/"

---------------
--- Helpers ---
---------------

--- Notifications ---

local function fail(message)
  error(message, 0)
end

local function notify(message, level)
  vim.notify(message, level or log.levels.INFO, { title = "Notes" })
end

local function with_error_notification(callback)
  return function(...)
    local ok, err = pcall(callback, ...)

    if not ok then
      notify(tostring(err), ERROR)
    end
  end
end

--- Files ---

local function open_file(path)
  local stat, err, code = uv.fs_stat(path)

  if not stat and code ~= "ENOENT" then
    fail(err)
  end

  if stat and stat.type ~= "file" then
    fail("Note is not a regular file: " .. path)
  end

  local buf = fn.bufnr(path)

  if buf ~= -1 and api.nvim_buf_is_loaded(buf) and api.nvim_buf_get_name(buf) == path then
    api.nvim_set_current_buf(buf)
  else
    fn.mkdir(fs.dirname(path), "p")
    api.nvim_cmd({ cmd = "edit", args = { path }, magic = { file = false, bar = false } }, {})
  end

  -- Missing on disk; the buffer may already contain unsaved text.
  return stat == nil
end

local function is_within_notes_dir(path)
  return path == notes_dir or startswith(path, notes_dir_prefix)
end

local function resolve_note_path(relative_path)
  relative_path = trim(relative_path)

  if relative_path == "" then
    fail("Note path cannot be empty")
  end

  if relative_path:match("^[/\\]") or relative_path:match("^%a:") then
    fail("Note path must be relative to the notes directory")
  end

  if relative_path:match("[/\\]$") then
    fail("Note path must include a filename")
  end

  local path = fs.normalize(fs.joinpath(notes_dir, relative_path), { expand_env = false })

  if path == notes_dir or not is_within_notes_dir(path) then
    fail("Note path escapes notes directory: " .. relative_path)
  end

  return fs.ext(path) == "" and (path .. ".md") or path
end

--- Dates ---

local function iso_weekday(wday)
  -- Monday=1 ... Sunday=7
  return ((wday + 5) % 7) + 1
end

local function current_iso_week()
  local date = os.date("*t")

  -- Thursday determines the ISO year.
  date = os.date("*t", os.time({
    day = date.day + 4 - iso_weekday(date.wday),
    hour = 12,
    month = date.month,
    year = date.year
  }))

  return string.format("%04d-W%02d", date.year, math.floor((date.yday - 1) / 7) + 1)
end

---------------
--- Actions ---
---------------

--- Notes ---

local function complete_note_path(arglead)
  local dir, prefix = arglead:match("^(.*)/([^/]*)$")

  dir, prefix = dir or "", prefix or arglead

  local path = fs.normalize(fs.joinpath(notes_dir, dir), { expand_env = false })

  if not is_within_notes_dir(path) then
    return {}
  end

  local scan = uv.fs_scandir(path)

  if not scan then
    return {}
  end

  local matches = {}

  while true do
    local name, kind = uv.fs_scandir_next(scan)

    if not name then
      break
    end

    if startswith(name, prefix) then
      matches[#matches + 1] = (dir == "" and "" or dir .. "/") .. name .. (kind == "directory" and "/" or "")
    end
  end

  table.sort(matches)

  return matches
end

local function open_note(relative_path)
  open_file(resolve_note_path(relative_path))
end

local function open_weekly_note()
  local week = current_iso_week()
  local path = fs.joinpath(notes_dir, "weekly", week .. ".md")
  local missing_on_disk = open_file(path)
  local lines = api.nvim_buf_get_lines(0, 0, -1, false)

  if not missing_on_disk or vim.bo.modified or #lines ~= 1 or lines[1] ~= "" then
    -- Preserve existing files and unsaved buffer contents.
    return
  end

  lines = fn.readfile(fs.joinpath(notes_dir, ".templates", "weekly.md"))

  for i, line in ipairs(lines) do
    lines[i] = line:gsub("{{iso_week}}", week)
  end

  api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

local function show_pending_tasks()
  vim.cmd([[silent vimgrep /^\s*-\s\+\[ \]/gj ]] .. fn.fnameescape(notes_dir) .. "/**/*.md")
  vim.cmd("copen")
end

--- Markdown ---

local function complete_current_task()
  local buf = api.nvim_get_current_buf()
  local cursor_row = api.nvim_win_get_cursor(0)[1]
  local lines = api.nvim_buf_get_lines(buf, 0, -1, false)

  local completed_task_line
  local completed_tasks
  local pending_tasks = {}
  local replacement_lines = { "## Tasks", "" }
  local section_end_row = #lines + 1
  local section_start_row

  for i, line in ipairs(lines) do
    if not section_start_row then
      if line == "## Tasks" then
        section_start_row = i
      end
    elseif line:match("^##?%s") or line:match("^##?$") then
      section_end_row = i
      break
    elseif line == "### Completed" and not completed_tasks then
      completed_tasks = {}
    elseif line:find("%S") then
      local pattern = completed_tasks and "^%-%s+%[[xX]%]%s+%S" or "^%-%s+%[ %]%s+%S"

      if not line:match(pattern) then
        notify("Keep only flat tasks and blank lines in ## Tasks / ### Completed", WARN)
        return
      end

      if i == cursor_row and not completed_tasks then
        completed_task_line = line:gsub("^(%-%s+)%[ %]", "%1[x]", 1):gsub("%s+$", "") .. " (completed: " .. os.date("%Y-%m-%d") .. ")"
      else
        local list = completed_tasks or pending_tasks

        list[#list + 1] = line
      end
    end
  end

  if not section_start_row or not completed_tasks or not completed_task_line then
    notify("Complete an unchecked task before ### Completed inside ## Tasks", WARN)
    return
  end

  completed_tasks[#completed_tasks + 1] = completed_task_line

  list_extend(replacement_lines, pending_tasks)

  if #pending_tasks > 0 then
    replacement_lines[#replacement_lines + 1] = ""
  end

  list_extend(replacement_lines, { "### Completed", "" })
  list_extend(replacement_lines, completed_tasks)

  local completed_task_row = section_start_row + #replacement_lines - 1

  if section_end_row <= #lines then
    replacement_lines[#replacement_lines + 1] = ""
  end

  api.nvim_buf_set_lines(buf, section_start_row - 1, section_end_row - 1, false, replacement_lines)
  api.nvim_win_set_cursor(0, { completed_task_row, 0 })
end

local function toggle_today_habit()
  local line = api.nvim_get_current_line()
  local cursor_row = api.nvim_win_get_cursor(0)[1]

  local cells_start, cells = line:match("^.*:%s*()([-X]%s+[-X]%s+[-X]%s+[-X]%s+[-X]%s+[-X]%s+[-X]%s*)$")

  if not cells then
    notify("Current line is not a valid seven-day habit row", WARN)
    return
  end

  local day, today = 0, iso_weekday(os.date("*t").wday)

  for offset, marker in cells:gmatch("()([-X])") do
    day = day + 1

    if day == today then
      -- Lua positions to API byte offsets.
      local col = cells_start + offset - 2

      api.nvim_buf_set_text(0, cursor_row - 1, col, cursor_row - 1, col + 1, { marker == "X" and "-" or "X" })
      return
    end
  end
end

----------------
--- Commands ---
----------------

local open_note_or_notify = with_error_notification(open_note)

api.nvim_create_user_command("Note", function(opts)
  if opts.args ~= "" then
    open_note_or_notify(opts.args)
    return
  end

  vim.ui.input({ prompt = "Note path: " }, function(relative_path)
    if relative_path and trim(relative_path) ~= "" then
      open_note_or_notify(relative_path)
    end
  end)
end, {
  nargs = "?",
  complete = complete_note_path,
  desc = "Open or create a note"
})

api.nvim_create_user_command("NoteTasks", with_error_notification(show_pending_tasks), { desc = "Show all unfinished tasks" })
api.nvim_create_user_command("NoteWeekly", with_error_notification(open_weekly_note), { desc = "Open the current weekly note" })

--------------------
--- Key bindings ---
--------------------

map("n", "<leader>nn", "<cmd>Note<cr>", { desc = "Notes: open/create note" })
map("n", "<leader>nw", "<cmd>NoteWeekly<cr>", { desc = "Notes: weekly note" })
map("n", "<leader>nt", with_error_notification(complete_current_task), { desc = "Notes: complete task" })
map("n", "<leader>nh", with_error_notification(toggle_today_habit), { desc = "Notes: toggle today's habit" })
