if [[ -z $CONTAINER_ID ]];
then 
alias cd=z 
alias cat=bat 
alias ls=lsd 
alias c=~/scripts/rebuild.sh 
alias home=cd $home 
fi 

eval "$(zoxide init bash)" 
eval "$(starship init bash)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/dragonblade316/.conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/dragonblade316/.conda/etc/profile.d/conda.sh" ]; then
        . "/home/dragonblade316/.conda/etc/profile.d/conda.sh"
    else
        export PATH="/home/dragonblade316/.conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

