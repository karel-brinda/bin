# Installation todo list

## OSX-specific

* Security & Privacy / General -> Require password immediately
* Change alt setting (Terminal > Preferences > Settings > ‘Use option as meta key’)
* Set 100% opacity (Terminal > Preferences > Profiles > Pro > Text > Background button > Opacity 100%)
* Change Terminal font to Hack (Terminal > Preferences > Profiles > Pro > Text > Font)
* Change Caps Lock to Escape (System Preferences > Keyboard > Modifier Keys)
* Switch off animations: System Preferences > Accessibility > Display > Reduce Motion
* Mendeley - Preference > File Organizer > Organize my files, Rename document files
* `defaults write com.apple.desktopservices DSDontWriteNetworkStores -boolean true` - don't create .\_DS\_Store in mounted disks
* `ln -s ~/bin/osx/KeyBindings/ ~/Library/KeyBindings`

## Others

* `ln -s ~/github/my/bin/ ~/bin`
* `echo ". ~/bin/.bashrc" >> ~/.bashrc`
* `echo ". ~/bin/.bashrc" >> ~/.bash_profile`
* `ln -s ~/bin/.gitconfig ~/.gitconfig`
* `ln -s ~/bin/.vimrc ~/.vimrc`
* `ln -s ~/bin/.vim ~/.vim`
* `ln -s ~/bin/.condarc ~/.condarc`
* `mkdir -p ~/.config/nvim && ln -s ~/bin/.config/nvim/init.vim ~/.config/nvim/init.vim`
* Start `vim` and run `:PluginInstall`
* `~/.vim/bundle/YouCompleteMe/install.sh`

## Apps

* [MikTex](http://www.tug.org/mactex/)
* [Sublime text](https://www.sublimetext.com/)
* [Mendeley](https://www.mendeley.com/download-mendeley-desktop/mac/)
* [Dropbox](https://www.dropbox.com/downloading)
