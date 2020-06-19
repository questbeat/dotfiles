function __tmux_create_session
    if type -aq tmux && not __tmux_is_running && not __ssh_is_running
        tmux new -s (__tmux_nice_session_name)
    end
end
