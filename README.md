# plugin.vim

plugin.vim is plugin manager for Vim/NeoVim.

This is similar to [vim-plug](https://github.com/junegunn/vim-plug) and
[dein.vim](https://github.com/Shougo/dein.vim), but not as fast
and not as powerful.

Instead, it's written in about 100 lines, so anyone can understand.


## Requirements

* git
* Vim 8.0 or NeoVim(0.5.0+)

## Installation

For Vim

```bash
curl -sSLo ~/.vim/autoload/plugin.vim --create-dirs \
  https://github.com/ryicoh/plugin.vim/raw/main/autoload/plugin.vim
```

For NeoVim

```bash
curl -sSLo ~/.config/nvim/autoload/plugin.vim --create-dirs \
  https://github.com/ryicoh/plugin.vim/raw/main/autoload/plugin.vim
```

## Usage

Example of `.vimrc`

```vim
call plugin#use("vim-denops/denops.vim")
call plugin#use("Shougo/ddc.vim")
call plugin#use("prabirshrestha/vim-lsp")
call plugin#use("mattn/vim-lsp-settings")
```

Delete a plugin

```vim
:call plugin#uninstall("ryicoh/deepl.vim")
```

Update all plugins

```vim
:call plugin#update()
```
