# https://nix-community.github.io/home-manager/options.html
{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];
  
  home.username = "whs";
  home.homeDirectory = "/home/whs";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = [ ];

  home.sessionVariables = {};

  home.shellAliases = {
    code = "codium";
  };

  # Allow using on non-NixOS
  targets.genericLinux.enable = true;
}
