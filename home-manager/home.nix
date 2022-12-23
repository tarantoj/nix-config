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
    # enableGnomeExtensions = true;
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
      # forceWayland = true;
      extraPolicies = {
        ExtensionSettings = { };
      };
    };
  };

  programs.mpv = {
    enable = true;
    config = {
      profile = "gpu-hq";
      force-window = true;
      ytdl-format = "bestvideo+bestaudio";
      # cache-default = 4000000;
      sub-auto = "fuzzy";
      gpu-context = "wayland";
      save-position-on-quit = true;
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
    signal-desktop
    mangohud
    gamescope
    gamemode
    gnome.gnome-boxes
    mellowplayer
    heroic
    lutris
    quickemu
    gnomeExtensions.pop-shell
    gnome-browser-connector
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    calibre
    powertop
    gnome.gnome-power-manager
    transmission-gtk
    transmission-remote-gtk
    plex-mpv-shim
    # sm64ex
    protontricks
    protonup
    wineWowPackages.stable
    winetricks
    obsidian
    gnome.dconf-editor
    ventoy-bin
    # prusa-slicer
    keepassxc
  ];

  # Fix icons and fonts in flatpak
  home.file.".local/share/fonts".source = config.lib.file.mkOutOfStoreSymlink "/run/current-system/sw/share/X11/fonts";
  home.file.".icons".source = config.lib.file.mkOutOfStoreSymlink "/run/current-system/sw/share/icons";
  home.file.".local/share/flatpak/overrides/global".text = ''
  [Context]
  filesystems=/run/current-system/sw/share/X11/fonts:ro;/run/current-system/sw/share/icons:ro
  '';

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
    "org/gnome/desktop/remote-desktop/rdp" = {
      screen-share-mode = "extend";
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.05";
}
