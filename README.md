# shell
## 本人自用 和 常用脚本临时测试


### 1.后端-安装到 /home 。大约需要2G硬盘空间
#### 需要网站支持-将脚本下载到本地，修改内容后上传到你的网站。
```
wget --no-check-certificate -O `pwd`/options.conf https://raw.githubusercontent.com/wxlost/shell/master/server/options.conf
```
##### 比如上传后访问链接为 https://myhome.com/tools/options.conf 那么 你的参数就是 myhome.com/tools
```
NAME="55R" && cd /root && wget --no-check-certificate -O $NAME.sh https://raw.githubusercontent.com/wxlost/shell/master/server/$NAME.sh && chmod +x $NAME.sh && bash $NAME.sh myhome.com/tools
```

### 原始脚本
```
NAME="55R" && cd /root && wget --no-check-certificate -O $NAME.sh https://raw.githubusercontent.com/wxlost/shell/master/server/$NAME.sh && chmod +x $NAME.sh && bash $NAME.sh 参数
```



# 2.秘钥登陆




# 3.伪装
```
NAME="caddy_install" && wget --no-check-certificate -O $NAME.sh https://raw.githubusercontent.com/wxlost/shell/master/caddy/$NAME.sh && chmod +x $NAME.sh && bash $NAME.sh install http.filemanager
```
```
NAME="caddy_onepvp" && wget --no-check-certificate -O $NAME.sh https://raw.githubusercontent.com/wxlost/shell/master/caddy/$NAME.sh && chmod +x $NAME.sh && bash $NAME.sh install http.filemanager
```