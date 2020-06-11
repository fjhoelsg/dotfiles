#!/bin/sh

# Close System Preferences
osascript -e 'tell application "System Preferences" to quit'

# General
defaults write com.apple.menuextra.battery ShowPercent -string "YES"                    # Show battery percentage
defaults write -g AppleShowScrollBars -string "WhenScrolling"                           # Only show scroll bars when scrolling
defaults write NSGlobalDomain NSWindowResizeTime .001                                   # Make save dialog animations faster
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false                      # Disable autocorrect
defaults write -g ApplePressAndHoldEnabled -bool false                                  # Enable key repeat
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false                # Enable key repeat in visual studio code
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true                    # Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true   # Enable tap to click
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1                        # Enable tap to click
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true             # Do not prompt to use new drives as Time Machine backups
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false                         # Do not save to iCloud by default
defaults write NSGlobalDomain AppleFontSmoothing -int 2                                 # Enable subpixel font rendering on non-Apple LCDs

# Security
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on                # Enable Firewall
sudo spctl --master-enable                                                              # Enable Gatekeeper
defaults write com.apple.screensaver askForPassword -int 1                              # Require password when screensaver is active
defaults write com.apple.screensaver askForPasswordDelay -int 0                         # Disable delay for password when screensaver is active

# Terminal
defaults write com.apple.terminal SecureKeyboardEntry -bool true                        # Enable secure keyboard entry
defaults write com.apple.terminal FocusFollowsMouse -bool true                          # Enable follow mouse

# Finder
defaults write -g AppleShowAllExtensions -bool true                                     # Show file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false              # Disable the warning when changing a file extension
defaults write com.apple.finder DisableAllAnimations -bool true                         # Disable animations
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"                     # Set default search scope to current folder
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false                     # Hide icons for internal drives on desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true              # Show icons for external drives on desktop
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true                  # Show icons for network drives on desktop
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true                  # Show icons for removable media on desktop
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true                # Do not create .DS_Store files in usb drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true            # Do not create .DS_Store files in network drives
defaults write com.apple.finder NewWindowTarget -string "PfLo"                          # Set home as default location for new Finder windows
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"            # Set home as default location for new Finder windows
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"                     # Use list view in all Finder windows by default
defaults write com.apple.finder WarnOnEmptyTrash -bool false                            # Disable the warning when emptying trash
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true                  # Enable AirDrop over ethernet

# Text and Encodings
defaults write com.apple.TextEdit RichText -int 0                                       # Use plain text mode for new TextEdit doucments
defaults write com.apple.TextEdit PlainTextEncoding -int 4                              # Open TextEdit files with UTF-8 encoding
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4                      # Write TextEdit files with UTF-8 encoding
defaults write com.apple.terminal StringEncodings -array 4                              # Use UTF-8 encoding in terminal

# Dock
defaults write com.apple.dock minimize-to-application -bool true                        # Minimize windows into their application’s icon
defaults write com.apple.dock show-process-indicators -bool true                        # Show indicator lights for open applications

# Mission Control
defaults write com.apple.dock expose-animation-duration -float 0.1                      # Speed up animations
defaults write com.apple.dashboard mcx-disabled -bool true                              # Disable Dashboard
defaults write com.apple.dock dashboard-in-overlay -bool true                           # Do not show Dashboard as a space
defaults write com.apple.dock mru-spaces -bool false                                    # Do not automatically rearrange spaces

# Kill affected applications
for app in "cfprefsd" "Dock" "Finder" "SystemUIServer"; do
	killall "${app}" &> /dev/null
done

# Install Xcode tools
xcode-select --install

# Homebrew
if ! $(command -v brew >/dev/null 2>&1 || { exit 1; }); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
brew analytics off
brew update
brew upgrade
brew install coreutils
brew install dash
brew cask install dotnet
brew install findutils
brew install git
brew install git-lfs
brew install gnu-sed
brew install gnu-tar
brew install golang
brew install grep
brew install htop
brew install imagemagick
brew install kubectl
brew install moreutils
brew install neovim
brew install nodejs
brew install npm
brew install openssh
brew install openjdk@11
brew install python
brew install reattach-to-user-namespace
brew install ssh-copy-id
brew install tmux
brew install tree
brew install watch
brew install wget
brew install zsh
brew cleanup

# Replace default shell with dash
ln -sf "$(which dash)" /usr/local/bin/sh

# Setup system Java
sudo ln -sfn /usr/local/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk

# Add brew zsh to shells
sudo sh -c 'echo $(brew --prefix)/bin/zsh >> /etc/shells'
