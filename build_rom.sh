# sync rom
repo init --depth=1 -u git://github.com/lighthouse-os/manifest.git -b raft -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Stealth1226/local_manifest --depth=1 -b raphael .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
mkdir hardware/qcom/display/config/
cp -ar hardware/qcom-caf/sm8150/display/config/*.xml hardware/qcom/display/config/
brunch raphael
#if you are a patch user (which is really not normal and not recommended), then must put like this, " m aex || repo forall -c 'git checkout .' "

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/raphael/*OFFICIAL*.zip raphael:mido -P
