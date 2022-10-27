# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors), use something like:
    # inputs.nix-colors.homeManagerModule

    # Feel free to split up your configuration and import pieces of it here.
  ];

  # TODO: Set your username
  home = {
    username = "james";
    homeDirectory = "/home/james";
  };

  programs.firefox = {
    enable = true;
    # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    #   https-everywhere
    #   privacy-badger
    # ];
    enableGnomeExtensions = true;
    # settings.graphics = {
    #   "media.ffmpeg.vaapi.enables" = true;
    # };
    profiles.default = {
      id = 0;
      name = "Default";
      isDefault = true;
      settings = {
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
        "media.navigator.medidataencoder_vpx_enabled" = true; 
      };
    };
    profiles.work = {
      id = 1;
      name = "Work";
      settings = {
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
        "media.navigator.medidataencoder_vpx_enabled" = true; 
      };

    };
    # profiles.work = {
    #   name = "Work";
    # };
    # graphics = {
    #   "media.ffmpeg.vaapi.enabled" = true; "media.rdd-ffmpeg.enabled" = true; "media.navigator.medidataencoder_vpx_enabled" = true; };
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      forceWayland = true;
      extraPolicies = {
        ExtensionSettings = { };
      };
    };
  };


  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      jnoortheen.nix-ide
      # dracula-theme.theme-dracula
      # vscodevim.vim
      # yzhang.markdown-all-in-one
    ];
  };
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    discord
    gnome-secrets
    microsoft-edge
    rnix-lsp
    vlc
    plex-media-player
    joycond
    signal-desktop
    mangohud
    gamescope
    gamemode
    gnome.gnome-boxes
    mellowplayer
    heroic
    lutris
    quickemu
    mpv
    gnomeExtensions.pop-shell
    gnome.gnome-tweaks
    calibre
    powertop
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;
  # programs.zsh.enable = true;

  programs.google-chrome.enable = true;
  programs.google-chrome.commandLineArgs = ["--enable-features=UseOzonePlatform" "--ozone-platform=wayland"];

  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.05";
}
