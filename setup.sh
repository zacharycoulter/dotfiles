# install xcode tools
xcode-select --install
sudo xcodebuild -license accept

# install homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/zacharycoulter/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# install git
brew install git

# install gnu stow
brew install stow

# clone dotfiles repo
mkdir -p ~/Git/zacharycoulter/dotfiles
git clone https://github.com/zacharycoulter/dotfiles.git ~/Git/zacharycoulter/dotfiles

# run stow
cd ~/Git/zacharycoulter/dotfiles
stow -t ~ */

# install apps from brewfile
brew bundle install

# install packer for nvim and install plugins
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# install tmux plugins
$(brew --prefix tpm)/share/tpm/bin/install_plugins

# use nvm to set up node
nvm install node

# set macos defaults
defaults write -g _HIEnableThemeSwitchHotKey 1 # Set dark mode
defaults write com.apple.dock autohide -bool true && killall Dock 		# Auto hide dock
defaults write com.apple.dock autohide-delay -float 5 && killall Dock 		# Set auto hide delay to 5s
defaults write com.apple.dock no-bouncing -bool TRUE && killall Dock 		# Remove bounce from dock icons
defaults write com.apple.dock minimize-to-application -bool true 		# Minimize application to icon
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true	# Avoiding the creation of .DS_Store files on network volumes
defaults write NSGlobalDomain AppleShowAllExtensions -bool true			# Show all file extensions
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true	# Expanding the save panel
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true	# Expanding the save panel
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true	# Expanding the save panel
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false	# Disabling the warning when changing a file extension
