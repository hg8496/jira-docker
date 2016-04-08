FROM hg8496/atlassian-docker
MAINTAINER hg8496@cstolz.de

ENV JIRA_VERSION 7.1.4

RUN curl -Lks  https://downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-${JIRA_VERSION}-jira-${JIRA_VERSION}.tar.gz -o /jira.tar.gz
RUN mkdir -p /opt/jira
RUN tar zxf /jira.tar.gz --strip=1 -C /opt/jira
RUN echo "jira.home = /opt/atlassian-home" > /opt/jira/atlassian-jira/WEB-INF/classes/jira-application.properties
RUN mv /opt/jira/conf/server.xml /opt/jira/conf/server-backup.xml
RUN chown -R atlassian:atlassian /opt/jira
RUN apt-get clean 
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /jira.tar.gz

ENV CONTEXT_PATH ROOT
ENV DATABASE_URL ""
ENV SSL_PROXY ""

ADD launch.bash /launch

WORKDIR /opt/jira
VOLUME ["/opt/atlassian-home"]
EXPOSE 8080
USER atlassian
CMD ["/launch"]
