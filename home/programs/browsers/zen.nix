{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = [
    #inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.zen-browser = {
    enable = true;

    profiles = {
      gettbit = {
        # bookmarks, extensions, search engines...
      };

    };
  };

  stylix.targets.zen-browser.profileNames = [ "gettbit"];

}