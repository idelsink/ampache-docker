# Ampache docker release checklist

A simple checklist to test if everything is working correctly.

## Setup

-   [ ] Url is: <http://ip:port>
-   [ ] Web install can be completed via steps in [README.md](./README.md)

## Usage

-   [ ] Local catalog can be added
-   [ ] Local catalog can be indexed
-   [ ] Music from local catalog can be played through web player
    -   [ ] Music can be played with `Streaming > Transcoding > Never`: **Never**
    -   [ ] Music can be played with `Streaming > Transcoding > Always`: **Always**

### UI elements

-  [ ] Waveform available when playing via web player

## Players

### Subsonic

-   [ ] Subsonic XML response at <http://url:port/rest/ping.view>
    ```xml
    <subsonic-response xmlns="http://subsonic.org/restapi" type="ampache" version="1.11.0" status="failed">
        <error code="10" message="Required parameter is missing."/>
    </subsonic-response>
    ```
-   [ ] Subsonic reachable via subsonic player
    -   [ ] Local ip
    -   [ ] External ip via port forwading
-   [ ] Subsonic playable using subsonic player
    -   [ ] Local ip
    -   [ ] External ip via port forwading

### Plex

-   [ ] Plex backend install can be completed via steps in [README.md](./README.md)
-   [ ] Plex backend **Login** reachable
    -   [ ] Local IP login <http://ip:port/web/login.php>
    -   [ ] External ip via port forwading <http://url:port/web/login.php>
-   [ ] Plex backend **Index** reachable
    -   [ ] Local IP login <http://ip:port/web/index.php>
    -   [ ] External ip via port forwading <http://url:port/web/index.php>
-   [ ] Can login at <http://ip:port/web/login.php> page and manually go to <http://url:port/web/index.php>
-   [ ] Link ampache to Plex account
-   [ ] Set Plex email in admin account
-   [ ] Browse content via Plex application
-   [ ] Play content via Plex application

### Webdav

### UPnP / DLNA
