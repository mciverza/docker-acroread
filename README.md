# Adobe Acrobat (acroread)

WORK IN PROGRESS, to convert this to an LXD container and then to an AppImage (see AppImage.org)

Forked from chrisdaish/docker-acroread

First edit 2016/12/14


Unofficial build of Adobe Acrobat 9.5.5 running within a docker container and
rendered by the local X Server.

## Changelog

```
v1.3
* Added cups printing support. Volume mount /etc/cups/client.conf:ro + /var/run/cups:ro
  NB: You might need to modify your cupsd.conf to allow printing from the Docker bridge IP.
* Upgraded base image from Ubuntu 14.04 to Ubuntu 14.04.3

v1.2
* Optional environment variables 'ARGS' and 'FILE' can now be passed into the
  container. For example: -e ARGS='-geometry 500x500' -e FILE='/home/acroread/Documents/dockercon14_agenda-digital.pdf'

* Additional configuration files can now be mounted inside the container (see example below).
  I have included the sample config in my [GitHub](https://github.com/chrisdaish/docker-acroread/tree/master/configFiles).

v1.1
* User permissions now correlate between host and container. This allows PDF
  files to be saved back to the host system by passing in the local users
  uid/gid as environment variables.

v1.0
* Initial Release
```

## Launch Command

```
docker run  -v $HOME/PathToDirectoryContainingPDFs:/home/acroread/Documents:rw \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -e uid=$(id -u) \
            -e gid=$(id -g) \
            -e DISPLAY=unix$DISPLAY \
            --name acroread \
            chrisdaish/acroread
```

Additional config example:

```
docker run  -v $HOME/PathToDirectoryContainingPDFs:/home/acroread/Documents:rw \
            -v $HOME/<pathToConfigFiles>/reader_prefs:/home/acroread/.adobe/Acrobat/9.0/Preferences/reader_prefs:ro \
            -v $HOME/<pathToConfigFiles>/client.conf:/etc/cups/client.conf:ro \
            -v /var/run/cups:/var/run/cups:ro \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -e uid=$(id -u) \
            -e gid=$(id -g) \
            -e DISPLAY=unix$DISPLAY \
            -e FILE='/home/acroread/Documents/dockercon14_agenda-digital.pdf' \
            --name acroread \
            chrisdaish/acroread
```

## FAQ

Note: If you receive the following Gtk error:

```
Gtk-WARNING **: cannot open display: unix:0.0
```

Simply allow the docker user to communicate with your X session

```
xhost +local:docker
```
