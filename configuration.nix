{ config, pkgs, ... }:

{
  ############################################
  # Imports & Basic System Configuration
  ############################################
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable Flakes (optional)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";

  # Networking
  networking.hostName = "nixos-guest";
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "America/New_York";

  # Locales
  i18n.defaultLocale = "en_US.UTF-8";

  ############################################
  # Services Section

[pi@nixos-flake:~]$ c
c: command not found

[pi@nixos-flake:~]$ sudo more /etc/nixos/configuration.nix 
{ config, pkgs, ... }:

{
  ############################################
  # Imports & Basic System Configuration
  ############################################
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable Flakes (optional)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";

  # Networking
  networking.hostName = "nixos-guest";
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "America/New_York";

  # Locales
  i18n.defaultLocale = "en_US.UTF-8";

  ############################################
  # Services Section
  ############################################
  services = {
    # Enable QEMU Guest Agent
    #qemuGuest.enable = true;

    # Enable SPICE Agent for clipboard sharing and display resizing
    spice-vdagentd.enable = true;

    # Enable SSH
    openssh.enable = true;

    # Printing support
    printing.enable = true;
  };

  ############################################
  # Desktop Environment
  ############################################
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;

  ############################################
  # System Packages
  ############################################
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
    brave

    # Development tools
    python3
    gcc
    cmake

    # Utilities
    mc
    vlc
    neofetch
    spice-vdagent     # SPICE agent for clipboard sharing
  ];

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
  # Firewall
  ############################################
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  ############################################
  # System State
  ############################################
  system.stateVersion = "24.11";  # Adjust based on your NixOS channel
}

