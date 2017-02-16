function fish_prompt
    set_color cyan
    printf "%s@%s " (whoami) (hostname)
    set_color yellow
    printf "%s" (pwd)
    set_color normal
    printf "%s " (__fish_git_prompt)
    printf "\n> "
end
