ZSH_DISABLE_COMPFIX=true

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
if [[ `uname` == "Darwin"  ]]; then
  alias dircolors='gdircolors'
fi
plugins=(git macos aws docker npm python sudo wd nvm zsh-dircolors-solarized zsh-autosuggestions fzf-zsh-plugin bazel)

source "$ZSH"/oh-my-zsh.sh

DISABLE_AUTO_UPDATE=true
DISABLE_UPDATE_PROMPT=true

# User configuration
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

EDITOR="vim"

#alias ls="/bin/ls -G --color"
alias ssh="ssh -A -o stricthostkeychecking=no"
alias cls="tput clear"
alias clear="tput clear"
alias vim="nvim"
alias gcsc="gh codespace create -r cadencerpm/cerebro -b main -m premiumLinux"
alias cat="bat"
alias ls="eza"

if [[ `uname` == "Darwin"  ]]; then
    source "$HOME"/.zshrc.mac
fi

function gpr() {
  echo 'git pull --rebase origin' `git rev-parse --abbrev-ref HEAD`
  git pull --rebase origin `git rev-parse --abbrev-ref HEAD`
}

function gpb {
  command echo 'git push origin' `git rev-parse --abbrev-ref HEAD`
  command git push origin `git rev-parse --abbrev-ref HEAD`
}

function gfp() {
  echo 'git push --force origin' `git rev-parse --abbrev-ref HEAD`
  git push --force origin `git rev-parse --abbrev-ref HEAD`
}

if [[ "$TERM" != "screen-256color" ]]; then
    if [[ -z "$NVIM_LISTEN_ADDRESS" ]]; then
        tmux attach-session -t "$USER" || tmux new-session -s "$USER"
    fi
fi

alias mux="tmuxinator"
alias muxd='tmux attach-session -t "$USER" || tmux new-session -s "$USER"'

export KUBE_EDITOR=vim
export PYTEST_ADDOPTS="-v"
[[ /usr/local/bin/kubectl  ]] && source <(kubectl completion zsh)

if [[ -x .zshrc.secrets ]]; then
  source .zshrc.secrets
fi

eval "$(zoxide init zsh)"

alias biob="bazel info output_base"
alias bie="echo $(bazel info output_base)/external"
alias bier="bazel info execution_root"
alias bibb="bazel info bazel-bin"
alias bzl=bazel

eval "$(github-copilot-cli alias -- "$0")"


alias rg='rg --hidden'
z mono

function frg {
    result=$(rg --ignore-case --color=always --line-number --no-heading "$@" |
        fzf --ansi \
            --color 'hl:-1:underline,hl+:-1:underline:reverse' \
            --delimiter ':' \
            --preview "bat --color=always {1} --theme='Solarized (light)' --highlight-line {2}" \
            --preview-window 'up,60%,border-bottom,+{2}+3/3,~3')
    file=${result%%:*}
    linenumber=$(echo "${result}" | cut -d: -f2)
    if [[ -n "$file" ]]; then
              $EDITOR +"${linenumber}" "$file"
    fi
}
