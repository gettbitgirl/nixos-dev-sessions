{ inputs, ... }:
{
  imports = [
    inputs.inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${inputs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  };
}