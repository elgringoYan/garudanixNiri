{ inputs, pkgs, ... }:

let
  biri = inputs.biri.packages.${pkgs.stdenv.hostPlatform.system}.default;

  biri-session = pkgs.runCommand "biri-session"
    {
      passthru.providedSessions = [ "biri" ];
    }
    ''
      mkdir -p $out/share/wayland-sessions

      cat > $out/share/wayland-sessions/biri.desktop <<EOF
      [Desktop Entry]
      Name=Biri
      Comment=Biri Wayland Compositor
      Exec=${biri}/bin/niri --session --config /home/yan/.config/biri/config.kdl
      Type=Application
      DesktopNames=Biri
      EOF
    '';
in
{
  environment.systemPackages = [
    biri
  ];

  services.displayManager.sessionPackages = [
    biri-session
  ];
}
