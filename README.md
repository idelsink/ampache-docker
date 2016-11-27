# Ampache Docker

An [docker](https://hub.docker.com/r/idelsink/ampache/) image with the [Ampache](http://ampache.org/) music server.

See:  [hub.docker.com/r/idelsink/ampache](https://hub.docker.com/r/idelsink/ampache/)

## Usage

```sh
docker run --name=ampache -d -v /path/to/your/music:/media:ro -p 80:80 idelink/ampache
```

## Installation summary

-   Get MySQL root password
-   Launch website (webroot/ampache; e.g. localhost/ampache)
-   Fill in obtained root credentials
-   New database user
-   Installation type: whatever you like
-   Transcoding: Template Configuration => ffmpeg
-   Players: do whatever you like (not tested, if not working create an issue please)
-   Create config
-   Create admin account
-   Update
-   And you're done!

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
~~ configuring system if not yet configured ~~
=> An empty or uninitialized MySQL volume is detected in /var/lib/mysql
=> Installing MySQL ...
=> Done!
=> Trying to secure database
=> Starting MySQL service
=> Waiting for confirmation of MySQL service startup
=> Databse is less vulnerable now; Stopping MySQL service

========================================================================
Random generated password for root is:
'P6eKWRlemOmuLHTUv8lTNxSq0xGepZ7rE5u7N7aRW9NuxHV5YA6q7rq9NM3BqeAVGK0TUi4DfCpcerXSR0MOlVJYl4RI0wHIHrlz'
You can now connect to this MySQL Server using:

    mysql -uroot -p<password> -h<host> -P<port>

Change the above password if deemed necessary.
MySQL user 'root' only allows local connections.
========================================================================

~~ starting the service manager supervisord ~~
2016-11-24 20:06:31,735 CRIT Set uid to user 0
crond[332]: crond (busybox 1.24.2) started, log level 8
```

Follow the rest of the steps from the summary.

### Plex backend

To setup the Plex backend do the following:

-   Pass an extra port while starting docker for the Plex backend pointing to `32400`.  
    For example add `-p 32400:32400` to the `docker run` command.
-   Enable the Plex backend (if not done during the installation process at `System > Use Plex backend > Enable`)
-   **Manually** go to the `login.php` page at <http://[ip]:[plex port]/web/login.php>
-   Login with an Ampache account
-   After login this page will ***NOT*** forward you to another page.
-   **Manually** go to the `index.php` page at <http://[ip]:[plex port]/web/index.php>
-   Link Ampache to an existing [Plex](plex.tv) account.
-   Make sure that the extra Plex port is available outside of your network via port forwarding, if you not only want to use it locally.
-   Now use the official or any Plex application to browse/play your content. (tested with the *official* Plex application on an Android v6.0.1)

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

## Some extra notes

-   Make sure that your volume is mounted correctly, e.g. if using SELinux make sure to add the appropriate permission labels
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
