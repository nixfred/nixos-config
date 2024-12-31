# NixOS Configuration with Flakes

This repository contains the configuration files for a NixOS system using Flakes. It provides a fully declarative system configuration for a Cinnamon-based desktop environment with essential tools, development utilities, and virtual machine support.

## Features

- **Flake-Based Configuration**: Ensures reproducible system builds.
- **Cinnamon Desktop Environment**: Lightweight and user-friendly.
- **Essential Tools**: Includes utilities, browsers, and development tools.
- **VM Integration**: Clipboard sharing via `spice-vdagent`.

## Files

### 1. `flake.nix`

The entry point for the NixOS flake. It defines:
- The `nixpkgs` input.
- The `outputs` section that points to the `configuration.nix` file.
- System architecture (`x86_64-linux`).

### 2. `configuration.nix`

The main system configuration file. It includes:
- **Flakes Enablement**: Allows `nix-command` and `flakes` features.
- **Display and Desktop**: Configures X11, LightDM, and Cinnamon.
- **Networking**: Uses `NetworkManager` for network management.
- **Package Management**: Declares system-wide packages, including:
  - Basic tools: `git`, `curl`, `wget`, `htop`
  - Browsers: `firefox`, `brave`
  - Development: `python3`, `gcc`, `cmake`
  - Utilities: `vlc`, `neofetch`, `spice-vdagent`
- **User Management**: Adds a user (`pi`) with passwordless `sudo`.

---

## Getting Started

### Prerequisites

Ensure you have:
1. A NixOS installation.
2. The `nix-command` and `flakes` features enabled.

### Clone the Repository

```bash
git clone https://github.com/your-username/nixos-config.git
cd nixos-config
```

### Apply the Configuration

1. Copy the files to `/etc/nixos`:
   ```bash
   sudo cp flake.nix configuration.nix /etc/nixos/
   ```

2. Remove any existing `flake.lock` file:
   ```bash
   sudo rm /etc/nixos/flake.lock
   ```

3. Rebuild the system:
   ```bash
   sudo nixos-rebuild switch --flake /etc/nixos
   ```

---

## Customization

- **Add Packages**: Edit the `environment.systemPackages` section in `configuration.nix` to include additional software.
- **Change Desktop Environment**: Replace `cinnamon` with another desktop manager if needed.
- **Enable Services**: Modify the `services` section to add or configure additional system services.

---

## Troubleshooting

### Missing Packages
If you encounter errors about missing packages during the build process:
1. Check if the package exists in your Nix channel:
   ```bash
   nix search nixpkgs <package-name>
   ```
2. Add or remove packages in `configuration.nix`.

### Flake-Related Issues
Ensure `flakes` and `nix-command` are enabled in your NixOS configuration:
```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

---

## Contributing

Contributions are welcome! Feel free to submit pull requests or open issues to improve this configuration.

---

## License

This repository is licensed under the [MIT License](LICENSE).

---

Let me know if you want to adjust any details or add additional sections! 🚀
