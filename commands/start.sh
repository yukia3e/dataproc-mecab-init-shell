#!/bin/bash
REGION=asia-northeast1
CLUSTER_NAME=cluster
SHELL_INSTALL_ON_CLUSTER=gs://${YOUR_GCS_BUCKET}/init/install_on_cluster.sh
SHELL_CLOUD_SQL_PROXY=gs://dataproc-initialization-actions/cloud-sql-proxy/cloud-sql-proxy.sh
WORKER_BUCKET_NAME=${YOUR_GCS_BUCKET}
CLOUDSQL_PROJECT_ID=${YOUR_CLOUDSQL_PROJECT_ID}
CLOUDSQL_INSTANCE_NAME=${YOUR_CLOUDSQL_INSTANCE_NAME}

gcloud dataproc clusters create ${CLUSTER_NAME} \
  --region ${REGION} \
  --optional-components=ANACONDA,JUPYTER \
  --enable-component-gateway \
  --image-version=1.3 \
  --bucket=${WORKER_BUCKET_NAME} \
  --worker-machine-type=n1-standard-2 \
  --master-machine-type=n1-standard-2 \
  --scopes default,bigquery,https://www.googleapis.com/auth/bigtable.admin.table,https://www.googleapis.com/auth/bigtable.data,https://www.googleapis.com/auth/devstorage.full_control,sql-admin \
  --initialization-actions ${SHELL_INSTALL_ON_CLUSTER},${SHELL_CLOUD_SQL_PROXY} \
  --metadata "enable-cloud-sql-hive-metastore=false,additional-cloud-sql-instances=${CLOUDSQL_PROJECT_ID}:${REGION}:${CLOUDSQL_INSTANCE_NAME}=tcp:5432" \
  --zone=asia-northeast1-b \
  --num-workers=2
