#!/bin/sh
rm -rf ./.zsh_autoenv \
    && git clone https://github.com/Tarrasch/zsh-autoenv ./.zsh_autoenv

rm -rf ./.config/nvim/pack/github/start/copilot.vim \
    && git clone https://github.com/github/copilot.vim.git ./.config/nvim/pack/github/start/copilot.vim \
    && rm -rf ./.config/nvim/pack/github/start/copilot.vim/.git

pushd .vim_runtime
python update_plugins.py
popd
