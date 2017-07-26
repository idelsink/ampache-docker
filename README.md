# Ampache Docker
[![](https://images.microbadger.com/badges/version/idelsink/ampache.svg)](https://microbadger.com/images/idelsink/ampache "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/idelsink/ampache.svg)](https://microbadger.com/images/idelsink/ampache "Get your own image badge on microbadger.com")
[![Docker Automated buil](https://img.shields.io/docker/automated/idelsink/ampache.svg)]()  
[![GitHub stars](https://img.shields.io/github/stars/idelsink/ampache-docker.svg?style=social&label=Star)]()
[![Docker Stars](https://img.shields.io/docker/stars/idelsink/ampache.svg)]()
[![Docker Pulls](https://img.shields.io/docker/pulls/idelsink/ampache.svg)]()

An [docker](https://hub.docker.com/r/idelsink/ampache/) image with the [Ampache](http://ampache.org/) music server.

See:  [hub.docker.com/r/idelsink/ampache](https://hub.docker.com/r/idelsink/ampache/)

## Usage

```sh
docker run --name=ampache -d -v /path/to/your/music:/media:ro -p 80:80 idelsink/ampache
```

There are extra ports that can be passed to the container using the `-p` flag.
The ports are:

-   80: http: ampache
-   443: (not used but https for the future)
-   9001: supervisord web UI (used to manage services)
-   32400: plex interface (see See [Plex backend](#plex-backend))

### Timezone

To set the correct timezone in the Docker container, the `TIMEZONE` environment
variable can be set. This can be done by adding the following to the `docker run`
command:

```sh
-e TIMEZONE="Europe/Amsterdam"
```

This would result in:

```sh
docker run --name=ampache -e TIMEZONE="Europe/Amsterdam" -d -v /path/to/your/music:/media:ro -p 80:80 idelsink/ampache
```

See the [List of tz database time zones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) that are available.
See the docker's [run environment variables](https://docs.docker.com/engine/reference/run/) section for more information about environment variables and docker.

## Installation summary

-   Get MySQL root password (Found in terminal or in a file in the `/root` directory in the container)
-   Launch website (<url/ip> or localhost)
-   Fill in obtained root credentials
-   Add new database user
-   Installation type: whatever you like
-   Transcoding: Template Configuration => ffmpeg
-   Players: do whatever you like (See [Available Players](#available-players))
-   Create config
-   Create admin account
-   Update
-   And you're done!
-   Now just add your catalog(s) end configure it like you want it.

## Installation

After starting the docker image as a daemon process,
look at the logs for the pseudo-random generated MySQL root password.

```sh
docker logs ampache
# or for tailing the log file
docker logs -f ampache
```

The output would look something like this:

```text
~~ Configuring system if not yet configured ~~
~~ Configuring supervisord ~~
~~ Configuring apache ~~
~~ Configuring mysql ~~
=> An empty or uninitialized MySQL volume is detected in /var/lib/mysql
=> Installing MySQL ...
=> Done!
=> Trying to secure database
=> Starting MySQL service
=> Waiting for confirmation of MySQL service startup
=> Databse is less vulnerable now; Stopping MySQL service

========================================================================
Random generated password for root is:
'MhKtpfjCHUzhT0vR51Sgu2iCuxlr3P97qo4D2A8jdRsOzaGsuV89nGfAEPF6qNKOIyY4FMawNJF86zOKLdg1eTykpr2vXED3wfrj
'
You can now connect to this MySQL Server using:

    mysql -uroot -p<password> -h<host> -P<port>

Change the above password if deemed necessary.
MySQL user 'root' only allows local connections.
========================================================================

~~ Configuring ampache ~~
=> Unzip ampache archive
~~ Starting the service manager supervisord ~~
```

Follow the rest of the steps from the installation summary.

### Plex backend

To setup the [Plex backend](https://github.com/ampache/ampache/wiki/API#plex-api) do the following:

-   Pass an extra port parameter while starting docker for the Plex backend pointing to port `32400`.  
    For example add `-p 32400:32400` to the `docker run` command.
-   If not already done so during the Ampache setup process, enable the Plex backend at `System > Use Plex backend > Enable`
-   **Manually** go to the `login.php` page at `http://[ip]:[plex port]/web/login.php`
-   Login with an Ampache account
-   After login this page will ***NOT*** forward you to another page.
-   **Manually** go to the `index.php` page at `http://[ip]:[plex port]/web/index.php`
-   Link Ampache to an existing [Plex](plex.tv) account.
-   Setup port forwarding if applicable.
-   Now use the official or any Plex application to browse/play your content. (tested with the *official* Plex application on Android 6.0.1)

## Available Players

> Ampache is more than only a web interface. Several backends are implemented to
> ensure you can stream your media from anywhere. Select backends to enable.
> Depending the backend, you may need to perform additional configuration.
> See [wiki page](https://github.com/ampache/ampache/wiki/API).

Players tested:

-   [x] Web interface
-   [x] Ampache API
-   [x] Subsonic    
-   [x] Plex       
-   [ ] UPnP         
-   [ ] DAAP (iTunes)
-   [ ] WebDAV        

## Update

To update to the newest docker image, if necessary, a backup can be made.
This is done by running a small script inside the docker container.
This will backup the database and Ampache configuration.

### Backup / restore configurations

Follow these steps to perform a backup of Ampache.
Follow Steps 8 to (end) to restore a backup of Ampache.

1.  Find your docker name / ID
```sh
docker ps
```

2.  Connect to the running container
```sh
docker exec -it <ID or name> sh
```

3.  Run the backup script (inside the container)
```sh
mkdir /backup
/scripts/backup.sh b /backup
```

4.  Follow the instructions

5.  Exit the docker container
```sh
exit
```

6.  Copy the files from the container to the host
```sh
docker cp <ID or name>:/backup ./backup
```

7.  Update to the new/other container and let it finish configuring

8.  Copy the files from host to container
```sh
docker cp ./backup <ID or name>:/backup
```

9.  Restore the backup using the backup script
```sh
/scripts/backup.sh r /backup
```

10. Follow the instructions

Exit the container and you're done.

## Some extra notes

-   The MySQL root password can be found in the `/root` directory.
-   Make sure that your volume is mounted correctly, e.g. if using SELinux make sure to add the appropriate permission labels. (See [this](https://docs.docker.com/engine/tutorials/dockervolumes/#/volume-labels))
-   Make sure not to use a port that is already used by another webserver/process.

## Image stack

-   Based on lightweight [Alpine Linux](https://alpinelinux.org/)
-   [Apache](https://httpd.apache.org/)
-   [MySQL](http://mariadb.org/)
-   [PHP](http://php.net/)
-   [Ampache](http://ampache.org/)
-   [FFmpeg](https://www.ffmpeg.org/) for all your transcoding needs

## License

> You can check out the full license [here](./LICENSE)

This project is licensed under the terms of the **MIT** license.
