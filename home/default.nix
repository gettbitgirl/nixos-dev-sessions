{
  self,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    #./theme
    ./terminal
    #inputs.nix-index-db.homeModules.nix-index
    #inputs.tailray.homeManagerModules.default
    #self.modules.theme
  ];

  home = {
    username = "gettbit";
    homeDirectory = "/home/gettbit";
    stateVersion = "26.05";

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
