PWD := $(shell pwd)

.PHONY: all
all: vim git

.PHONY: vim
vim:
	ln -s $(PWD)/vim $(HOME)/.vim
	ln -s $(PWD)/vimrc $(HOME)/.vimrc

.PHONY: git
git:
	ln -s $(PWD)/gitconfig $(HOME)/.gitconfig
	ln -s $(PWD)/gitignore $(HOME)/.gitignore
	./scripts/create-local-gitconfig.sh

.PHONY: clean
clean:
	rm -iv $(HOME)/.vim
	rm -iv $(HOME)/.vimrc
	rm -iv $(HOME)/.gitconfig
	rm -iv $(HOME)/.gitignore

