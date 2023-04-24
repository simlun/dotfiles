System:
```
# apt-get install cifs-utils pass build-essential zsh autojump neovim python3-neovim tmux jq silversearcher-ag fzy ripgrep python3-dev python3-venv
```

dotfiles:
```
$ git clone git@github.com:simlun/dotfiles.git .dotfiles
$ cd .dotfiles
$ make
$ make nvim
```

sway:
```
# apt-get install sway stterm swaylock swayidle wdisplays grimshot brightnessctl pavucontrol xdg-desktop-portal-wlr mako-notifier wl-clipboard qtwayland5 imv slurp grim
$ cd .dotfiles
$ make sway
```

Configure env variables, then restart Sway (log out+in):
```
$ echo "exec dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway" >> ~/.config/sway/config
 
$ mkdir -p ~/.config/environment.d
$ echo "MOZ_ENABLE_WAYLAND=1" > ~/.config/environment.d/firefox-wayland.conf
```

pyenv:
```
$ git clone https://github.com/pyenv/pyenv.git ~/.pyenv
# apt-get install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
$ pyenv install 3.6.15 && pyenv install 3.7.15
$ pyenv global system 3.6.15 3.7.15
```

pipx:
```
# apt-get install python3-pip python3-venv
$ python3 -m pip install --user pipx
```

syncthing:
https://apt.syncthing.net/
```
$ sudo curl -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
$ echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
$ sudo apt-get update
$ sudo apt-get install syncthing
$ systemctl --user enable syncthing.service
$ systemctl --user start syncthing.service
$ open http://127.0.0.1:8384/
```
Then set username/password and disable global discovery etc.
