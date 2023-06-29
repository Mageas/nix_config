{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.desktop.dwm;
in
{
  options.plusultra.desktop.dwm = with types; {
    enable = mkBoolOpt false "Whether or not to enable Dwm.";
    wallpaper = mkOpt (nullOr package) null "The wallpaper to display.";
    extraConfig =
      mkOpt str "" "Additional configuration for the Dwm config file.";
  };

  config = mkIf cfg.enable {
    # Desktop additions
    plusultra.desktop.addons = {
      rofi = enabled;
      sxhkd = enabled;
      alacritty = enabled;
    };

    # Specific version of dwm with patches
    nixpkgs.overlays = [
      (self: super: {
        dwm = super.dwm.overrideAttrs (oldAttrs: rec {
          src = fetchGit {
            url = "git://git.suckless.org/dwm";
            rev = "712d6639ff8e863560328131bbb92b248dc9cde7";
          }; 
          patches = [
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/alwayscenter.diff";
              sha256 = "0sr2nzdlm53as576c0vwzdc84flld70v67n04pijqa03jisciysi";
            })
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/bar.diff";
              sha256 = "143klyrhmnddwn3i98y7a52i2nlc23486acidzavbfhpafqfy79i";
            })
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/config.diff";
              sha256 = "0v3xxj397vbq91gbxm7vljcsbmacms9wqd5sq0npkc9bcnih0kbq";
            })
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/fakefullscreen.diff";
              sha256 = "0f8vxjx3nxrm1jgxrn2810fspywxginan6kfcidnsvsr5kljimm6";
            })
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/focusonclick.diff";
              sha256 = "0qb69wmrzy0nqzqqc64fbga535859483kd1fhk0ifx4j9k9z5mjv";
            })
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/fullgaps.diff";
              sha256 = "0636gv7p2jnxi914ji2zq7ffzyz4m1cxnxa6jah09ggm5z8sk6mm";
            })
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/movestack.diff";
              sha256 = "11184xppcpi1rpzbnagilypnsh9gf6q7x1f6zd1431cn5g0434a4";
            })
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/nomonocleborder.diff";
              sha256 = "1r3ycxr94lllfrlx99mp70qr713x90ba7y9id7v6d7hz7ikz32rp";
            })
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/picom.diff";
              sha256 = "1g1r2lp96fdjy3wjklfasw5i8j6yl3nfrigz7n8dnigi9qfn90cf";
            })
            (super.fetchpatch {
              url = "https://raw.githubusercontent.com/Mageas/dwm/main/patches/warp.diff";
              sha256 = "11vlc03w4kjmajb8900xrpv8rb1lssynx1q7rlnn2w75bqskh8di";
            })
          ];
        });
      })
    ];

    plusultra.home.configFile."dwm/autostart".source = ./autostart;

    # systemd.user.services.dwm = {
    #   description = "Dwm config";
    #   script = ''
    #     sxhkd &
    #     test > /home/mageas/test
    #   '';
    #   wantedBy = [ "graphical-session.target" ];
    #   partOf = [ "graphical-session.target" ];
    # };

    systemd.user.services.dwm = {
      description = "Dwm autostart - Autostart script of DWM";
      documentation = [ "man:dwm(5)" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStartPre=sleep 2;
        ExecStart = ''
          /home/${config.plusultra.user.name}/.config/dwm/autostart
        '';
        TimeoutStopSec = 10;
      };
    };

    services.xserver = {
      enable = true;
      windowManager.dwm.enable = true;
      displayManager.defaultSession = "none+dwm";
      displayManager.lightdm = {
        enable = true;
        greeters.gtk = {
          enable = true;
          theme = {
            name = "Materia-dark";
            package = pkgs.materia-theme;
          };
          indicators = [ "~session" "~power" ];
          extraConfig = ''
            hide-user-image = true
          '';
        };
      };
      libinput.enable = true;
    };
  };
}
