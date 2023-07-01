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
    ];

    plusultra.home.configFile."joshuto/joshuto.toml".source = ./joshuto.toml;
    plusultra.home.configFile."joshuto/keymap.toml".source = ./keymap.toml;
    plusultra.home.configFile."joshuto/mimetype.toml".source = ./mimetype.toml;
    plusultra.home.configFile."joshuto/preview_file.sh".source = ./preview_file.sh;
    plusultra.home.configFile."joshuto/theme.toml".source = ./theme.toml;
  };
}