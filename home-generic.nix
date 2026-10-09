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
  home.stateVersion = "23.11";

  wayland.windowManager.hyprland.configType = "lua";

  nixpkgs.config.allowUnfree = true;

  stylix.enable = true;

  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Bat shell alias
  home.shellAliases = {
    ls = "lla";
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.option_as_alt = "Both";
    };
  };
  programs.aria2.enable = true;
  programs.direnv.enable = true;
  programs.direnv.silent = true;
  programs.emacs.enable = true;
  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.git = {
    enable = true;
    settings = {
      core = {
        autocrlf = "input";
      };
      pull = {
        rebase = true;
      };
      init = {
        defaultBranch = "main";
      };
      delta = {
        navigate = true;
      };
    };
  };
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
  programs.lazygit = {
    enable = true;
    enableFishIntegration = true;
    settings.git = {
      autoFetch = false;
      autoRefresh = false;
    };
  };
  programs.mergiraf.enable = true;
  programs.mergiraf.enableGitIntegration = true;
  programs.nix-index.enable = true;
  programs.obsidian.enable = true;
  programs.pandoc.enable = true;
  programs.pgcli.enable = true;
  programs.sioyek.enable = true;
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # --- PACKAGES WITHOUT HOME-MANAGER CONFIGURATION ---
  home.packages =
    with pkgs;
    [
      _7zz
      ack
      bitwarden-desktop
      bulletty
      discord
      duckdb
      elinks
      ffmpeg
      fzy
      git-absorb
      gitlab-ci-local
      gnused
      graphviz
      hyperfine
      imagemagick
      jetbrains.idea
      lla
      moreutils
      nil
      nixfmt
      pv
      sqlite
      swi-prolog
      tree
      unzip
      wget
      xz
      yubikey-manager
    ]
    ++ [ kage.default ];

  # --- SERVICES --
  services.hister = {
    enable = true;
    settings = {
      app = {
        search_url = "https://kagi.com/search?q={query}";
        log_level = "info";
      };
      server = {
        address = "127.0.0.1:4433";
        database = "db.sqlite3";
      };
    };
  };
  services.syncthing.enable = true;
}
