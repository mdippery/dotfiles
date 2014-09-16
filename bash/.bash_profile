# See [1], [2], and [3] for the differences between ~/.bash_profile and
# ~/.bashrc. Note that on OS X, ~/.bash_profile is executed for _every_
# new Terminal window/tab.
#
# Some greybeards say that environment variables should be in ~/.bash_profile
# (or ~/.profile) and pretty much everything else goes in ~/.bashrc, but on
# OS X it really doesn't matter. [3]
#
#   [1] http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
#   [2] http://michael-rushanan.blogspot.com/2013/01/os-x-bashrc-vs-profile-vs-bashprofile.html
#   [3] http://superuser.com/questions/409186/environment-variables-in-bash-profile-or-bashrc

if hash fortune 2>/dev/null && hash cowsay 2>/dev/null; then
  fortune | cowsay -n | cut -c-$(tput cols)
fi

[ -r ~/.bashrc ] && source ~/.bashrc
