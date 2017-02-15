function fish_prompt
    set_color cyan
    printf "%s" (whoami)
    printf "@%s " (hostname)
    set_color yellow
    printf "%s" (pwd)
    set_color normal
    printf "%s " (__fish_git_prompt)
    if test -d .git
        set_color magenta
        printf "[%s]" (git rev-parse --short HEAD)
        set_color normal
    end
    printf "\n> "
end
