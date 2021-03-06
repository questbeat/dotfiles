# https://github.com/chriskempson/base16-shell/blob/master/profile_helper.fish
function base16
    set base16_dir "$XDG_CONFIG_HOME/base16-shell"

    set -l theme (find "$base16_dir/scripts" -type f -exec basename {} .sh \; | \
        sort | awk -F"/" '{ print $NF }' | fzf +m +s)
    test -n "$theme" || return

    set script "$base16_dir/scripts/$theme.sh"
    sh "$script"
    ln -sf "$script" ~/.base16_theme

    set -gx BASE16_THEME (string split -m 1 '-' "$theme")[2]
    echo -e "if !exists('g:colors_name') || g:colors_name != '$theme'\n  colorscheme $theme\nendif" > ~/.vimrc_background

    if test (count $BASE16_SHELL_HOOKS) -eq 1 && test -d "$BASE16_SHELL_HOOKS"
      for hook in $BASE16_SHELL_HOOKS/*
        test -f "$hook"; and test -x "$hook"; and "$hook"
      end
    end
end
