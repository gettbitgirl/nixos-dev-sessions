{ config, pkgs, ... }:
let
  data = config.xdg.dataHome;
  conf = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in
{
  imports = [
    ./emulators/alacritty.nix
    ./programs
    #./shell/starship.nix
    ./shell/zsh.nix
    #./shell/zoxide.nix
  ];

  home.packages = [ pkgs.nixfmt pkgs.nixd];


  # add environment variables
  home.sessionVariables = {
    # clean up ~
    LESSHISTFILE = "${cache}/less/history";
    LESSKEY = "${conf}/less/lesskey";

    WINEPREFIX = "${data}/wine";
    XAUTHORITY = "$XDG_RUNTIME_DIR/Xauthority";

    EDITOR = "nano";
    DIRENV_LOG_FORMAT = "";

    # auto-run programs using nix-index-database
    NIX_AUTO_RUN = "1";
  };
}
