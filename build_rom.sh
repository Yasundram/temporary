# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/DerpFest-11/manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/pocox3pro/Local-Manifests.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# patch
cd frameworks/base && rm -rf *.patch && curl -LO https://github.com/amanrajOO7/frameworks_base/commit/9d2bc956704f692fabb5b0639b60a8c6d241ca49.patch && patch -p1 < *.patch && cd -
cd packages/apps/Settings/DerpQuest && rm -rf *.patch && curl -LO https://github.com/amanrajOO7/packages_apps_DerpQuest/commit/d8568c7f7be50c581dc6c710486e5c74a066488e.patch && patch -p1 < *.patch && cd -

# build rom
source build/envsetup.sh
lunch derp_vayu-user
mka derp

# upload rom
rclone copy out/target/product/vayu/DerpFest*.zip cirrus:vayu -P
