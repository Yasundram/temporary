# sync rom
repo init --depth=1 -u https://github.com/NezukoOS/manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Fraschze97/local_manifest.git --depth=1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# patches
cd external/selinux
curl -LO https://github.com/PixelExperience/external_selinux/commit/9d6ebe89430ffe0aeeb156f572b2a810f9dc98cc.patch
patch -p1 < *.patch
cd ../..

cd frameworks/opt/net/ims
curl -LO  https://github.com/PixelExperience/frameworks_opt_net_ims/commit/661ae9749b5ea7959aa913f2264dc5e170c63a0a.patch
patch -p1 < *.patch
cd ../..

# build rom
source build/envsetup.sh
lunch nezuko_RMX1941-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
export USE_GAPPS=true
export SKIP_ABI_CHECKS=true
export SKIP_API_CHECKS=true
export CUSTOM_BUILD_TYPE=UNOFFICIAL
mka bacon -j$(nproc --all)

# upload rom to rclone
rclone copy out/target/product/RMX1941/*NEZUKO*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d _ -f 2 | cut -d - -f 1) -P

