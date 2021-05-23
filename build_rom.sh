# sync rom
repo init --depth=1 -u https://github.com/P-404/platform_manifest -b rippa -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/MLZ94/local_manifest -b p404 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
 
# build rom
source build/envsetup.sh
lunch p404_X00QD-userdebug
make p404

# upload rom
rclone copy out/target/product/X00QD/*2021*.zip cirrus:X00QD -P
