PWD := $(shell pwd)
PREZTO_IS_INSTALLED := $(shell [ -e ~/.zprezto ] && echo yes || echo no)

.PHONY: all
all: vim git zsh tmux xsession

.PHONY: vim
vim:
	ln -s $(PWD)/vim $(HOME)/.vim
	ln -s $(PWD)/vimrc $(HOME)/.vimrc
	ln -s $(PWD)/gometlinter.json $(HOME)/.gometlinter.json

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

.PHONY: zsh
zsh: prezto
	ln -s $(PWD)/zshrc $(HOME)/.zshrc
	ln -s $(PWD)/zshrc.mac $(HOME)/.zshrc.mac
	ln -s $(PWD)/zshrc.linux $(HOME)/.zshrc.linux
	ln -s $(PWD)/zpreztorc $(HOME)/.zpreztorc
	ln -s $(PWD)/zlogin $(HOME)/.zlogin

# I use tmux 2.8 (as it's the version used in Fedora 30)
#
# Installing tmux 2.8 on a Mac:
# $ brew uninstall tmux
# $ brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/b3bd700d9fc53fa153c884b0ea613822de1f375c/Formula/tmux.rb
# $ brew pin tmux
# $ brew list --pinned
#
# A newer tmux can be used after this PR is merged:
# https://github.com/seebi/tmux-colors-solarized/pull/23/files
.PHONY: tmux
tmux:
	cat $(PWD)/tmux.conf > $(HOME)/.tmux.conf
	cat $(PWD)/tmux-colors-solarized/tmuxcolors-dark.conf >> $(HOME)/.tmux.conf
	#cat $(PWD)/tmux-colors-solarized/tmuxcolors-light.conf >> $(HOME)/.tmux.conf

# TODO: Make this clean target safer! Ask first?
.PHONY: clean
clean:
	rm -vf $(HOME)/.vim
	rm -vf $(HOME)/.vimrc
	rm -vf $(HOME)/.gometlinter.json
	rm -vf $(HOME)/.gitconfig
	rm -vf $(HOME)/.gitignore
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
