function dn
	set -l escaped_argv (string escape --no-quoted $argv)
	bash -c "$escaped_argv &" > /dev/null
end

# Status Chars
#set __fish_git_prompt_char_dirtystate '*'
#set __fish_git_prompt_char_stagedstate '+'
#set __fish_git_prompt_char_untrackedfiles '?'
#set __fish_git_prompt_char_stashstate '$'
#set __fish_git_prompt_char_upstream_ahead '>'
#set __fish_git_prompt_char_upstream_behind '<'

set fish_color_cwd CCA700
set fish_color_name 44FFFF
set fish_color_host 11DD33
set fish_color_error FF0000
set fish_color_greeting FF3333
set fish_color_determination yellow
set fish_color_date 888888
set fish_color_arrows 00CCA7

set fish_prompt_pwd_dir_length 2

# Fish git prompt
set __fish_git_prompt_showdirtystate 1
set __fish_git_prompt_showstashstate 1
set __fish_git_prompt_showuntrackedfiles 1
set __fish_git_prompt_showcolorhints 1
set __fish_git_prompt_show_informative_status 1
set __fish_git_prompt_color 9CFEFA
set __fish_git_prompt_color_branch 00CCA7
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red


function fish_greeting
	set_color --italics $fish_color_greeting
	printf "Hello "
	set_color --bold $fish_color_name
	printf $USER
	set_color normal
	set_color --italics $fish_color_host
	printf @
	printf (hostname)
	set_color $fish_color_greeting
	printf "! You are filled with "
	set_color --bold $fish_color_determination
	printf "determination"
	set_color normal
	set_color --italics $fish_color_greeting
	printf ".\n"
	set_color --italics $fish_color_date
	printf "It is is "
	printf (date)
	printf ".\n"
	set_color normal
end

function fish_prompt
	set last_status $status
	if set -q SUDO_USER
		set_color --italics yellow
		printf (prompt_pwd)
	else
		set_color --italics $fish_color_cwd
		printf (prompt_pwd)
	end
	set_color normal
	if not test $last_status -eq 0
		set_color $fish_color_error
		printf ' ['
		printf $last_status
		printf ']'
	end
	if set -q SUDO_USER
		printf ' '
		set_color -b blue yellow --bold
		printf '('
		printf $USER
		printf ')'
		set_color normal
		printf ' '
	else
		set_color --bold $fish_color_arrows
		printf ' >> '
	end
	set_color normal
end

function fish_right_prompt
	if set -q VIRTUAL_ENV
		echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
	end
	set_color normal
	printf '%s ' (__fish_git_prompt)
	set_color normal
end

function fish_right_prompt_loading_indicator -a last_prompt
    echo -n "$last_prompt" | sed -r 's/\x1B\[[0-9;]*[JKmsu]//g' | read -zl uncolored_last_prompt
    echo -n (set_color brblack)"$uncolored_last_prompt"(set_color normal)
end

if [ "(uname)" = Linux ]
	shopt -s globstar
end

# Exports
export SHELL='/usr/bin/fish'
export EDITOR='vim'
export TERM='xterm-256color'

export SSH_ASKPASS=/usr/lib/seahorse/ssh-askpass

# the auto prompt-edited detetction is not enabled somehow
export VIRTUAL_ENV_DISABLE_PROMPT=1
set -U -x VIRTUAL_ENV_DISABLE_PROMPT 1

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
# alias emacs='vim'
alias bcsum='paste -sd+ - | bc'
alias dropcli='dropbox-cli'
alias getclip="xsel --clipboard"
alias kitty="cat"
alias lisp='sbcl --script'
alias putclip="xsel --clipboard"
alias python='python3'
alias trash='gio trash'
alias voice='arecord -f S16_LE -c 2 -r 96000 -D hw:0,0'
alias winf='wine winefile'
alias winx='startx /bin/wine winefile --kiosk --'

alias demacro='python2 ~/dotfiles/py-scripts/demacro.py'
alias dragon='python2 ~/Documents/Projects/dragon/'
alias odus='python3 ~/dotfiles/py-scripts/odus.py'
alias oscar='python3 ~/dotfiles/py-scripts/oscar.py'
alias sparky='python3 ~/Documents/Projects/sparky/'
alias todo='~/dotfiles/sh-scripts/get-todo.sh'
alias tsq='python3 ~/dotfiles/py-scripts/tsq.py'
alias von='python3 -m von'
alias wplatex='python2 ~/dotfiles/py-scripts/latex2wp.py'
alias wpmd='python3 ~/dotfiles/py-scripts/markdown2wp.py'

