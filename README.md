# NextPilot Develop Toolchain for Ubuntu

nextpilot-ubuntu-toolchain is the develop toolchain for [nextpilot-flight-control](https://github.com/nextpilot/nextpilot-flight-control.git) in Ubuntu.

the script `init.sh` will update/install/configure the follow tools：

- git
- python, pip, scons, kconfiglib, mkdocs etc, see [requirements.txt](requirements.txt)
- gcc-arm-none-eabi
- qemu-system-arm

## how to start

clone repo to `~/.npdt`, or any other directory

```shell
git clone -depth=1 https://github.com/nextpilot/nextpilot-ubunut-toolchain.git ~/.npdt
```

`source ~/.npdt/init.sh` to activate toolchain, when first run `init.sh`, will install toolchain and create python venv, but later only activate environment

```shell
source ~/.npdt/init.sh
```

change to [nextpilot-flight-control](https://github.com/nextpilot/nextpilot-flight-control.git) bsp folder, for example:

```shell
cd ~/nextpilot-flight-control/bsps/sitl/qemu 
```

build or config current bsp, must run `source ~/.npdt/init.sh` before.

```shell
# activate toolchain
source ~/.npdt/init.sh

# build project
scons

# config project
menuconfig
```
