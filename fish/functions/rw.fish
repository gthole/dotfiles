function rw
    if test $argv[1]
        tmux rename-window $argv[1]
    else
        tmux rename-window (echo $PWD | ag -o --no-color '[^\/]+$')
    end
end
