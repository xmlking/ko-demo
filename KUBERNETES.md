# Kubernetes

Ephemeral Kubernetes Clusters with KinD

## Install

```bash
GO111MODULE="on" go get sigs.k8s.io/kind@v0.4.0
```

## Usage

### Create a cluster

> for help `kind [command] --help`

```bash
kind create cluster # Default cluster context name is `kind`.
# with name
kind create cluster --name blog --wait 5m

# list clusters
kind get clusters

# Deleting a Cluster
kind delete cluster
```

> verify `kindest/node` container running with  `docker ps`

### Interacting With Your Cluster

```bash
export KUBECONFIG="$(kind get kubeconfig-path)"
# export KUBECONFIG="$(kind get kubeconfig-path --name blog)"
kubectl cluster-info
```

### Loading

> Loading an Image Into Your Cluster

```bash
kind load docker-image my-custom-image:unique-tag
kind load docker-image ko.local/ko-demo-7a5550aba07ee9abc7c6c2992dc2c243:0f9dea87eb5c56703dc806e05d70276ca14014c9dc49ca8c8cb88507f8997a72
```

## With Makefile

```bash
make create-hello
# Create a new cluster called hello
make delete-hello
# Delete the hello cluster
make env-hello
make list
# Provide a list of all cluster
make clean
# Delete all of my clusters
make nginx1
# create cluster and deploy nginx
```

## Reference

1. <https://kind.sigs.k8s.io/>
2. <https://blog.alexellis.io/be-kind-to-yourself/>
3. <https://garethr.dev/2019/05/ephemeral-kubernetes-clusters-with-kind-and-make/>
