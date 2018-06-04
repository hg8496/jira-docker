FROM hg8496/atlassian-docker
MAINTAINER hg8496@cstolz.de

ENV JIRA_VERSION 7.10.0

RUN curl -Lks https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-${JIRA_VERSION}.tar.gz -o /jira.tar.gz \
  && mkdir -p /opt/jira \
  && tar zxf /jira.tar.gz --strip=1 -C /opt/jira \
  && echo "jira.home = /opt/atlassian-home" > /opt/jira/atlassian-jira/WEB-INF/classes/jira-application.properties \
  && mv /opt/jira/conf/server.xml /opt/jira/conf/server-backup.xml \
  && chown -R atlassian:atlassian /opt/jira \
  && apt-get clean  \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /jira.tar.gz

ENV CONTEXT_PATH ROOT
ENV DATABASE_URL ""
ENV SSL_PROXY ""

COPY launch.bash /launch

WORKDIR /opt/jira
VOLUME ["/opt/atlassian-home"]
EXPOSE 8080
USER atlassian
CMD ["/launch"]
