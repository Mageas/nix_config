{ config, lib, ... }:

with builtins;
with lib;
{
  ## Location config
  time.timeZone = mkDefault "Europe/Paris";
}
