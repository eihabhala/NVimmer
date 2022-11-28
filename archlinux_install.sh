#!/bin/bash

function yellow() {
    echo -e "\033[33m\033[01m\033[05m$1\033[0m"
}

function red() {
    echo -e "\033[31m\033[01m$1\033[0m"
}

function green() {
    echo -e "\033[32m$1\033[0m"
}

function byellow() {
    echo -e "\033[33m\033[01m$1\033[0m"
}

function blue() {
    echo -e "\033[34m$1\033[0m"
}

green " _   ___     ___                               "
green "| \\ | \\ \\   / (_)_ __ ___  _ __ ___   ___ _ __ "
green "|  \\| |\\ \\ / /| | '_ \` _ \\| '_ \` _ \\ / _ \\ '__|"
green "| |\\  | \\  / | | | | | | | | | | | |  __/ |   "
green "|_| \\_|  \\_/  |_|_| |_| |_|_| |_| |_|\\___|_|"

green "Welcome to NVimmer, Make your NeoVim/Vim perform as an !!!"
green '专门为 NeoVim 打造的一键式脚本'
blue "Email: devilyouwei@gmail.com"

echo ""
byellow '1. 如在大陆地区使用，有些插件需要科学上网...'
echo ""
byellow '2. 大陆地区请更换gem, npm, pip等包管理器的镜像为国内源'
byellow '(When in China, change the npm, gem, pip source to China Mainland)'
echo ""
byellow '3. 建议您的系统是干净的，如果已经有vim或者neovim的配置，请提前备份好，会被覆盖，按<Ctrl-C>结束该脚本'
echo ""
byellow "Waiting for installing, 3 seconds..."
echo ""

sleep 3

echo "Install Linux Compile Tools and Env------------------------"
sudo --version
status=$?
if [ "$status" != 0 ]; then
    echo "Install sudo"
    pacman -S sudo --noconfirm
fi
sudo pacman -S git --noconfirm
sudo pacman -Syu 
sudo pacman -S cmake base-devel automake git ssl-cert clang-tools --noconfirm
echo "-----------------------------------------------------------"
echo ""
sleep 1

echo ""
echo "Check curl-------------------------------------------------"
curl --version
status=$?
if [ "$status" != 0 ]; then
    echo "Install Curl..."
    sudo pacman -S curl --noconfirm
fi
echo "-----------------------------------------------------------"
echo ""
sleep 1

echo ""
echo "Check snap-------------------------------------------------"
snap --version
status=$?
if [ "$status" != 0 ]; then
    echo "Install Snap..."
    sudo pacman -S snapd --noconfirm
    export =$PATH:/snap/bin
fi
echo "-----------------------------------------------------------"
echo ""
sleep 1

echo "Check NeoVim-----------------------------------------------"
nvim -v
status=$?
if [ "$status" != 0 ]; then
    echo "Install NeoVim..."
    sudo snap install --beta nvim --classic
    if [ "$?" != 0 ]; then
        sudo pacman -S neovim --noconfirm
    fi
fi
echo "-----------------------------------------------------------"
echo ""
sleep 1

echo "Check Node.js----------------------------------------------"
node -v
status=$?
if [ "$status" != 0 ]; then
    echo "Install Node.js..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    if [ "$?" != 0 ]; then
        red "Network Error: curl fail to download 'nvm'"
        exit 1
    fi
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    nvm install stable
fi
echo "-----------------------------------------------------------"
echo ""
sleep 1

echo "Check Python (both 2 and 3)--------------------------------"
python --version
status=$?
if [ "$status" != 0 ]; then
    echo "Install Python2..."
    sudo pacman -S python --noconfirm
fi

python3 --version
status=$?
if [ "$status" != 0 ]; then
    echo "Install Python3..."
    sudo pacman -S python3 --noconfirm
fi
echo "-----------------------------------------------------------"
echo ""
sleep 1

echo "Check Perl-------------------------------------------------"
perl -v
status=$?
if [ "$status" != 0 ]; then
    echo "Install Perl..."
    sudo pacman -S perl --noconfirm
fi
echo "-----------------------------------------------------------"
echo ""
sleep 1

echo "Check Ruby-------------------------------------------------"
ruby -v
status=$?
if [ "$status" != 0 ]; then
    echo "Install ruby..."
    sudo pacman -S ruby --noconfirm
fi
echo "-----------------------------------------------------------"
echo ""
sleep 1

echo "Check Latex------------------------------------------------"
latexmk -v
status=$?
if [ "$status" != 0 ]; then
    echo "Install Latexmk..."
    sudo pacman -S latexmk --noconfirm
fi
echo "-----------------------------------------------------------"
echo ""
sleep 1

echo "Install NeoVim Providers-----------------------------------"
echo ""
echo "Node:"
npm -v
if [ "$?" -eq 0 ]; then
    npm -g install neovim
fi

# never support python2 and pip2

echo ""
echo "Python3:"
pip3 --version
if [ "$?" != 0 ]; then
    sudo pacman -S python3-pip --noconfirm
fi
pip3 install neovim
pip3 install neovim-remote

echo ""
echo "Ruby:"
gem -v
if [ "$?" -eq 0 ]; then
    sudo pacman -S ruby-dev --noconfirm
    sudo gem install neovim
fi

