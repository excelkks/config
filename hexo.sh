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
for pkg in "git" "node"; do
    if  ! type $pkg 2>/dev/null; then
        echo -e "\033[34m installing $pkg ....................... \033[0m"
        $PM install $pkg
    fi
done
# install hexo
if ! type hexo 2>/dev/null; then
    echo -e "\033[34m installing hexo....................... \033[0m"
    echo 
    npm install -g hexo
fi

echo -e "\033[34m environment successful insalled. \033[0m"
