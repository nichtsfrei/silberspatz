#!/bin/sh

grep niri $HOME/.config/fish/config.fish || printf '
if test "$XDG_VTNR" -eq 1
    if test -z "$NIRI_SOCKET"
        exec niri --session || true
    end
end
' >> $HOME/.config/fish/config.fish
# if test "$XDG_VTNR" -eq 1
#   if test -z "$NIRI_SOCKET"
#     niri --sesion 2> /dev/null || true
#   end
# end
