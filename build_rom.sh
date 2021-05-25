# sync rom
repo init --depth=1 -u https://github.com/Project-Xtended/manifest.git -b xr -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Hashimkp/local_manifests.git --depth 1 -b aosp .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch xtended_RMX1971-userdebug
make xtended -j$(nproc --all)

# upload rom
rclone copy out/target/product/RMX1971/Xtended*.zip cirrus:RMX1971 -P
