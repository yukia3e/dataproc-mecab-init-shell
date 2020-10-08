#!/bin/bash
REGION=asia-northeast1
CLUSTER_NAME=cluster
SHELL_INSTALL_ON_CLUSTER=gs://${YOUR_GCS_BUCKET}/init/install_on_cluster.sh
WORKER_BUCKET_NAME=${YOUR_GCS_BUCKET}
gcloud dataproc clusters create ${CLUSTER_NAME} \
  --region ${REGION} \
  --optional-components=ANACONDA,JUPYTER \
  --enable-component-gateway \
  --image-version=1.3 \
  --bucket=${WORKER_BUCKET_NAME} \
  --worker-machine-type=n1-standard-2 \
  --master-machine-type=n1-standard-4 \
  --initialization-actions ${SHELL_INSTALL_ON_CLUSTER} \
  --properties=spark:spark.jars=/usr/local/lib/jars/*,spark:spark.driver.extraClassPath=/usr/local/lib/jars/* \
  --zone=asia-northeast1-b \
  --num-workers=2
