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
    cat = "bat";
    ls = "eza";
  };

  programs.aria2.enable = true;
  programs.bat.enable = true;
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
  programs.direnv.enable = true;
  programs.direnv.silent = true;
  programs.eza.enable = true;
  programs.fd.enable = true;
  programs.firefox.enable = true;
  programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
  programs.fish.enable = true;
  programs.fish.shellInit = "set -g fish_greeting";
  programs.fzf.enable = true;
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
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    settings = {
      shell = "${pkgs.fish}/bin/fish";
      enable_audio_bell = "no";

      tab_bar_style = "powerline";
      tab_powerline_style = "round";

      notify_on_cmd_finish = "unfocused";
    };
  };
  programs.lazygit = {
    enable = true;
    enableFishIntegration = true;
    settings = {
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
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
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
      git-absorb
      gitlab-ci-local
      gnused
      graphviz
      hyperfine
      imagemagick
      jetbrains.idea
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
