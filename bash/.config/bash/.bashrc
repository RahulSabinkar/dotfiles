# _               _
#| |__   __ _ ___| |__  _ __ ___
#| '_ \ / _` / __| '_ \| '__/ __|
#| |_) | (_| \__ \ | | | | | (__
#|_.__/ \__,_|___/_| |_|_|  \___|
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]";

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

export PS1="\[$(tput bold)\]\[\e[31m\][\[\e[m\]\[$(tput bold)\]\[\e[33m\]\u\[\e[m\]\[$(tput bold)\]\[\e[32m\]@\[\e[m\]\[$(tput bold)\]\[\e[34m\]\h\[\e[m\]\[$(tput bold)\] \[\e[35m\]\W\[\e[m\]\[$(tput bold)\]\[\e[31m\]]\[\e[m\]\[$(tput bold)\]\[\e[36m\]\`parse_git_branch\`\[\e[m\]\\$ "

# PS1='[\u@\h \W]\$ '

# Use neovim for vim if present.
 [ -x "$(command -v nvim)" ] && alias vim="nvim" vimdiff="nvim -d"

#Allows you to cd into directory by just typing the directory name
shopt -s autocd

set -o vi

#Infinite History
HISTSIZE= HISTFILESIZE=

# Some aliases
alias mkd="mkdir -pv"
alias cp="cp -iv"
alias reload="source ~/.bashrc"

# Adding color
alias ls='ls -hN --color=auto --group-directories-first'
alias dir='dir -hN --color=auto --group-directories-first'
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ccat="highlight --out-format=ansi"

# Internet
alias yt="youtube-dl --add-metadata -ic"
alias yta="youtube-dl --add-metadata -xic"

# Suckless Hacking
alias edit="vim config.h"
alias doit="sudo make clean install"
alias save="cp config.h config.def.h"
alias fallback="cp config.def.h config.h"
alias change="diff config.def.h config.h"

# Pacman
alias p="pacman"
alias sp="sudo pacman"

# Shortcuts
alias bc="nvim ~/.bashrc"
alias vimrc="nvim ~/.vimrc"
alias nvimrc="nvim ~/.config/nvim/init.vim"

# Config Shortcuts
alias cfd="cd ~/.config/dwm/"
eval "$(starship init bash)"
