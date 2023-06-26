{ options, config, lib, pkgs, ... }:
let
  installImages = pkgs.writeShellScriptBin "install-images.sh" ''
    #!/usr/bin/env bash
    cp ./wallpaper.jpg /run/current-system/sw/share/
  '';
in
{
  environment.systemPackages = with pkgs; [
    installImages
  ];
}