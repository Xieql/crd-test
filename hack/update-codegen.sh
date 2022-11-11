#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

REPO_ROOT=$(git rev-parse --show-toplevel)

echo "REPO_ROOT ${REPO_ROOT}"

PKG_PATH=${REPO_ROOT}/pkg
APIS_PATH=${PKG_PATH}/api


echo "REPO_ROOT ${REPO_ROOT}  PKG_PATH ${PKG_PATH}   APIS_PATH ${APIS_PATH}   "

# For all commands, the working directory is the parent directory(repo root).
REPO_ROOT=$(git rev-parse --show-toplevel)
cd "${REPO_ROOT}"

export GOPATH=$(go env GOPATH | awk -F ':' '{print $1}')
export PATH=$PATH:$GOPATH/bin

echo "Generating with deepcopy-gen"
deepcopy-gen \
  --go-header-file hack/boilerplate.go.txt \
  --input-dirs=${APIS_PATH}/policy/v1alpha1 \
  --output-package=${APIS_PATH}/policy/v1alpha1 \
  --output-file-base=zz_generated.deepcopy

echo "Generating with register-gen"
register-gen \
  --go-header-file hack/boilerplate.go.txt \
  --input-dirs=${APIS_PATH}/policy/v1alpha1 \
  --output-package=${APIS_PATH}/policy/v1alpha1 \
  --output-file-base=zz_generated.register

echo "Generating with client-gen"
client-gen \
  --go-header-file hack/boilerplate.go.txt \
  --input-base="" \
  --input=${APIS_PATH}/policy/v1alpha1 \
  --output-package=${PKG_PATH}/generated/clientset \
  --clientset-name=versioned

echo "Generating with lister-gen"
lister-gen \
  --go-header-file hack/boilerplate.go.txt \
  --input-dirs=${APIS_PATH}/policy/v1alpha1 \
  --output-package=${PKG_PATH}/generated/listers

echo "Generating with informer-gen"
informer-gen \
  --go-header-file hack/boilerplate.go.txt \
  --input-dirs=${APIS_PATH}/policy/v1alpha1 \
  --versioned-clientset-package=${PKG_PATH}/generated/clientset/versioned \
  --listers-package=${PKG_PATH}/generated/listers \
  --output-package=${PKG_PATH}/generated/informers
