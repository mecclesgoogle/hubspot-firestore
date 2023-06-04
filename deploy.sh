#!/bin/bash
gcloud functions deploy hubspot-webhook \
--gen2 \
--region='us-central1' \
--runtime=nodejs18 \
--source='/home/markeccles/firestore/googlecloudfunctions' \
--entry-point='hubspot_webhook' \
--project='hubspot-demo-388804'

