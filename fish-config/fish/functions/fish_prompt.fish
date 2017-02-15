function fish_prompt
    set_color cyan
    printf "%s@%s " (whoami) (hostname)
    set_color yellow
    printf "%s" (pwd)
    set_color normal
    if test -d .git
        printf "%s " (__fish_git_prompt)
        set_color magenta
        printf "[%s]" (git rev-parse --short HEAD)
        set_color normal
    end
    printf "\n> "
end
