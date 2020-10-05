#!/bin/bash
REGION=asia-northeast1
CLUSTER_NAME=cluster
SHELL_INSTALL_ON_CLUSTER=gs://
WORKER_BUCKET_NAME=
gcloud dataproc clusters create ${CLUSTER_NAME} \
  --region ${REGION} \
  --optional-components=ANACONDA,JUPYTER \
  --enable-component-gateway \
  --image-version=1.3 \
  --bucket=${WORKER_BUCKET_NAME} \
  --worker-machine-type=n1-standard-2 \
  --master-machine-type=n1-standard-4 \
  --initialization-actions ${SHELL_INSTALL_ON_CLUSTER} \
  --zone=asia-northeast1-b \
  --num-workers=2
