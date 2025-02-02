# aliases
alias vim=nvim

# homebrew in path
eval $(/opt/homebrew/bin/brew shellenv)

# move .zscompdump files into hidden directory
autoload -Uz compinit
compinit -d ~/.config/zsh/.zcompdump

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="geoffgarside"

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# zsh-autosuggest config
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
