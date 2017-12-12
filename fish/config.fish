set FISH_CLIPBOARD_CMD "cat" # Stop that.

set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'no'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch 'FFFFFF'
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '*'
set __fish_git_prompt_char_stagedstate '+'
set __fish_git_prompt_char_untrackedfiles '?'
set __fish_git_prompt_char_stashstate '$'
set __fish_git_prompt_char_upstream_ahead '>'
set __fish_git_prompt_char_upstream_behind '<'

set fish_color_cwd CCA700
set fish_color_name 00CCA7
set fish_color_greeting FF3333

function fish_greeting
	set_color $fish_color_greeting
	printf "Hello "
	set_color $fish_color_name
	printf (whoami)
	set_color $fish_color_greeting
	printf "! You are filled with "
	set_color $fish_color_name
	printf "determination"
	set_color $fish_color_greeting
	printf "."
end

function fish_prompt
  set last_status $status

  set_color $fish_color_name
  printf (whoami)@(hostname)
  printf ' '
  set_color $fish_color_cwd
  printf (dirs)

  set_color normal
  printf '%s ' (__fish_git_prompt)
  set_color normal
  printf '\n$ '

  zd --add "$PWD"
end

if [ "(uname)" = Linux ]
	shopt -s globstar
end

# Exports
export SHELL='/bin/fish'
export EDITOR='vim'
export TERM='xterm-256color'
if [ -d $HOME/.texmf ]
   	export TEXMFHOME=$HOME/.texmf
end
if [ -d $HOME/.sage ]
   	export DOT_SAGENB=$HOME/.sage
end
if [ -f /usr/bin/zathura ]
   	export PDFVIEWER='zathura'
end
if [ -f ~/dotfiles/aws-hmmt ]
   	source ~/dotfiles/aws-hmmt
end

umask 007 # set umask

# Aliases
alias kitty="cat"
alias getclip="xsel --clipboard"
alias putclip="xsel --clipboard"
alias lisp='sbcl --script'
alias bcsum='paste -sd+ - | bc'

alias dragon='python2 ~/Documents/Projects/dragon/'
alias sparky='python2 ~/Documents/Projects/sparky/'
alias von='python3 -m von'
alias tsq='python2 ~/dotfiles/py-scripts/tsq.py'
alias wplatex='python2 ~/dotfiles/py-scripts/latex2wp.py'	
alias teach='python3 ~/dotfiles/py-scripts/teach.py'	
alias demacro='python2 ~/dotfiles/py-scripts/demacro.py'
alias winf='wine winefile'
alias winx='startx /bin/wine winefile --kiosk --'
alias s3='aws s3'

export PYTHONPATH="$PYTHONPATH:/home/evan/Documents/Projects/"

alias pudb='python2 -m pudb.run'
alias dropcli='python2 ~/dotfiles/py-scripts/dropbox.py'
alias trash='gio trash'
alias emacs='vim' # Sorry, can't help it
alias gogogo='startx'
alias voice='arecord -f S16_LE -c 2 -r 96000 -D hw:0,0'
alias sudo='sudo ' # allows my aliases to get into sudo

# Create a new TeX file
function newtex 
	mkdir $argv
	cd $argv
	cat ~/Dropbox/Archive/Code/LaTeX-Templates/Generic.tex >> "$argv.tex"
	gvim "$argv.tex"
end

# Shortcut for editors and the like
function pdf
	if test -f "$argv""pdf"
		disown zathura "$argv""pdf"
	else if test -f "$argv.pdf"
		disown zathura "$argv.pdf"
	else if test -f "$argv"
		disown zathura "$argv"
	else
		echo "Cannot found a suitable file."
	end
end

# Uses the locate utility to find a certain file
function hunt ()
	python2 ~/dotfiles/py-scripts/hunt.py "$argv"
	cd (cat /tmp/hunt)
	pwd
	ls -l --color=tty
end

set -x LESS_TERMCAP_md (printf "\e[01;31m")
set -x LESS_TERMCAP_me (printf "\e[0m")
set -x LESS_TERMCAP_se (printf "\e[0m")
set -x LESS_TERMCAP_so (printf "\e[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\e[0m")
set -x LESS_TERMCAP_us (printf "\e[01;32m")

#It speaks!
alias hi="echo Hi!"
alias hello="echo Hello!"
alias ok="echo Glad you approve."
alias kk="echo Glad you approve."
alias bye="echo So long, and thanks for all the fish."
alias darn="echo Heh."
alias bleh="echo Meh."
alias hm="echo Hm?"
alias aoeu="echo I see you are a Dvorak user."
alias fml="echo HAHAHAHAHA"
alias lolwut="echo idk"
alias meow="echo Here, kitty! \<3"
alias purr="echo Here, kitty! \<3"

#QQ
alias qq="echo QQ!"
alias qqq="echo QQ!"
alias qqqq="echo QQ!"

# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Misc :)
alias less='less -R'                          # less should detect colors correctly
alias diff='diff --color'                     # show differences in color
alias grep='grep --color'                     # show differences in color
alias egrep='egrep --color=auto'              # show differences in color
alias fgrep='fgrep --color=auto'              # show differences in color

# Some shortcuts for different directory listings
if [ (uname) = Linux ]
	alias ls='ls --color=tty --quoting-style=literal' # classify files in color
	alias ll='ls -l --color=tty'                  # long list
	alias l='ls -CF'                              #
end
if [ (uname) = Darwin ]
	alias ls='ls -G' # classify files in color
	alias ll='ls -Gl'                             # long list
	alias l='ls -CF'                              #
end

# Custom change-directory function: cd + ls = cs
function cs
	if [ -n $argv ]
		cd $argv
	end
	ll
end
alias c='cs'

# Fish completions
complete -x -c cs -a "(__fish_complete_directories)"
complete -c disown -x -a "(__fish_complete_subcommand -u -g)"

source ~/dotfiles/z.fish
function z
	zd $argv
	ll
end

# vim: ft=sh
