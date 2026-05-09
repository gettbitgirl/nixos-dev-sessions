{ inputs, ...}:

{
  
  flake.modules = {
    theme = import ./theme;
    plymouth-theme  = import inputs.nixos-plymouth.nixosModules.default;
  };



}
