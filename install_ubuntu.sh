#!/bin/bash
echo " ... updating  ... "
cd ~/
sudo apt-get -y update
sudo apt-get -y upgrade
echo "done!"

echo " ... install ... "
sudo apt install -y htop default-jdk git curl zsh libreoffice-calc pactl flameshot pavucontrol net-tools alien unzip ca-certificates software-properties-common apt-transport-https wget
mkdir ~/dev
echo "install done!"

read -p "Install ohmyzsh?" -n 1 -r
echo # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo " ... ohmyzsh ... "
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo " ... ohmyzsh ... "  
fi

read -p "Install remmina?" -n 1 -r
echo # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo " ... remmina ... "
  sudo snap install remmina --devmode
  echo " ... remmina ... "
fi

read -p "Install giteye?" -n 1 -r
echo # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # https://www.how2shout.com/linux/how-to-install-giteye-gui-git-client-on-ubuntu-22-04-20-04-lts/
  echo " ... giteye ... "
  wget https://www.collab.net/sites/default/files/downloads/GitEye-2.2.0-linux.x86_64.zip
  mkdir ~/dev/giteye
  unzip GitEye-*-linux.x86_64.zip -d ~/dev/giteye
  sudo rm GitEye-*-linux.x86_64.zip
  echo "giteye done!"
fi

read -p "Install chrome?" -n 1 -r
echo # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # https://linuxize.com/post/how-to-install-google-chrome-web-browser-on-ubuntu-20-04/
  echo " ... chrome ... "
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  echo "chrome done!"
fi

read -p "Install visual studio?" -n 1 -r
echo # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # https://kimconnect.com/linux-how-to-install-visual-studio-code/
  echo " ... visual studio ... "
  wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
  sudo apt-get -y update
  sudo apt install -y code
  echo "visual studio done!"
fi

read -p "Install intellij?" -n 1 -r
echo # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # https://linuxconfig.org/how-to-install-intellij-idea-on-ubuntu-20-04-linux-desktop
  echo " ... intellij ... "
  sudo snap install intellij-idea-community --classic
  echo "intellij done!"
fi

read -p "Install docker?" -n 1 -r
echo # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # https://docs.docker.com/engine/install/ubuntu/
  echo " ... docker ... "
  sudo apt-get install \
      ca-certificates \
      curl \
      gnupg \
      lsb-release
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get -y update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
  sudo usermod -aG docker $USER
  newgrp docker
  echo "docker done!"
fi

read -p "Install aws?" -n 1 -r
echo # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo " ... aws ... "
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
    echo "aws done!"
fi

read -p "Install portainer?" -n 1 -r
echo # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # https://docs.portainer.io/v/ce-2.9/start/install/server/docker/linux
  echo " ... portainer ... "
  docker volume create portainer_data
  docker run -d -p 8000:8000 -p 9000:9000 --name portainer \
      --restart=always \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v portainer_data:/data \
      portainer/portainer-ce .
  echo "portainer done!"
fi

read -p "Install kubernetes?" -n 1 -r
echo # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
  echo " ... kubernetes ... "
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
  echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  echo "kubernetes done!"
fi

read -p "Install kubectx & kubens?" -n 1 -r
echo # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
# https://github.com/ahmetb/kubectx
echo " ... kubectx & kubens ... "
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' >> ~/.bashrc 
source ~/.bashrc
kubectl krew install ctx
kubectl krew install ns
echo "kubectx & kubens done!"

read -p "Install command-line fuzzy finder?" -n 1 -r
echo # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
# https://github.com/junegunn/fzf
echo " ... command-line fuzzy finder ... "
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
source ~/.bashrc
echo "command-line fuzzy finder done!"

read -p "Install sdkman?" -n 1 -r
echo # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
# https://sdkman.io/install
echo " ... sdkman ... "
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
echo "sdkman done!"

echo " ... finishing  ... "
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt -y autoremove
echo "done!"