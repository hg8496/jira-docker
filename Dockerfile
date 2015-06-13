FROM ubuntu:14.04
MAINTAINER hg8496@cstolz.de

ENV JIRA_VERSION 6.4.6

ADD own-volume.sh /usr/local/bin/own-volume

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install sudo software-properties-common python-software-properties xmlstarlet curl -y \
    && echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && DEBIAN_FRONTEND=noninteractive apt-add-repository ppa:webupd8team/java -y \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install oracle-java8-installer -y \
    && curl -Lks http://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-${JIRA_VERSION}.tar.gz -o /root/jira.tar.gz \
    && /usr/sbin/groupadd atlassian \
    && /usr/sbin/useradd --create-home --home-dir /opt/jira --groups atlassian --shell /bin/bash jira \
    && tar zxf /root/jira.tar.gz --strip=1 -C /opt/jira \
    && mkdir -p /opt/atlassian-home \
    && chown -R jira:jira /opt/atlassian-home \
    && echo "jira.home = /opt/atlassian-home" > /opt/jira/atlassian-jira/WEB-INF/classes/jira-application.properties \
    && chown -R jira:jira /opt/jira \
    && mv /opt/jira/conf/server.xml /opt/jira/conf/server-backup.xml \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/jira.tar.gz \
    && echo "%atlassian ALL=NOPASSWD: /usr/local/bin/own-volume" >> /etc/sudoers \
    && mkdir -p /opt/atlassian-home


ENV CONTEXT_PATH ROOT
ADD launch.bash /launch

WORKDIR /opt/jira
VOLUME ["/opt/atlassian-home"]
EXPOSE 8080
USER jira
CMD ["/launch"]
