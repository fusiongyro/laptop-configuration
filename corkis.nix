{
  nixpkgs,
  nixpkgsUnstable,
  pkgs,
  config,
  kage,
  stylix,
  firefox-addons,
  ...
}:
  let firefoxProfile = "1bo2ckd5.default-esr"; in
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
  stylix.targets.firefox.profileNames = [ firefoxProfile ];

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

  programs.firefox.configPath = "Library/Application Support/org.nixos.firefox";
  programs.firefox.profiles.${firefoxProfile}.extensions.packages = with firefox-addons.packages.${pkgs.system}; [
    bitwarden
    ublock-origin
    kagi-search
  ];

  programs.git = {
    settings = {
      user.name = "Daniel K Lyons";
      user.email = "dlyons@nrao.edu";
    };
  };
}
