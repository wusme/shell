#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH
#Version: 0.6.8

sh_ver="0.0.4"
sh_55R="https://raw.githubusercontent.com/wxlost/shell/master/server"
dir=`pwd`

#这里判断系统
if [ -f /etc/redhat-release ]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
fi

#check if we are root
[[ $EUID -ne 0 ]] && echo -e "${RED}Error:${PLAIN} This script must be run as root!" && exit 1

# Disable selinux
if [ -s /etc/selinux/config ] && grep 'SELINUX=enforcing' /etc/selinux/config; then
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
    setenforce 0
fi

[[ ${release} != "debian" ]] && [[ ${release} != "ubuntu" ]] && [[ ${release} != "centos" ]] && echo -e "${Error} 本脚本不支持当前系统 ${release} !" && exit 1

conf_Shell(){
    wget --no-check-certificate -O ${dir}/options.conf http://${options}/options.conf
    wget --no-check-certificate -O ${dir}/manyuser.sh ${sh_55R}/manyuser.sh  && chmod +x manyuser.sh
    wget --no-check-certificate -O ${dir}/install.sh ${sh_55R}/install.sh  && chmod +x install.sh
    if [ ! -d ${dir}/include ]; then
    mkdir include
    fi
    if [ ! -d ${dir}/src ]; then
    mkdir src
    fi
    wget --no-check-certificate -O ${dir}/include/color.sh ${sh_55R}/include/color.sh
    wget --no-check-certificate -O ${dir}/include/check_os.sh ${sh_55R}/include/check_os.sh
    wget --no-check-certificate -O ${dir}/include/get_char.sh ${sh_55R}/include/get_char.sh
    wget --no-check-certificate -O ${dir}/include/memory.sh ${sh_55R}/include/memory.sh
    wget --no-check-certificate -O ${dir}/include/download.sh ${sh_55R}/include/download.sh
    wget --no-check-certificate -O ${dir}/include/python.sh ${sh_55R}/include/python.sh
    wget --no-check-certificate -O ${dir}/include/init_CentOS.sh ${sh_55R}/include/init_CentOS.sh
    wget --no-check-certificate -O ${dir}/include/init_Debian.sh ${sh_55R}/include/init_Debian.sh
    wget --no-check-certificate -O ${dir}/include/init_Ubuntu.sh ${sh_55R}/include/init_Ubuntu.sh
    clear
    printf "
#######################################################################
#     必备附加脚本下载完毕
#######################################################################
"
}

Int_Shell(){
    wget -N --no-check-certificate -O ${dir}/options.conf http://${options}/options.conf
    wget -N --no-check-certificate -O ${dir}/manyuser.sh ${sh_55R}/manyuser.sh  && chmod +x manyuser.sh
    wget -N --no-check-certificate -O ${dir}/install.sh ${sh_55R}/install.sh  && chmod +x install.sh
    if [ ! -d ${dir}/include ]; then
    mkdir include
    fi
    if [ ! -d ${dir}/src ]; then
    mkdir src
    fi
    wget -N --no-check-certificate -O ${dir}/include/color.sh ${sh_55R}/include/color.sh
    wget -N --no-check-certificate -O ${dir}/include/check_os.sh ${sh_55R}/include/check_os.sh
    wget -N --no-check-certificate -O ${dir}/include/get_char.sh ${sh_55R}/include/get_char.sh
    wget -N --no-check-certificate -O ${dir}/include/memory.sh ${sh_55R}/include/memory.sh
    wget -N --no-check-certificate -O ${dir}/include/download.sh ${sh_55R}/include/download.sh
    wget -N --no-check-certificate -O ${dir}/include/python.sh ${sh_55R}/include/python.sh
    wget -N --no-check-certificate -O ${dir}/include/init_CentOS.sh ${sh_55R}/include/init_CentOS.sh
    wget -N --no-check-certificate -O ${dir}/include/init_Debian.sh ${sh_55R}/include/init_Debian.sh
    wget -N --no-check-certificate -O ${dir}/include/init_Ubuntu.sh ${sh_55R}/include/init_Ubuntu.sh
    clear
    printf "
#######################################################################
#     必备附加脚本下载完毕
#######################################################################
"
}

#check count of parameters. 
if [ $# -eq 0 -o $# -gt 2 ]; then
	echo " - Usage: $0 {options.conf的地址}"; exit 1;
fi
options=${1}
sh_new=0

if [ ! -d ${dir}/include ]; then
Int_Shell
fi

if [ $# -eq 2 -a "$2" = '-p' ]; then
	conf_Shell
fi

clear
	echo -e "当前版本为 [ ${sh_ver} ]，开始检测最新版本..."
	sh_new_ver=$(wget -N --no-check-certificate -qO- "${sh_55R}/55R.sh"|grep 'sh_ver="'|awk -F "=" '{print $NF}'|sed 's/\"//g'|head -1)
	[[ -z ${sh_new_ver} ]] && echo -e "${Error} 检测最新版本失败 !" && Menu
	if [[ ${sh_new_ver} != ${sh_ver} ]]; then
		echo -e "发现新版本[ ${sh_new_ver} ]，是否更新？[Y/n]"
		read -p "(默认: y):" yn
		[[ -z "${yn}" ]] && yn="y"
		if [[ ${yn} == [Yy] ]]; then
        conf_Shell
		wget -N --no-check-certificate ${sh_55R}/55R.sh && chmod +x 55R.sh
        clear
		echo -e "脚本已更新为最新版本[ ${sh_new_ver} ] !"
		else
		echo && echo "已取消更新脚本..." && echo
		fi
	else
		echo -e "当前已是最新版本[ ${sh_new_ver} ] !"
		sleep 5s
	fi

if [ -z "`grep ^python_install_dir ${dir}/options.conf`" ]; then
echo &&	echo -e "Error: options.conf 校验失败!" && echo "Info: 请检查服务器访问配置文件的过程!" && exit 1;
fi

printf "
#######################################################################
#     欢迎使用 后端一键私人版 var ${sh_new_ver}
#     系统支持 CentOS/RadHat 6+ Debian 6+ and Ubuntu 12+
#######################################################################
"
#read -p "按任意键继续...." var
bash install.sh && exit 1