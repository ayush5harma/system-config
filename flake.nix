{
  description = "common system flake";
  inputs = {
    # Where we get most of our software. Giant mono repo with recipes
    # called derivations that say how to build software.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # nixos-22.11
# Manages configs links things into your home directory
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Controls system level software and settings including fonts
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Tricked out nvim
    pwnvim.url = "github:zmre/pwnvim";
  };
  outputs = inputs: {
    darwinConfigurations.Ayushs-MacBook-Pro =
      inputs.darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = import inputs.nixpkgs { system = "aarch64-darwin"; };
        modules = [
          ({ pkgs, ... }: {
            # here go the darwin preferences and config items
            programs.zsh.enable = true;
            environment.shells = [ pkgs.bash pkgs.zsh ];
            environment.loginShell = pkgs.zsh;
            environment.systemPackages = [pkgs.scrcpy pkgs.kubectx  pkgs.ruby_3_2 pkgs.scrcpy pkgs.apktool pkgs.envsubst pkgs.nix-direnv pkgs.direnv pkgs.awscli2 pkgs.eksctl pkgs.jq pkgs.jadx pkgs.wget pkgs.protobuf pkgs.dos2unix pkgs.p7zip pkgs.coreutils pkgs.fastlane pkgs.vault pkgs.ngrok pkgs.cocoapods];
            environment.systemPath = [ "/Users/ayushsharma/Library/Android/sdk/platform-tools" "/opt/homebrew/bin" "/opt/homebrew/opt/imagemagick@6/bin" ];
            environment.pathsToLink = [ "/Applications" ];
            environment.variables = {
              CHROME_EXECUTABLE = "/Applications/Arc.app/Contents/MacOS/Arc";
            };
           nix.extraOptions = ''
              experimental-features = nix-command flakes
            '';
            services.nix-daemon.enable = true;
            system.defaults.finder.AppleShowAllExtensions = true;
            system.defaults.dock.autohide = true;
            system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
            system.defaults.NSGlobalDomain.InitialKeyRepeat = 14;
            system.defaults.NSGlobalDomain.KeyRepeat = 1;
            users.users.ayushsharma.home=/Users/ayushsharma;
            system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";
            system.defaults.NSGlobalDomain.AppleMetricUnits = 1;
            system.defaults.NSGlobalDomain.AppleScrollerPagingBehavior = true;
      #      system.defaults.NSGlobalDomain.AppleShowAllFiles = true;
            system.defaults.NSGlobalDomain.AppleShowScrollBars = "Always";
            system.defaults.NSGlobalDomain.AppleTemperatureUnit = "Celsius";
            system.defaults.NSGlobalDomain.NSAutomaticWindowAnimationsEnabled = false;
            system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
            system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
            system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
            system.defaults.NSGlobalDomain."com.apple.sound.beep.feedback" = 1;
            system.defaults.NSGlobalDomain."com.apple.trackpad.scaling" = 2.0;
            system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
            system.defaults.dock.autohide-delay = 0.0;
            system.defaults.dock.autohide-time-modifier = 0.0;
            system.defaults.finder.FXDefaultSearchScope = "SCcf";
            system.defaults.finder.FXEnableExtensionChangeWarning = false;
            system.defaults.finder.FXPreferredViewStyle = "Nlsv";
            system.defaults.finder.QuitMenuItem = true;
            system.defaults.screencapture.location = "/Users/ayushsharma/Pictures/Screenshots";
            system.defaults.trackpad.Clicking = true;
            system.defaults.trackpad.TrackpadRightClick = true;

            # backwards compat; don't change
            system.stateVersion = 4;
            homebrew = {
              enable = true;
              caskArgs.no_quarantine = true;
              global.brewfile = true;
             # masApps = { };
             # casks = [ "spotify" "PlayCover/playcover/playcover-community" "authy" "appium-inspector" "telegram" "nordvpn"];
             # taps = [ "PlayCover/playcover" ];
             brews = [ "ios-deploy" "imagemagick" "mysql" "redis" "grep" "parallel" "libimobiledevices"];
            };
          })
          inputs.home-manager.darwinModules.home-manager
          { 
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.ayushsharma.imports = [
                ({ pkgs, ... }: {
                  # Don't change this when you change package input. Leave it alone.
                  home.stateVersion = "22.11";
                  # specify my home-manager configs
                  home.packages = [
                    pkgs.ripgrep
                    pkgs.fd
                    pkgs.curl
                    pkgs.less
                    inputs.pwnvim.packages."aarch64-darwin".default
                  ];
                  home.sessionVariables = {
                    PAGER = "less";
                    CLICLOLOR = 1;
                    EDITOR = "nvim";
                  };
                  programs.bat.enable = true;
                  programs.bat.config.theme = "TwoDark";
                  programs.fzf.enable = true;
                  programs.fzf.enableZshIntegration = true;
                  programs.exa.enable = true;
                  programs.git.enable = true;
                  programs.zsh.enable = true;
                  programs.zsh.enableCompletion = true;
                  programs.zsh.enableAutosuggestions = true;
                  programs.zsh.enableSyntaxHighlighting = true;
                  programs.zsh.shellAliases = { ls = "ls --color=auto -F"; };
                  programs.zsh.initExtra = '' eval "$(direnv hook zsh)" '';
                  home.file.".inputrc".text = ''
                    set show-all-if-ambiguous on
                    set completion-ignore-case on
                    set mark-directories on
                    set mark-symlinked-directories on
                    set match-hidden-files off
                    set visible-stats on
                    set keymap vi
                    set editing-mode vi-insert
                  '';
                })
              ];
            };
          }
        ];
      };
  };
}
