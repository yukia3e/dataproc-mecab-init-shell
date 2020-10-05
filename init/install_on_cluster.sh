#!/bin/bash

# install Google Python client on all nodes
apt-get update
apt-get install -y python-pip
pip install --upgrade google-api-python-client

# install Mecab
apt-get install -y mecab libmecab-dev mecab-ipadic mecab-ipadic-utf8 git make curl xz-utils file swig
git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git
./mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -a -y
pip install --upgrade mecab-python3

# git clone on Master
# USER=root
# ROLE=$(/usr/share/google/get_metadata_value attributes/dataproc-role)
# REPOSITORY=CHANGE_TO_YOUR_REPOGITORY_URL
# if [["${ROLE}" == 'Master']]; then
#   cd home/$UESR
#   git clone ${REPOSITORY}
# fi
