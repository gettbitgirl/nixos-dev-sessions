{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    #./nh.nix
    ./nixpkgs.nix
    #./substituters.nix
  ];

  # we need git for flakes
  environment.systemPackages = [ pkgs.git ];

  nix =
    let
      flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
    in
    {

      nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
      settings = {
        auto-optimise-store = true;
        #builders-use-substitutes = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        flake-registry = "/etc/nix/registry.json";

        trusted-users = [
          "root"
          "@wheel"
        ];

        accept-flake-config = false;
      };
    };
}
