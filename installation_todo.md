# Install TODO

## OSX-specific

* Security & Privacy / General -> Require password immediately
* Change alt setting in terminal Terminal > Preferences > Settings > ‘Use option as meta key’
* Change Terminal font to Hack
* Change Caps Lock to Escape (System Preferences / Keyboard / Modifier Keys)
* Switch off animations: System Preferences > Accessibility > Display > Reduce Motion
* `defaults write com.apple.desktopservices DSDontWriteNetworkStores -boolean true` - don't create .\_DS\_Store in mounted disks
* `ln -s ~/bin/osx/KeyBindings/ ~/Library/KeyBindings`

## Others

* `ln -s ~/github/my/bin/ ~/bin`
* Add `. ~/bin/.bashrc` to ~/.bashrc
* Add `. ~/bin/.bash_profile` to `~/.bash_profile`
* `ln -s ~/bin/.pypirc ~/.pypirc`
* `ln -s ~/bin/.gitconfig ~/.gitconfig`
* `ln -s ~/bin/.vimrc ~/.vimrc`
* `ln -s ~/bin/.vim ~/.vim`
* `mkdir -p ~/.config/nvim && ln -s ~/bin/.config/nvim/init.vim ~/.config/nvim/init.vim`
* Start `vim` and run `:PluginInstall`
