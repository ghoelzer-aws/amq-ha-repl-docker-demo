#AMQ 7 Shared Nothing/HA Demo Image
FROM registry.access.redhat.com/rhel7/rhel

MAINTAINER Greg Hoelzer <ghoelzer@redhat.com>
RUN yum install -y tar gzip unzip bc which lsof java-1.8.0-openjdk java-1.8.0-openjdk-devel && \
    yum clean all

RUN mkdir -p /opt/openshift && \
    mkdir -p /opt/app-root/installs && chmod -R a+rwX /opt/app-root/installs && \
    mkdir -p /opt/app-root/projects/failoverdemo62 && chmod -R a+rwX /opt/app-root/projects/failoverdemo62 && \
    mkdir -p /opt/app-root/source && chmod -R a+rwX /opt/app-root/source && \
    mkdir -p /opt/app-root/target && chmod -R a+rwX /opt/app-root/target && \
    mkdir -p /opt/s2i/destination && chmod -R a+rwX /opt/s2i/destination && \
    mkdir -p /opt/app-root/src && chmod -R a+rwX /opt/app-root/src

ADD installs/ /opt/app-root/installs/
ADD init.sh /opt/app-root/

# Run AMQ 7 Installation and Config
RUN cd /opt/app-root

EXPOSE 8161 8261

#Setup and Run AMQ 7 Artemis
CMD ["/opt/app-root/init.sh"]
