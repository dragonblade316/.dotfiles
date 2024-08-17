if status --is-interactive
	#thing that makes terminal look good
	#set -Ux STARSHIP_DISTRO "  "
	#starship init fish | source

	#multiplexer
	if set -q ZELLIJ
	else
		zellij
	end

end
