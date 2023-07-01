{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.internal;
{
  imports = [ ./hardware.nix ];

  plusultra = {
    archetypes = {
      workstation = enabled;
    };

    apps = {
      steam = enabled;
      gparted = enabled;
      brave = enabled;
      feh = enabled;
      nemo = enabled;
    };

    cli-apps = {
      joshuto = enabled;
      rsync = enabled;
    };

    desktop = {
      dwm = enabled;
    };

    tools = {
      flatpak = enabled;
      docker = enabled;
    };

    system = {
      lightdm = enabled;
    };
  };

  # Fix ca.desrt.dconf error for home-manager (https://nix-community.github.io/home-manager/index.html#_why_do_i_get_an_error_message_about_literal_ca_desrt_dconf_literal_or_literal_dconf_service_literal)
  programs.dconf.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
