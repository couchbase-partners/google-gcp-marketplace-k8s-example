# Overview

Couchbase’s mission is to be the data platform that revolutionizes digital innovation. To make this possible, Couchbase created the world’s first Engagement Database, built on the most powerful NoSQL technology.

> The Couchbase Autonomous Operator for Kubernetes enables cloud portability and automates > > operational best practices for deploying and managing the Couchbase Data Platform. To optimize integration, we maintain strategic partnerships with enterprise Kubernetes providers, including the Red Hat OpenShift Container Platform. As a result, we’re the only NoSQL vendor to offer native integration of Kubernetes with the Couchbase Data Platform

## Prerequisites

#### Acquire License

The Couchbase Autnomous Operator is currently in beta; so there is no cost to use it at this time. However, the Couchbase Clusters that you deploy require your own [licenses](https://www.couchbase.com/legal/agreements#ProductLicenses), where applicable.

### UI Installation with Google Cloud Marketplace

Get up and running with a few clicks! Install the Couchbase Operator app to a
Google Kubernetes Engine cluster using Google Cloud Marketplace. Follow the
on-screen instructions:

*TODO: link to solution details page*

### Command-line instructions

There are some steps that you we have to complete before we can get to installing Couchbase in the Marketplace.  It is important to know there will
be some command line work as we will be using the Couchbase Admin WebUI to manage the clusters.  This means you **can not use the cloud shell** to complete all steps.

### Google Cloud MarketPlace UI Deployments

For those using the __Google Cloud MarketPlace UI__ to deploy, only need to follow select sections:

Tool dependencies:

- gcloud
- kubectl

Authorization:
Provisioning a GKE cluster and configuring kubectl to connect to it:

If you are using the command line all sections are relevant.

These [instructions](https://github.com/GoogleCloudPlatform/marketplace-k8s-app-tools/) gives you the core pieces that you need.

### Commandline Setup

Start by cloning the repo from [github](https://github.com/couchbase-partners/marketplace-k8s-app-example/).

These [instructions](https://github.com/GoogleCloudPlatform/marketplace-k8s-app-tools/) gives you the core pieces that you need.

We will work **exclusively** in the __couchbase__ directory.

We continue preparing our environment with a few more tools. You need to have __envsubst__  which is part of the [gettext](https://www.gnu.org/software/gettext/) package installed for this walkthrough check if you do by:  

`which envsubst`

If it comes up blank then run (for Mac), for others please use the above link for your environment:

`brew install gettext && brew link --force gettext`

Repeat the which command above again and it will be in your path.

You must have the command __envsubst__, which is part of the [gettext](https://www.gnu.org/software/gettext/) package installed.
Check if you have it installed by:  

```
which envsubst
```

If it comes up blank then run (for Mac), for others please use the above link for your environment:

```
brew install gettext && brew link --force gettext
```

Repeat the __which__ command above again and it will be in your path.

Edit environment variables to modify your Couchbase deployment by editing the file __exports.sh__ found in the __couchbase__ directory.

Referencing the [password policy](https://developer.couchbase.com/documentation/server/current/security/security-passwords.html) for Couchbase
will be useful here.

With those environment variables set 
Substitute the environment variables in exports.sh with:

```
source ./exports.sh && envsubst < 3a-parameter-cb-cluster.yaml > created-cb-cluster.yaml
```

We now have created the file __created-cb-cluster.yaml__ which we will use later.

Deploy your Operator with:

```
make app/install
```

### Deploying Couchbase Clusters (applies to UI and commandline)
If you were using the Marketplace UI you have done your clickyclicky work and now have deployed the operator.  You will have some important information on the right side of the post-deploy page.

We continue by making sure the operator is ready:

`kubectl get deployments --watch`

Control-C to cancel the watch after you notice that the operator shows available.

Deploy your Couchbase cluster with:

`kubectl apply -f created-cb-cluster.yaml`

Wait until at least the first node is ready

`kubectl get pods --watch`

Control-C to cancel the watch after at least one is ready.

Now we need to forward ports so we can access the Couchbase WebUI.  Open a new terminal window and run:

`kubectl port-forward cb-cluster-member-0000 8091:8091`

In a browser window navigate to the [Couchbase Web UI](https://localhost:8091)

Commandline install: If you haven't changed the defaults:

- Username: couchbaseAdmin
- Password: longPass32d

Marketplace UI install: Your login information is on the right of the post-deploy page.

fin

