`bash` will read `~/.bash_profile` if it is an _interactive login shell_, and
`~/.bashrc` if it is simply an interactive shell. An interactive login shell
is one that presents a user login; an interactive "non-login" shell is one
that is launched when you are already logged in.

You think that makes sense, but you are probably wrong.

Basically, here's how `bash` will load config files:

On **Mac OS X**, every shell launched by Terminal.app is an _interactive login
shell_, and thus will load `~/.bash_profile`.

On **Linux**, when you first boot up the machine, you will be presented with
an _interactive login shell_ and `~/.bash_profile` will be loaded. Thereafter,
you will be presented with an _interactive (non-login) shell_, and `~/.bashrc`
will be loaded. Except, of course, if you're using a GUI. In that case, upon
logging in and launching your terminal app (e.g., Konsole), you will always be
given an _interactive (non-login) shell_—the opposite of Mac OS X,
essentially.

[Some][staiger] [greybeards][rushanan] [say][stack] that environment variables
should go in `~/.bash_profile`, and pretty much everything else in
`~/.bashrc`. Of course, since the files loaded by GUI terminals differ
depending on your platform, this rule of thumb doesn't really work. Thus, it
makes sense to put everything in `~/.bashrc` and load that file from
`~/.bash_profile`.

  [rushanan]: http://michael-rushanan.blogspot.com/2013/01/os-x-bashrc-vs-profile-vs-bashprofile.html
  [stack]: http://superuser.com/questions/409186/environment-variables-in-bash-profile-or-bashrc
  [staiger]: http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
