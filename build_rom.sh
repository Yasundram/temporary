# sync rom
repo init --depth=1 -u git://github.com/PotatoProject/manifest.git -b dumaloo-release -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Dustxyz/personal_manifest.git --depth 1 -b posp .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8  

# build rom
sudo apt install -y python2
. build/envsetup.sh
lunch potato_ysl-userdebug
brunch ysl -j$(nproc --all)

# upload rom
rclone copy out/target/product/ysl/*.zip cirrus:ysl -P 
