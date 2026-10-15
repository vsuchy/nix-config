# Personal Nix configuration

## macOS setup

Use the existing `vs` account. Install the Xcode command-line tools, Homebrew and Nix:

- `xcode-select --install`
- `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- `curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install --enable-flakes`

From the repository root, bootstrap nix-darwin using the locked flake input:

```sh
sudo nix --extra-experimental-features 'nix-command flakes' run --inputs-from . nix-darwin#darwin-rebuild -- switch --flake .#macbook-pro
```

Apply later changes with:

```sh
sudo darwin-rebuild switch --flake .#macbook-pro
```

## Manual macOS settings

Set these options manually in System Settings:

- TODO

## Validation and updates

From the repository root, validate changes before switching:

```sh
nix flake check --no-update-lock-file
```

Update the pinned Nix dependencies:

```sh
nix flake update
```
