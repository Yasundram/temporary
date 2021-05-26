# sync rom
repo init -u https://github.com/NusantaraProject-ROM/android_manifest -b 11 --depth=1 -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/Fraschze97/local_manifest --depth=1 -b nusantara .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8


# Patches
cd external/selinux
curl -LO  https://github.com/PixelExperience/external_selinux/commit/9d6ebe89430ffe0aeeb156f572b2a810f9dc98cc.patch
patch -p1 < *.patch
cd ../..

cd platform/frameworks/av
curl -LO https://github.com/phhusson/platform_frameworks_av/commit/624cfc90b8bedb024f289772960f3cd7072fa940.patch
patch -p1 < *.patch
cd ../../../..

cd frameworks/opt/net/ims
curl -LO https://github.com/PixelExperience/frameworks_opt_net_ims/commit/661ae9749b5ea7959aa913f2264dc5e170c63a0ah.patch
patch -p1 < *.patch
cd ../../../..

# build
. build/envsetup.sh
lunch nad_RMX1941-userdebug
export USE_GAPPS=true
export SELINUX_IGNORE_NEVERALLOWS=true
mka nad

# upload 
rclone copy out/target/product/RMX1941/*.zip cirrus:RMX1941 -P 
