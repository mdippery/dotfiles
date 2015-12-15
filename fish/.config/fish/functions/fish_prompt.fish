function fish_prompt
    set_color blue
    echo -n (basename (prompt_pwd))
    set_color -o black
    echo -n ' > '
    set_color normal
end
