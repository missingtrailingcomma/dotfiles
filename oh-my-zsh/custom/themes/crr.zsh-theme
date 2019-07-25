local user="%(!.%{$fg[white]%}.%{$fg[white]%})%n%{$reset_color%}"

local at="%{$fg[white]%}@%{$reset_color%}"

local host="%{$fg[white]%}$(hostname -s)%{$reset_color%}"

local ret_status="%{$fg[red]%}$%{$reset_color%} "

PS1='
%{$fg[white]%}$(abbrev_pwd)%{$reset_color%} $(git_prompt_info)
${ret_status}'

RPS1='${user}${at}${host}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
