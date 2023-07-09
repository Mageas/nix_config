inputs@{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.plusultra.cli-apps.joshuto;
in
{
  options.plusultra.cli-apps.joshuto = with types; {
    enable = mkBoolOpt false "Whether or not to enable joshuto.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      joshuto
      catdoc
      bat
    ];
    
    plusultra.home.configFile."joshuto".source = ./config;
  };
}