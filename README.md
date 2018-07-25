# Overview

Couchbase’s mission is to be the data platform that revolutionizes digital innovation. To make this possible, Couchbase created the world’s first Engagement Database, built on the most powerful NoSQL technology.

> The Couchbase Autonomous Operator for Kubernetes enables cloud portability and automates > > operational best practices for deploying and managing the Couchbase Data Platform. To optimize integration, we maintain strategic partnerships with enterprise Kubernetes providers, including GCP MarketPlace - Kubernetes applications. As a result, we’re the only NoSQL vendor to offer native integration of Kubernetes with the Couchbase Data Platform

This user guide provides information on deploying the Couchbase Autonomous Operator (and eventually a Couchbase Server Cluster) on the GCP Marketplaces - Kubernetes Applications. 

There are two methods to do this:

- Through the GCP Marketplace UI (section: Quickly Install via Google Cloud Platform Marketplace)
- Through the command-line (section: Command-line Instructions)

Choose the method that you deem most appropriate, though there is no harm in attempting both.

## Acquire Licenses

The Couchbase Autonomous Operator is provided at no charge while in beta.  However, for Couchbase Server you are required to provide your own [licenses](https://www.couchbase.com/subscriptions-and-support#pricingForm).

## Quickly Install via Google Cloud Platform Marketplace

Get up and running with a few clicks! Install the Couchbase Operator app to a
Google Kubernetes Engine cluster using Google Cloud Marketplace. To get start simply follow the [on-screen instructions](https://console.cloud.google.com/marketplace/details/couchbase-public/couchbase-operator):

## Command-line Instructions

Deploying a Couchbase Autonomous Operator Instance to the GCP Marketplace by command-line is supported.

After a command-line deployment you will be able to view your instance both through the GCP UI and a local kubectl client.

These [instructions](https://github.com/GoogleCloudPlatform/marketplace-k8s-app-tools/) provide the installation and setup information needed.  The section "Development guide" is not relevant for this user guide and can be ignored.

Additionally, you need to have __envsubst__ installed which is part of the [gettext](https://www.gnu.org/software/gettext/) package.

The working directory will be the **couchbase** directory, directly off of the root of the repository.  

Navigate to the couchbase directory:

`cd couchbase`

### Environment Variables

The file exports.sh defines the environment variables needed for this user guide.

Most of the environment variables have reasonable defaults however, you **must change** the environment variable **REGISTRY** to match your GCP project's location.

It is also recommended that you change the **DB_PASSWORD** and **DB_USERNAME** variables.

Password and Username Rules can be found on the [official couchbase website](https://developer.couchbase.com/documentation/server/5.1/security/security-passwords.html#topic_iyx_5ps_lq).

Set the environment variables from exports.sh and substitute those environment variables from 3a-parameter-cb-cluster.yaml into a new file created-cb-cluster.yaml:

```script
source ./exports.sh && envsubst < 3a-parameter-cb-cluster.yaml > created-cb-cluster.yaml
```

### Deploying the Couchbase Autonomous Operator

The first step is to install the [Custom Resource Definition (CRD)](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions).  This has to be done once per cluster.

`make crd/install`

Deploy the Couchbase Autonomous Operator with:

`make app/install`

Now that the operator is deployed, wait until the operator shows as available:

`kubectl get deployments --watch`

Use the shortcut __Control-C__ to cancel the watch after that the operator shows available.

Deploy your Couchbase cluster with:

`kubectl apply -f created-cb-cluster.yaml`

Wait until at least the first node is ready:

`kubectl get pods --watch`

Use the shortcut __Control-C__ to cancel the watch after at least one is ready.

Forward ports so that the Couchbase Web Console can be accessed from a local browser.

Open a new terminal window and run:

`kubectl port-forward cb-cluster-member-0000 8091:8091`

In a browser window navigate to the [Couchbase Web Console](https://localhost:8091)

### Viewing the Application via GCP Marketplace
You may want to view the details of your application from a GCP perspective.

Login to [GCP](https://https://console.cloud.google.com/) and navigate from the hamburger menu to Kubernetes Engine -> Applications.  

Click the name of the couchbase deployment (e.g. couchbase-operator-1), to go to the applications information page.

### Couchbase Configuration Changes

If you would like to make edits to the Couchbase configuration, you may do that via the [Couchbase Web Console](https://localhost:8091) or through kubectl.  

To edit the configuration via kubectl, change the desired values in created-cb-cluster.yaml
and rerun the kubectl apply command:

`kubectl apply -f created-cb-cluster.yaml`

The changes to the Couchbase Cluster that are made through kubectl are reflected in the Couchbase Web Console.

fin