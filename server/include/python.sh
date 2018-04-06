#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://blog.linuxeye.com
#
# Notes: OneinStack for CentOS/RadHat 5+ Debian 6+ and Ubuntu 12+
#
# Project home page:
#       https://oneinstack.com
#       https://github.com/lj2007331/oneinstack

Install_Python() {
  pushd ${oneinstack_dir}/src
  if [ "${CentOS_RHEL_version}" == '7' ]; then
    [ ! -e /etc/yum.repos.d/epel.repo ] && cat > /etc/yum.repos.d/epel.repo << EOF
[epel]
name=Extra Packages for Enterprise Linux 7 - \$basearch
#baseurl=http://download.fedoraproject.org/pub/epel/7/\$basearch
mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=\$basearch
failovermethod=priority
enabled=1
gpgcheck=0
EOF
  elif [ "${CentOS_RHEL_version}" == '6' ]; then
    [ ! -e /etc/yum.repos.d/epel.repo ] && cat > /etc/yum.repos.d/epel.repo << EOF
[epel]
name=Extra Packages for Enterprise Linux 6 - \$basearch
#baseurl=http://download.fedoraproject.org/pub/epel/6/\$basearch
mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=\$basearch
failovermethod=priority
enabled=1
gpgcheck=0
EOF
  fi

  if [ "${OS}" == "CentOS" ]; then
    pkgList="gcc dialog augeas-libs openssl openssl-devel libffi-devel redhat-rpm-config ca-certificates"
    for Package in ${pkgList}; do
      yum -y install ${Package}
    done
  else
    pkgList="gcc dialog libaugeas0 augeas-lenses libssl-dev libffi-dev libpcre3 libpcre3-dev ca-certificates"
    for Package in ${pkgList}; do
      apt-get -y install $Package
    done
  fi

  # Install zlib
    #src_url=http://cnpve.ru/download/zlib-1.2.11.tar.gz && Download_src
    src_url=https://raw.githubusercontent.com/wxlost/shell/master/server/src/zlib-1.2.11.tar.gz && Download_src
    tar xzf zlib-1.2.11.tar.gz
    rm -rf zlib-1.2.11.tar.gz
    pushd zlib-1.2.11
    ./configure
    make && make install
    popd
    rm -rf zlib-1.2.11

  # Install Python
  if [ ! -e "${python_install_dir}/bin/python" -a ! -e "${python_install_dir}/bin/python3" ] ;then
    #src_url=http://cnpve.ru/download/Python-2.7.14.tgz && Download_src
    src_url=https://raw.githubusercontent.com/wxlost/shell/master/server/src/Python-2.7.14.tgz && Download_src
    tar xzf Python-2.7.14.tgz
    tar xzf Python-2.7.14.tgz
    rm -rf Python-2.7.14.tgz
    pushd Python-2.7.14
    ./configure --prefix=${python_install_dir}
    make && make install
    [ ! -e "${python_install_dir}/bin/python" -a -e "${python_install_dir}/bin/python3" ] && ln -s ${python_install_dir}/bin/python{3,}
    popd
    rm -rf Python-2.7.14
  fi

  if [ ! -e "${python_install_dir}/bin/easy_install" ] ;then
    #src_url=http://cnpve.ru/download/setuptools-32.0.0.zip && Download_src
    src_url=https://raw.githubusercontent.com/wxlost/shell/master/server/src/setuptools-32.0.0.zip && Download_src
    unzip -q setuptools-32.0.0.zip
    rm -rf setuptools-32.0.0.zip
    pushd setuptools-32.0.0
    ${python_install_dir}/bin/python setup.py install
    popd
    rm -rf setuptools-32.0.0
  fi

  if [ ! -e "${python_install_dir}/bin/pip" ] ;then
    #src_url=http://cnpve.ru/download/pip-9.0.1.tar.gz && Download_src
    src_url=https://raw.githubusercontent.com/wxlost/shell/master/server/src/pip-9.0.1.tar.gz && Download_src
    tar xzf pip-9.0.1.tar.gz
    rm -rf pip-9.0.1.tar.gz
    pushd pip-9.0.1
    ${python_install_dir}/bin/python setup.py install
    popd
    rm -rf pip-9.0.1
    rm -rf /usr/bin/pip
    ln -s /usr/local/python/bin/pip /usr/bin/pip												
  fi

  #注释,有的机器报错.http://mirrors.linuxeye.com/oneinstack/src
  #if [ ! -e "/root/.pip/pip.conf" ] ;then
  #    [ ! -d "/root/.pip" ] && mkdir /root/.pip
  #    echo -e "[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple" > /root/.pip/pip.conf
  #fi
  popd
}