alias mu='neomutt'
alias m1='neomutt -F ~/.config/mutt/neomuttrc.1'
alias m2='neomutt -F ~/.config/mutt/neomuttrc.2'

export PYTHONPATH="$PYTHONPATH:$HOME:$HOME/dotfiles/py-scripts/"

# Create a new TeX file
function newtex
	mkdir $argv
	cd $argv
	cat ~/Dropbox/Archive/Code/LaTeX-Templates/Generic.tex >> "$argv.tex"
	gvim "$argv.tex"
end

# Shortcut for editors and the like
function pdf
	if test -f (echo $argv | cut -f 1 -d '.').pdf
		dn zathura (echo $argv | cut -f 1 -d '.').pdf
	else if test -f "$argv""pdf"
		dn zathura "$argv""pdf"
	else if test -f "$argv.pdf"
		dn zathura "$argv.pdf"
	else
		echo "Cannot found a suitable file."
	end
end

# Uses the locate utility to find a certain file
function hunt ()
	python3 ~/dotfiles/py-scripts/hunt.py "$argv"
	cd (cat /tmp/hunt.(whoami))
	pwd
	ls -l --color=tty
end

function pdfenc --argument-names 'infile' 'outfile' 'password' 
	qpdf --encrypt "$password" "$password" 128 --print=none --modify=none -- $infile $outfile
end

# correct horse battery staple
function chbs
	shuf -n 1000 /usr/share/dict/words | grep -E "^[a-z]{3,9}\$" | head -n 12
end

set -x LESS_TERMCAP_md (printf "\e[01;31m")
set -x LESS_TERMCAP_me (printf "\e[0m")
set -x LESS_TERMCAP_se (printf "\e[0m")
set -x LESS_TERMCAP_so (printf "\e[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\e[0m")
set -x LESS_TERMCAP_us (printf "\e[01;32m")

#It speaks!
alias aoeu="echo I see you are a Dvorak user."
alias bleh="echo Meh."
alias bye="echo So long, and thanks for all the fish."
alias darn="echo Heh."
alias fml="echo HAHAHAHAHA"
alias hello="echo Hello!"
alias hi="echo Hi!"
alias hm="echo Hm?"
alias kk="echo Glad you approve."
alias lolwut="echo idk"
alias meow="echo Here, kitty! \<3"
alias ok="echo Glad you approve."
alias purr="echo Here, kitty! \<3"

#QQ
alias qq="echo QQ!"
alias qqq="echo QQ!"
alias qqqq="echo QQ!"
alias qqqqq="echo QQ!"
alias qqqqqq="echo QQ!"
alias qqqqqqq="echo QQ!"
alias qqqqqqqq="echo QQ!"
alias qqqqqqqqq="echo QQ!"
alias qqqqqqqqqq="echo QQ!"
alias qqqqqqqqqqq="echo QQ!"
alias qqqqqqqqqqqq="echo QQ!"
alias qqqqqqqqqqqqq="echo QQ!"
alias qqqqqqqqqqqqqq="echo QQ!"
alias qqqqqqqqqqqqqqq="echo QQ!"
alias qqqqqqqqqqqqqqqq="echo QQ!"
alias qqqqqqqqqqqqqqqqq="echo QQ!"
alias qqqqqqqqqqqqqqqqqq="echo QQ!"
alias qqqqqqqqqqqqqqqqqqq="echo QQ!"

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

# Fish completions
complete -c disown -x -a "(__fish_complete_subcommand -u -g)"
complete -c dn -x -a "(__fish_complete_subcommand -u -g)"

# Addon settings
set -U __done_notification_urgency_level normal

# fish vi key bindings
fish_vi_key_bindings
bind -M default \ce 'accept-autosuggestion'
bind -M insert \ce 'accept-autosuggestion'

function fish_mode_prompt
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        or test "$fish_key_bindings" = "fish_hybrid_key_bindings"
        switch $fish_bind_mode
            case default
                set_color --bold --background red white
                echo 'N'
            case insert
                set_color --bold --background green white
                echo 'I'
            case replace_one
                set_color --bold --background green white
                echo 'R'
            case replace
                set_color --bold --background cyan white
                echo 'R'
            case visual
                set_color --bold --background magenta white
                echo 'V'
        end
        set_color normal
        echo -n ' '
    end
end
# vim: ft=sh
