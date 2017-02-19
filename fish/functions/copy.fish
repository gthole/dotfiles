# Copy a selection of a file by line numbers onto clipboard
# copy <filename> <startline> <endline>

function copy
    head -n $argv[3] $argv[1] | \
        tail -n (math "$argv[3] - $argv[2] + 1") | \
        pbcopy
    pbpaste
end
