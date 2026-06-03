{
  pkgs,
  inputs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
    ];
    userSettings = {
      "nix.serverPath" = "nixd";
      "nix.enableLanguageServer" = true;
      "nix.serverSettings" = {
        "nixd" = {
          "formatting" = {
            "command" = [ "alejandra" ]; # or nixfmt or nixpkgs-fmt
          };
           "options" = {
              "nixos" = {
                "expr" = "(builtins.getFlake \"~/.dotfiles\").nixosConfigurations.girlcomputer.options";
              };
              "home_manager" = {
                "expr" = "(builtins.getFlake \"~/.dotfiles\").homeConfigurations.gettbit.options";
              };
           };
        };
      };
      "files.autoSave" = "onFocusChange";
      "telemetry.telemetryLevel" = "off";
      "update.mode" = "none"; # Let Nix handle updates
    };
  };
  #stylix.targets.vscode.profileNames = ["default"];
  #stylix.targets.vscode.enable = true;
}
