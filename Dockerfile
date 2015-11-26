FROM hg8496/atlassian-docker
MAINTAINER hg8496@cstolz.de

ENV JIRA_VERSION 7.0.0

RUN curl -Lks  https://downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-${JIRA_VERSION}-jira-${JIRA_VERSION}.tar.gz -o /root/jira.tar.gz \
    && tar zxf /root/jira.tar.gz --strip=1 -C /opt/jira \
    && echo "jira.home = /opt/atlassian-home" > /opt/jira/atlassian-jira/WEB-INF/classes/jira-application.properties \
    && mv /opt/jira/conf/server.xml /opt/jira/conf/server-backup.xml \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/jira.tar.gz

ENV CONTEXT_PATH ROOT
ENV DATABASE_URL ""
ENV SSL_PROXY ""

ADD launch.bash /launch

WORKDIR /opt/jira
VOLUME ["/opt/atlassian-home"]
EXPOSE 8080
USER jira
CMD ["/launch"]
