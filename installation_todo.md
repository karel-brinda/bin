# OS X install TODO

* Security & Privacy / General -> Require password immediately
* Change alt setting in terminal Terminal > Preferences > Settings > ‘Use option as meta key’
* Change Terminal font to Hack
* Change Caps Lock to Escape (System Preferences / Keyboard / Modifier Keys)
* Switch off animations: System Preferences > Accessibility > Display > Reduce Motion
* `defaults write com.apple.desktopservices DSDontWriteNetworkStores -boolean true` - don't create .\_DS\_Store in mounted disks

* `ln -s ~/github/my/bin/ ~/bin`
* `ln -s ~/bin/.bashrc ~/.bashrc`
* `ln -s ~/bin/.pypirc ~/.pypirc`
* `ln -s ~/bin/.gitconfig ~/.gitconfig`
* `ln -s ~/bin/.vimrc ~/.vimrc`
* `ln -s ~/bin/.vim ~/.vim`
* Start `vim` and run `:PluginInstall`
* `mkdir -p ~/.config/nvim && ln -s ~/bin/.config/nvim/init.vim ~/.config/nvim/init.vim`
* `ln -s ~/bin/osx/KeyBindings/ ~/Library/KeyBindings`
