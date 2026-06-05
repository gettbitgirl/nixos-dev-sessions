{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations =
    let
      # shorten paths
      inherit (inputs.nixpkgs.lib) nixosSystem;

      homeImports = import "${self}/home/profiles";

      mod = "${self}/system";
      # get the basic config to build on top of
      inherit (import mod) laptop;

      # get these into the module system
      specialArgs = { inherit inputs self; };
    in
    {
      girlcomputer = nixosSystem {
        inherit specialArgs;
        modules = laptop ++ [
          ./girlcomputer
          #"${mod}/core/lanzaboote.nix"

          "${mod}/programs/gamemode.nix"
          "${mod}/programs/gnome"
          "${mod}/programs/games.nix"

          #"${mod}/network/syncthing.nix"

          #"${mod}/services/kanata"
          #"${mod}/services/gnome-services.nix"
          #"${mod}/services/location.nix"

          {
            home-manager = {
              users.dev.imports = homeImports."dev@girlcomputer";
              extraSpecialArgs = specialArgs;
              backupFileExtension = ".hm-backup";
            };
          }

        ];
      };
    };
}
