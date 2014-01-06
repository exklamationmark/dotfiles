# install homebrew (package manager)
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

# install ruby
brew install ruby

# install git
brew install git

# install go
brew install go

# install node.js
brew install node

# install redis
brew install redis

# install postgresql
brew install postgresql
# load postgres on the fly: 
# launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

# config rubygems
echo "gem: --no-ri --no-rdoc" > ~/.gemrc

# install rails
gem install rails

# install coffescript compiler
gem install coffee-script-source
