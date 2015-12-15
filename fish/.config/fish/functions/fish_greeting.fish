function fish_greeting
    if test -r /etc/motd
        lolcat </etc/motd
    else
        echo "(hostname -s)?" | cowthink | lolcat
    end
end
