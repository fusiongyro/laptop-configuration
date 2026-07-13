{ nixpkgs, pkgs, nixpkgsUnstable, config, kage, ... }:
{
  home.stateVersion = "23.11";
  
  # important settings
  home.username = "dlyons";
  home.homeDirectory = "/home/dlyons";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.dyalog.acceptLicense = true;
  
  # My mail signature
  home.file.".signature".text = ''
  --
  Daniel K Lyons
  fusion@storytotell.org
  '';
  
  # My SSH configuration
  home.file.".ssh/config".text = ''
  Host github.com
    User git
    IdentityFile ~/.ssh/id_ed25519.pub
    IdentitiesOnly yes

  Host *
    IdentityAgent ~/.1password/agent.sock
    ControlMaster auto
    ControlPath ~/.ssh/master-%r@%h:%p

  Host 7gf.org csv5.clanspum.net
    User fusion
  '';
  
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
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [ pkgs.gnome-browser-connector pkgs._1password-cli ];
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };

  # Fish configuration: remove the greeting
  programs.fish.enable = true;
  programs.fish.shellInit = "set -g fish_greeting";

  programs.ghostty.enable = true;
  programs.ghostty.systemd.enable = true;
  
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
    settings.theme = "rose_pine";
  };

  # Kitty
  programs.kitty = {
    enable = true;
    font.name = "Berkeley Mono";
    font.size = 14;
    shellIntegration.enableFishIntegration = true;
    themeFile = "rose-pine";
  };

  programs.nix-index.enable = true;

  # Starship. Make sure it hooks up to Fish
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # --- PACKAGES WITHOUT HOME-MANAGER CONFIGURATION ---
  home.packages = with pkgs; [
    _7zz
    anki
    bespokesynth
    bluez
    brightnessctl
    calibre
    discord
    dyalog
    element-desktop
    gvfs
    helm
    jetbrains.idea
    lazygit
    mtpfs
    nixpkgsUnstable.legacyPackages.${system}.nushell
    obsidian
    python312
    ride
    signal-desktop
    swww
    syncthing
    telegram-desktop
    thunderbird
    transmission_4-gtk
    unzip
    wireplumber
    wl-clipboard
    wofi
    yabridge
    zoom-us
  ] ++ [home-manager kage.default];
  
  # --- SERVICES -- 
  # Syncthing
  services.syncthing.enable = true; 
}
