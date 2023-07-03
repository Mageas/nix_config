{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.desktop.dwm;
in
{
  options.plusultra.desktop.dwm = with types; {
    enable = mkBoolOpt false "Whether or not to enable DWM.";
    isDefaultSession.enable = mkBoolOpt false "Whether or not to make DWM the default session.";
  };

  config = mkIf cfg.enable {
    # Desktop additions
    plusultra.desktop.addons = {
      alacritty = enabled;
      autostart = enabled;
      gtk = enabled;
      polkit = enabled;
      rofi = enabled;
      sxhkd = enabled;
      wallpapers = enabled;
      xdg-portal = enabled;
    };

    plusultra.home.file.".local/bin/statusbar".source = ./statusbar;

    # Specific version of dwm with patches
    nixpkgs.overlays = [
      (self: super: {
        dwm = super.dwm.overrideAttrs (oldAttrs: rec {
          src = fetchGit {
            url = "git://git.suckless.org/dwm";
            rev = "712d6639ff8e863560328131bbb92b248dc9cde7";
          }; 
          patches = [
            # (builtins.fetchurl https://raw.githubusercontent.com/Mageas/dwm/main/patches/alwayscenter.diff)
            # (builtins.fetchurl https://raw.githubusercontent.com/Mageas/dwm/main/patches/bar.diff)
            # (builtins.fetchurl https://raw.githubusercontent.com/Mageas/dwm/main/patches/config.diff)
            # (builtins.fetchurl https://raw.githubusercontent.com/Mageas/dwm/main/patches/fakefullscreen.diff)
            # (builtins.fetchurl https://raw.githubusercontent.com/Mageas/dwm/main/patches/focusonclick.diff)
            # (builtins.fetchurl https://raw.githubusercontent.com/Mageas/dwm/main/patches/fullgaps.diff)
            # (builtins.fetchurl https://raw.githubusercontent.com/Mageas/dwm/main/patches/movestack.diff)
            # (builtins.fetchurl https://raw.githubusercontent.com/Mageas/dwm/main/patches/nomonocleborder.diff)
            # (builtins.fetchurl https://raw.githubusercontent.com/Mageas/dwm/main/patches/picom.diff)
            # (builtins.fetchurl https://raw.githubusercontent.com/Mageas/dwm/main/patches/warp.diff)
            # I don't know why, but the SHA256 has random mismatches
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/alwayscenter.diff";
              sha256 = "sha256-Z0+WNfb4aniWML3/P+46BC7A36OpbfG0prL7ZA7jX54=";
            })
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/bar.diff";
              sha256 = "sha256-3Ad0kOdPcC3kKQm1RiXSMfelkEbajF4UrjwCKTs7v+I=";
            })
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/config.diff";
              sha256 = "sha256-xVjg1S1wKdA7ojrgzv9cFRTmnWz/mb1UNneddS16xzg=";
            })
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/fakefullscreen.diff";
              sha256 = lib.fakeSha256;
            })
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/focusonclick.diff";
              sha256 = lib.fakeSha256;
            })
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/fullgaps.diff";
              sha256 = lib.fakeSha256;
            })
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/movestack.diff";
              sha256 = lib.fakeSha256;
            })
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/nomonocleborder.diff";
              sha256 = lib.fakeSha256;
            })
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/picom.diff";
              sha256 = lib.fakeSha256;
            })
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/warp.diff";
              sha256 = lib.fakeSha256;
            })
          ];
        });
      })
    ];

    services.xserver = {
      windowManager.dwm.enable = true;
      displayManager.defaultSession = mkIf cfg.isDefaultSession.enable "none+dwm";
    };
  };
}
