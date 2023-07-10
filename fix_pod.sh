cd ios;
pod deintegrate;
rm -f Podfile.lock;
pod install --repo-update;
cd ..;