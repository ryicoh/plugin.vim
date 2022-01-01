# plugin.vim


## Requirements

* git
* Vim 8.0 or NeoVim(0.4.0+)

## Installation

```bash
curl -fLo ~/.vim/autoload/plugin.vim --create-dirs \
  https://github.com/ryicoh/plugin.vim/raw/main/autoload/plugin.vim
```

## Usage

```vim
plugin#use("vim-denops/denops.vim")
```

For NeoVim
```vim
if has('nvim')
  set runtimepath+=$HOME/.vim
endif

plugin#use("vim-denops/denops.vim")
```
