set -e
pushd ~/.dotfiles/nixos/nixos/
jj git fetch --remote origin
jj rebase --branch @ --onto main@origin
nvim .
alejandra . &>/dev/null
jj diff --git --context 0 *.nix
echo "NixOS rebuilding"
nh os switch ~/.dotfiles/nixos/nixos
#need to add logging and better errors

gen=$(nh os info | grep "current")
jj commit -m "$gen" .
jj bookmark set main --revision @-
jj git push --bookmark main
popd
