# Installation todo list

## OSX-specific

* Security & Privacy / General -> Require password immediately
* Energy Saver / Power Adapter -> on Prevent computer from sleeping, off Enable Power Nap
* Change alt setting (Terminal > Preferences > Settings > ‘Use option as meta key’)
* Set 100% opacity (Terminal > Preferences > Profiles > Pro > Text > Background button > Opacity 100%)
* Change Terminal font to [Hack](https://sourcefoundry.org/hack/#download) (Terminal > Preferences > Profiles > Pro > Text > Font)
* Change Caps Lock to Escape (System Preferences > Keyboard > Modifier Keys)
* Three fingers dragging (Accessibility / Mouse and Trackpad / Trackpad / Options / Enable dragging - three fingers)
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
* `ln -s ~/bin/.ipython/`
* `ln -s ~/bin/.parallel/`
* `ln -s ~/bin/.Rprofile`
* `ln -s ~/bin/.tmux.conf`
* `ln -s ~/bin/.hushlogin`
* `ln -s ~/bin/.condarc ~/.condarc`
* `ln -s ~/bin/.Rprofile ~/.Rprofile`
* `mkdir -p ~/.config/nvim && ln -s ~/bin/.config/nvim/init.vim ~/.config/nvim/init.vim`
* Start `vim` and run `:PluginInstall`
* `~/.vim/bundle/YouCompleteMe/install.sh`

## Machine-specific

* Harvard Odyssey `.bashrc` (to fix sftp):
  ```bash
  if [ "$SSH_TTY" ]; then
        . ~/bin/.bashrc
  fi
  ```

## Apps

* [Adobe](https://www.adobe.com/creativecloud/desktop-app.html)
* [Atom](https://atom.io/download/mac)
* [Dropbox](https://www.dropbox.com/downloading)
* [Git](https://git-scm.com/download/mac)
* [Google Chrome](https://www.google.com/chrome/)
* [Google Drive](https://www.google.com/drive/download/)
* [Mendeley](https://www.mendeley.com/download-mendeley-desktop/mac/)
* [MikTex](http://www.tug.org/mactex/)
* [Office](https://www.office.com/)
* [PDFTK](https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/pdftk_server-2.02-mac_osx-10.11-setup.pkg)
* [R](https://cran.r-project.org/bin/macosx/)
* [Rstudio](https://www.rstudio.com/products/rstudio/download/)
* [Slack](https://slack.com/downloads/osx)
* [Sublime 3](https://www.sublimetext.com/3)
* [Texts](http://www.texts.io/download/)
* [VLC](https://www.videolan.org/vlc/index.html)
* [VSCode](https://code.visualstudio.com/docs/?dv=osx)
* XCode (app store)
* [WKHTMLTOPDF](https://wkhtmltopdf.org/downloads.html)

