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

          # ── Niri specialization ─────────────────────────────────────────
          # Boot into this via the bootloader entry labelled "niri".
          # It inherits everything from the base config above, then overrides
          # the desktop environment.
          {
            specialisation.niri.configuration = {
              # Switch off GNOME (re-declared here so the specialisation
              # cleanly overrides rather than merging with the base).
              services.desktopManager.gnome.enable = inputs.nixpkgs.lib.mkForce false;
              services.displayManager.gdm.enable = inputs.nixpkgs.lib.mkForce false;

              # Pull in the niri system module
              imports = [ "${mod}/programs/niri" ];
            };
          }
        ];
      };
    };
}
