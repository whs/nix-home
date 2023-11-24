# https://nix-community.github.io/home-manager/options.html
{ config, pkgs, lib, ... }:

let
  stdenv = pkgs.stdenv;
  githubGitignore = filename:
    let
      gitignore = pkgs.fetchFromGitHub {
        owner = "github";
        repo = "gitignore";
        rev = "4488915eec0b3a45b5c63ead28f286819c0917de";
        hash = "sha256-t/+ZQiGEziCqs8kIdlb/3/KBs0XQnHyQC+xoV2rzfbQ=";
      };
    in lib.splitString "\n" (builtins.readFile "${gitignore}/${filename}");
in {
  home.packages = [
    pkgs.nodejs
    pkgs.go
    pkgs.python3 pkgs.poetry
    pkgs.kubectl
    pkgs.go-jsonnet
    /*pkgs.awscli2*/ pkgs.ssm-session-manager-plugin
    pkgs.google-cloud-sdk
    pkgs.ripgrep
    pkgs.nixd # For completion of Nix files
    pkgs.ansible
    pkgs.git-crypt
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".ssh/known_hosts.home-manager".text = ''
# https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints
github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
github.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj7ndNxQowgcQnjshcLrqPEiiphnt+VTTvDP6mHBL9j1aNUkY4Ue1gvwnGLVlOhGeYrnZaMgRK6+PKCUXaDbC7qtbW8gIkhL7aGCsOr/C56SJMy/BCZfxd1nWzAOxSDPgVsmerOBYfNqltV9/hWCqBywINIR+5dIg6JTJ72pcEpEjcYgXkE2YEFXV1JHnsKgbLWNlhScqb2UmyRkQyytRLtL+38TGxkxCflmO+5Z8CSSNY7GidjMIZ7Q4zMjA2n1nGrlTDkzwDCsw+wqFPGQA179cnfGWOWRVruj16z6XyvxvjJwbz0wQZ75XK5tKSb7FNyeIEs4TT4jk+S4dhPeAUC5y+bDYirYgM4GC7uEnztnZyaVWQ7B381AK4Qdrwt51ZqExKbQpTUNn+EjqoTwvqNj4kqx5QUCI0ThS/YkOxJCXmPUWZbhjpCg56i+2aB6CmK2JGhn57K5mj0MNdBXA4/WnwH6XoPWJzK5Nyu2zB3nAZp+S5hpQs+p1vN1/wsjk=
# https://docs.gitlab.com/ee/user/gitlab_com/index.html#ssh-host-keys-fingerprints
gitlab.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfuCHKVTjquxvt6CM6tdG4SLp1Btn/nOeHHE5UOzRdf
gitlab.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsj2bNKTBSpIYDEGk9KxsGh3mySTRgMtXL583qmBpzeQ+jqCMRgBqB98u3z++J1sKlXHWfM9dyhSevkMwSbhoR8XIq/U0tCNyokEi/ueaBMCvbcTHhO7FcwzY92WK4Yt0aGROY5qX2UKSeOvuP4D6TPqKF1onrSzH9bx9XUf2lEdWT/ia1NEKjunUqu1xOB/StKDHMoX4/OKyIzuS0q/T1zOATthvasJFoPrAjkohTyaDUz2LN5JoH839hViyEG82yB+MjcFV5MU3N1l1QL3cVUCh93xSaua1N85qivl+siMkPGbO5xR/En4iEY6K2XPASUEMaieWVNTRCtJ4S8H+9
gitlab.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBFSMqzJeV9rUzU4kWitGjeR4PWSa29SPqJ1fVkhtj3Hw9xjLVXVYrU9QlYWrOLXBpQ6KWjbjTDTdDkoohFzgbEY=
# https://support.atlassian.com/bitbucket-cloud/docs/configure-ssh-and-two-step-verification/
bitbucket.org ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDQeJzhupRu0u0cdegZIa8e86EG2qOCsIsD1Xw0xSeiPDlCr7kq97NLmMbpKTX6Esc30NuoqEEHCuc7yWtwp8dI76EEEB1VqY9QJq6vk+aySyboD5QF61I/1WeTwu+deCbgKMGbUijeXhtfbxSxm6JwGrXrhBdofTsbKRUsrN1WoNgUa8uqN1Vx6WAJw1JHPhglEGGHea6QICwJOAr/6mrui/oB7pkaWKHj3z7d1IC4KWLtY47elvjbaTlkN04Kc/5LFEirorGYVbt15kAUlqGM65pk6ZBxtaO3+30LVlORZkxOh+LKL/BvbZ/iRNhItLqNyieoQj/uh/7Iv4uyH/cV/0b4WDSd3DptigWq84lJubb9t/DnZlrJazxyDCulTmKdOR7vs9gMTo+uoIrPSb8ScTtvw65+odKAlBj59dhnVp9zd7QUojOpXlL62Aw56U4oO+FALuevvMjiWeavKhJqlR7i5n9srYcrNV7ttmDw7kf/97P5zauIhxcjX+xHv4M=
bitbucket.org ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBPIQmuzMBuKdWeF4+a2sjSSpBK0iqitSQ+5BM9KhpexuGt20JpTVM7u5BDZngncgrqDMbWdxMWWOGtZ9UgbqgZE=
bitbucket.org ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIazEu89wgQZ4bqs3d63QSMzYVa0MuJ2e2gKTKqu+UUO

madoka.whs.in.th ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFJFyFW3y1KUx4F2YxFT8qhJDDVamRYBXTmOmpTg1pMy
madoka.whs.in.th ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBHF4b0e57dHgjUQGBOBGGuNDZSD6uJL9ZZOyiG6qr5VVcetSVI5vlvUzyzo7UKU7pouGtJ/9kXVwv+T3vDAmmAk=
madoka.whs.in.th ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDbTZqaWSJ7PbIAn+j9Ym7x1DBL2I/IWvz/SOha7QCP+fbjEFhRrdIe0UFb2qkqRMxVPZR2no8D6uML7+1lD4ieLXeLPFtRfu/VCu6MrJlt+10IXeMuLiHbhIeaFxkp82tuuD1zx5mwBYGLfCpyxJPl+XlUWLt9mEspVtFTAjjK7EqsTlK0vf70EtUGdbvOiQ0fY+M9GonJ64L85qbQOVAEEPSAxPZpW1KVcEcBdhwJo/ds72S0kSYylzWbBw7eEY9ziBYZWcs64xAmpmf4v/W5AlOiEfp5jlXDCm+ytxCWllbPkRTPy3wLEx5pcgEtUe8BOAZ7yZLPf5NFP9f5LrMn
    '';
  };

  home.sessionVariables = {
    EDITOR = "nano";
    DEFAULT_USER = config.home.username;
  };

  home.sessionPath = [
    "$HOME/go/bin"
  ];

  home.shellAliases = {
    k = "kubectl";
    rbp = "git pull --rebase && git push";
    ssm-ssh = "aws ssm start-session --target";
  };

  # Allow using on non-NixOS
  # Put this in per-host file!
  ## targets.genericLinux.enable = true;

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "";
      plugins = ["kubectl" "aws" "docker"];
    };
    antidote = {
      enable = true;
      plugins = [
        "agnoster/agnoster-zsh-theme"
        
        # "zsh-users/zsh-completions kind:defer"
        # "zsh-users/zsh-history-substring-search kind:defer"
        # "apachler/zsh-aws kind:defer"
        "ahmetb/kubectl-aliases kind:defer path:.kubectl_aliases"
      ];
    };

    initExtra = ''
      setopt promptsubst
    '';
  };
  programs.git = {
    enable = true;
    difftastic.enable = true;
    userName = "Manatsawin Hanmongkolchai";
    userEmail = "git@whs.in.th";
    ignores = githubGitignore "Global/Ansible.gitignore"
      ++ githubGitignore "Global/JetBrains.gitignore"
      ++ githubGitignore "Global/macOS.gitignore"
      ++ githubGitignore "Global/VisualStudioCode.gitignore"
      ++ [ ".direnv" ".envrc" ];
    extraConfig = {
      init = {
        defaultBranch = "master";
      };
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com";
        };
      };
    };
  };
  programs.ssh = {
    enable = true;
    package = null; # Don't install ssh
    serverAliveInterval = 60;
    matchBlocks = {
      "i-* mi-*" = {
        # https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started-enable-ssh-connections.html
        #proxyCommand = "${pkgs.dash}/bin/dash -c \"${pkgs.awscli2}/bin/aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'\"";
      };
    };
    userKnownHostsFile = "~/.ssh/known_hosts ~/.ssh/known_hosts.home-manager";
    extraConfig = ''
# Use SSHFP
VerifyHostKeyDNS ask
    '';
  };
}
