
# crd.Makefile provides targets to install Application CRD.
include ../vendor/marketplace-tools/crd.Makefile

# gcloud.Makefile provides default values for
# REGISTRY and NAMESPACE derived from local
# gcloud and kubectl environments.
include ../vendor/marketplace-tools/gcloud.Makefile

# marketplace.Makefile provides targets such as
# ".build/marketplace/deployer/envsubst" to build the base
# deployer images locally.
include ../vendor/marketplace-tools/marketplace.Makefile

# ubbagent.Makefile provides ".build/ubbagent/ubbagent"
# target to build the ubbagent image locally.
include ../vendor/marketplace-tools/ubbagent.Makefile
include ../vendor/marketplace-tools/var.Makefile

# app.Makefile provides the main targets for installing the
# application.
# It require s several APP_* variables defined as followed.
include ../vendor/marketplace-tools/app.Makefile

APP_DEPLOYER_IMAGE ?= $(CB_DEPLOYER_IMAGE)
#NAME ?= cb-operator-1
APP_PARAMETERS ?= { \
  "name": "$(NAME)", \
  "namespace": "$(NAMESPACE)", \
  "couchbaseOperatorImage": "$(CB_OP_IMAGE)", \
  "dbUsername": "$(DB_USERNAME)", \
  "dbPassword": "$(DB_PASSWORD)", \
  "initialDelaySeconds": "$(INIT_DELAY_SEC)", \
  "periodSeconds": "$(PERIOD_SEC)", \
  "failureThreshold": "$(FAIL_THRESHOLD)", \
  "autoFailoverTimeout": "$(AUTO_FAIL_TIMEOUT)", \
  "autoFailoverMaxCount": "$(AUTO_FAIL_MAX)", \
  "autoFailoverODDI": "$(AUTO_FAIL_ODDI)", \
  "autoFailoverODDITP": "$(AUTO_FAIL_ODDI_TP)", \
  "autoFailoverServerGroup": "$(AUTO_FAIL_SG)", \
  "bucketMemoryQuota": "$(BUCKET_MEM_QUOTA)", \
  "clusterReplicas": "$(CLUSTER_REPLICAS)", \
  "containerPort": "$(CONTAINER_PORT)", \
  "servers": "$(SERVERS)", \
  "dataServiceMemoryQuota": "$(DATA_SVC_QUOTA)", \
  "indexServiceMemoryQuota": "$(IDX_SVC_QUOTA)", \
  "searchServiceMemoryQuota": "$(SRC_SVC_QUOTA)", \
  "eventingServiceMemoryQuota": "$(EVT_SVC_QUOTA)", \
  "analyticsServiceMemoryQuota": "$(ANA_SVC_QUOTA)", \
  "storeClass": "$(STORAGE_CLASS)" \
}
#TESTER_IMAGE ?= $(REGISTRY)/example/wordpress/tester:$(TAG)
APP_TEST_PARAMETERS ?= { \
  "imageTester": "$(TESTER_IMAGE)" \
}

# Extend the target as defined in app.Makefile to
# include real dependencies.
app/build:: .build/couchbase/deployer

.build/couchbase: | .build
	mkdir -p "$@"

.build/couchbase/deployer: apptest/deployer/* \
                           apptest/deployer/manifest/* \
                           deployer/* \
                           manifest/* \
                           schema.yaml \
                           .build/marketplace/deployer/envsubst \
                           .build/var/APP_DEPLOYER_IMAGE \
                           .build/var/REGISTRY \
                           .build/var/TAG \
                           | .build/couchbase
	$(call print_target, $@)
	docker build \
	    --build-arg REGISTRY="$(REGISTRY)" \
	    --build-arg TAG="$(TAG)" \
	    --tag "$(APP_DEPLOYER_IMAGE)" \
	    -f deployer/Dockerfile \
	    .
	docker push "$(APP_DEPLOYER_IMAGE)"
	@touch "$@"