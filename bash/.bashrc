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
