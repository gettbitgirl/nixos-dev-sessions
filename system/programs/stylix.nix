{
  config,
  self,
  inputs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${inputs.base16-schemes}/base16/${config.theme.name}.yaml";
    polarity = "light";
  };
}
