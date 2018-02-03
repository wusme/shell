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
    src_url=https://raw.githubusercontent.com/wxlost/shell/master/server/src/zlib-1.2.11.tar.gz && Download_src
    tar xzf zlib-1.2.11.tar.gz
    pushd zlib-1.2.11
    ./configure
    make && make install
    popd
    rm -rf zlib-1.2.11

  # Install Python
  if [ ! -e "${python_install_dir}/bin/python" -a ! -e "${python_install_dir}/bin/python3" ] ;then
    src_url=http://mirrors.linuxeye.com/oneinstack/src/Python-${python_version}.tgz && Download_src
    tar xzf Python-${python_version}.tgz
    pushd Python-${python_version}
    ./configure --prefix=${python_install_dir}
    make && make install
    [ ! -e "${python_install_dir}/bin/python" -a -e "${python_install_dir}/bin/python3" ] && ln -s ${python_install_dir}/bin/python{3,}
    popd
    rm -rf Python-${python_version}
  fi

  if [ ! -e "${python_install_dir}/bin/easy_install" ] ;then
    src_url=http://mirrors.linuxeye.com/oneinstack/src/setuptools-${setuptools_version}.zip && Download_src
    unzip -q setuptools-${setuptools_version}.zip
    pushd setuptools-${setuptools_version}
    ${python_install_dir}/bin/python setup.py install
    popd
    rm -rf setuptools-${setuptools_version}
  fi

  if [ ! -e "${python_install_dir}/bin/pip" ] ;then
    src_url=http://mirrors.linuxeye.com/oneinstack/src/pip-${pip_version}.tar.gz && Download_src
    tar xzf pip-${pip_version}.tar.gz					   
    pushd pip-${pip_version}
    ${python_install_dir}/bin/python setup.py install
    popd
    rm -rf pip-${pip_version}
    rm -rf /usr/bin/pip
    ln -s /usr/local/python/bin/pip /usr/bin/pip												
  fi

  if [ ! -e "/root/.pip/pip.conf" ] ;then
      [ ! -d "/root/.pip" ] && mkdir /root/.pip
      echo -e "[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple" > /root/.pip/pip.conf
  fi
  popd
}
