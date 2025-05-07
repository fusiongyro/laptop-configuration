# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ 
  config, 
  pkgs, 
  nixpkgsUnstable,
  ... 
}:

{
  imports =
    [ 
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
    
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "iverson";

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "dvorak";
  };
  console.useXkbConfig = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Flatpak for Bitwig
  services.flatpak.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  security.sudo.enable = true;

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "dlyons";

  # Firmware updates
  services.fwupd.enable = true;

  # Fingerprint reader
  services.fprintd.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dlyons = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Daniel Lyons";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "input" "docker"];
    packages = with pkgs; [
      _7zz
      discord
      dropbox
      dyalog
      element-desktop
      emulationstation
      firefox
      gnomeExtensions.appindicator
      gnomeExtensions.gsconnect
      gnome-tweaks
      helm
      jetbrains.idea-ultimate
      kdePackages.kate
      mtpfs
      nixpkgsUnstable.legacyPackages.${system}.nushell
      obsidian
      python312
      retroarch
      ride
      signal-desktop
      syncthing
      tdesktop
      thunderbird
      transmission_4-gtk
      unzip
      wl-clipboard
      yabridge
      yabridgectl
      zoom-us
    ];
  };

  # 1password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["dlyons"];
  };
    
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "freeimage-unstable-2021-11-01"
  ];
  nixpkgs.config.dyalog.acceptLicense = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    helix
    restic
    virt-manager
    git
    file
    docker
    j
    android-file-transfer
    wine64
    wineWow64Packages.full
  ];

  # auto-backup stuff
  services.udev.extraRules = ''
    SUBSYSTEM=="block", ACTION=="add", ATTRS{idVendor}=="090c", RUN+="${pkgs.util-linux}/bin/logger hello"
  '';

  # android
  services.udev.packages = [ pkgs.android-udev-rules ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  
  # Needed to configure enable the other fish shell integrations
  programs.fish.enable = true;

  # Virtualization
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # also Docker
  virtualisation.docker.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
