#! /bin/bash

WORKSPACE_PATH=$(readlink -f "$(dirname "$0")")

TOOLCHAIN_PATH=/toolchains/armhf_eabi_14.2.rel1

source ${TOOLCHAIN_PATH}/setup.sh

make clean
make