# mktree
OhMyZsh plugin to create nested directories and files with a one line command

Why?

I don't want to run separate commands to create nested directories and files such as:

mkdir -p dir/subdir1
touch dir/subdir1/index1.js
touch dir/subdir1/index2.js

I would rather do this:

mktree dir/subdir1/{index1.js,index2.js}

Usage:

1. If the name of the directory or file has a dot, it will be considered a file instead of a directory.
2. Do not use spaces within the command arg.
3. Curly braces are used to nest directories or files.

Create a single directory:

    $ mktree dir1
    $ ls -R
    dir1

    ./dir1:

Create a single file:

    $ mktree index.js
    $ ls -R
    index.js

Create a directory with one file:

    $ mktree dir1/index.js
    $ ls -R
    dir1

    ./dir1:
    index.js

Create nested directory with multiple files:

    $ mktree dir/{subDir1,subDir2/{index1.js,index2.js}}
    $ ls -R
    ./dir:
    subDir1 subDir2

    ./dir/subDir1:

    ./dir/subDir2:
    index1.js index2.js

# Installation

To install, clone the repo into `~/.oh-my-zsh/custom/plugins` (ZSH plugins don't allow dashes, so make sure you clone it into a single-word folder):
``` bash
git clone https://github.com/efrenlosoya/mktree.git ~/.oh-my-zsh/custom/plugins/mktree
```

Then add it to your list of plugins in `~/.zshrc` (e.g `plugins=(mktree)`).

# Issues
If the plugin does not work you may need to give execute permission to `~/.oh-my-zsh/custom/plugins/mktree/mktree.sh`
