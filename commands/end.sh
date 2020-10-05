#!/bin/bash
REGION=asia-northeast1
gcloud dataproc clusters delete cluster \
  --region ${REGION}