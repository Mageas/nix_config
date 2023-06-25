{ config, lib, ... }:

with builtins;
with lib;
{
  ## Location config
  time.timeZone = mkDefault "Europe/Paris";
  i18n.defaultLocale = mkDefault "en_US.UTF-8";
}