echo ""
echo "Perl:"
sudo pacman -S cpanminus pmuninstall --noconfirm
cpanm -v
if [ "$?" -eq 0 ]; then
    cpanm --local-lib ~/perl5 Neovim::Ext
    cpanm Neovim::Ext
fi
cat ~/.bashrc | grep perl5
if [ "$?" != 0 ]; then
    echo 'eval $(perl -I $HOME/perl5/lib/perl5 -Mlocal::lib)' >>~/.bashrc
fi
echo "----------------------------------------------------------"
echo ""
sleep 1

echo "Install Yarn, ESLint, Prettier-------------------------------"
eslint -v
if [ "$?" != 0 ]; then
    echo "Install eslint..."
    npm -g install eslint
fi
prettier -v
if [ "$?" != 0 ]; then
    echo "Install prettier..."
    npm -g install prettier
fi
yarn -v
if [ "$?" != 0 ]; then
    echo "Install yarn..."
    npm -g install yarn
fi
echo "----------------------------------------------------------"
echo ""
sleep 1

echo "Install astyle--------------------------------------------"
sudo pacman -S astyle --noconfirm
echo "----------------------------------------------------------"
echo ""
sleep 1

echo "Install universal ctags---------------------------------------------"
sudo pacman -S universal-ctags --noconfirm
echo "----------------------------------------------------------"
echo ""
sleep 1

echo "Install the other formatters------------------------------"
sudo pacman -S clang-format --noconfirm
sudo snap install shfmt
echo "----------------------------------------------------------"
echo ""
sleep 1

echo "Install xclip---------------------------------------------"
sudo pacman -S xclip --noconfirm
echo "----------------------------------------------------------"
echo ""
sleep 1

green "Config Your NeoVim---------------------------------------"
curl -o ~/.config/nvim/init.vim --create-dirs \
    https://raw.githubusercontent.com/devilyouwei/NVimmer/master/nvim/init.vim
if [ "$?" != 0 ]; then
    red "Network Error: curl fail to download 'init.vim'"
    exit 1
fi

curl -o ~/.config/nvim/coc-settings.json --create-dirs \
    https://raw.githubusercontent.com/devilyouwei/NVimmer/master/nvim/coc-settings.json
if [ "$?" != 0 ]; then
    red "Network Error: curl fail to download 'coc-settings.json'"
    exit 1
fi

green "Config successfully!"
green "----------------------------------------------------------"
echo ""
sleep 1

echo "Install vim-plug------------------------------------------"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if [ "$?" != 0 ]; then
    red "Network Error: curl fail to download 'plug.vim'"
    exit 1
fi
echo "----------------------------------------------------------"
echo ""
sleep 1

echo "Clean trash and packages----------------------------------"
sudo pacman -S autoremove --noconfirm
if [ ! -d ".git" ]; then
    rm archlinux_install.sh
fi
echo "----------------------------------------------------------"
echo ""
sleep 1

echo "Install NeoVim Plugins------------------------------------"
nvim -c PlugInstall -c q -c q
echo "Exit NeoVim..."
echo "All the plugins are installed!"
echo "----------------------------------------------------------"
echo ""
echo y | command

# Eihab Confirm
# sleep 1
# echo y | command
# read -p "Set NeoVim as the default editor and replace vim? [Y/N]: "  
# echo y | command 
# confirm 
# echo y
# if [ "$confirm" = "y" ] || [ "$confrim" = "Y" ] || [ "$confirm" = "yes" ] || [ "$confirm" = "Yes" ]; then 
    # BASH
    
    echo "export EDITOR=/snap/bin/nvim" >>~/.bashrc
    echo "alias vim='nvim'" >>~/.bashrc
    echo "alias vi='nvim'" >>~/.bashrc

    # ZSH
    echo "export EDITOR=/snap/bin/nvim" >>~/.zshrc
    echo "alias vim='nvim'" >>~/.zshrc
    echo "alias vi='nvim'" >>~/.zshrc

# Eihab Changes
# fi

echo ""
echo "-------------------------------------------------------END"
echo 'Enjoy! ( ￣▽ ￣)～■ *Cheers* □ ～(￣▽ ￣)'

echo ""
echo "--------------------NVimmer-------------------------------"
green " _   ___     ___                               "
green "| \\ | \\ \\   / (_)_ __ ___  _ __ ___   ___ _ __ "
green "|  \\| |\\ \\ / /| | '_ \` _ \\| '_ \` _ \\ / _ \\ '__|"
green "| |\\  | \\  / | | | | | | | | | | | |  __/ |   "
green "|_| \\_|  \\_/  |_|_| |_| |_|_| |_| |_|\\___|_|"

echo "--------------------Favour--------------------------------"
echo '(๑ •̀ ㅂ•́ )و ✧ Like NVimmer? Go to:'
echo ""
blue 'https://github.com/devilyouwei/NVimmer'
echo ""
yellow '☆ ☆ ☆ ☆ ☆ '
echo ""
blue 'devilyouwei@gmail.com'
blue 'https://www.devil.ren'
blue '2ND Ave Long Branch NJ US'
blue '@devilyouwei'
echo ""
byellow '(Remeber to restart the terminal or reconnect to the server, then type nvim!)'
byellow '使用neovim前请先重启终端，然后输入vi即可'
echo ""

# curl -o archlinux_install.sh https://raw.githubusercontent.com/eihabhala/NVimmer/master/archlinux_install.sh && bash archlinux_install.sh