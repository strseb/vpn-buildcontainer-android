#!/usr/bin/env bash

echo "Copy project over, i/o is slooow"
rsync --delete -q -av /mnt/client /opt/ --exclude .rcc --exclude .moc --exclude .obj --exclude .tmp --exclude balrog --exclude windows \
    --exclude tools --exclude .git
cd /opt/client
ls
git init
echo "COMPILE!"
./scripts/android/package.sh -d -j 22 $QTPATH
echo "Done, Output is at /mnt/android-build hope you mounted :) "
cp -rp .tmp/src/android-build/build/intermediates/merged_native_libs/debug/out/lib /mnt/android-build/libs
cp -rp .tmp/src/android-build/build/outputs/apk/release /mnt/android-build/apk-release
cp .tmp/src/android-build/mozillavpn.apk  /mnt/android-build/mozillavpn.apk 

echo "Stats for ccache:"
ccache -s
echo "Recomporessing, plz wait"
