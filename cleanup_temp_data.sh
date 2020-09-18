# https://stackoverflow.com/questions/29930198/can-i-delete-data-from-ios-devicesupport

rm -rf ~/git/Unity/*/Builds/Android/*
rm -rf ~/git/Unity/*/Builds/Mac/*

# xcode junk
rm -rf /Users/user/Library/Developer/Xcode/DerivedData

# xcode device support - will be rebuilt
rm -rf '/Users/user/Library/Developer/Xcode/iOS DeviceSupport'

# xcode App Archives
rm -rf /Users/user/Library/Developer/Xcode/Archives/

# xcode iOS Builds
rm -rf ~/git/Unity/*/Builds/iOS/*


# HARD

# Unity asset store downloads
# rm -rf "/Users/user/Library/Unity/Asset Store-5.x"
# Unity imports Library
#rm -rf ~/git/Unity/*/Library
