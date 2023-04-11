{
  home-manager.users.dlyons = { pkgs, ... }: {
    home.stateVersion = "23.05";
    
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

    home.sessionVariables = {
      EDITOR = "hx";
    };
    
    # NNN, a simple file manager.
    programs.nnn.enable = true;
    
    # Syncthing and Dropbox
    services.syncthing.enable = true;
    # services.dropbox.enable = true;

    # Exa and Bat
    programs.exa.enable = true;
    programs.bat.enable = true;

    # Direnv
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
    
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
}