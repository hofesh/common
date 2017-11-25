#! bash

# show hidden dock apps
defaults write com.apple.Dock showhidden -bool YES
killall Dock

# show hidden files in finder
defaults write com.apple.finder AppleShowAllFiles YES
killall Dock
