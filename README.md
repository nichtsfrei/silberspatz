# Silberspatz - My Custom Silverblue Image

Silberspatz is my personal custom Fedora Silverblue image built using the Universal Blue template. This image represents my specific workflow and preferences for a productive Linux environment.

## Overview

This is a specialized Fedora Silverblue image that I've customized for my own needs and workflow. It's built on top of the Universal Blue template but includes my personal preferences and tools.

## Key Features

- **Modern Tiling Window Manager**: Niri with custom configuration
- **Enhanced Productivity Tools**: Neovim, Fish shell, tmux
- **Custom Keyboard Mapping**: Kanata keyboard layout configurator
- **CLI Tools**: System management, development utilities
- **Custom Hardware Support**: udev rules, keyboard mappings
- **Terminal Applications**: foot, fuzzel, btop, bat, fzf
- **Security**: U2F support via pam-u2f, enhanced PAM configurations

## Architecture

### Core Technologies
- **bootc**: Container-native OS approach for Fedora Silverblue
- **Podman**: Container management
- **Niri**: Tiling Wayland compositor
- **Kanata**: Keyboard layout configurator

### System Components
- Fedora Silverblue base with ostree containerization
- Custom build scripts and containerfile
- Automated disk image generation (ISO, qcow2, raw)
- Security configurations with PAM and u2f

## Installation and Setup

### Prerequisites
- System running Fedora Silverblue or compatible bootc image
- GitHub access for repository management
- Basic CLI familiarity

### Installation Options

1. **Direct bootc installation**:
   ```bash
   sudo bootc switch ghcr.io/nichtsfrei/silberspatz:latest
   ```

2. **Building from source**:
   ```bash
   just build
   ```

3. **Creating disk images**:
   ```bash
   just build-iso
   just build-qcow2
   ```

## Development and Customization

### Build Process
- Uses Justfile for build automation
- Container-based build using Podman
- Bootc Image Builder (BIB) for disk images
- Automated VM running with systemd-vmspawn

### Customization Points
- Modify `build_files/build.sh` to add/remove packages
- Adjust `system_files/etc/niri/config.kdl` for window manager settings
- Update `Containerfile` to change base image or add tools
- Customize `disk_config/iso.toml` for disk image generation

### Custom Tools Included
- Kanata: Keyboard layout configurator
- Various CLI productivity tools (btop, bat, fzf, ripgrep)

## Security Configuration

- U2F security key support via pam-u2f
- Enhanced security configurations through PAM
- Systemd user services for secure credential management
- Secure development workflow with distrobox

## Repository Structure

```
silberspatz/
├── README.md            # This file
├── Justfile           # Build automation
├── Containerfile        # Image build definition
├── build_files/         # Build scripts and utilities
├── disk_config/         # Disk image configurations
├── system_files/        # System configuration files
└── LICENSE            # License information
```

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

## Related Projects

This image is built on the Universal Blue template, which is designed for creating custom bootc images. For more information about the template and how to use it for your own projects, refer to the Universal Blue project documentation.

## License

This project is licensed under the Apache License, Version 2.0 - see the LICENSE file for details.

## Contributing

This is my personal project built for my own workflow and preferences. While the repository is open, it's not intended for general contribution. Feel free to fork and customize for your own needs.

## Support

This is my personal image, so support is limited. Feel free to explore the upstream projects or fork this repository to create your own version.
