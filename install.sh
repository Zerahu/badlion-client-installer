#!/bin/bash

# Ensure script is run as a normal user, not root
if [[ $EUID -eq 0 ]]; then
    echo "Please do not run this script directly as root."
    exit 1
fi

echo "Script requires sudo priviledges: "
sudo echo " "

if ! command -v wget &>/dev/null; then
  echo "wget is not installed. Make sure to install it before running this script!"
  exit 1
fi

wget -O BadlionClient "https://client-updates-cdn77.badlion.net/BadlionClient"


if [ -f "BadlionClient" ]; then
    chmod a+x BadlionClient
    sudo mv BadlionClient /usr/bin

    sudo wget -O /usr/share/icons/badlion-client.png "https://assets.badlion.net/cdn-cgi/image/width=300,f=auto/site/assets/badlion-logo.webp"

    echo """
[Desktop Entry]
Name=Badlion Client
StartupWMClass=Badlion Client
Comment=Badlion Client
GenericName=Minecraft Client Badlion pvp
Exec=/usr/bin/BadlionClient %U
Icon=badlion-client
Type=Application
StartupNotify=true
Categories=Minecraft;Gaming;Client;Modpack;
""" > badlion-client.desktop

    sudo mv badlion-client.desktop /usr/share/applications/badlion-client.desktop

    exit 0

else
    echo "Make sure to navigate to the folder where badlion is located first!"
    exit 1
fi
