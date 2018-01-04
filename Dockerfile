# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
FROM elzurdo87/debian-apache-php-last

run apt-get update 
run apt-get install -y php-xml subversion


copy ./instantclient-basic-linux.x64-12.2.0.1.0.zip /home
copy ./instantclient-sdk-linux.x64-12.2.0.1.0.zip /home

run mkdir -p /opt/oracle/instantclient

run cp /home/instantclient-basic-linux.x64-12.2.0.1.0.zip /opt/oracle/instantclient
run cp /home/instantclient-sdk-linux.x64-12.2.0.1.0.zip /opt/oracle/instantclient

run cd /opt/oracle/instantclient && \ 
        unzip instantclient-basic-linux.x64-12.2.0.1.0.zip && \ 
        unzip instantclient-sdk-linux.x64-12.2.0.1.0.zip && \ 
        mv instantclient_12_2/* ./ && \
        rm -r instantclient_12_2/ instantclient-basic-linux.x64-12.2.0.1.0.zip instantclient-sdk-linux.x64-12.2.0.1.0.zip

run cd /opt/oracle/instantclient && \ 
    ln -s libclntsh.so.12.1 libclntsh.so && \ 
    ln -s libocci.so.12.1 libocci.so

env ORACLE_HOME /opt/oracle/instantclient
env LD_LIBRARY_PATH /opt/oracle/instantclient

#run pecl install oci8-2.0.12

run     echo instantclient,/opt/oracle/instantclient | pecl install oci8
run     echo "extension=oci8.so" >> /etc/php/7.0/apache2/php.ini


expose 22 80 443

#CMD    ["/usr/sbin/sshd", "-D"]



