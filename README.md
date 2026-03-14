# Silberspatz - My Custom Silverblue Image

Silberspatz is my personal custom Fedora Silverblue image built using the Universal Blue template. This image represents my specific workflow and preferences for a productive Linux environment.

## Overview

This is a specialized Fedora Silverblue image that I've customized for my own needs and workflow. It's built on top of the Universal Blue template but includes my personal preferences and tools.

Key features include:
- A modern tiling window manager (Niri) with my custom configuration
- Enhanced productivity tools (Neovim, Fish shell, tmux)
- Custom keyboard mapping with Kanata
- On-screen keyboard utility (OnScreenSki)
- Command-line tools for system management and development
- Custom hardware configuration
- Pre-configured terminal and application settings

## Architecture and Components

The image is built using:
- **bootc**: Container-native OS approach for Fedora Silverblue
- **Podman**: Container management
- **Niri**: A tiling Wayland compositor
- **Kanata**: A keyboard layout configurator
- **OnScreenSki**: An on-screen keyboard utility
- **Various custom tools**: For system management, terminal enhancement, and security

## Installation and Setup

### Prerequisites
- A system running Fedora Silverblue or compatible bootc image
- Access to GitHub for repository management
- Basic familiarity with CLI tools

### Installation Options

1. **Using bootc directly**:
   ```bash
   sudo bootc switch ghcr.io/nichtsfrei/silberspatz:latest
   ```

2. **Building from source**:
   ```bash
   just build
   ```

3. **Creating disk images (ISO, qcow2, raw)**:
   ```bash
   just build-iso
   just build-qcow2
   ```

## Key Features

### Window Management
- Uses [Niri](https://github.com/YaLTeR/niri) as the tiling window manager
- Custom configuration with keybindings, workspaces, and layouts
- Configured workspaces for different purposes (root, chat, game)

### Terminal and Development
- Enhanced terminal setup with Fish shell and tmux
- Pre-configured Neovim with custom settings
- Productivity tools and CLI utilities
- Support for containerized development with distrobox

### Security and Authentication
- U2F security key support via pam-u2f
- Enhanced security configurations through PAM
- Systemd user services for secure credential management

### Custom Hardware Support
- Custom udev rules for input devices
- Hardware-specific configurations
- Custom keyboard mappings with Kanata

### Applications
- Firefox removal (as a customization choice)
- Terminal applications like foot, fuzzel
- System monitoring tools (btop, bat)
- Development and productivity utilities

## Configuration

### Niri Configuration
The Niri window manager is configured with:
- Custom keybindings for window management and application launching
- Workspace organization for different tasks
- Visual customization and animation settings
- Input device configurations

### Terminal Setup
- Foot terminal with custom font and color scheme
- Fish shell with enhanced configuration
- tmux for terminal multiplexing

## Building from Source

To build the image locally:

1. Clone this repository
2. Generate a signing key pair:
   ```bash
   cosign generate-key-pair
   ```
3. Set up GitHub secrets for container signing
4. Run:
   ```bash
   just build
   ```

## Customization

This image serves as a template that can be easily customized:
- Modify `build_files/build.sh` to add/remove packages
- Adjust `system_files/etc/niri/config.kdl` for window manager settings
- Update `Containerfile` to change base image or add tools
- Customize `disk_config/iso.toml` for disk image generation

## Related Projects

This image is built on the Universal Blue template, which is designed for creating custom bootc images. For more information about the template and how to use it for your own projects, refer to the Universal Blue project documentation.

## License

This project is licensed under the Apache License, Version 2.0 - see the LICENSE file for details.

## Contributing

This is my personal project built for my own workflow and preferences. While the repository is open, it's not intended for general contribution. Feel free to fork and customize for your own needs.

## Support

This is my personal image, so support is limited. Feel free to explore the upstream projects or fork this repository to create your own version.
