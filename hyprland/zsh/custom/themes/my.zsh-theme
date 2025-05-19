# Put your custom themes in this folder.
# See: https://github.com/ohmyzsh/ohmyzsh/wiki/Customization#overriding-and-adding-themes
#
# Example:

#PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "

# Looks:
# host.user / dir / exit / modules
# %

# COLOURLESS
git_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null || git rev-parse --short HEAD 2> /dev/null)
  [ -n "$ref" ] && echo " ${ref##refs/heads/}"
}

virtualenv_info() {
  [ -n "$VIRTUAL_ENV" ] && echo "(venv:$(basename $VIRTUAL_ENV))"
}

#PROMPT="%m::%n(%L) | %~ | %D::%* | %?
#."
RPROMPT="%F{yellow}$(git_info)%f | %F{yellow}$(virtualenv_info)%f"

PROMPT="%F{cyan}%m::%n%f | %F{green}%/%f | %F{blue}%D%f::%F{blue}%*%f | %F{magenta}%?%f
--"
