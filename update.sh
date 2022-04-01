#!/bin/sh
rm -rf ./.config/nvim/pack/github/start/copilot.vim \
    && git clone https://github.com/github/copilot.vim.git ./.config/nvim/pack/github/start/copilot.vim \
    && rm -rf ./.config/nvim/pack/github/start/copilot.vim/.git
