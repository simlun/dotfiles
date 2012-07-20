PWD := $(shell pwd)
OHMYZSH_IS_INSTALLED := $(shell [ -e ~/.oh-my-zsh ] && echo yes || echo no)

.PHONY: all
all: vim git zsh

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
	git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
endif

.PHONY: zsh
zsh: oh-my-zsh
	ln -s $(PWD)/zshrc $(HOME)/.zshrc
	ln -s $(PWD)/zshrc.aliases $(HOME)/.zshrc.aliases
	ln -s $(PWD)/zshrc.mac $(HOME)/.zshrc.mac
	ln -s $(PWD)/zshrc.linux $(HOME)/.zshrc.linux


.PHONY: clean
clean:
	rm -iv $(HOME)/.vim
	rm -iv $(HOME)/.vimrc
	rm -iv $(HOME)/.gitconfig
	rm -iv $(HOME)/.gitignore
	rm -iv $(HOME)/.zshrc
	rm -iv $(HOME)/.zshrc.aliases
	rm -iv $(HOME)/.zshrc.mac
	rm -iv $(HOME)/.zshrc.linux

