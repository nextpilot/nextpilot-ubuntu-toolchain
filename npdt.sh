#! /usr/bin/env bash

echo
echo '******************************************************************'
echo "* Welcome to Nextpilot Develop Envrionment Installer on Ubuntu LTS"
echo '*      _   __             __   ____   _  __        __'
echo '*     / | / /___   _  __ / /_ / __ \ (_)/ /____   / /_'
echo '*    /  |/ // _ \ | |/_// __// /_/ // // // __ \ / __/'
echo '*   / /|  //  __/_>  < / /_ / ____// // // /_/ // /_'
echo '*  /_/ |_/ \___//_/|_| \__//_/    /_//_/ \____/ \__/'
echo '*'
echo '* Copyright All Reserved 2015-2024 NextPilot Development Team'
echo '******************************************************************'

script_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
ubuntu_release="$(lsb_release -rs)"

if [ "$ubuntu_release" != "22.04" ] && [ "$ubuntu_release" != "20.04" ]; then
    echo
    echo "Error: only support Ubuntu 20.04/22.04, but current $ubuntu_release"
    exit 1
fi

# 是否命令行选用镜像服务器
using_mirror=0
need_install=0
for arg in "$@"; do
    if [ "$arg" == "--china" ]; then
        using_mirror=1
    fi
    if [ "$arg" == "--install" ]; then
        need_install=1
    fi
done

# 根据时区选择镜像服务器
if date -R | grep -q +0800; then
    using_mirror=1
fi

# 判断git是否安装
if [ ! "$(which git)" ]; then
    need_install=1
fi

# 判断python是否安装
if [ ! "$(which python)" ] && [ ! "$(which python3)" ]; then
    need_install=1
fi

# 判断是否首次安装
if [ ! -f "$script_path/install.lock" ]; then
    need_install=1
fi

echo
echo "################################################################"
echo "install ubuntu dependencies"
echo "################################################################"
echo "Ubuntu Version $(lsb_release -rs)"
if [ "$need_install" == "1" ]; then
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install -y \
        git \
        gcc gcc-arm-none-eabi binutils-arm-none-eabi gdb-multiarch \
        libncurses5 libncurses5-dev libncursesw5-dev \
        python3 python3-pip python3-venv \
        qemu qemu-system-arm

    # config git http.postBuffer
    git config --global http.postBuffer 524288000

    echo "" >"$script_path/install.lock"
else
    echo "ubuntu dependencies have installed"
fi
echo "----------------------------------------------------------------"
echo "$(git --version) from $(which git)"
echo "----------------------------------------------------------------"
which qemu-system-arm
qemu-system-arm --version
echo "----------------------------------------------------------------"
which arm-none-eabi-gcc
arm-none-eabi-gcc --version

echo
echo "################################################################"
echo "create/activat python venv"
echo "################################################################"
if [ ! -d "$script_path/.venv" ]; then
    python3 -m venv "$script_path/.venv"
    source "$script_path/.venv/bin/activate"
    if [ "$using_mirror" == "1" ]; then
        python3 -m pip config set global.index-url https://mirrors.aliyun.com/pypi/simple
    fi
    python3 -m pip install -r "$script_path/requrement.txt"
else
    echo "python venv have activated"
    source "$script_path/.venv/bin/activate"
fi
echo "----------------------------------------------------------------"
echo "$(python3 -V) from $(which python3)"
pip3 -V
echo "----------------------------------------------------------------"
which scons
scons --version

# echo
# echo "################################################################"
# echo "display toolchain version"
# echo "################################################################"
