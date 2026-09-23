{
  nixpkgs,
  nixpkgsUnstable,
  pkgs,
  config,
  kage,
  stylix,
  ...
}:
{

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "dlyons";
  home.homeDirectory = "/Users/dlyons";

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-soft.yaml";
  stylix.fonts.monospace = {
    package = pkgs.victor-mono;
    name = "Victor Mono";
  };
  stylix.fonts.sizes.terminal = 16;
  stylix.targets.firefox.profileNames = [ "1bo2ckd5.default-esr" ];

  home.packages =
    with pkgs;
    [
      docker
      maven
      tesseract
    ]
    ++ (with nixpkgsUnstable; [
      pyrefly
      ty
    ]);

  programs.git = {
    settings = {
      user.name = "Daniel K Lyons";
      user.email = "dlyons@nrao.edu";
    };
  };

  programs.kitty = {
    settings = {
      macos_option_as_alt = "yes";
    };
    keybindings = {
      "ctrl+shift+m" = "new_window";
      "super+1" = "goto_tab 1";
      "super+2" = "goto_tab 2";
      "super+3" = "goto_tab 3";
      "super+4" = "goto_tab 4";
      "super+5" = "goto_tab 5";
      "super+6" = "goto_tab 6";
      "super+7" = "goto_tab 7";
      "super+8" = "goto_tab 8";
      "super+9" = "goto_tab 9";
    };
  };
}
