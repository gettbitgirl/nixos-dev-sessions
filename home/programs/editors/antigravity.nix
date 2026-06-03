{
  inputs,
  ...
}:
{
  home.packages = with inputs.antigravity-nix.packages.x86_64-linux; [
    default
    google-antigravity-ide
    google-antigravity-cli
  ];
}
