# Launch tmux shell on startup

function init_tmux
    # If not running interactively, don't do anything
    # TODO: Is this worthwhile?
    # [[ $- != *i* ]] && return

    # Exit early if tmux is not installed
    if not type "tmux" > /dev/null
        return
    end

    # Exit early if we're already running tmux
    if test $TMUX
        return
    end

    # Load tmux configuration
    tmux source-file ~/.tmux.conf ^ /dev/null

    # Get the id of a deattached session
    set ID (tmux ls | grep -vm1 attached | cut -d: -f1)

    if not test $ID
        # Start a new session if none available
        exec tmux
    else
        # If there's a detached session available, attach to it
        exec tmux attach-session -t "$ID"
    end
end
