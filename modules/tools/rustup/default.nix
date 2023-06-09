{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.plusultra.tools.rustup;
in
{
  options.plusultra.tools.rustup = with types; {
    enable = mkBoolOpt false "Whether or not to enable rustup.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ rustup ]; };
}
