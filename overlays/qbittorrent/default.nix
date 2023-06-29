{ channels, ... }:

final: prev:

{
  inherit (channels.unstable) qbittorrent;
}
