# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/Users/florian/.zshrc'

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

# NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Force PHP CLI to 7.4.33
alias php="/Applications/MAMP/bin/php/php7.4.33/bin/php"
export PATH="/usr/local/opt/php@7.4/bin:$PATH"
export PATH="/usr/local/opt/php@7.4/sbin:$PATH"
export LDFLAGS="-L/usr/local/opt/php@7.4/lib"
export CPPFLAGS="-I/usr/local/opt/php@7.4/include"

# Force PHP CLI to 8.1.13
# alias php="/Applications/MAMP/bin/php/php8.1.13/bin/php"
# export PATH="/usr/local/opt/php@8.1/bin:$PATH"
# export PATH="/usr/local/opt/php@8.1/sbin:$PATH"
# export LDFLAGS="-L/usr/local/opt/php@8.1/lib"
# export CPPFLAGS="-I/usr/local/opt/php@8.1/include"

export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"

# Display git branch.
autoload -Uz vcs_info

precmd() { 
    # If .git exists in directory
    if [ -d .git ]; then
        vcs_info
        git_status="$(git status --porcelain --branch 2> /dev/null)"
        commits_to_push="$(echo "$git_status" | grep -o "ahead [0-9]*" | sed "s/ahead/↑/")"
        commits_to_pull="$(echo "$git_status" | grep -o "behind [0-9]*" | sed "s/behind/↓/")"
        git_info=""
        # If $commits_to_pull is not empty add to git_info
        if [ ! -z "$commits_to_pull" ]; then
            git_info="$git_info %F{black}%K{yellow} $commits_to_pull %k%f"
        fi
        # If $commits_to_push is not empty add to git_info
        if [ ! -z "$commits_to_push" ]; then
            git_info="$git_info $commits_to_push"
        fi
        RPROMPT='%F{white}${vcs_info_msg_0_}${git_info}%f'
    else
        vcs_info_msg=""
        RPROMPT=""
    fi
}

zstyle ':vcs_info:git:*' formats '(%b)'

setopt PROMPT_SUBST

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
