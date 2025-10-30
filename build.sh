# Copy our wallpaper into the image
cp -r files/* /

# Set as default GNOME wallpaper
mkdir -p /usr/share/glib-2.0/schemas
cat > /usr/share/glib-2.0/schemas/90-aba-wallpaper.gschema.override <<'EOF'
[org.gnome.desktop.background]
picture-uri='file:///usr/share/backgrounds/aba-wallpaper.png'
picture-options='zoom'
EOF
glib-compile-schemas /usr/share/glib-2.0/schemas
