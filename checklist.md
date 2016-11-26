# Ampache docker release checklist

A simple checklist to test if everything is working correctly.

## Setup

-   [ ] Url is: <http://ip:port/ampache>
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

-   [ ] Subsonic XML response at <http://url:port/ampache/rest/ping.view>
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

### Webdav

### UPnP / DLNA
