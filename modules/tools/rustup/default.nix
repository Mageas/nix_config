{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let 
  cfg = config.plusultra.tools.rustup;

  configureRustup = pkgs.writeText "configure-rustup.sh" ''
    #!/usr/bin/env bash
    if command -v rustup >/dev/null 2>&1; then
      rustup install stable
      rustup default stable
    fi
  '';
in
{
  options.plusultra.tools.rustup = with types; {
    enable = mkBoolOpt false "Whether or not to enable rustup.";
  };

  config =
    mkIf cfg.enable { 
      environment.systemPackages = with pkgs; [ rustup ];

      nixpkgs.config = {
        scripts.postShellHooks = [ "${configureRustup}" ];
      };
    };
}
