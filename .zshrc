ZSH_DISABLE_COMPFIX=true
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"
DISABLE_UPDATE_PROMPT=true
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

# ULTRA-OPTIMIZED: Skip compinit check on most shells (regenerate daily)
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

export PATH="$HOME/bin:/opt/homebrew/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster"

CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"

# ULTRA-OPTIMIZED: Reduced plugin list (removed zsh-dircolors-solarized which adds overhead)
# Consider removing fzf-zsh-plugin if you don't use it frequently
if [[ `uname` == "Darwin"  ]]; then
  alias dircolors='gdircolors'
fi
plugins=(git macos fzf-zsh-plugin)

source "$ZSH"/oh-my-zsh.sh

# User configuration
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

EDITOR="vim"

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

# OPTIMIZED: Cache kubectl completion
if [[ -f ~/.zsh/kubectl_completion ]]; then
    source ~/.zsh/kubectl_completion
fi

if [[ -x .zshrc.secrets ]]; then
  source .zshrc.secrets
fi

eval "$(zoxide init zsh)"

alias biob="bazel info output_base"
alias bier="bazel info execution_root"
alias bibb="bazel info bazel-bin"
alias bzl=bazel

alias rg='rg --hidden'
cd /Users/ewhauser/working/cadencerpm/monorepo

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

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# OPTIMIZED: Cache mirrord completion
if [[ -f ~/.zsh/mirrord_completion ]]; then
    source ~/.zsh/mirrord_completion
fi

# ULTRA-OPTIMIZED: Comment out autoenv if not critical (~24ms saved)
# Uncomment if you need directory-based environment loading:
# source ~/.zsh-autoenv/autoenv.zsh

alias gz="bazel run //:gazelle"

alias snowsql=/Applications/SnowSQL.app/Contents/MacOS/snowsql
export PATH="/Users/ewhauser/.local/bin:$PATH"

function cpr {
    $(which claude) -p "Run the /pr slash command. Determine the content for the commit message, branch name, and PR description from the context <context>$(git diff main)</context>" --model haiku
}

# ULTRA-OPTIMIZED: Lazy-load gcloud SDK (~75ms saved)
# Defers loading until you actually use gcloud
gcloud() {
    if [ -f '/Users/ewhauser/google-cloud-sdk/path.zsh.inc' ]; then
        . '/Users/ewhauser/google-cloud-sdk/path.zsh.inc'
    fi
    if [ -f '/Users/ewhauser/google-cloud-sdk/completion.zsh.inc' ]; then
        . '/Users/ewhauser/google-cloud-sdk/completion.zsh.inc'
    fi
    unset -f gcloud
    gcloud "$@"
}
