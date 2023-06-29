{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.suites.development;
  apps = {
    vscode = enabled;
    yubikey = enabled;
  };
  cli-apps = {
    tmux = enabled;
    yubikey = enabled;
    prisma = enabled;
  };
in
{
  options.plusultra.suites.development = with types; {
    enable = mkBoolOpt false
      "Whether or not to enable common development configuration.";
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [
      12345
      3000
      3001
      8080
      8081
    ];

    plusultra = {
      inherit apps cli-apps;

      tools = {
        direnv = enabled;
        go = enabled;
        http = enabled;
        node = enabled;
      };

      virtualisation = { podman = enabled; };
    };
  };
}
