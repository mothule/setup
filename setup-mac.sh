#!/usr/bin/env bash -eu
source ./shared/print.sh
source ./shared/bash.sh
source ./shared/bash_profile.sh
source ./shared/atom.sh
source ./mac/homebrew.sh


# Should be installed xcode-select.
if no_installed xcode-select ; then
  error "xcode-select: command not found. Retry after xcode-select installed. \nSee: https://developer.apple.com/download/more/"
  exit 1
fi

if [[ ! -e ~/.bash_profile ]] ; then
  touch ~/.bash_profile
  notice 'created .bash_profile'
fi

info 'Configure alias of bash.'
append_bash_profile 'alias ls="ls -G"'
append_bash_profile 'alias ll="ls -lG"'
append_bash_profile 'alias la="ls -laG"'
reload_bash_profile
info 'Configured.'

# Install Homebrew if not installed yet.
info 'Homebrew check.'
if no_installed brew ; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  info 'Installed Homebrew'
  brew update
  notice 'Updated Homebrew'
  brew upgrade
  notice 'Upgraded all formulas'
else
  notice 'Homebrew already installed.'
fi
append_bash_profile "# Homebrew"
append_bash_profile "export PATH=/usr/local/bin:$PATH"
reload_bash_profile


# Install formulas
info 'Homebrew formulas install.'

# pyenv
brew_install pyenv
append_bash_profile '# pyenv'
append_bash_profile 'eval "$(pyenv init -)"'
reload_bash_profile

# rbenv
brew_install rbenv
append_bash_profile '# rbenv'
append_bash_profile 'eval "$(rbenv init -)"'
reload_bash_profile

# Node Version Manager
if [[ ! -e '/usr/local/opt/nvm/nvm.sh' ]]; then
  brew install nvm
  if [[ ! -e ~/.nvm ]]; then
    mkdir ~/.nvm
  fi
  info 'nvm installed.'
else
  notice 'nvm already installed.'
fi
notice 'Configure nvm to .bash_profile.'
append_bash_profile '# nvm configure'
append_bash_profile 'export NVM_DIR="$HOME/.nvm"'
append_bash_profile '[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm'
append_bash_profile '[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion'
reload_bash_profile

# Mac App Store command-line interface
brew_install mas
brew_install awscli
append_bash_profile "# AWS CLI completer"
append_bash_profile "# https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-configure-completion.html"
append_bash_profile "complete -C aws_completer aws"
reload_bash_profile

brew_install vim
brew_install carthage
brew_install curl
brew_install ffmpeg
brew_install git
brew_install git-flow
brew_install glib
brew_install gnu-getopt
append_bash_profile "# use gnu-getopt instead of /usr/bin/getopt"
append_bash_profile 'export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"'
reload_bash_profile
brew_install gnu-sed
brew_install httpie
brew_install imagemagick
brew_install jq
brew_install mysql@5.6
brew_install neovim
brew_install nginx
brew_install parallel
brew_install redis
brew_install the_silver_searcher
brew_install tig
# if brew_install bash-completion ; then
#   append_bash_profile "# Git-Completion"
#   append_bash_profile "source /usr/local/etc/bash_completion.d/git-prompt.sh"
#   append_bash_profile "source /usr/local/etc/bash_completion.d/git-completion.bash"
#   append_bash_profile "GIT_PS1_SHOWDIRTYSTATE=true"
#   append_bash_profile "export PS1='\[\033[35;40m\]\u@\h\[\033[00;40m\]:\[\033[36;40m\]\w\[\033[31;40m\]$(__git_ps1)\[\033[00m\]\$ '"
#   reload_bash_profile
# fi

# brew_install ruby-completion
# brew_install gem-completion
# brew_install bundler-completion
# brew_install rake-completion
# brew_install rails-completion

brew_cask_install docker
brew_cask_install google-cloud-sdk
append_bash_profile "source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"
append_bash_profile "source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
reload_bash_profile
# brew_cask_install java8
brew_cask_install google-chrome
brew_cask_install atom
brew_cask_install google-japanese-ime
brew_cask_install iterm2
brew_cask_install virtualbox
brew_cask_install vagrant
info 'Homebrew installation Completed.'

info 'Configure defaults.'

# Dock:自動的に隠す
defaults write com.apple.dock autohide -bool true

# タップでクリックを許可
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1

# Finder:隠しファイル/フォルダを表示
defaults write com.apple.finder AppleShowAllFiles true

# Finder:拡張子を表示
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# iPhoneを接続した時に写真アプリの自動起動を防ぐ
defaults write com.apple.ImageCapture disableHotPlug -bool NO

# KeyRepeatが始まるディレイ
defaults write -g InitialKeyRepeat -int 15

# KeyRepeat中のディレイ
defaults write -g KeyRepeat -int 2

info 'Install from Apple store using mas.'
# Evernote
if [[ -n "`man list | grep 406056744`" ]] ; then
  mas install 406056744
fi

info 'Configure atom'
append_atom_config "'.platform-darwin':"
append_atom_config "  'cmd-_': 'tree-view:toggle'"
append_atom_config ""
append_atom_config "'atom-text-editor':"
append_atom_config "  'ctrl-j': 'core:move-down'"
append_atom_config "  'ctrl-k': 'core:move-up'"
append_atom_config "  'ctrl-l': 'core:move-right'"
append_atom_config "  'ctrl-h': 'core:move-left'"
append_atom_config "  'ctrl-;': 'editor:move-to-end-of-line'"
append_atom_config "  'ctrl-g': 'editor:move-to-first-character-of-line'"
append_atom_config "  'cmd-k cmd-l': 'unset!' # 'editor:lower-case'"
append_atom_config "  'ctrl-shift-M': 'markdown-preview:toggle'"

info 'Install atom packages'
apm_install advanced-open-file
apm_install atomic-chrome
apm_install emmet
apm_install color-picker
apm_install file-icons

info 'Configure vim'
cp ./shared/.vimrc ~/.vimrc

info 'Configure git'
cp ./mac/.gitconfig ~/.gitconfig

info 'completed!'
