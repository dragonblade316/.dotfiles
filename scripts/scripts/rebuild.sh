set -e
pushd ~/.dotfiles/nixos/nixos/
nvim .
alejandra . &>/dev/null
git diff -U0 *.nix
echo "NixOS rebuilding"
nh os switch -H dragonblade316
#need to add logging and better errors

gen=$(nh os info | grep "current")
git add .
git commit -m "$gen"
popd
