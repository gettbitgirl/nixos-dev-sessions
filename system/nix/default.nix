{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    #./nh.nix
    ./nixpkgs.nix
    #./substituters.nix
  ];

  # we need git for flakes
  environment.systemPackages = [pkgs.git];

  nix = let
    flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
  in {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    settings = {
      extra-substituters = ["https://noctalia.cachix.org" "https://gettbitgirl.cachix.org"];
      extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" "gettbitgirl.cachix.org-1:ZWl5ZgnEiAYuwk86kuVww8pTKofUc7UkEWL/Y7fNBF4="];
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
