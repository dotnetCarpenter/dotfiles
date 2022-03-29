# dotfiles

Change `DEFAULT_DOTFILES_DIR` in _.profile_ to an absolute
path, that points to the _WSL_ directory.

Symlink the following files (change path as necessary):

```
.bash_aliases -> projects/opensource/dotfiles/WSL/.bash_aliases
.bash_gitps1 -> projects/opensource/dotfiles/git/.bash_gitps1
.bashrc -> projects/opensource/dotfiles/WSL/.bashrc
.gitconfig -> projects/opensource/dotfiles/git/.gitconfig
.profile -> projects/opensource/dotfiles/WSL/.profile
```


Forgotten bash repo: https://github.com/dotnetCarpenter/bash
