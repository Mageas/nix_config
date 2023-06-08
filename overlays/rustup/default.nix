{ channels, ... }:

final: prev:

{
  inherit (channels.unstable) rustup;
}
