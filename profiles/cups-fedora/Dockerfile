FROM fedora
MAINTAINER AVL <avlubimov@gmail.com>
LABEL maintainer="AVL <avlubimov@gmail.com>"
LABEL description="Cupsd on top of centos i386"

ENV VOLUME=/srv

#RUN sed -i '/excludedocs/d' /etc/rpm/macros.imgcreate
#RUN sed -i '/nodocs/d' /etc/yum.conf
RUN dnf -q update -y && dnf -q install -y cups file cups-filters

RUN mkdir -p ${VOLUME}
RUN mkdir -p ${VOLUME}/cups

COPY --chown=root:root --chmod=0755 docker-entrypoint.sh /
RUN touch /etc/cups/START_CUPS_BROWSED.off
RUN mv /etc/cups/* ${VOLUME}/cups/

CMD ["/docker-entrypoint.sh"]




