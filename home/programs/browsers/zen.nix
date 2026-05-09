{
  inputs,
  pkgs,
  ...
}:
{

  imports = [ inputs.zen-browser.homeModules.twilight ];

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