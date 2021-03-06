#Debian implementation of https://github.com/shellbro/dockerfile-dropbox.git
FROM debian:latest

ARG HOST_UID=1001
ARG HOST_GID=1001

RUN apt -y update;\
    apt -y install python python3 curl

RUN groupadd -g $HOST_GID dropbox-user && \
    useradd -ms /bin/bash -u $HOST_UID -g $HOST_GID dropbox-user  && \
    mkdir /opt/dropbox && \
    chown $HOST_UID:$HOST_GID /opt/dropbox
COPY dropbox.sh /opt/dropbox/dropbox.sh

USER dropbox-user
WORKDIR /home/dropbox-user

RUN cd /opt/dropbox && \
    curl -L "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf - &&\
    >&2 echo "Dropbox ver.:" $(cat /opt/dropbox/.dropbox-dist/VERSION) &&\
    curl -L -o dropbox\
    "https://www.dropbox.com/download?dl=packages/dropbox.py" &&\
    chmod a+x /opt/dropbox/dropbox

EXPOSE 17500

ENTRYPOINT ["/bin/bash","/opt/dropbox/dropbox.sh"]
