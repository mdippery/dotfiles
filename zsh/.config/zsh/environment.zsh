export OS=$(uname -s | tr '[:upper:]' '[:lower:]')
export HOSTNAME_HASH=$(hostname | md5sum | awk '{print $1 }')
