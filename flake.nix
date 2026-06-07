{
  description = "Jackits's NixOS and Home-Manager flake";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        ./hosts
        #./lib
        ./modules
        #./pkgs
        #./fmt-hooks.nix
        #inputs.nixos-hardware.nixosModules.asus-fa506nc
        #inputs.nixos-plymouth.nixosModules.default
      ];
    };

  inputs = {
    skwd-wall = {
      url = "github:liixini/skwd-wall";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.inputs.nixpkgs.follows = "nixpkgs";
      inputs.skwd-daemon.inputs.nixpkgs.follows = "nixpkgs";
    };
    skwd = {
      url = "github:liixini/skwd";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.inputs.nixpkgs.follows = "nixpkgs";
      inputs.skwd-daemon.inputs.nixpkgs.follows = "nixpkgs";
    };
    nirimod.url = "github:srinivasr/nirimod";
    yamis.url = "github:gettbitgirl/Yet-Another-Monochrome-Icon-Set";
    nix-waywallen.url = "github:gettbitgirl/nix-waywallen";
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # global, so they can be `.follow`ed
    systems.url = "github:nix-systems/default-linux";
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
    };
    nix-userstyles = {
      url = "github:adam01110/nix-userstyles";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # rest of inputs, alphabetical order

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-plymouth.url = "github:BeatLink/nixos-plymouth";
    kwin-effects-better-blur-dx = {
      url = "github:xarblu/kwin-effects-better-blur-dx";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/pull/2337/head";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    base16-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };
  };
}
