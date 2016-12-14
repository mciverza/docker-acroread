FROM ubuntu:14.04.3

MAINTAINER Chris Daish <chrisdaish@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV acroreadPackage AdbeRdr9.5.5-1_i386linux_enu.deb
ENV uid 1000
ENV gid 1000

RUN useradd -m acroread; \
    dpkg --add-architecture i386; \
    apt-get update; \
    apt-get install -y wget libcups2 libgtk2.0-0:i386 libnss3-1d:i386 libnspr4-0d libxml2:i386 libxslt1.1:i386 libstdc++6:i386
    rm -rf /var/lib/apt/lists/*
#removed cups and libnss-mdns since this is intented to be an AppImage, that will use the hosts's print and other stuff.

RUN wget -q http://ardownload.adobe.com/pub/adobe/reader/unix/9.x/9.5.5/enu/$acroreadPackage -O /tmp/$acroreadPackage; \
    dpkg -i  /tmp/$acroreadPackage; \
    rm /tmp/$acroreadPackage

COPY start-acroread.sh /tmp/

ENTRYPOINT ["/tmp/start-acroread.sh"]
