fish_add_path /home/dragonblade316/.cargo/bin

if status --is-interactive

	#thing that makes terminal look good
	#set -Ux STARSHIP_DISTRO "  "
	starship init fish | source

	#multiplexer
	if set -q ZELLIJ
	else
		zellij
	end

end

# Created by `pipx` on 2024-09-24 22:17:09
set PATH $PATH /home/dragonblade316/.local/bin
