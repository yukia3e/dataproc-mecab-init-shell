#!/bin/bash

# install Google Python client on all nodes
apt-get update
apt-get install -y python-pip
pip install --upgrade pip
pip install --upgrade google-api-python-client

# install Mecab
apt-get install -y mecab libmecab-dev mecab-ipadic mecab-ipadic-utf8 git make curl xz-utils file swig
git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git
./mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -a -y
pip install --upgrade mecab-python3
cp /etc/mecabrc /usr/local/etc/

# JAR
JAR_PATH=/usr/local/lib/jars
mkdir $JAR_PATH

## JDBC MySQL
## ref. https://www.kwbtblog.com/entry/2019/07/27/003225
URL_GCS_JDBC_MYSQL_JAR=gs://${YOUR_GCS_BUCKET}/jars/mysql-connector-java-8.0.21.jar
gsutil cp $URL_GCS_JDBC_MYSQL_JAR $JAR_PATH/

## BigQuery
URL_GCS_BIGQUERY_CONNECTOR_JAR=gs://spark-lib/bigquery/spark-bigquery-latest.jar
gsutil cp $URL_GCS_BIGQUERY_CONNECTOR_JAR $JAR_PATH/

# git clone on Master
# USER=root
# ROLE=$(/usr/share/google/get_metadata_value attributes/dataproc-role)
# REPOSITORY=CHANGE_TO_YOUR_REPOGITORY_URL
# if [["${ROLE}" == 'Master']]; then
#   cd home/$UESR
#   git clone ${REPOSITORY}
# fi
