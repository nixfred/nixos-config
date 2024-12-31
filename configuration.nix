{ config, pkgs, ... }:

{
  ############################################
  # Imports & Basic System Configuration
  ############################################
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";

# Alias
environment.shellAliases = {
  au = "sudo nix flake update /etc/nixos";
  c = "clear";
  ll = "ls -la";
  gs = "git status";
  aa = "sudo nixos-rebuild switch --flake /etc/nixos#nixosvm";
  "ping1" = "ping 1.1.1.1";  # Numeric keys like '1' are invalid; renamed to 'ping1'
  ".." = "cd ..";  # Quotes for special characters
  eip = "curl ifconfig.me";
  lin = "ssh -L 5901:127.0.0.1:5901 pi@lin";
  du = "du -h";
  ne = "cmatrix";
  e = "exit";
  htop = "sudo htop";
  df = "df -h";
  live = "vnstat --live";
};

  # Networking
  networking.hostName = "nixosvm";  # Set hostname to "nixosvm"
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
    terminator
    bash
    coreutils
    neovim
    neofetch
    cmatrix
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
    vlc
    neofetch
    spice-vdagent     # SPICE agent for clipboard sharing
    #qemu-guest-agent  # Guest agent for host-guest communication
    #virtio-drivers    # VirtIO drivers for networking and storage
    mc                # Midnight Commander (added)
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

