{
  nixpkgs,
  pkgs,
  nixpkgsUnstable,
  config,
  kage,
  stylix,
  ...
}:
{
  stylix.enable = true;

  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Bat shell alias
  home.shellAliases = {
    cat = "bat";
    ls = "eza";
  };

  # --- PROGRAMS ---
  # Exa and Bat
  programs.aria2.enable = true;
  programs.bat.enable = true;
  programs.fd.enable = true;
  programs.fzf.enable = true;
  programs.eza.enable = true;

  # Direnv
  programs.direnv.enable = true;
  programs.direnv.silent = true;

  # Firefox
  programs.firefox.enable = true;

  # Fish configuration: remove the greeting
  programs.fish.enable = true;
  programs.fish.shellInit = "set -g fish_greeting";

  # Helix. Add my keybindings.
  programs.helix = {
    enable = true;
    settings.keys.normal = {
      "A-v" = "page_up";
      "C-b" = "move_char_left";
      "C-f" = "move_char_right";
      "C-n" = "move_line_down";
      "C-p" = "move_line_up";
      "C-v" = "page_down";
    };

    settings.keys.select = {
      "C-b" = "extend_char_left";
      "C-f" = "extend_char_right";
      "C-n" = "extend_line_down";
      "C-p" = "extend_line_up";
    };
  };
  programs.home-manager.enable = true;

  # Kitty
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
  };

  programs.nix-index.enable = true;

  # Starship. Make sure it hooks up to Fish
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # --- PACKAGES WITHOUT HOME-MANAGER CONFIGURATION ---
  home.packages =
    with pkgs;
    [
      _7zz
      bitwarden-desktop
      calibre
      discord
      jetbrains.idea
      lazygit
      obsidian
      nil
      nixfmt
      unzip
      yubikey-manager
    ]
    ++ [ kage.default ];

  # --- SERVICES --
  # Syncthing
  services.syncthing.enable = true;
}
