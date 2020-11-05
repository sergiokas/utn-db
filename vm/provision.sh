#!/bin/sh
apt-get update -y && apt-get upgrade -y
apt-get install -y vim zsh tmux

# Databases
apt-get install -y mariadb-server redis-server memcached postgresql sqlite3 libpq-dev libmysqlclient-dev python3-dev python3-venv

# Mysql
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
echo "CREATE USER 'admin'@'%' IDENTIFIED BY 'admin';" | mysql
echo "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%';" | mysql
service mariadb restart

# Postgres
sed -i 's/peer/trust/' /etc/postgresql/10/main/pg_hba.conf
service postgresql restart
psql -U postgres -c "ALTER USER postgres WITH PASSWORD 'postgres';"

# CouchDB
apt-get install -y apt-transport-https gnupg ca-certificates
echo "deb https://apache.bintray.com/couchdb-deb bionic main" | sudo tee -a /etc/apt/sources.list.d/couchdb.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8756C4F765C9AC3CB6B85D62379CE192D401AB61
apt-get update -y
#apt-get install couchdb -y
