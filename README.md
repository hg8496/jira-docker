# jira-docker
docker run --name mysql-jira-data -d mysql false
docker run -d --name jira-data hg8496/jira false
docker run --volumes-from mysql-jira-data --name mysql-jira -e MYSQL_USER=jira -e MYSQL_PASSWORD=jira -e MYSQL_DATABASE=jira -e MYSQL_ROOT_PASSWORD=toor -d mysql
