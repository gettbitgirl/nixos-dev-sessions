{
  pkgs,
  inputs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    
  };
  stylix.targets.vscode.profileNames = ["default"];
  stylix.targets.vscode.enable = true;
}
