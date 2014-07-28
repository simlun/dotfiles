PWD := $(shell pwd)
OHMYZSH_IS_INSTALLED := $(shell [ -e ~/.oh-my-zsh ] && echo yes || echo no)

.PHONY: all
all: vim git zsh tmux

.PHONY: vim
vim:
	ln -s $(PWD)/vim $(HOME)/.vim
	ln -s $(PWD)/vimrc $(HOME)/.vimrc

.PHONY: git
git:
	ln -s $(PWD)/gitconfig $(HOME)/.gitconfig
	ln -s $(PWD)/gitignore $(HOME)/.gitignore
	./scripts/create-local-gitconfig.sh

.PHONY: oh-my-zsh
oh-my-zsh:
ifeq ($(OHMYZSH_IS_INSTALLED),yes)
	@echo "oh-my-zsh seems to be already installed, good!"
else
	git submodule init
	git submodule update
	ln -s $(PWD)/oh-my-zsh $(HOME)/.oh-my-zsh
endif

.PHONY: zsh
zsh: oh-my-zsh
	ln -s $(PWD)/zshrc $(HOME)/.zshrc
	ln -s $(PWD)/zshrc.global $(HOME)/.zshrc.global
	ln -s $(PWD)/zshrc.aliases $(HOME)/.zshrc.aliases
	ln -s $(PWD)/zshrc.mac $(HOME)/.zshrc.mac
	ln -s $(PWD)/zshrc.linux $(HOME)/.zshrc.linux

.PHONY: tmux
tmux:
	cat $(PWD)/tmux.conf > $(HOME)/.tmux.conf
	#cat $(PWD)/tmux-colors-solarized/tmuxcolors-dark.conf >> $(HOME)/.tmux.conf
	cat $(PWD)/tmux-colors-solarized/tmuxcolors-light.conf >> $(HOME)/.tmux.conf

# TODO: Make this clean target safer! Ask first?
.PHONY: clean
clean:
	rm -vf $(HOME)/.vim
	rm -vf $(HOME)/.vimrc
	rm -vf $(HOME)/.gitconfig
	rm -vf $(HOME)/.gitignore
	rm -vf $(HOME)/.zshrc
	rm -vf $(HOME)/.zshrc.aliases
	rm -vf $(HOME)/.zshrc.mac
	rm -vf $(HOME)/.zshrc.linux
	rm -vf $(HOME)/.zshrc.global
	rm -vf $(HOME)/.tmux.conf

