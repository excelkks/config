#!/bin/bash
Get_Dist_Name()
{
    if grep -Ei "ubuntu" /etc/*-release 2>/dev/null >/dev/null; then
        SYSTEM="ubuntu"
        PM="apt-get"
    elif grep -Ei "centos" /etc/*-release 2>/dev/null >/dev/null; then
        SYSTEM="centos"
        PM="yum"
    elif sw_vers | grep -Ei "mac os x" 2>/dev/null >/dev/null; then
        SYSTEM="macosx"
        PM="brew"
    fi
}

Get_Dist_Name
# install package
if [ $SYSTEM = "macosx" ]; then
    for pkg in "git" "node"; do
        if  ! type $pkg 2>/dev/null; then
            echo -e "\033[34m installing $pkg ....................... \033[0m"
            $PM install $pkg
        fi
    done
else
    for pkg in "git" "nodejs" "npm"; do
        if  ! type $pkg 2>/dev/null; then
            echo -e "\033[34m installing $pkg ....................... \033[0m"
            sudo $PM install $pkg
        fi
    done
fi

# install hexo
if ! type hexo 2>/dev/null; then
    echo -e "\033[34m installing hexo....................... \033[0m"
    npm install -g hexo
fi

succ_flag=1
for pkg in "git" "node" "npm" "hexo"; do
    if !type $pkg 2>/dev/null; then
        echo -e "\033[31m $pkg not been installed, please check it. \033[0m"
        succ_flag=0
    fi
done
if [ $succ_flag=1 ]; then
    echo -e "\033[34m envirnment insalled successfully. \033[0m"
fi
