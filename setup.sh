#!/usr/bin/env bash
set -e

# ---------- Colors ----------
RED="\033[1;31m"
GREEN="\033[1;32m"
CYAN="\033[1;36m"
RESET="\033[0m"

# ---------- Spinner ----------
spinner() {
  local pid=$1
  local delay=0.08
  local spinstr='|/-\'
  while ps -p $pid > /dev/null 2>&1; do
    local temp=${spinstr#?}
    printf " [%c]  " "$spinstr"
    spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    printf "\b\b\b\b\b\b"
  done
  printf "    \b\b\b\b"
}

run_step() {
  echo -e "${CYAN}>> $1${RESET}"
  shift
  ("$@" >/dev/null 2>&1) &
  spinner $!
  wait $!
  echo -e "${GREEN}✔ Done${RESET}"
}

# ---------- Base ----------
run_step "Installing core packages" sudo pacman -S --needed --noconfirm \
  base-devel git curl wget unzip networkmanager zsh

run_step "Installing dev tools" sudo pacman -S --needed --noconfirm \
  go rust cargo python python-pip python-virtualenv \
  ccache lld gettext ffmpegthumbnailer imagemagick

# ---------- Hyprland ----------
run_step "Installing Hyprland stack" sudo pacman -S --needed --noconfirm \
  hyprland hyprlock hypridle \
  xdg-desktop-portal-hyprland \
  wayland wayland-protocols wl-clipboard grim slurp

# ---------- UI ----------
run_step "Installing UI tools" sudo pacman -S --needed --noconfirm \
  waybar rofi-wayland swaync nwg-look

# ---------- Terminals ----------
run_step "Installing terminals" sudo pacman -S --needed --noconfirm \
  alacritty kitty

# ---------- Theming ----------
run_step "Installing themes and GTK" sudo pacman -S --needed --noconfirm \
  gtk3 gtk4 papirus-icon-theme lxappearance

# ---------- Fonts ----------
run_step "Installing fonts" sudo pacman -S --needed --noconfirm \
  ttf-jetbrains-mono noto-fonts noto-fonts-emoji ttf-font-awesome

# ---------- Audio ----------
run_step "Installing audio stack" sudo pacman -S --needed --noconfirm \
  pipewire pipewire-alsa pipewire-pulse wireplumber

# ---------- Bluetooth ----------
run_step "Installing bluetooth" sudo pacman -S --needed --noconfirm \
  bluez bluez-utils

# ---------- Utilities ----------
run_step "Installing utilities" sudo pacman -S --needed --noconfirm \
  brightnessctl playerctl network-manager-applet pavucontrol fastfetch

# ---------- Enable services ----------
run_step "Enabling services" sudo systemctl enable NetworkManager bluetooth

# ---------- Install yay ----------
if ! command -v yay &>/dev/null; then
  echo -e "${CYAN}>> Installing yay${RESET}"
  git clone https://aur.archlinux.org/yay.git /tmp/yay >/dev/null 2>&1
  cd /tmp/yay
  makepkg -si --noconfirm >/dev/null 2>&1 &
  spinner $!
  wait $!
  cd ~
  echo -e "${GREEN}✔ yay installed${RESET}"
fi

# ---------- Install paru ----------
if ! command -v paru &>/dev/null; then
  echo -e "${CYAN}>> Installing paru${RESET}"
  git clone https://aur.archlinux.org/paru.git /tmp/paru >/dev/null 2>&1
  cd /tmp/paru
  makepkg -si --noconfirm >/dev/null 2>&1 &
  spinner $!
  wait $!
  cd ~
  echo -e "${GREEN}✔ paru installed${RESET}"
fi

# ---------- AUR packages ----------
run_step "Installing AUR packages" yay -S --needed --noconfirm \
  wallust \
  catppuccin-gtk-theme-mocha \
  ttf-jetbrains-mono-nerd \
  ghostty

# ---------- Cargo tools ----------
run_step "Installing cargo tools" cargo install matugen

echo -e "${GREEN}All done. Reboot and start Hyprland.${RESET}"
