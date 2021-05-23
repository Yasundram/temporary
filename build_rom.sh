# sync rom
repo init -u https://github.com/Palladium-OS/platform_manifest.git -b 11 --depth=1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/cArN4gEisDeD/local_manifest --depth=1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom      
source build/envsetup.sh
lunch palladium_RMX1941-userdebug
mka palladium
      
# upload rom
rclone copy out/target/product/RMX1941/*UNOFFICIAL*.zip cirrus:RMX1941 -P
   
      
