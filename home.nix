{ nixpkgs, pkgs, nixpkgsUnstable, config, kage, stylix, ... }:
{
  home.stateVersion = "23.11";
  
  # important settings
  home.username = "dlyons";
  home.homeDirectory = "/home/dlyons";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.dyalog.acceptLicense = true;
  
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
  stylix.fonts.monospace = {
    package = pkgs.victor-mono;
    name = "Victor Mono";
  };
  stylix.fonts.sizes.terminal = 14;
  stylix.targets.firefox.profileNames = ["m8hth7ie.default"];

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
    IdentityAgent ~/.bitwarden-ssh-agent.sock
    ControlMaster auto
    ControlPath ~/.ssh/master-%r@%h:%p

  Host 7gf.org csv5.clanspum.net
    User fusion
  '';
   
  # Firefox
  programs.firefox = {
    nativeMessagingHosts = [ pkgs.gnome-browser-connector ];
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };

  # --- PACKAGES WITHOUT HOME-MANAGER CONFIGURATION ---
  home.packages = with pkgs; [
    anki
    bluez
    brightnessctl
    mtpfs
    thunderbird
    transmission_4-gtk
    wireplumber
    wl-clipboard
    wofi
    yubikey-manager
    zoom-us
  ];
}
