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
=> An empty or uninitialized MySQL volume is detected in /var/lib/mysql
=> Installing MySQL ...
=> Done!
=> Trying to secure database
=> Starting MySQL service
=> Waiting for confirmation of MySQL service startup
=> Databse is less vulnerable now; Stopping MySQL service

========================================================================
Random generated password for root is:
'9R0Y8sonEfBg5gg48XRy6cW2mr7QiZA9ZzsANAvT1TOWGUIukvnOpV5t9ymCgzuZ7jqN2N7QI9YuQCWlbkOt2wpGfabHa3GZ45ly'
You can now connect to this MySQL Server using:

    mysql -uroot -p<password> -h<host> -P<port>

Change the above password if deemed necessary.
MySQL user 'root' only allows local connections.
========================================================================

2016-11-23 23:13:36,132 CRIT Set uid to user 0
crond[329]: crond (busybox 1.24.2) started, log level 8
```

Follow the rest of the steps from the summary.

## Image stack

-   Based on lightweight [Alpine Linux](https://alpinelinux.org/)
-   [Apache](https://httpd.apache.org/)
-   [PHP](http://php.net/)
-   [MySQL](http://mariadb.org/)
-   [Ampache](http://ampache.org/)

## License

> You can check out the full license [here](./LICENSE)

This project is licensed under the terms of the **MIT** license.
