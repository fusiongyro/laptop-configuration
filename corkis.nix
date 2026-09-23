{
  config,
  pkgs,
  pkgsUnstable,
  kage,
  stylix,
  ...
}:
{

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dlyons";
  home.homeDirectory = "/Users/dlyons";

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-soft.yaml";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    with pkgs;
    [
      maven
      tesseract
    ]
    ++ (with pkgsUnstable; [
      pyrefly
      ty
    ]);

  # Git configuration
  programs.git = {
    settings = {
      user.name = "Daniel K Lyons";
      user.email = "dlyons@nrao.edu";
    };
  };

  home.sessionVariables = {
    # environment variables go here
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
