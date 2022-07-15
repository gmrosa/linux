# colours
RED_PATTERN='(?:\d+\/\d+\s+(?!(?:Running)|(?:Completed))\w+\s+\d+ )'
YELLOW_PATTERN='(?:(\d+)\/\1\s+Running\s+(?:(?:[1-9]{1} )|(?:[0-9]{2,} )))'
GREEN_PATTERN='(?:([0-9]+)\/\1\s+Running\s+0)|(?:0\/[0-9]+\s+Completed\s+[0-9]+)'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
BLUE='\033[01;34m'
NONE='\033[0m'
# default
alias sudo='sudo '
alias ls='ls --color'
alias ll='ls -lh'
alias grep="grep --color"
alias ..="cd .."
alias ...="cd ../../"
alias ip="/usr/sbin/ip -c"
# bash
alias bashrcedit='code ~/.bashrc'
alias sourcebashrc='source ~/.bashrc'
alias bashaliasedit='code ~/.bash_aliases'
alias sourcebashalias='source ~/.bash_aliases'
# dev
alias cddev='cd ~/dev'
# git
alias gitaddall='git add -A'
alias gitcommit='_gitcommit(){ echo "git commit -m $1" ; git commit -m $1; }; _gitcommit'
alias gitpush='_gitpush(){ echo "git push origin $1" ; git push origin $1; }; _gitpush'
alias gitcheckout='_gitcheckout(){ echo "git checkout --track origin/$1" ; git checkout --track origin/$1; }; _gitcheckout'
alias gitclean='gitrefresh; gitprune'
alias gitdeletelocalbranch='_gitdeletelocalbranch(){ echo "git branch -d $1"; git branch -d $1;}; _gitdeletelocalbranch'
alias gitdeleteremotebranch='git push -d origin $1'
alias gitlistlocalbranches='git branch -l'
alias gitlistremotebranches='git branch -r'
alias gitprune='git remote prune origin'
alias gitrefresh='_gitrefresh(){ git fetch; git pull; }; _gitrefresh'
alias gitrename='_gitrename(){ echo "git branch -m $1" ; git branch -m $1; }; _gitrename'
# giteye
alias giteye='~/dev/giteye/./GitEye &'
# gradlew
alias gradlebootrun='_bootRun(){ ./gradlew bootRun --args="--spring.profiles.active=$1";}; _bootRun'
alias java18='sdk use java open-jdk-18'
alias java11='sdk use java open-jdk-11'
alias java8='sdk use java oracle-8'
# kubernetes
alias k="kubectl"
alias kget="kubectl get"
alias kpods='kubectl get pods'
alias krc='kubectl resource-capacity --pods'
alias kdp="kubectl describe pod"
alias kdn="kubectl describe node"
alias kdeployments="kubectl get deployments"
alias kpvc="kubectl get pvc"
alias kall="kubectl get all"
alias ksvc="kubectl get svc"
alias krs="kubectl get rs"
alias kgetctx="kubectl config get-contexts"
alias kctx="kubectl ctx"
alias kns="kubectl ns"
alias kdeletepod='_kdeletepod(){ echo "kubectl delete pod $1"; kubectl delete pod $1;}; _kdeletepod'
alias kdeletepodforce='_kdeletepodforce(){ echo "kubectl delete pod $1 --grace-period=0 --force"; kubectl delete pod $1 --grace-period=0 --force;}; _kdeletepodforce'
alias klogs='_klogs(){ echo "kubectl logs $1"; kubectl logs $1;}; _klogs'
alias kscalezero='_kscalezero(){ echo "kubectl scale --replicas=0 deployment/$1"; kubectl scale --replicas=0 deployment/$1;}; _kscalezero'


function kcountnotes(){
	kubectl get nodes --no-headers | awk -v _date=$(date +%F-%T) -v y=$YELLOW -v r=$RED -v g=$GREEN -v b=$BLUE -v n=$NONE '{a[$2]++}END{ for (i in a)printf "%-1s %-1s %-1s %-1s %-1s \n", _date , y"Status:"n, g i n , y"Node Count"n  , g a[i] n;}'
}
function ksortpods(){
	awk '!/STATUS/ { if( NF==6 || NF>=10 ) { print $4 } else if( NF==5 || NF==9 ) { print $3 } }' | sort | uniq -c | sort -nr | column -t
}
function kgetzones(){
	kubectl get nodes -o json | jq -r '.items[] | "Node: " + .metadata.name + " Zone: "  + .metadata.labels."topology.kubernetes.io/zone"' | column -t
}

# audio
alias hearmyvoice="pactl load-module module-loopback latency_msec=1"
alias stophearingmyvoice="pactl unload-module module-loopback"