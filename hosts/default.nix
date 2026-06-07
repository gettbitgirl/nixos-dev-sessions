{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations =
    let
      inherit (inputs.nixpkgs.lib) nixosSystem;

      homeImports = import "${self}/home/profiles";

      mod = "${self}/system";
      inherit (import mod) laptop;

      specialArgs = { inherit inputs self; };
    in
    {
      girlcomputer = nixosSystem {
        inherit specialArgs;
        modules = laptop ++ [
          ./girlcomputer
          #"${mod}/core/lanzaboote.nix"

          "${mod}/programs/gamemode.nix"
          "${mod}/programs/niri"
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

          # ── Niri specialization ──────────────────────────────────────────
          # Select at boot via the "niri" bootloader entry.
          # The niri module itself disables GNOME/GDM with mkForce.
          #{
            #specialisation.niri.configuration = {
              #imports = [ "${mod}/programs/niri" ];
            #};
          #}
        ];
      };
    };
}
