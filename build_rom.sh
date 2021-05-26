# sync rom
repo init --depth=1 -u https://github.com/CherishOS/android_manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/HyperNotAryanX97/Begonia -b backup .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch cherish_begonia-userdebug
#dont remove the \ , it helps patch users
brunch begonia \
	&& repo forall -c 'git checkout .' || repo forall -c 'git checkout'

# upload rom
# If you need to upload json/multiple files too then put like this
#rclone copy out/target/product/mido/*.zip cirrus:mido -P
#rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/mido/*.zip cirrus:begonia -P
