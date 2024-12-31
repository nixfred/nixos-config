
###############################

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

  # Networking
  networking.hostName = "nixos-flake";
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "America/New_York";

  # Locales
  i18n.defaultLocale = "en_US.UTF-8";

  ############################################
  # Display Server (X11), Display Manager, DE
  ############################################
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.xserver.displayManager.lightdm.enable = true;
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
  networking.firewall.allowedTCPPorts = [ 22 ];

  ############################################
  # System State
  ############################################
  system.stateVersion = "24.11";
}
