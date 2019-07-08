#!/usr/bin/env bash

# Usage:
#   hack/release.sh $VERSION
#
# Example:
#   hack/release.sh v0.1.1

VERSION=$1

go get github.com/ahmetb/govvv
govvv build -o bin/hello-world main.go -version $VERSION
git tag $VERSION
git push origin $VERSION