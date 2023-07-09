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
      plusultra.joshuto-open
      joshuto
      catdoc
      bat
    ];

    extraOptions.home.shellAliases = {
      lf = ''
        cwd_file="/tmp/joshuto-cwd"
        env joshuto --output-file "$cwd_file" --path "$(pwd)" $@

        if [ -e "$cwd_file" ]; then
            joshuto_cwd=$(cat "$cwd_file")
            rm "$cwd_file" &>/dev/null && cd "$joshuto_cwd"
        fi
      '';
    };

    plusultra.home.configFile."joshuto".source = ./config;
  };
}