{ inputs, ...}:

{
  
  flake.modules = {
    theme = import ./theme;
    plymouth-theme = import inputs.nixos-plymouth.nixosModules.default ;
    stylixx = import inputs.stylix.nixosModules.stylix;
  };
}
