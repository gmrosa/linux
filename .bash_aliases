# default
alias sudo='sudo '
# bash
alias bashrcEdit='sudo code ~/.bashrc'
alias bashrcRefresh='source ~/.bashrc'
alias bashAliasEdit='sudo code ~/.bash_aliases'
alias bashAliasRefresh='source ~/.bash_aliases'
# dev
alias cdDev='cd ~/dev'
# git
alias gitAddAll='git ls-files --modified | xargs git add'
alias gitCheckout='_gitCheckout(){ echo "git checkout --track origin/$1" ; git checkout --track origin/$1; }; _gitCheckout'
alias gitClean='gitRefresh; gitPrune'
alias gitDeleteLocalBranch='_gitDeleteLocalBranch(){ echo "git branch -d $1"; git branch -d $1;}; _gitDeleteLocalBranch'
alias gitDeleteRemoteBranch='git push -d origin $1'
alias gitListLocalBranches='git branch -l'
alias gitListRemoteBranches='git branch -r'
alias gitPrune='git remote prune origin'
alias gitRefresh='_gitRefresh(){ git fetch; git pull; }; _gitRefresh'
alias gitRename='_gitRename(){ echo "git branch -m $1" ; git branch -m $1; }; _gitRename'
# giteye
alias gitEye='~/dev/giteye/./GitEye &'
# gradlew
alias gradleBootRun='_bootRun(){ ./gradlew bootRun --args="--spring.profiles.active=$1";}; _bootRun'
alias java18='sdk use java open-jdk-18'
alias java11='sdk use java open-jdk-11'
alias java8='sdk use java oracle-8'
# kubernetes
alias kubectx="kubectl ctx"
alias kubens="kubectl ns"
alias k8sDeletePod='_k8sDeletePod(){ echo "kubectl delete pod $1"; kubectl delete pod $1;}; _k8sDeletePod'
alias k8sDeletePodForce='_k8sDeletePodForce(){ echo "kubectl delete pod $1 --grace-period=0 --force"; kubectl delete pod $1 --grace-period=0 --force;}; _k8sDeletePodForce'
alias k8sGetLogs='_k8sGetLogs(){ echo "kubectl logs $1"; kubectl logs $1;}; _k8sGetLogs'
alias k8sGetPods='kubectl get pods'
alias k8sScaleZero='_k8sScaleZero(){ echo "kubectl scale --replicas=0 deployment/$1"; kubectl scale --replicas=0 deployment/$1;}; _k8sScaleZero'