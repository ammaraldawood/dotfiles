# Enable Powerlevel10k instant prompt (Must be at the top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==============================================================================
# Environment Variables
# ==============================================================================
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export DOTFILES="${DOTFILES:-$HOME/dotfiles}"
export FZF_DEFAULT_OPTS="--color=16"
export BAT_THEME="ansi"
export PATH="$HOME/.local/bin:$HOME/.local/share/nvim/mason/bin:$PATH"

# ==============================================================================
# Zsh History Options
# ==============================================================================
HISTFILE="$HOME/.zhistory"
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# ==============================================================================
# Oh-My-Zsh & Theme Init
# ==============================================================================
plugins=(git)

# Homebrew (macOS / Linuxbrew) and common distro / oh-my-zsh layouts.
_dotfiles_source_first() {
  local f
  for f in "$@"; do
    [[ -n "$f" && -r "$f" ]] && source "$f" && return 0
  done
  return 1
}

_brew=""
command -v brew >/dev/null 2>&1 && _brew="$(brew --prefix)"

_dotfiles_source_first \
  ${_brew:+"$_brew/share/powerlevel10k/powerlevel10k.zsh-theme"} \
  /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme \
  "$ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme"

_dotfiles_source_first \
  ${_brew:+"$_brew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"} \
  /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh \
  "$ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

_dotfiles_source_first \
  ${_brew:+"$_brew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"} \
  /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  "$ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

unset _brew
unfunction _dotfiles_source_first

[[ -r "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# ==============================================================================
# Aliases & Functions
# ==============================================================================
if command -v eza >/dev/null 2>&1; then
  alias ls='eza -la --no-user --git --git-repos --header --total-size --links --context --mounts --group-directories-first --icons --time-style=relative -S --binary'
fi
if command -v bat >/dev/null 2>&1; then
  alias cat="bat"
fi
alias python="python3"
alias ghosttyconfig='nvim "${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/config"'
alias nf='fzf -m --preview="bat --color=always {}" --bind "enter:become(nvim {+})"'
alias darkacademia='echo "✒️ 🕰️ 🕯️ Musica est umbra mentis quaerentis" && mpv --no-video --ytdl-format=bestaudio --ytdl-raw-options=extractor-args="youtube:player_client=web_embedded" "https://youtube.com/playlist?list=PLyAYx1J3XKOSQpSCEVtjWkRMP1l0N9EpD&si=fQbuUmigHK5V216s"'

cld() {
  bat ~/Downloads/*(om[1])
}

y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# ==============================================================================
# Tool Inits
# ==============================================================================
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

if command -v conda >/dev/null 2>&1; then
  __conda_setup="$(conda 'shell.zsh' 'hook' 2>/dev/null)" && eval "$__conda_setup"
  unset __conda_setup
fi

if [[ -d "$HOME/.grok/bin" ]]; then
  export PATH="$HOME/.grok/bin:$PATH"
  fpath=(~/.grok/completions/zsh $fpath)
  autoload -Uz compinit && compinit -C
fi

# bioSyntax: colored less for common bioinformatics formats
export LESS=" -R "
if command -v src-hilite-lesspipe.sh >/dev/null 2>&1; then
  export LESSOPEN="| src-hilite-lesspipe.sh %s"
fi

alias less='less -NSi -# 10'
# -N: add line numbers
# -S: don't wrap lines (force to single line)
# -# 10: Horizontal scroll distance

alias more='less'

# Explicit call of  <file format>-less for piping data
# i.e:  samtools view -h aligned_hits.bam | sam-less
# Core syntaxes (default)
alias clustal-less='source-highlight -f esc --lang-def=clustal.lang --outlang-def=bioSyntax.outlang     --style-file=fasta.style | less'
alias bed-less='source-highlight     -f esc --lang-def=bed.lang     --outlang-def=bioSyntax.outlang     --style-file=sam.style   | less'
alias fa-less='source-highlight      -f esc --lang-def=fasta.lang   --outlang-def=bioSyntax.outlang     --style-file=fasta.style | less'
alias fq-less='source-highlight      -f esc --lang-def=fastq.lang   --outlang-def=bioSyntax.outlang     --style-file=fasta.style | less'
alias gtf-less='source-highlight     -f esc --lang-def=gtf.lang     --outlang-def=bioSyntax-vcf.outlang --style-file=vcf.style   | less'
alias pdb-less='source-highlight     -f esc --lang-def=pdb.lang     --outlang-def=bioSyntax-vcf.outlang --style-file=pdb.style   | less'
alias sam-less='source-highlight     -f esc --lang-def=sam.lang     --outlang-def=bioSyntax.outlang     --style-file=sam.style   | less'
alias vcf-less='source-highlight     -f esc --lang-def=vcf.lang     --outlang-def=bioSyntax-vcf.outlang --style-file=vcf.style   | less'
alias bam-less='sam-less'

# Auxillary syntaxes (uncomment to activate)
alias fai-less='source-highlight      -f esc --lang-def=faidx.lang    --outlang-def=bioSyntax.outlang   --style-file=sam.style   | less'
alias flagstat-less='source-highlight -f esc --lang-def=flagstat.lang --outlang-def=bioSyntax.outlang   --style-file=sam.style   | less'

# P10K Custom Config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# SDKMAN (Must be at the very end)
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
