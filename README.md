# EPrints-dock

Environments for running preconfigured EPrints repository in a Docker container.

This environment files are necessary to run [rorasa/eprints3](https://hub.docker.com/r/rorasa/eprints3/) Docker image.

====

Ever want a digital repository in your home?

EPrints-dock allows an institutional-grade repository system [EPrints](http://www.eprints.org) to be deployed instantly as a 
docker container. EPrints is a full-fledged respository system employed in hundreds on universities and libraries worldwide. 
With EPrints-dock, it takes only a few steps to have your own powerful repository up-and-running locally in no time.

EPrints-dock is designed to work as a local repository where large traffic and security are not concerns. 
It works best as a local repository, home repository or a demo. 
For large scale production repository, it is advised to deploy EPrints properly on a server following the instructions 
at http://wiki.eprints.org/w/Main_Page .

## Installation

For first time installation of EPrints-dbox, follow the following steps:

### 1. Install Docker

Docker engine for your OS can be found and install following the instruction at https://www.docker.com/products/docker

### 2. Download EPrints-dock (For new repository only)

Download the latest release of EPrints-dock at https://github.com/rorasa/eprints-dock/releases .

ALternatively, use git to clone a repository:
```
git clone https://github.com/rorasa/eprints-dock.git
```

### 3. Start you EPrints in a docker container
 
 Run start_eprints.sh script to start the container.
 
 
### 4. Setting up a new repository (For new repository only)

If you have just downloaded a blamk EPrints-dock, you need to set up a new repository.
Please follow the instructions in Create your repository.

An EPrints repository is required to have its own domain name. Suppose your repository's domain is *your.repository.domain*, 
please map this domain to 127.0.0.1 in your machine's host setting.

**In Linux or MAC** Add the domain to your `/etc/hosts`.

Example

```bash
echo "127.0.0.1     your.repository.domain | sudo tee -a /etc/hosts
```

**In Windows**

1. Start Notepad.exe as Administrator.
2. Using Notepad, open C:\Windows\System32\Drivers\etc\hosts
3. Add `127.0.0.1     your.repository.domain` to the last line. Save the file.

### 6. Access your repository

Open your web browser. Type in `your.repository.domain` (don't forget to change this to your real domain) into the browser URL box. 
Suppose that the repository is already created and the hosts file is set correctly, the homepage of EPrints should show up. Enjoy!

## Day-to-day use of EPrints-dock

After the first time setup of EPrints-dock and the repository, it is very easy to access your repository. 

Just start up Docker, run start_eprints.sh script, and go to your.domain.name on your browser. That's it!

## Create your repository

If this is the first time you use EPrints-dock, then you have to create a new repository.

### 1. Get a fresh EPrints-dock

After all the requires dependencies are installed, please download and extract the latest version of EPrints-dock from https://github.com/rorasa/eprints-dock/releases .

### 2. Start up your repository server

Start your repository server by execute the start_eprints.sh script. After the server is started, you should be at the root of the server. Run this command
```bash
su eprints
```
to switch to *eprints* admin user. You should now be at `eprints@<containerid>$`.

### 3. Create new repository

The instance of EPrints is installed at `/usr/share/eprints3/`. To create a new repository, use command
```bash
/usr/share/eprints3/bin/epadmin create
```
then follow the on-screen instructions.

Please take note of the *Host Name*. This is your repository's domain (*your.repository.domain*) the you will use to access your repository. It is also the domain name you use during the setup of your host.

When prompt to create a database, use username `root` and password `root`.

### 5. Finalise your repository

After a new repository is created. Do
```bash
exit
```
to drop back to root user. 

Then restart the server by
```bash
service apache2 restart
```

Supposed that you already setup your machine's host, you can put your repository's domain into your browser. If everything is working properly you should see an EPrints homepage.

# Technical details

The following part of this documentation is inteded for developers and is not requires for a day-to-day use of EPrints-dock.

## Structure of EPrints-dock

* start_eprints.sh -- A script to start EPrints server via docker run command.
* eprints -- A folder that stores all the repository data.
* mysql -- A folder that stores EPrints's MySQL database.

## Software in the package

The current version of EPrints-dock is shipped with EPrints 3.3, Ubuntu 14.04 LTS, and Apache 2.

## Construction of the image

This section describes the steps to construct the iamge rorasa/eprints3 in details.

### Start base image

On your terminal, run
```
docker run --name prototype -p 80:80 -v $PWD/eprints3/archives:/usr/share/eprints3/archives -v $PWD/eprints3/cfg:/usr/share/eprints3/cfg -v $PWD/mysql:/var/lib/mysql -t -i ubuntu:14.04
```

### Add EPrints APT
Open APT sources.list
```
vi /etc/apt/sources.list
```
Add the following lines to the file:
```
deb http://deb.eprints.org/3.3/ stable/
deb-src http://deb.eprints.org/3.3/ source/
```

### Install LAMP stack and EPrints
```
apt-get update && apt-get -y --force-yes install apache2 mysql-server php5 libapache2-php5 eprints 
```

### Create a bootstrap file
On the terminal, 
```
vi bootstrap.sh
```
Add the following lines to bootstrap.sh:
```
#!/bin/bash

service apache2 start
service mysql start

echo "========================================================="
echo "                 Welcome to EPrints-dock                 "
echo "========================================================="
```

### Enable EPrints and exit
On the terminal, 
```
a2ensite eprints
exit
```

You should now be back at the host shell.

### Commit a new image
Commit a new image by
```
docker commit --change "CMD bash -C '/bootstrap.sh'; 'bash'" -a "auther name <auther email>" -m "Commit meesage" <container-id> rorasa/eprints3
```

## References

[EPrints manual](http://wiki.eprints.org/w/EPrints_Manual)

[Docker documentation](https://docs.docker.com/)
