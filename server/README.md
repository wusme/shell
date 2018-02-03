# server
## 本人自用 和 常用脚本临时测试


### 1.后端-安装到 /home 。大约需要2G硬盘空间
##### 需要网站支持-将脚本下载到本地，修改内容后上传到你的网站。
```
wget --no-check-certificate -O `pwd`/options.conf https://raw.githubusercontent.com/wxlost/shell/master/server/options.conf
```
##### 比如上传后访问链接为 https://myhome.com/tools/options.conf 那么 你的参数就是 myhome.com/tools
```
cd /root && wget --no-check-certificate -O 55R.sh https://raw.githubusercontent.com/wxlost/shell/master/server/55R.sh && chmod +x 55R.sh && bash 55R.sh myhome.com/tools
```
##### 初次使用需要用上面的下载，后续执行本脚本
```
bash 55R.sh myhome.com/tools
```


### 原始脚本
```
cd /root && wget --no-check-certificate -O 55R.sh https://raw.githubusercontent.com/wxlost/shell/master/server/55R.sh && chmod +x 55R.sh && bash 55R.sh 参数
```
