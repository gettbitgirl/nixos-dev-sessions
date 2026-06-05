{ pkgs, ... }:
{
  users.users.dev = {
    isNormalUser = true;
    initialPassword = "1234";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
