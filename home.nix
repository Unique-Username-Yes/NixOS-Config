{ pkgs, ... }:

{
  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      initExtra = ''eval "$(direnv hook zsh)"; PROMPT=\"%n@%m%#\"'';
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "robbyrussell";
      };
      shellAliases = {
        # Assumes you have the config repo in your home dir
        update = "echo Running: sudo nix flake update ~/NixOS-Config/. && sudo nix flake update ~/NixOS-Config/.";
        switch = "echo Running: sudo nixos-rebuild switch --flake ~/NixOS-Config# && sudo nixos-rebuild switch --flake ~/NixOS-Config#";

        ls = "lsd";
        cat = "bat";
      };
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    # Need to launch codium from nix develop shell to get environment working correctly...
    vscode = {
      enable = true;
      package = pkgs.vscodium;

      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      mutableExtensionsDir = false;

      # To update extensions, run 'nix-shell scripts/update_vscodium_extensions.sh' and replace current extensions
      # TODO: automate this
      extensions = with pkgs.vscode-extensions; [
        # CodeLLDB works when added here, but not when added from VscodeMarketplace?
        vadimcn.vscode-lldb
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-direnv";
          publisher = "cab404";
          version = "1.0.0";
          sha256 = "0xikkhbzb5cd0a96smj5mr1sz5zxrmryhw56m0139sbg7zwwfwps";
        }
        {
          name = "nix-ide";
          publisher = "jnoortheen";
          version = "0.2.2";
          sha256 = "1264027sjh9a112si0y0p3pk3y36shj5b4qkpsj207z7lbxqq0wg";
        }
        {
          name = "vscode-clangd";
          publisher = "llvm-vs-code-extensions";
          version = "0.1.24";
          sha256 = "sha256-yOpsYjjwHRXxbiHDPgrtswUtgbQAo+3RgN2s6UYe9mg=";
        }
        {
          name = "cmake";
          publisher = "twxs";
          version = "0.0.17";
          sha256 = "sha256-CFiva1AO/oHpszbpd7lLtDzbv1Yi55yQOQPP/kCTH4Y=";
        }
        {
          name = "cmake-tools";
          publisher = "ms-vscode";
          version = "1.15.31";
          sha256 = "sha256-GwNSpgQe8/rdYAsGvUUFS7LLRR1RkjEdu8f7ArhCimU=";
        }
        {
          name = "clang-tidy";
          publisher = "notskm";
          version = "0.5.1";
          sha256 = "sha256-neAvG8bk8yzpbuSzvVVi8Z3lCr29FBncXx3Sv/KChHw=";
        }
        # {
        #   name = "sonarlint-vscode";
        #   publisher = "SonarSource";
        #   version = "3.21.0";
        #   sha256 = "sha256-m1X0uPbr8yaQCQ+gsc4I3JmJktjowcM2Ae02dM4lIDs=";
        # }
        # {
        #   name = "vscode-lldb";
        #   publisher = "vadimcn";
        #   version = "1.9.2";
        #   sha256 = "sha256-TxHILZ0862gnWPrh9ut3dqCcGHrWMgUfYCkOjygMcVk=";
        # }
        {
          name = "vsliveshare";
          publisher = "MS-vsliveshare";
          version = "1.0.5883";
          sha256 = "sha256-BNxLINcbat2F4PHCrKHKIuMpXW1q9aP2SDb0oIv48v0=";
        }
        {
          name = "gitlens";
          publisher = "eamodio";
          version = "14.3.0";
          sha256 = "sha256-ZZPW+A0wekn2XBaaaYfoBDMQAY7+lpFCqkOCDZi16kA=";
        }

      ];

      # TODO: make settings.json mutable and store it separately?
      # https://github.com/andyrichardson/dotfiles/blob/28c3630e71d65d92b88cf83b2f91121432be0068/nix/home/vscode.nix#L5
      userSettings = {
        # "workbench.colorTheme" = "Mayukai Semantic Mirage";
        "workbench.iconTheme" = "ayu";

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.formatterPath" = "nixpkgs-fmt";
        "nix.serverSettings" = {
          "nil" = {
            "formatting" = { "command" = [ "nixpkgs-fmt" ]; };
          };
        };

        "git.enableCommitSigning" = true;
        "terminal.integrated.fontFamily" = "Hack Nerd Font Mono";
      };
    };
  };

  home = {
    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      htop
    ];

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.05";

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "bigsad";
    homeDirectory = "/home/bigsad";
  };
}
