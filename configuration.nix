{ config, pkgs, ... }:

{
  ############################################
  # Imports & Basic System Configuration
  ############################################
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader Configuration
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";  # Adjust this based on your setup

  # Networking
  networking.hostName = "nixos-guest";  # Change hostname if needed
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "America/New_York";

  # Locales
  i18n.defaultLocale = "en_US.UTF-8";

  ############################################
  # Graphical Environment
  ############################################
  services.xserver.enable = true;
  services.xserver.layout = "us";  # Keyboard layout
  services.xserver.xkbOptions = "";  # Optional XKB options
  services.xserver.displayManager.lightdm.enable = true;  # LightDM display manager
  services.xserver.desktopManager.cinnamon.enable = true;  # Cinnamon desktop environment

  ############################################
  # Clipboard Sharing for VMs (spice-vdagent)
  ############################################
  services.spice-vdagentd.enable = true;

  ############################################
  # Users & Passwordless Sudo
  ############################################
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  users.users.pi = {
    isNormalUser = true;
    description = "pi";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  ############################################
  # Unfree Packages & System Packages
  ############################################
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Basic tools
    git
    curl
    wget
    htop
    bash
    coreutils
    neovim
    tmux
    alacritty
    rxvt-unicode
    konsole

    # Browsers
    firefox
    brave

    # Development tools
    python3
    gcc
    cmake

    # Utilities
    vlc
    neofetch
    spice-vdagent  # Clipboard sharing for VMs
  ];

  ############################################
  # Firewall
  ############################################
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];  # Allow SSH

  ############################################
  # System State
  ############################################
  system.stateVersion = "24.11";
}
