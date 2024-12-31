{ config, pkgs, ... }:

{
  ############################################
  # Imports & Basic System Configuration
  ############################################
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader (assumes /dev/vda as root)
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  # Networking
  networking.hostName = "nixos-guest";
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "America/New_York";

  # Locales
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  ############################################
  # Display Server (X11), Display Manager, DE
  ############################################
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # LightDM Display Manager (no auto-login)
  services.xserver.displayManager.lightdm.enable = true;

  # Cinnamon Desktop (older-style option)
  services.xserver.desktopManager.cinnamon.enable = true;

  ############################################
  # SSH, Printing, PipeWire
  ############################################
  services.openssh.enable = true;
  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  ############################################
  # Users & Passwordless Sudo
  ############################################
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  users.users.pi = {
    isNormalUser = true;
    description = "pi";
    extraGroups = [ "networkmanager" "wheel" ];
    # If you didn't define a password here, use `passwd pi`.
  };

  ############################################
  # Unfree Packages & System Packages
  ############################################
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Basic CLI tools
    git
    curl
    wget
    htop
    bash
    coreutils
    tmux
    neovim
    python3
    nodejs
    openssh
    gdb
    openssl
    sqlite
    emacs
    nano
    alacritty
    rxvt-unicode
    gnome-terminal
    konsole
    terminator

    # Browsers
    firefox
    brave
    chromium

    # Build Tools
    gcc
    gnumake
    cmake

    # Utilities
    vlc
    mpv
    ffmpeg
    sshfs
    figlet
    nmap
    vnstat
    neofetch
    mc
    autossh
    proxychains
    rclone
    unzip
    traceroute
    cmatrix
  ];

  ############################################
  # Firewall
  ############################################
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  ############################################
  # System State
  ############################################
  system.stateVersion = "24.11";
}


