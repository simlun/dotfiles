PWD := $(shell pwd)
PREZTO_IS_INSTALLED := $(shell [ -e ~/.zprezto ] && echo yes || echo no)

.PHONY: all
all: git zsh tmux bin

.PHONY: nvim
nvim:
	mkdir -p $(HOME)/.config/nvim
	ln -s $(PWD)/nvim/init.vim $(HOME)/.config/nvim/init.vim
	ln -s $(PWD)/nvim/dotlocal_share_nvim_site_pack_myplugins_start $(HOME)/.local/share/nvim/site/pack/myplugins/start


.PHONY: vim
vim:
	ln -s $(PWD)/vim $(HOME)/.vim
	ln -s $(PWD)/vimrc $(HOME)/.vimrc
	ln -s $(PWD)/gometalinter.json $(HOME)/.gometalinter.json

.PHONY: git
git:
	ln -s $(PWD)/gitconfig $(HOME)/.gitconfig
	ln -s $(PWD)/gitignore $(HOME)/.gitignore
	./scripts/create-local-gitconfig.sh

.PHONY: prezto
prezto:
ifeq ($(PREZTO_IS_INSTALLED),yes)
	@echo "prezto seems to be already installed, good!"
else
	git submodule init
	git submodule update --init --recursive
	ln -s $(PWD)/zprezto $(HOME)/.zprezto
endif

.PHONY: base16
base16: $(HOME)/.base16_theme $(HOME)/.vimrc_background

$(HOME)/.base16_theme:
	ln -s $(PWD)/base16/base16-shell/scripts/base16-solarized-dark.sh $(HOME)/.base16_theme

$(HOME)/.vimrc_background:
	cp $(PWD)/base16/vimrc_background $(HOME)/.vimrc_background

.PHONY: zsh
zsh: prezto base16
	ln -s $(PWD)/zshrc $(HOME)/.zshrc
	ln -s $(PWD)/zshrc.mac $(HOME)/.zshrc.mac
	ln -s $(PWD)/zshrc.linux $(HOME)/.zshrc.linux
	ln -s $(PWD)/zpreztorc $(HOME)/.zpreztorc
	ln -s $(PWD)/zlogin $(HOME)/.zlogin

.PHONY: tmux
tmux:
	cat $(PWD)/tmux.conf > $(HOME)/.tmux.conf
	cat $(PWD)/tmux-colors-solarized/tmuxcolors-base16.conf >> $(HOME)/.tmux.conf

# TODO: Make this clean target safer! Ask first?
.PHONY: clean
clean:
	rm -vf $(HOME)/.vim
	rm -vf $(HOME)/.vimrc
	rm -vf $(HOME)/.gometalinter.json
	rm -vf $(HOME)/.gitconfig
	rm -vf $(HOME)/.gitignore
	rm -vf $(HOME)/.base16_theme
	rm -vf $(HOME)/.vimrc_background
	rm -vf $(HOME)/.zshrc
	rm -vf $(HOME)/.zshrc.mac
	rm -vf $(HOME)/.zshrc.linux
	rm -vf $(HOME)/.zpreztorc
	rm -vf $(HOME)/.zlogin
	rm -vf $(HOME)/.tmux.conf
	rm -vf $(HOME)/.xsession
	rm -vf $(HOME)/.Xmodmap

.PHONY: xsession
xsession:
	test -e $(HOME)/.xsession || ln -s $(PWD)/xsession $(HOME)/.xsession
	test -e $(HOME)/.Xmodmap || ln -s $(PWD)/Xmodmap $(HOME)/.Xmodmap

.PHONY: clean-i3
clean-i3:
	rm -rf $(HOME)/.config/i3
	rm -rf $(HOME)/.config/i3status

.PHONY: i3
i3:
	mkdir -p $(HOME)/.config/i3
	mkdir -p $(HOME)/.config/i3status
	ln -s $(PWD)/i3/i3.conf $(HOME)/.config/i3/config
	ln -s $(PWD)/i3/i3status.conf $(HOME)/.config/i3status/config
	mkdir -p $(HOME)/.config/i3/bin
	ln -s $(PWD)/i3/bin/keymap $(HOME)/.config/i3/bin/keymap
	ln -s $(PWD)/i3/bin/passmenu $(HOME)/.config/i3/bin/passmenu
	ln -s $(PWD)/i3/bin/xbacklight $(HOME)/.config/i3/bin/xbacklight
	ln -s $(PWD)/i3/bin/dmenu_actions $(HOME)/.config/i3/bin/dmenu_actions
	test -e $(HOME)/.config/i3/bin/dmenu_favourites || cp $(PWD)/i3/bin/dmenu_favourites.tmpl $(HOME)/.config/i3/bin/dmenu_favourites

.PHONY: sway
sway:
	ln -s $(PWD)/sway $(HOME)/.config/sway

.PHONY: simlun-fedora-repo
simlun-fedora-repo:
	sudo wget https://bintray.com/simlun/fedora/rpm -O /etc/yum.repos.d/bintray-simlun-fedora.repo

.PHONY: bin
bin:
	mkdir -p $(HOME)/bin
	for b in `ls -1 $(PWD)/bin`; do ln -sf $(PWD)/$$b $(HOME)/bin/$$b; done
