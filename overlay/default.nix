# This file defines two overlays and composes them
{ inputs, ... }:
let
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
      microsoft-edge = prev.microsoft-edge.overrideAttrs (oldAttrs: {
        installPhase = (oldAttrs.installPhase or "") + ''
          substituteInPlace $out/share/applications/microsoft-edge.desktop \
            --replace "$out/bin/microsoft-edge" "$out/bin/microsoft-edge --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-features=WebRTCPipeWireCapturer"
        '';
      });

  };
in
inputs.nixpkgs.lib.composeManyExtensions [ additions modifications ]
