{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) filterAttrs hasPrefix;
  styler = inputs.nix-userstyles;
  palette = filterAttrs (name: _: hasPrefix "base0" name) config.lib.stylix.colors;
  system = pkgs.stdenv.hostPlatform.system;
in {


  imports = [ inputs.zen-browser.homeModules.default ];
  programs.zen-browser = {
    enable = true;
    #nativeMessagingHosts = [pkgs.firefoxpwa];
    profiles = {
      default = {
        userContent = lib.mkAfter (builtins.readFile (styler.lib.mkUserContent system{
          inherit palette;
          userStyles = [
  # keep-sorted start
  "advent-of-code"
  "alacritty.org"
  "alternativeto"
  "amplenote"
  "anilist"
  "anonymous-overflow"
  "arch-wiki"
  "boringproxy"
  "brave-search"
  "bsky"
  "bstats"
  "canvas-lms"
  "chatgpt"
  "chatreplay"
  "chess.com"
  "cinny"
  "claude"
  "cobalt"
  "codeberg"
  "crates.io"
  "crowdin"
  "deepl"
  "deepseek"
  "desmos"
  "dev.to"
  "devdocs"
  "discord"
  "docs.deno.com"
  "docs.rs"
  "duckduckgo"
  "ecosia"
  "elk"
  "formative"
  "freedesktop"
  "ghostty.org"
  "github"
  "gleam.run"
  "gmail"
  "go.dev"
  "google"
  "google-drive"
  "google-gemini"
  "google-photos"
  "grabify"
  "graphite"
  "hackage"
  "hacker-news"
  "have-i-been-pwned"
  "holodex"
  "home-manager-options-search"
  "homepage"
  "hoogle"
  "hoppscotch"
  "hyperpipe"
  "ichi.moe"
  "indie-wiki-buddy"
  "inoreader"
  "instagram"
  "invidious"
  "invokeai"
  "jisho"
  "keybr.com"
  "keyoxide"
  "lastfm"
  "learn-x-in-y-minutes"
  "lemmy"
  "libreddit"
  "lichess"
  "lingva"
  "linkedin"
  "listenbrainz"
  "lobste.rs"
  "mastodon"
  "mdbook"
  "mdn"
  "microsoft-word"
  "migadu-webmail"
  "minesweeper"
  "modrinth"
  "mullvad-leta"
  "namemc"
  "neovim.io"
  "nitter"
  "nixos-manual"
  "nixos-search"
  "npm"
  "ollama"
  "openmediavault"
  "paste.rs"
  "perplexity"
  "phanpy"
  "picrew"
  "pinterest"
  "planet-minecraft"
  "poe"
  "porkbun"
  "pronouns.cc"
  "pronouns.page"
  "proton"
  "pypi"
  "pythonanywhere"
  "quizlet"
  "raindrop"
  "react.dev"
  "reddit"
  "regex101"
  "rentry.co"
  "scalar"
  "searchix"
  "searxng"
  "seventv"
  "shinigami-eyes"
  "snapchat-web"
  "spotify-web"
  "stack-overflow"
  "startpage"
  "status.cafe"
  "stylus"
  "substack"
  "syncthing"
  "tabnews"
  "tldraw"
  "trinket"
  "tuta"
  "twitch"
  "twitter"
  "vercel"
  "vikunja"
  "web.dev"
  "whatsapp-web"
  "wiki.nixos.org"
  "wikipedia"
  "wikiwand"
  "youtube"
  "zen-browser-docs"
  # keep-sorted end
];

          extraCss = ''
            *,
            *::before,
            *::after 
          '';
        }));
          
        # bookmarks, extensions, search engines...
      };

    };
  };

  stylix.targets.zen-browser.profileNames = [ "default"];

}