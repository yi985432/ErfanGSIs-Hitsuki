#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    distro=$(awk -F= '$1 == "ID" {print $2}' /etc/os-release)
    if [[ "$distro" == "arch" ]]; then
        echo "-> Arch Linux Detected"
        sudo pacman -S --needed unace unrar zip unzip p7zip sharutils uudeview arj cabextract file-roller dtc xz python-pip brotli lz4 gawk libmpack aria2
        #aur=rar
        for package in mpack rename; do
            git clone https://aur.archlinux.org/"${package}"
            cd "${package}" || continue
            makepkg -si --skippgpcheck
            cd - || break
            rm -rf "${package}"
        done
    else
        sudo apt install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller device-tree-compiler liblzma-dev python-pip brotli liblz4-tool gawk aria2 rename -y
    fi
    pip install backports.lzma protobuf pycrypto
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install protobuf xz brotli lz4 aria2 liblzma-dev
    pip install backports.lzma protobuf pycrypto
fi
