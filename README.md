My dotfiles organized by application. Installation requires [GNU Stow][stow].
To install:

    $ git clone https://github.com/mdippery/dotfiles.git .dotfiles
    $ cd .dotfiles
    $ stow <packages>

All packages can be installed in one fell swoop with the following shell
script:

    for pkg in *; do
      [ $pkg != 'README.md' ] && stow $pkg
    done

---

If you're looking for Vim configuration scripts, you should instead take
a look at my [Vimfiles][vim] repository.

  [stow]: http://www.gnu.org/software/stow/
  [vim]: https://github.com/mdippery/vimfiles
