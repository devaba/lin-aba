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

glib-compile-schemas /usr/share/glib-2.0/schemas
