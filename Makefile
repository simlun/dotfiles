PWD := $(shell pwd)

.PHONY: all
all: vim

.PHONY: vim
vim:
	ln -s $(PWD)/vim $(HOME)/.vim
	ln -s $(PWD)/vimrc $(HOME)/.vimrc

.PHONY: clean
clean:
	rm -iv $(HOME)/.vim
	rm -iv $(HOME)/.vimrc

