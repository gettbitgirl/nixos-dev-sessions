# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = false;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  environment.systemPackages = with pkgs; [
  python315
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  kdePackages.kate
  kdePackages.yakuake
  kdePackages.discover
  kdePackages.oxygen

  (fluent-icon-theme.override {
    colorVariants = [ "red" ];
  })
  darkly-qt5
  darkly
  inputs.kwin-effects-better-blur-dx.packages.${pkgs.system}.default
  #inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

}
