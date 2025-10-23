{ nixpkgs, pkgs, nixpkgsUnstable, ... }:
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
  programs.bat.enable = true;
  programs.eza.enable = true;
  
  # Direnv
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  
  # Firefox
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];
  };

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

  # Kitty
  programs.kitty = {
    enable = true;
    settings = {
      # shell = "fish";
      font_family = "PragmataPro";
      font_size = 12;
    };
  };

  # Starship. Make sure it hooks up to Fish
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # --- PACKAGES WITHOUT HOME-MANAGER CONFIGURATION ---
  home.packages = with pkgs; [
    _7zz
    discord
    dyalog
    element-desktop
    gnome-tweaks
    helm
    mtpfs
    nixpkgsUnstable.legacyPackages.${system}.nushell
    obsidian
    python312
    ride
    signal-desktop
    syncthing
    tdesktop
    thunderbird
    transmission_4-gtk
    unzip
    wl-clipboard
    zoom-us
  ] ++ [home-manager];
  
  # --- GNOME SETTINGS ---
  gtk.enable = true;
  gtk.theme = {
    package = pkgs.gnome-themes-extra;
    name = "Adwaita-dark";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
    };
    
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-temperature = 4500;
    };
  };

  # --- SERVICES -- 
  # Syncthing
  services.syncthing.enable = true; 
}
