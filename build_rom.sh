# sync rom
repo init --depth=1 -u git://github.com/DerpFest-11/manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/DhruvChhura/manifest_personal.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Build Rom

source build/envsetup.sh
lunch derp_ysl-user
make bacon

# upload rom
rclone copy out/target/product/ysl/*2021*.zip cirrus:ysl -P
