#!/bin/sh
#These defaults need to match schema.yaml if you plan to display them on the UI.  They also have to be set in Makefile under APP_PARAMETERS
#Password and Username Rules can be found https://developer.couchbase.com/documentation/server/5.1/security/security-passwords.html#topic_iyx_5ps_lq

export NAME=cb-operator-1
#REGISTRY has to match your target GCP project
export REGISTRY=gcr.io/couchbase-dev
export IMAGE_BASE=/k8s/operator
export TAG=2.0
export CONTAINER_PORT=8080
export DB_PASSWORD=longPass32d
export DB_USERNAME=couchbaseAdmin
export INIT_DELAY_SEC=30
export PERIOD_SEC=5
export FAIL_THRESHOLD=19
#export OP_REPLICAS=1
export CLUSTER_REPLICAS=1
export DATA_SVC_QUOTA=256
export IDX_SVC_QUOTA=256
export SRC_SVC_QUOTA=256
export EVT_SVC_QUOTA=256  #new
export ANA_SVC_QUOTA=1024 #new
export SERVERS=3
export BUCKET_MEM_QUOTA=256
export AUTO_FAIL_TIMEOUT=120
export AUTO_FAIL_MAX=3 #new
export AUTO_FAIL_ODDI=true #new boolean
export AUTO_FAIL_ODDI_TP=120  #new
export AUTO_FAIL_SG=false #new boolean
export STORAGE_CLASS=standard #new 

#######DO NOT EDIT BELOW!

export SECRET_NAME=$NAME-secret
export CB_OP_IMAGE=$REGISTRY$IMAGE_BASE:$TAG
export CB_DEPLOYER_IMAGE=$REGISTRY$IMAGE_BASE/deployer:$TAG
export DB_PASSWORD=`echo -n $DB_PASSWORD | base64`

