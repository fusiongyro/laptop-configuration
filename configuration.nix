# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      <home-manager/nixos>
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
    
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Mount the old partition, while we still have it
  # fileSystems."/old".device = "/dev/nvme0n1p3";

  networking.hostName = "shevchenko"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "dvorak";
    xkbOptions = "ctrl:swapcaps";
  };

  # Configure console keymap
  console.keyMap = "dvorak";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dlyons = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Daniel Lyons";
    extraGroups = [ "networkmanager" "wheel" "libvirtd"];
    packages = with pkgs; [
      firefox
      bitwig-studio
      jetbrains.idea-ultimate
      tdesktop
      signal-desktop
      zoom-us
      dropbox
      syncthing
    ];
  };
  
  # 1password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["dlyons"];
  };
    
  home-manager.users.dlyons = { pkgs, ... }: {
    home.stateVersion = "22.11";
    
    # Fish configuration: remove the greeting
    programs.fish.enable = true;
    programs.fish.shellInit = "set -g fish_greeting";
    
    # Starship. Make sure it hooks up to Fish
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };
    
    # Kitty
    programs.kitty = {
      enable = true;
      settings = {
        # shell = "fish";
        font_family = "PragmataPro";
        font_size = 14;
      };
    };
    
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
    
    # NNN, a simple file manager.
    programs.nnn.enable = true;
    
    # Syncthing and Dropbox
    services.syncthing.enable = true;
    # services.dropbox.enable = true;
    
    # Exa and Bat
    programs.exa.enable = true;
    programs.bat.enable = true;
    
    # Bat shell alias
    home.shellAliases = {
      cat = "bat";
      ls = "exa";
    };
    
    # My mail signature
    home.file.".signature".text = ''
    --
    Daniel K Lyons
    fusion@storytotell.org
    '';
    
    # My SSH configuration
    home.file.".ssh/config".text = ''
    Host *
      IdentityAgent ~/.1password/agent.sock
      ControlMaster auto
      ControlPath ~/.ssh/master-%r@%h:%p

    Host 7gf.org csv5.clanspum.net
      User fusion
    '';
    
    # A few Gnome settings
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        clock-format = "12h";
      };
      
      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-temperature = 4500;
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    helix
    restic
    virt-manager
    git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
  system.stateVersion = "22.11"; # Did you read the comment?
}
