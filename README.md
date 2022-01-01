# plugin.vim

plugin.vim is plugin manager for Vim/NeoVim.

This is similar to [vim-plug](https://github.com/junegunn/vim-plug) and
[dein.vim](https://github.com/Shougo/dein.vim), but not as fast
and not as powerful.


## Requirements

* git
* Vim 8.0 or NeoVim(0.5.0+)

## Installation

```bash
curl -sSLo ~/.vim/autoload/plugin.vim --create-dirs \
  https://github.com/ryicoh/plugin.vim/raw/main/autoload/plugin.vim
```

## Usage

For Vim

```vim
plugin#use("vim-test/vim-test")
```

For NeoVim
```vim
if has('nvim')
  set runtimepath+=$HOME/.vim
endif

plugin#use("vim-test/vim-test")
```

Delete a plugin

```vim
:call plugin#uninstall("vim-test/vim-test")
```

Update all plugins

```vim
:call plugin#update()
```
