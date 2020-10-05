#!/bin/bash
ZONE=
gcloud compute ssh --zone=$ZONE \
  --ssh-flag="-D 1080" --ssh-flag="-N" --ssh-flag="-n" \
  cluster