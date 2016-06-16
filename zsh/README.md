`zsh` is configured using four key files that are read in the following order
and used for the following purposes:

<table>
<tr>
<th></th>
<th>File</th>
<th>Purpose</th>
</tr>
<tr>
<td align="right">1</td>
<td><code>.zshenv</code></td>
<td>According to the <a
href="http://zsh.sourceforge.net/Intro/intro_3.html">zsh manual</a>, this file
is "sourced on all invocations of the shell. ... It should contain commands to
set the command search path, plus other important environment variables. [It]
should not contain commands that produce output or assume the shell is
attached to a tty." So basically: important environment variables.</td>
</tr>
<tr>
<td align="right">1.5</td>
<td><code>.zprofile</code>
<td>Similar to <code>.zlogin</code>, but sourced <em>before</em>
<code>.zshrc</code>. Either <code>.zprofile</code> or <code>.zlogin</code>
should be used, but not both. <code>.zlogin</code> is preferable;
<code>.zprofile</code> is intended for <code>ksh</code> fans.
<tr>
<td align="right">2</td>
<td><code>.zshrc</code></td>
<td>This is sourced <em>only</em> in interactive shells. According to the <a
href="http://zsh.sourceforge.net/Intro/intro_3.html">zsh manual</a>, it "should
contain commands to set up aliases, functions, options, key bindings, etc." So
it functions much like <code>~/.bashrc</code> does for <code>bash</code>.</td>
</tr>
<tr>
<td align="right">3</td>
<td><code>.zlogin</code></td>
<td>Sourced only for <em>login</em> shells, much like
<code>~/.bash_profile</code>. (See below for more information on login
shells.) The <a href="http://zsh.sourceforge.net/Intro/intro_3.html">zsh
manual</a> notes that "<code>.zlogin</code> is not the place for alias
definitions, options, environment variable settings, etc.; as a general rule,
it should not change the shell environment at all. Rather, it should be used
to set the terminal type and run a series of external commands
(<code>fortune</code>, <code>msgs</code>, etc)."</td>
</tr>
<tr>
<td align="right">4</td>
<td><code>.zlogout</code></td>
<td>Sourced on logout (obviously).</td>
</tr>
</table>

To sum it up: the following files (in the order they are read) should be used
to configure `zsh`:

1. `.zshenv`
2. `.zshrc` (if interactive)
3. `.zlogin` (if login)
4. `.zlogout`

## Login vs. interactive shells

A _login shell_ is one that presents a prompt for a username and password. An
_interactive shell_ is one that presents a command prompt (instead of simply
executing a script or program). An _interactive login shell_ is one that does
both.

On Linux, you will get a _login shell_ only when logging in to a command
line-only interface. If you log into a desktop environment (such as KDE) and
launch a terminal program (such as Konsole) you will _not_ get a login shell.

OS X is just the opposite: Terminal.app _always_ launches a login shell.

In other words, on Linux, when launching `zsh` from, e.g., Konsole, the
following files will be read:

1. `.zshenv`
2. `.zshrc`
3. `.zlogout`

On OS X, when launching Terminal.app, the following files will be read:

1. `.zshenv`
2. `.zshrc`
3. `.zlogin`
4. `.zlogout`

In general, though, environment variables should be set in `.zshenv`, other
settings (aliases, functions) in `.zshrc`, and then `.zlogin` can be used to
show a friendly message when logging in—except on Linux, where that should
be done in `.zshrc`.
