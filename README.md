# terraform-gke1

Launch and manage a GKE cluster using Terraform.

1. You need to have an active GCP account
2. Generate a SA
3. Download a key from your SA 

## Launch GKE Cluster

```
$ terraform init
$ terraform plan
$ terraform apply
```

## Launch Nginx Demo Application

First, you will need to authenticate to the cluster, then you can run the following:

```
$ kubectl apply -f deployment.yaml
$ kubectl apply -f service.yaml
$ kubectl apply -f ingress.yaml
```

**Note:** Operations can take more than 5 minutes. 

## Questions?

Open an issue.
