{
  pkgs,
  inputs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula

    ];
    
  };
  stylix.targets.vscode.profileNames = ["default"];
  stylix.targets.vscode.enable = true;
}
