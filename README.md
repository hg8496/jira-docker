# jira-docker

Mostly borrowed from https://bitbucket.org/atlassianlabs/atlassian-docker

docker run --name postgres-jira-data -e POSTGRES_PASSWORD=jira -d postgres:9.3 false
docker run --volumes-from postgres-jira-data --name postgres-jira -e POSTGRES_PASSWORD=jira -d postgres:9.3

docker run -d --name jira-data hg8496/jira false
docker run -ti --name jira --volumes-from jira-data --link postgres-jira:postgres -p 127.0.0.1:55080:8080 -e SSL_PROXY=jira.domain.de -e DATABASE_URL=postgresql://postgres:jira@postgres:5432/postgres
