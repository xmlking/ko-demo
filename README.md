# ko-demo

**ko** is a `build/publish/deploy` tool for `go` applications on `Kubernetes`

It allows you to:

- build Go binaries
- containerize them and publish to a registry
- automatically update Kubernetes manifests to references the correct container image

## Install

ko can be installed via:

```bash
go get github.com/google/ko/cmd/ko
```

To update your installation:

```bash
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
...
  template:
...
    spec:
      containers:
      - name: hello-world
        image: github.com/xmlking/ko-demo/main
```

### Apply

Then to start the build, containerize and deploy a single `ko` command is necessary.

```bash
ko apply -f config/
```

To deploy in a different namespace:

```bash
ko -n nondefault apply -f config/
```

You will see a Pod running and you will be able to call your Go function:

```bash
$ kubectl get pods
NAME                                            READY     STATUS      RESTARTS   AGE
hello-world-54557f6647-wsng6                    1/1       Running     0          50s

$ kubectl port-forward pod/hello-world-54557f6647-wsng6 8080:8080 &
[1] 99038

$ curl localhost:8080
Handling connection for 8080
Hello world !
```

### Build/publish but do not deploy

If all you want to do is build the Go binary and publish an image to the registry then, with the Demo project cloned in your $GOPATH.

```bash
ko publish github.com/xmlking/ko-demo/main
```
