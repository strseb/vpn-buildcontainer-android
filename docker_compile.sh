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
cp -r .tmp/src/android-build/build/outputs  /mnt/android-build/

echo "Stats for ccache:"
ccache -s
echo "Recomporessing, plz wait"
