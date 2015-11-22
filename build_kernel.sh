#!/bin/bash

# Prepare output colouring commands
red=$(tput setaf 1) # Red
grn=$(tput setaf 2) # Green
yel=$(tput setaf 3) # Yellow
blu=$(tput setaf 4) # Blue
txtbld=$(tput bold) # Bold
bldred=${txtbld}${red} # Bold Red
bldgrn=${txtbld}${grn} # Bold Green
bldblu=${txtbld}${blu} # Bold Blue
txtrst=$(tput sgr0) # Reset

echo ""
echo "${bldgrn}Setup: Environment${txtrst}"
echo ""
export ARCH=arm
export CROSS_COMPILE=~/working/kernel/arm-eabi-4.8/bin/arm-eabi-
mkdir output

echo ""
echo "${bldblu}Export:${txtrst} defconfig"
echo ""
make -C $(pwd) O=output VARIANT_DEFCONFIG=msm8226-sec_ms013g_eur_defconfig msm8226-sec_defconfig SELINUX_DEFCONFIG=selinux_defconfig

echo ""
echo "${bldblu} Starting Compiling${txtrst}"
echo ""
echo "${yel}"
make -C $(pwd) O=output

tools/dtbTool -s 2048 -o output/arch/arm/boot/dt.img -p output/scripts/dtc/ output/arch/arm/boot/
echo "${txtrst}"

cp -v output/arch/arm/boot/Image $(pwd)/arch/arm/boot/zImage

