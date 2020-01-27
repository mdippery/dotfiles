function _free_memory {
  local pages=$(\
    vm_stat \
      | grep 'Pages free:' \
      | awk -F : '{ print $2 }' \
      | tr -d ' ' \
      | tr -d '.' \
  )
  expr $(($pages * 4 / 1024))
}

function _hardware_info {
  system_profiler SPHardwareDataType \
    | grep "$1" \
    | cut -d : -f 2 \
    | sed 's/^ //g'
}

function _total_memory {
  expr $(sysctl -n hw.memsize) / $((1024**2))
}

function greet {
  local indent=$(printf '\t\t    ')
  local grey="$(tput setaf 0)$(tput bold)"
  local reset=$(tput sgr0)
  local user="$(tput setaf 2)"
  cat <<EOM
${indent}${user}$(whoami)@$(system_profiler SPSoftwareDataType | grep 'Computer Name' | awk '{ print $3 }')${reset}
${indent}${grey}os${reset}      macOS $(sw_vers -productVersion)
${indent}${grey}host${reset}    $(_hardware_info 'Model Identifier')
${indent}${grey}cpu${reset}     $(_hardware_info 'Number of Processors') $(_hardware_info 'Processor Speed') $(_hardware_info 'Processor Name')
${indent}${grey}kernel${reset}  Darwin $(uname -r)
${indent}${grey}uptime${reset}  $(system_profiler SPSoftwareDataType | grep 'Time since boot' | cut -d : -f 2,3 | sed 's/^ //g')
${indent}${grey}memory${reset}  $(_free_memory) MB free of $(_total_memory) MB total
${indent}${grey}load${reset}    $(uptime | awk -F , '{ print $NF }' | awk -F : '{ print $NF }' | sed 's/^ //g')
${indent}${grey}shell${reset}   $SHELL
EOM
  echo -e "\033[9A"
  lolcat <<EOM
          .:'
      __ :'__
   .'\`__\`-'__\`\`.
  :__________.-'
  :_________:
   :_________\`-;
    \`.__.-.__.'

EOM
}

# Sometimes Xcode upgrades don't install header files in /usr/include properly
function install-missing-headers {
  local dir=/Library/Developer/CommandLineTools/Packages
  local pkg=$(ls -t1 $dir | head -n 1)
  open "$dir/$pkg"
}

function ldd {
  onoe 'I think you mean `otool [-L]`'
  return 1
}

# Rebuilds the LaunchServices database. Useful for removing
# duplicate entries from the "Open with..." menu.
function rebuild-openwith {
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
}
