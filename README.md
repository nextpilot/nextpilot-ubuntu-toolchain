# NextPilot Develop Toolchain for Ubuntu

`nextpilot-ubuntu-toolchain` is the develop toolchain for [nextpilot-flight-control](https://github.com/nextpilot/nextpilot-flight-control.git) in Ubuntu.

the script `init.sh` will update/install/configure the follow tools：

- git
- python, pip, scons, kconfiglib, mkdocs etc, see [requirements.txt](requirements.txt)
- gcc-arm-none-eabi
- qemu-system-arm

## how to start

clone this repo to `~/.ndt`, or any other directory

```shell
git clone -depth=1 https://github.com/nextpilot/nextpilot-ubunut-toolchain.git ~/.ndt
```

`source ~/.ndt/init.sh` to activate toolchain, when first run `init.sh` will install toolchain and create python venv

```shell
source ~/.ndt/init.sh
```

change to [nextpilot-flight-control](https://github.com/nextpilot/nextpilot-flight-control.git) bsp folder, for example:

```shell
cd ~/nextpilot-flight-control/bsps/sitl/qemu 
```

before build or config bsp, must run `source ~/.ndt/init.sh` firstly to activate toolchain.

```shell
# activate toolchain
source ~/.ndt/init.sh

# config project, only for developer
scons --menuconfig
scons --guiconfig

# build project
scons
scons default -j10

# run sitl
./qemu.sh

```
