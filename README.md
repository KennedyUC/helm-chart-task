## Deployment of Udagram Application to Kubernetes using Helm Chart  

This repository contains the scripts for deploying an Udagram application using Helm Chart, and the instructions to run the application.  

## Repository Architecture 

helm-chart-task
    ├───udagram
    │   ├───charts
    │   └───templates
    ├───k8s-manifests
    └───ubuntu-base  

**`helm-chart-task`**: This is the root directory containing other directories, gitlab ci script and helper shell script.  

**`udagram`**: This directory contains the helm chart template and the configuration scripts for installing the application to the kubernetes cluster.  

**`k8s-manifests`**: This directory contains the original kubernetes manifest files from which the helm templates are derived.  

**`ubuntu-base`**: This directory contains the scripts for building a base docker image for Ubuntu with the utils required for running the gitlab ci pipeline.  

## Installing the Helm Chart  
The helm chart is configured to install the application, based on the values defined in the `values.yaml` script.  

A ci pipeline is configured to run the job automatically, once a commit is made to the main branch. 

To view the manifests to be installed:

```  
helm template ./udagram
```

To install the application with helm cli:

```  
helm install <app-name> ./udagram -n <app-name> --values ./helm-job/values.yaml --create-namespace  
```  

To upgrade the application after making updates on the `values.yaml` script:  

```  
helm upgrade <app-name> ./udagram -n <app-name> --values ./helm-job/values.yaml --create-namespace  
```  

To package the helm chart for distribution:  

```  
helm package ./udagram  
```