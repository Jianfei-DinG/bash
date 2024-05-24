<img src="https://cdn.jsdelivr.net/gh/Dtyyyyyy/PicGoIMG/img/mysql.png" width = "100%" height = "100%" div align=center />

<hr style="border: none; height: 1px; background-color: green;">

安装
```
sudo apt-get install mysql-server 安装包
apt show mysql-server #版本号
mysql --version #查看版本
```

```
最新版本安装
https://dev.mysql.com/downloads/repo/apt/  #查看
https://dev.mysql.com/get/mysql-apt-config_0.8.30-1_all.deb   #下载
wget https://dev.mysql.com/get/mysql-apt-config_0.8.30-1_all.deb

sudo dpkg -i mysql-apt-config_0.8.30-1_all.deb
sudo apt-get update
sudo apt-get install mysql-server

sudo systemctl start mysql  #启动
sudo systemctl status mysql  #查看服务的状态
https://www.cnblogs.com/Magiclala/p/16638781.html #教程
```
<hr style="border: none; height: 1px; background-color: green;">

```
卸载
sudo service mysql stop  #停止 MySQL 服务
sudo apt-get remove --purge mysql-server mysql-client mysql-common  #卸载 MySQL 服务器软件包
sudo rm -rf /etc/mysql /var/lib/mysql #删除 MySQL 配置文件和数据
sudo apt-get autoremove #清除残余的依赖项
sudo apt-get clean  #清理缓存
```
<hr style="border: none; height: 1px; background-color: green;">

```
sudo mysql -u root -p  #登录
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'xinmima2018';  #首次修改密码
SELECT User, Host FROM mysql.user WHERE User='root';  #查询用户

##### 更改为允许来自任何主机（'%'）##
USE mysql;  #进入 MySQL 数据库
UPDATE user SET Host='%' WHERE User='root' AND Host='localhost';   #修改 root 用户的 Host 字段
FLUSH PRIVILEGES;  #刷新权限

SELECT User, Host FROM mysql.user WHERE User='root';  #查询用户
#############################
```
<hr style="border: none; height: 1px; background-color: green;">

```
允许远程连接
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
# bind-address            = 0.0.0.0
sudo systemctl restart mysql
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'xinmima2018';  #连接失败需要执行
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'xinmima2018' WITH GRANT OPTION;  #授予用户权限连接

授予用户访问特定的数据库，database_name 是数据库名。
GRANT ALL PRIVILEGES ON database_name.* TO 'user'@'远程主机IP' IDENTIFIED BY 'password' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON database1.* TO 'user'@'远程主机IP' IDENTIFIED BY 'password' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON database2.* TO 'user'@'远程主机IP' IDENTIFIED BY 'password' WITH GRANT OPTION;

quit #退出
```
<hr style="border: none; height: 1px; background-color: green;">
