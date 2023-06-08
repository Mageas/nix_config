{ channels, ... }:

final: prev:

{
  inherit (channels.unstable) nextcloud-client;
}
