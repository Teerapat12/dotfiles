#custom cd
chpwd() ls

#clear and display what's in the current directory
clear-ls-all(){
	clear
	exa -al
	zle redisplay
}
zle -N clear-ls-all

#clear and display the current directory tree with level 2
clear-tree(){
	clear
	tree -L 2
	zle redisplay
}
zle -N clear-tree

#go to root directory
function git_root() {
    BUFFER="cd $(git rev-parse --show-toplevel 2>/dev/null || echo $HOME)"
    zle accept-line
}
zle -N git_root

bindkey '^k' clear-ls-all
bindkey '^l' clear-tree
bindkey '^h' git_root
