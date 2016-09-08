# EPrints-dock

Environments for running preconfigured EPrints repository in a Docker container.

This environment files are necessary to run rorasa/eprints3 Docker image.

====

Ever want a digital repository in your home?

EPrints-dock allows an institutional-grade repository system [EPrints](http://www.eprints.org) to be deployed instantly as a 
docker container. EPrints is a full-fledged respository system employed in hundreds on universities and libraries worldwide. 
With EPrints-dbox, it takes only a few steps to have your own powerful repository up-and-running locally in no time.

EPrints-dbox is designed to work as a local repository where large traffic and security are not concerns. 
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

## Day-to-day use of EPrints-box

After the first time setup of EPrints-dock and the repository, it is very easy to access your repository. 

Just start up Docker, run start_eprints.sh script, and go to your.domain.name on your browser. That's it!

## Create your repository

If this is the first time you use EPrints-box, then you have to create a new repository.

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

Please take note of the *Host Name*. This is your repository's domain (*your.repository.domain*) the you will use to access your repository. It is also the domain name you use [during the setup of your host](https://github.com/rorasa/eprints-box#5-setting-your-host).

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

