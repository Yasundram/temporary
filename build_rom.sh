# sync rom
repo init --depth=1 -u git://github.com/LineageOS/android.git -b lineage-16.0 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/ItsVixano/local_manifest --depth 1 -b daisy-pie .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Install imagemagick
sudo apt update -y && sudo apt install imagemagick python bc bsdmainutils -y

# build rom
source build/envsetup.sh
lunch lineage_daisy-userdebug
croot
brunch daisy
#if you are a patch user (which is really not normal and not recommended), then must put like this, `m aex || repo forall -c 'git checkout .'

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/daisy/lineage-16.0*.zip cirrus:daisy -P
