#!/usr/bin/env bash

set -e

sudo add-apt-repository -y universe
sudo apt-get -q update



function install_miktex {
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889
    if [[ $(lsb_release -rs) == "18.04" ]]; then # replace 8.04 by the number of release you want
        echo "deb http://miktex.org/download/ubuntu bionic universe" | sudo tee /etc/apt/sources.list.d/miktex.list
    elif [[ $(lsb_release -rs) == "20.04" ]]; then # replace 8.04 by the number of release you want
        echo "deb http://miktex.org/download/ubuntu focal universe" | sudo tee /etc/apt/sources.list.d/miktex.list
    else
        echo "Not supported"
        exit
    fi
    sudo apt-get update
    sudo apt-get install miktex
    sudo miktexsetup --shared=yes finish
    sudo initexmf --admin --set-config-value [MPM]AutoInstall=1
}

if ! command -v latex &> /dev/null
then
    echo "Install MikTex"
    install_miktex
fi

sudo apt-get install -y texlive rubber