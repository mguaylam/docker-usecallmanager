FROM debian

RUN apt update
RUN apt --yes install wget patch gcc make g++ libedit-dev uuid-dev libjansson-dev libxml2-dev sqlite3 libsqlite3-dev bzip2
RUN mkdir -p /home/usecallmanager
ADD https://raw.githubusercontent.com/usecallmanagernz/patches/master/asterisk/cisco-usecallmanager-18.2.2.patch /usr/src/
ADD http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-18.2.2.tar.gz /usr/src/
WORKDIR /usr/src/
RUN tar -zxvf asterisk-18.2.2.tar.gz
WORKDIR /usr/src/asterisk-18.2.2/
RUN patch -p1 < ../cisco-usecallmanager-18.2.2.patch
RUN CFLAGS="-DENABLE_SRTP_AES_GCM -DENABLE_SRTP_AES_256" ./configure
RUN make
RUN make install
RUN make config
RUN make samples
ENTRYPOINT asterisk -cvv