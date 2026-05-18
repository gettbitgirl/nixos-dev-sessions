{ pkgs, ... }:
{
  stylix.fonts = {
    sansSerif = {
      package = pkgs.google-fonts.override { fonts = [ "Inter" ]; };
      name = "Inter";
    };

    serif = {
      package = pkgs.libertinus;
      name = "Libertinus Serif";
    };

    monospace = {
      package = pkgs.nerd-fonts.comic-shanns-mono;
      name = "ComicShannsMono Nerd Font Mono";
    };

    emoji = {
      package = pkgs.twitter-color-emoji;
      name = "Twitter Color Emoji";
    };
  };
  
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-symbols

      # Sans(Serif) fonts
      libertinus
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      twitter-color-emoji
      roboto
      (google-fonts.override { fonts = [ "Inter" ]; })

      # monospace fonts
      jetbrains-mono

      # nerdfonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      nerd-fonts.comic-shanns-mono
    ];

    # causes more issues than it solves
    enableDefaultPackages = false;

    
    


    # user defined fonts
    fontconfig.defaultFonts = {
      serif = [ "Libertinus Serif" ];
      sansSerif = [ "Inter" ];
      monospace = [ "ComicShannsMono Nerd Font Mono" ];
      emoji = [ "Twitter Color Emoji" ];
    };
  };
}
