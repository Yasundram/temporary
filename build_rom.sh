
# sync rom
repo init --depth=1 -u git://github.com/DerpFest-11/manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/P-Salik/local_manifest --depth=1 -b DerpFest .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Patches
cd frameworks/base
curl -LO https://github.com/PixelExperience/frameworks_base/commit/37f5a323245b0fd6269752742a2eb7aa3cae24a7.patch
patch -p1 < *.patch
cd ../..

cd frameworks/opt/net/wifi
curl -LO https://github.com/PixelExperience/frameworks_opt_net_wifi/commit/3bd2c14fbda9c079a4dc39ff4601ba54da589609.patch
patch -p1 < *.patch
cd ../../../..

# build
. build/envsetup.sh
lunch derp_RMX1941-userdebug
mka derp

# upload build
rclone copy out/target/product/RMX1941/*UNOFFICIAL*.zip cirrus:RMX1941 -P
