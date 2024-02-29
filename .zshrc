[[ -z "$TMUX" ]] && { tmux attach-session -t $USER || tmux new -s $USER -n "main"}

export MODULAR_HOME="/home/cmeorin/.modular"
export PATH="/home/cmeorin/.modular/pkg/packages.modular.com_mojo/bin:$PATH"
export MODULAR_HOME="/home/cmeorin/.modular"
export PATH="/home/cmeorin/.modular/pkg/packages.modular.com_mojo/bin:$PATH"
export PATH="$PATH:/opt/nvim-linux64/bin"
export EDITOR=nvim
export VISUAL=nvim
source $ZSH/oh-my-zsh.sh
source ~/antigen.zsh


antigen use oh-my-zsh
# Load the theme
antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship
# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle web-search
antigen bundle lein
antigen bundle command-not-found
antigen bundle common-aliases
antigen bundle compleat
antigen bundle git-extras
antigen bundle git-flow
antigen bundle npm
antigen bundle web-search
antigen bundle sudo
antigen bundle z
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh
antigen bundle zsh-users/zsh-autosuggestions
# NVM bundle
antigen apply

alias cdn='cd ~/.config/nvim'
alias zshrc='nvim ~/.zshrc'
alias adb='~/Android/Sdk/platform-tools/adb'
alias aplogdprocess="~/aplogd_process"
alias mntserver='sshfs cmeorin@zbr05lbld15.mot.com:/localrepo/cmeorin/ /home/cmeorin/motoServer'
alias cdlr='cd ~/projetos/'
alias cddialer='cd packages/apps/Dialer'
alias cdcontacts='cd packages/apps/Contacts'
alias setjdk16='setjdk jdk-16.0.2'
alias setjdk17='setjdk java-17-openjdk-amd64'
alias setjdk20='setjdk jdk-20'
alias loginmot='ssh cmeorin@zbr05lbld15.mot.com'
alias cdbot='cd ~/bot/automation-contrib/tools/asw/dev/botcr/python-bot'
alias syncto='~/AndroidStudioProjects/codesync/syncto.py -a'
alias syncfrom='~/AndroidStudioProjects/codesync/syncfrom.py -a'
alias syncconfig='~/AndroidStudioProjects/codesync/syncconfig.py'
alias logviewer='java -jar ~/Log_Viewer/LogViewer-2.5-all.jar'
alias idea='~/idea-IU-232.9559.62/bin/idea.sh'
alias cdbuilds='cd ~/Documents/builds/'
alias pycharm='~/pycharm-2023.1.3/bin/pycharm.sh'
alias dialer_bot='cd ~/Dialer/automation-contrib/tools/asw/dev/botcr/dialer && python dialer_bot.py'
alias activatevenv='source ./.venv/bin/activate'
alias zshrc='nvim ~/.zshrc'
alias gist='gh gist'
alias unziplog='() { local nfp=$HOME/Documents/LOGS/$2 && mkdir -p $nfp && sudo unzip $1 -d $nfp && cd $nfp }'
alias cdl='cd ~/Documents/LOGS/'
alias hf='hyperfine'
alias ts='tmux source ~/.tmux.conf'
alias nrs='sudo nixos-rebuild switch'
alias hme='sudo nvim /etc/nixos/home.nix'
alias nre='sudo nvim /etc/nixos/configuration.nix'

function getactivity(){
  adb shell dumpsys activity activities | less | grep -E '.*ResumedActivity.*$|\s.+([Hh]ist)\s.+#[0-9]|mCurrentFocus|mFocusedApp' | grep -v "null"
}

function cdprivapk(){
  cd out/target/product/$1/product/priv-app/$2
}

function syncapk(){
  rsync -aP cmeorin@zbr05lbld15.mot.com:/localrepo/cmeorin/$1/out/target/product/$2/product/priv-app/$3/$3.apk .
}

function cdapk(){
  cd out/target/product/$1/product/app/$2
}

function rootpushpriv(){
  adb root && adb remount && adb push $1.apk product/priv-app/$1 && adb reboot && adb wait-for-device && sleep 5 && scrcpy
}

function rootpush(){
  adb root && adb remount && adb push $1.apk product/app/$1 && adb reboot && adb wait-for-device && sleep 5 && scrcpy
}


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# push to branch, eg: pushto bu
function pushto(){
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    echo -e "${GREEN}Pushing to gerrit in branch $1 \e[0m"
    git push origin HEAD:refs/for/$1
}

# push to drafts
function pushdrafts() {
  git push origin HEAD:refs/drafts/$1
}

# push to specific gerrit id
function pushchanges() {
  git push origin HEAD:refs/changes/$1
}

# force push directly to remote branch
function pushforced() {
  git push -f origin HEAD:refs/heads/$1
}

# fetch and checkout branch
function checkout() {
  echo 'fetch ' $1
  git fetch origin $1
  echo 'check-out ' $1
  git checkout $1
}

# pull with rebase
function pull() {
  checkout $1
  echo 'rebase ' $1
  git pull --rebase origin $1
}

# execute dialer_bot and get back to same directory
function dialerbot {
  local mode=$1
  local args=$2
  local current_dir=$(pwd)
  dialer_bot $mode $args
  cd $current_dir
}

function downloadlogs {
  wget -r -np -nH --cut-dirs=3 -R index.html $1
}

# exec logconverter.py
function logconverter() {
    local dir=$1

    if [ -z "$dir" ]; then
        dir=$(pwd)
        echo "No directory provided. Using default: $dir"
    elif [ -d "$dir" ]; then
        echo "Directory used: $dir"
    else
	echo "Directory doesn't exist, please, leave it empty to use your current working directory, or pass a valid one." >&2
	return 1
    fi

   python3.11 $LOG_CONVERTER $dir
}

function setjdk() {
   export JAVA_HOME=/usr/lib/jvm/$1
}
function lsjdk(){
   ls /usr/lib/jvm/
}


# GITHUB CLI FUNCTIONS


# Gist edit. Add to file to gist. $1 is ID or URL, $2 is the file to add
function gha(){
  gh gist edit $1 --add $2
}

# Gist create. To create gists. $* refers to any arbitrary number of parameters
# so, this is a default function for creating gists.
function ghc(){
  gh gist create $*
}

# Gist edit. Edits gist description. $1 is ID or URL, $2 is the description
function ghd(){
  gh gist edit $1 -d $2
}

# Gist edit. Edits file. $1 is ID or URL, $2 is the filename
function ghf(){
  gh gist edit $1 -f $2
}

# Gist edit. Removes file. $1 is ID or URL, $2 is the file to be removed
function ghr(){
  gh gist edit $1 -r $2
}
##########################################################################

# Moves to the last log folder created
function cdll() {
  cd ~/Documents/LOGS/$(ls -t ~/Documents/LOGS/ | grep -E -m 1 '[Ii][Kk][Ss].*')
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

