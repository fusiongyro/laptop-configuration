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

  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-soft.yaml";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
  stylix.fonts.monospace = {
    package = pkgs.victor-mono;
    name = "Victor Mono";
  };
  stylix.fonts.sizes.terminal = 16;

  home.packages =
    with pkgs;
    [
      coreutils-prefixed
      docker
      maven
      isync
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
}
