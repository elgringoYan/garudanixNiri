# This is your system's configuration file.
# Use this to configure your system environment.
{
  inputs,
  pkgs,
  ...
}:
{
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # inputs.self.nixosModules.example

    # Chaotic Nyx and home-manager are already preconfigured by garudaSystem,
    # no need to add it to profit from it!
    # https://www.nyx.chaotic.cx
    # https://home-manager-options.extranix.com

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      inputs.self.overlays.additions
      inputs.self.overlays.modifications

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
    ];
  };

  # Garuda Nix edition and features, as picked in the installer.
  garuda.dr460nized.enable = true;
  garuda.gaming.enable = true;
  garuda.performance-tweaks.enable = true;
  garuda.samba.enable = true;
  garuda.btrfs-maintenance.enable = true;

  # Hardware auto-detected with nixos-facter during installation.
  # Hardware probed during installation, see ./facter.json.
  garuda.hardware.autoDriver.reportPath = ./facter.json;
  # Auto-detected NVIDIA GPU, enable the proprietary driver.
  garuda.hardware.nvidia.enable = true;
  garuda.hardware.nvidia.nvidiaBusId = "PCI:1:0:0";
  garuda.hardware.nvidia.amdgpuBusId = "PCI:5:0:0";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use the CachyOS kernel (via chaotic-nyx).
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  hardware.nvidia.package = pkgs.nvidia_cachyos;

  networking.hostName = "GarudaNix";

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_CA.UTF-8";

  i18n.extraLocaleSettings = {
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "ca";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "cf";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."yan" = {
    isNormalUser = true;
    description = "Yanick";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  home-manager.users."yan" = import ../home-manager/home.nix;

  services.flatpak.enable = true;
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "26.11";
}
