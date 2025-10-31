#!/usr/bin/env bash
set -oue pipefail

# Copy overlay from the mounted context (/ctx) into the image root
if [[ -d /ctx/files ]]; then
  cp -r /ctx/files/* /
fi

# Set default GNOME wallpaper
mkdir -p /usr/share/glib-2.0/schemas
cat > /usr/share/glib-2.0/schemas/90-aba-wallpaper.gschema.override <<'GSOVR'
[org.gnome.desktop.background]
picture-uri='file:///usr/share/backgrounds/aba-wallpaper.png'
picture-uri-dark='file:///usr/share/backgrounds/aba-wallpaper.png'
picture-options='zoom'
GSOVR

# Ensure PLATFORM_ID exists for bootc-image-builder
if ! grep -q '^PLATFORM_ID=' /usr/lib/os-release; then
  VID="$(. /usr/lib/os-release; echo "${VERSION_ID:-}")"
  if [ -n "$VID" ]; then
    echo "PLATFORM_ID=platform:f${VID}" >> /usr/lib/os-release
  else
    # Fallback (Fedora 41+ base is common for Bluefin/Bazzite)
    echo "PLATFORM_ID=platform:f41" >> /usr/lib/os-release
  fi
fi

glib-compile-schemas /usr/share/glib-2.0/schemas
