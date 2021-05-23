# sync rom 
repo init --depth=1 -u https://github.com/Wave-Project/manifest -b r -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Shazu-xD/test1.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
brunch RMX1801

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/RMX1801/Wave*.zip cirrus:RMX1801 -P
