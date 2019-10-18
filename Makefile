PWD := $(shell pwd)
PREZTO_IS_INSTALLED := $(shell [ -e ~/.zprezto ] && echo yes || echo no)

.PHONY: all
all: vim git zsh tmux xsession

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
	ln -s $(PWD)/base16/base16-shell/scripts/base16-solarized-light.sh $(HOME)/.base16_theme

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
	#cat $(PWD)/tmux-colors-solarized/tmuxcolors-dark.conf >> $(HOME)/.tmux.conf
	#cat $(PWD)/tmux-colors-solarized/tmuxcolors-light.conf >> $(HOME)/.tmux.conf
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

.PHONY: i3
i3:
	mkdir -p $(HOME)/.config/i3
	mkdir -p $(HOME)/.config/i3status
	test -e $(HOME)/.config/i3/config || ln -s $(PWD)/i3/i3.conf $(HOME)/.config/i3/config
	test -e $(HOME)/.config/i3status/config || ln -s $(PWD)/i3/i3status.conf $(HOME)/.config/i3status/config

.PHONY: simlun-fedora-repo
simlun-fedora-repo:
	sudo wget https://bintray.com/simlun/fedora/rpm -O /etc/yum.repos.d/bintray-simlun-fedora.repo
