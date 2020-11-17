#!/bin/bash

# install Google Python client on all nodes
apt-get update
apt-get install -y python-pip
pip install --upgrade pip
pip install --upgrade google-api-python-client

# install Mecab
apt-get install -y mecab libmecab-dev mecab-ipadic mecab-ipadic-utf8 git make curl xz-utils file swig

## install mecab-ipadic-neologd
git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git
./mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -a -y

## install mecab-python3
pip install --upgrade mecab-python3
cp /etc/mecabrc /usr/local/etc/

## install user dictionaries
URL_GCS_CUSTOM_DICT=gs://${YOUR_GCS_BUCKET}/dict/*.dic
DIR_CUSTOM_DICT=/usr/lib/x86_64-linux-gnu/mecab/dic/${YOUR_DICT_DIR_NAME}
mkdir $DIR_CUSTOM_DICT
gsutil cp $URL_GCS_CUSTOM_DICT $DIR_CUSTOM_DICT/
# echo "userdic = $DIR_CUSTOM_DICT/industry_keywords.dic,$DIR_CUSTOM_DICT/brand_indexes.dic" >> /etc/mecabrc

## disable invoking unknown word processing
URL_GCS_CHAR_DEF=gs://${YOUR_GCS_BUCKET}/char.def
DIR_NEOLOGD_CHAR_DEF=/usr/share/mecab/dic/ipadic/mecab-ipadic-neologd/build/
gsutil cp $URL_GCS_CHAR_DEF $DIR_CUSTOM_DICT/
find $DIR_NEOLOGD_CHAR_DEF -name char.def -type f | xargs -i cp $DIR_CUSTOM_DICT/char.def {}

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
