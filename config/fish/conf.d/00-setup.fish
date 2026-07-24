if command -q mise
    mise activate fish | source
end

if command -q direnv
    direnv hook fish | source
end

if command -q zoxide;
    zoxide init fish | source
end

if command -q fzf
   fzf --fish | source
end

if command -q jj
    jj util completion fish | source
end


