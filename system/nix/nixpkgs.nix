{
  self,
  inputs,
  ...
}: {
  nixpkgs = {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      #"electron-25.9.0"
    ];

    overlays = [
      inputs.nix-waywallen.overlays.default
      inputs.nirimod.overlays.default
    ];
  };
}
