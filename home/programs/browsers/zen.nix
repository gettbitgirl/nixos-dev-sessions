{
  inputs,
  pkgs,
  ...
}:
{

  imports = [ inputs.zen-browser.homeModules.default ];
  programs.zen-browser = {
    enable = true;
    #nativeMessagingHosts = [pkgs.firefoxpwa];
    profiles = {
      gettbit = {
        # bookmarks, extensions, search engines...
      };

    };
  };

  stylix.targets.zen-browser.profileNames = [ "gettbit"];

}