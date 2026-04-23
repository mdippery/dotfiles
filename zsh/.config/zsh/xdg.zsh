export XDG_BIN_HOME=${XDG_BIN_HOME:-$HOME/.local/bin}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_CACHE_HOME}

# Setting XDG_RUNTIME_DIR is left as an exercise for the reader (but probably
# isn't particularly necessary). Some ideas for setting its value here:
# <https://wiki.alpinelinux.org/wiki/XDG_RUNTIME_DIR#Initialising_manually_in_/tmp>

[ -r "${DOTZSH_PLAT}/xdg.zsh" ] && . "${DOTZSH_PLAT}/xdg.zsh"
