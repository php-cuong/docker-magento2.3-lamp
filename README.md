# How to install Magento 2.3 on localhost
How to install Magento 2.3 with Docker Compose on Windows 10 Pro. In the previous lesson, I showed everybody how to install Magento 2.2.x on Windows 10 Pro in the video link https://www.youtube.com/watch?v=akcaOBrLTzM&list=PL98CDCbI3TNvPczWSOnpaMoyxVISLVzYQ, today I show everybody installing Magento 2.3.

## The basic System Requirements:
    - Windows 10 64bit: Pro, Enterprise or Education (1607 Anniversary Update, Build 14393 or later). You can check Windows 10 Build Version on your computer by going to Run → enter the "winver".
    - Virtualization is enabled in BIOS. Typically, virtualization is enabled by default. This is different from having Hyper-V enabled. For more detail see Virtualization must be enabled in Troubleshooting.
    https://docs.docker.com/docker-for-windows/troubleshoot/#virtualization-must-be-enabled
    - At least 4GB of RAM.
    - Git is installed, go to the link for downloading https://git-scm.com/download/win
    - Docker Community Edition 17.06.2-ce-win27 is installed, go to the link for downloading https://docs.docker.com/docker-for-windows/release-notes/#docker-community-edition-17062-ce-win27-2017-09-06

Okie, let's go.

Let's do this practice, you need to follow steps by step:

## Step 1: Install Docker CE 17.06.2 on the Windows 10 Pro 64bit
Go to the link https://docs.docker.com/docker-for-windows/release-notes/#docker-community-edition-17062-ce-win27-2017-09-06 for downloading the docker CE 17.06.2

## Step 2: Create the docker containers from docker-compose.yml
    - Before creating the docker containers, you must share the local drives where you will save the source codes for your projects. Go to Docker -> Settings -> Shared Drivers, select the local drives you want to be available to your containers.
    - Move to the local drive that you are working on it, don't use the C drive, because all your data will be lost if you re-install windows.
    - Git clone https://github.com/php-cuong/docker-magento2.3-lamp.git
    - Open the docker-compose.yml file and change volumes following the path on your computer
    - Create the docker containers from docker-compose.yml file
    Run the command line: docker-compose up -d
    - Let's see the images on your computer
    Run the command line: docker images
    - Let's see the containers on your computer
    Run the command line: docker ps -a

## Step 3: Install Magento 2.3.0 with Docker
1. Before downloading and installing Magento 2.3.0, you must sure your server meet the minimum following requirements:

    a. Apache 2.4
  
    b. MySQL 5.7
  
    c. PHP 7.1.3+ or 7.2.x

2. Accessing the server where you will install Magento 2.3.0

     a. Where having the PHP, Apache2, Webmin
     
        - Start the docker container named magento2.3: docker start magento2.3
        - Start the docker container named mysql_5.7: docker start mysql_5.7
        - Start the docker container named phpmyadmin_4.8: docker start phpmyadmin_4.8
        - SSH to the container named magento2.3: docker exec -it magento2.3 bin/bash
        - Check the php and apache2 version: php -v, apache2 -v
        - Check the Webmin: https://127.0.0.1:10000
        - username: root
        - password: root

     b. Where having the phpMyadmin
  
        - phpMyadmin: http://127.0.0.1:8080
        - username: root
        - password: giaphugroup
        - Check the mysql version
        - Create the new database named magento_2_3_0

3. Install Magento 2.3.0

        - Go to the link https://magento.com/tech-resources/download for downloading Magento 2.3.0.
        - On your windows, move to the D drive, create the folder named magento/2.3.x/2.3.0, then copy the zip file just downloaded to this folder and unzip the file.
        - Create a host for running Magento 2.3.0 on your localhost: On your Windows 10, go to the path C:\Windows\System32\drivers\etc, open the hosts file
        Insert the new row: 127.0.0.1 magento-en.2.3.0.giaphugroup.com and press the ctrl + s for saving the new data. If you can't save the hosts file, please change the permission.
        - Create a virtual host: On your browser, press https://localhost:10000, log in with the account information: Username: root, Password: root, then go to the Webmin -> Servers -> Apache Webserver -> Create virtual host -> Create a New Virtual Server
        - Restart apache2 service: service apache2 restart
        - On your browser, press http://magento-en.2.3.0.giaphugroup.com
        - The information for connecting to mysql database:
        - host: mysql
        - username: root
        - password: giaphugroup
        - database: magento_2_3_0
        - Deploy static content
        Run the command line: php bin/magento setup:static-content:deploy -f

## Let's install the sample data for Magento 2 please see the practice http://bit.ly/2OKBBwK
- Thank you for your watching. If you have any questions about this practice, please feel free to leave a comment below. Don't forget to like, comment, share my videos and subscribe to my channel for getting the latest videos. Please do not hesitate to contact me, if you need me to join your Magento project. My rate is $25/hour in Magento 1 and $30/hour in Magento 2.
