# do-tf-k8s

Starter point for deploying Kubernetes clusters on DigitalOcean using Terraform.

Organized into several top-level files:

## main.tf

Contains fundamental resource definitions:

* A container registry, with plans to support shared credentials for managed image references

* A "project" (DigitalOcean's logical grouping of resources)

* A Kubernetes cluster; defaults a node pool to 3 modestly-small droplets

## outputs.tf

Sole output is "kubeconfig", which (once the deployment has succeeded) can be used to write out a kubeconfig locally for assignment to %KUBECONFIG% and subsequent kubectl commands:

```
> terraform output -raw kubeconfig > kubeconfig.yaml
> set KUBECONFIG="%CD%\kubeconfig.yaml"
> kubectl cluster-info
```

## providers.tf

Minimal specification of DigitalOcean provider for initialization.

## variables.tf

The only required variable, which should be specified by the environmental variable TF_VAR_DO_TOKEN, is DO_TOKEN, which specifies your DigitalOcean API token. Other optional variables include:

* DO_PROJECT, which indicates the name of the project used for logical grouping of resources (also reused to generate a unique/relevant name for the container registery); defaults to "do-tf-k8s"

* DO_REGION, to customize specific regions of DigitalOcean clouds into which the resources will be deployed; defaults to "nyc3" (see https://slugs.do-api.dev/ for more options)

* DO_K8SSLUG, to indicate which version of Kubernetes will be used on the cluster; defaults to "1.25.12-do.0" (see https://slugs.do-api.dev/ for more options)

## Deployment

Once %TF_VAR_DO_TOKEN% has been defined, the standard Terraform process is sufficient:

```
> terraform init
> terraform plan
> terraform apply
```

After successful deployment, you can pull; write; and assign the kubeconfig (see [[## outputs.tf]]) to utilize the cluster.

## TODO

Immediate plans/ambitions include:

- [ ] Add support for domain name routing
- [ ] Add support for Let's Encrypt certificate signing of the top-level domain (see above) and forwarding to the cluster CA
- [ ] Add support for integrated load balancing on ingress
