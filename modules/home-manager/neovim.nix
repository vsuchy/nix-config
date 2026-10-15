{
  pkgs,
  ...
}:

{
  xdg.configFile = {
    "nvim/plugin/notes.lua".source = ../../dotfiles/.config/nvim/plugin/notes.lua;
  };

  programs.neovim = {
    enable = true;
    initLua = builtins.readFile ../../dotfiles/.config/nvim/init.lua;

    extraPackages = with pkgs; [
      bash-language-server
      lua-language-server
      rubocop
      shellcheck
      vscode-langservers-extracted
    ];

    plugins = with pkgs.vimPlugins; [
      blink-cmp
      dracula-nvim
      friendly-snippets
      gitsigns-nvim
      grug-far-nvim
      lualine-nvim
      mini-nvim
      nvim-treesitter.withAllGrammars
      render-markdown-nvim
    ];
  };
}
