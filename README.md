# ko-demo

**ko** is a `build/publish/deploy` tool for `go` applications on `Kubernetes`

It allows you to:

- build Go binaries
- containerize them and publish to a registry
- automatically update Kubernetes manifests to references the correct container image

## Prerequisite

> run then outside **this project root** and `$GOPATH`

```bash
# go lang  build/publish/deploy tool
go get -u github.com/google/ko/cmd/ko
```

## Local

You can certainly build/run your code locally:

### Run

```bash
go run main.go
```

### Test

```bash
curl http://localhost:8080
```

## Deploy

### Configure a Registry

To specify the registry that you want to use, set the KO_DOCKER_REPO variable, for instance:

to publish locally set: `export KO_DOCKER_REPO=ko.local`

```bash
export PROJECT_ID=ngx-starter-kit
export KO_DOCKER_REPO=gcr.io/${PROJECT_ID}
```

### Usage

Write a Kubernetes manifest with an import path that is similar to a Go import path like:

```yaml
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: hello-world
spec:
---
template:
---
spec:
  containers:
    - name: hello-world
      image: github.com/xmlking/ko-demo
```

### Deploying

Then to start the build, containerize and deploy a single `ko` command is necessary.

```bash
ko apply -f deploy/

# -P or --preserve-import-paths
ko apply -P -f deploy/

# Deploy to minikube w/o registry.
ko apply -L -f deploy/

# This is the same as above.
KO_DOCKER_REPO=ko.local ko apply -f deploy/
```

To deploy in a different namespace:

```bash
ko -n nondefault apply -f deploy/
```

You will see a Pod running and you will be able to call your Go function:

```bash
kubectl get pods
NAME                                            READY     STATUS      RESTARTS   AGE
hello-world-59868cf5f9-5gqhj                    1/1       Running     0          5s

kubectl port-forward pod/hello-world-59868cf5f9-5gqhj 8080:8080 &
[1] 99038

curl localhost:8080
Handling connection for 8080
Hello world !
```

### Teardown

```bash
ko delete -f deploy/
```

### Build/publish but do not deploy

If all you want to do is build the Go binary and publish an image to the registry then, with the Demo project cloned in your \$GOPATH.

```bash
ko publish github.com/xmlking/ko-demo
# publish to local docker repo
ko resolve -L -f deploy/
```

### Release Management

ko is also useful to help manageing releases

```bash
# publish to  docker repo ar KO_DOCKER_REPO
ko resolve -P -f deploy/ > release.yaml
# publish to local docker repo
ko resolve -P -L -f deploy/ > release.yaml
```

This will publish all of the binary components as container images to gcr.io/xmlking/... and create a `release.yaml` file containing all of the configuration for your application with inlined image references.

This resulting configuration may then be installed onto Kubernetes clusters via:

```bash
kubectl apply -f release.yaml
```

### Run Docker

```bash
docker run -it -p 8080:8080  ko.local/github.com/xmlking/ko-demo
# test
curl http://localhost:8080
```
