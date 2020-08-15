#!/bin/sh
apt-get update -y && apt-get upgrade -y
apt-get install -y vim zsh tmux

# Databases
apt-get install -y mariadb-server redis-server memcached postgresql libpq-dev libmysqlclient-dev

# Postgres
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
