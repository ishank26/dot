user="morpheus"
# set a fancy prompt (non-color, unless we know we "want" color)
if [ "$TERM" = "xterm" ]; then
    export TERM=xterm-256color
fi

if [ "$TERM" = "screen" ]; then
    export TERM=screen-256color
fi

if [ "$COLORTERM" = "xfce4-terminal" ] || [ "$COLORTERM" = "truecolor" ]; then
    export TERM=xterm-256color
fi

export EDITOR=vim
export VISUAL=$EDITOR

#anaconda
export PATH=/home/$user/programs/anaconda2/bin:$PATH

#cudnn
#export PATH=/usr/local/cuda-7.5/bin:$PATH
#export LD_LIBRARY_PATH=/usr/local/cuda-7.5/lib64
#tts

# sources

source $HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh
source /home/morpheus/programs/antigen.zsh
source /etc/commonrc


### antigen ###
# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle zsh-users/zsh-autosuggestions

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
#antigen theme geometry-zsh/geometry
antigen theme https://github.com/denysdovhan/spaceship-prompt spaceship


# done.
antigen apply

 ####

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
