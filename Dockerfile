FROM debian

RUN apt update
RUN apt --yes install wget patch gcc make g++ libedit-dev uuid-dev libjansson-dev libxml2-dev sqlite3 libsqlite3-dev bzip2
RUN mkdir -p /home/usecallmanager
ADD https://raw.githubusercontent.com/usecallmanagernz/patches/master/asterisk/cisco-usecallmanager-16.16.0.patch /usr/src/
ADD http://downloads.asterisk.org/pub/telephony/asterisk/old-releases/asterisk-16.16.0.tar.gz /usr/src/
WORKDIR /usr/src/
RUN tar -zxvf asterisk-16.16.0.tar.gz
WORKDIR asterisk-16.16.0
RUN patch -p1 < ../cisco-usecallmanager-16.16.0.patch
RUN CFLAGS="-DENABLE_SRTP_AES_GCM -DENABLE_SRTP_AES_256" ./configure
RUN make
RUN make install
CMD service asterisk start && tail -F /var/log/asterisk/full