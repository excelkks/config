# don't record dup commands
HISTCONTROL=ignoredups

# record all terminal's commands
shopt -s histappend

# incase resize window size
shopt -s checkwinsize

bind 'set match-hidden-files off'
bind 'set show-all-if-ambiguous on'
bind 'set menu-complete-display-prefix on'
bind 'TAB:menu-complete'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Set the PS1 prompt
export PS1='\[\033[1;32m\]➜ \[\033[0m\] \[\033[1;36m\]\W\[\033[0m\] '

