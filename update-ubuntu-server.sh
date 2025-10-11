#!/bin/bash

# Ubuntu Server Update and Developer Tools Installation Script
# This script updates the system and installs essential developer tools
# Run with sudo privileges: sudo ./ubuntu_setup.sh

set -e # Exit on any error

echo "========================================="
echo "Ubuntu Server Setup Script"
echo "========================================="
echo "Starting system update and developer tools installation..."
echo ""

# Function to print colored output
print_status() {
  echo -e "\e[32m[INFO]\e[0m $1"
}

print_error() {
  echo -e "\e[31m[ERROR]\e[0m $1"
}

print_warning() {
  echo -e "\e[33m[WARNING]\e[0m $1"
}

# Check if running as root/sudo
if [[ $EUID -eq 0 ]]; then
  print_warning "Running as root. This is recommended for system updates."
else
  print_error "This script requires sudo privileges. Please run: sudo $0"
  exit 1
fi

# Update package lists
print_status "Updating package lists..."
apt update

# Upgrade existing packages
print_status "Upgrading existing packages..."
apt upgrade -y

# Install essential system tools
print_status "Installing essential system tools..."
apt install -y \
  curl \
  wget \
  unzip \
  zip \
  tar \
  gzip \
  tree \
  htop \
  neofetch \
  yazi

# Install version control systems
print_status "Installing version control systems..."
apt install -y \
  git \
  subversion

# Display system information
print_status "Installation completed! Here's your system info:"
echo ""
neofetch

print_status "Installed tools versions:"
echo "Git: $(git --version)"

echo ""
echo "========================================="
echo "Setup Complete!"
echo "========================================="
echo "Essential developer tools have been installed."
echo "Please reboot your system to ensure all changes take effect."
echo ""
echo "Note: If you added users to the docker group, they need to"
echo "log out and back in for the changes to take effect."
echo ""
echo "To reboot now, run: sudo reboot"
