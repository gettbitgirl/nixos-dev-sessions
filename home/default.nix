{
  self,
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./specializations.nix
    ./terminal
    #inputs.nix-index-db.homeModules.nix-index
    #inputs.tailray.homeManagerModules.default
    self.modules.theme
  ];

  home = {
    username = "dev";
    homeDirectory = "/home/dev";
    stateVersion = "26.05";

    file."Pictures/Wallpapers/default.jpg".source = config.theme.wallpaper;
  };

  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  # let HM manage itself when in standalone mode
  programs.home-manager.enable = true;
}
