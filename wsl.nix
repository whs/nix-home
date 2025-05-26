# https://nix-community.github.io/home-manager/options.html
{ config, pkgs, ... }:

{
  # Forward ssh to host, in case we're using external ssh key manager
  home.shellAliases.ssh = "ssh.exe";
  programs.git.extraConfig.core.sshCommand = "ssh.exe";
}
