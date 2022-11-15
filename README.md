# OKD Openshift Payload CICD Pipeline with Tekton and Kind 

## Intro

This is a simple POC project to build openshift/okd core operator images and push them to a local registry 

**NB** This is a WIP 

## Description

A simple set of Tekton yaml files that will make use of a trigger to execute  pipeline build

### Clone the repository and build

```bash
git clone git@github.com:luigizuccarelli/okd-openshiftpayload-build-poc

cd okd-openshiftpayload-poc

```

## Usage

This assumes that Kind is up and running and Tekton pipeliens and triggers have been deployed

Execute the following command


```bash
kubectl -apply k overlays/emvironment/cicd

# create a pod tpo curl the trigger endpoint (this will trigger the build)
kubectl apply -f manifests/tekton/utility/base/curl-pod.yaml

# once the pod is rnning execute the following curl command
kubectl exec -it curl-pod -n okd-team
curl -H "Accept: application/json" -d'{"url":"https://github.com/openshift/assisted-installer-agent","name":"assisted-installer-agent", "hash":"c9153da1eacf25eb1d85b45c939ac48880d1af6c","revision":"master"}' 'http://el-okd-openshift-build-poc.okd-team.svc.cluster.local:8080'

```

Check that the pipeline was triggered and monitor logs

```bash
tkn pr list -n okd-team
tkn pr logs <pr-name-from-previous-step> -n okd-team -f

# to trigger another pipeline with different params for url, name, hash and revision
curl -H "Accept: application/json" -d'{"url":"git-url-to-build","name":"git-repo-name", "hash":"git-hash-comit","revision":"branch"}' 'http://el-okd-openshift-build-poc.okd-team.svc.cluster.local:8080'

```

