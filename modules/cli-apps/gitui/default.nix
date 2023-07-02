inputs@{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.cli-apps.gitui;
in
{
  options.plusultra.cli-apps.gitui = with types; {
    enable = mkBoolOpt false "Whether or not to enable gitui.";
  };

  config = 
    mkIf cfg.enable { environment.systemPackages = with pkgs.plusultra; [ gitui-gpg ];
  };
}
