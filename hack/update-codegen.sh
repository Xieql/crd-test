#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

PKG_PATH=github.com/Xieql/crd-test/client-go
APIS_PATH=github.com/Xieql/crd-test/api

# For all commands, the working directory is the parent directory(repo root).
REPO_ROOT=$(git rev-parse --show-toplevel)
cd "${REPO_ROOT}"

export GOPATH=$(go env GOPATH | awk -F ':' '{print $1}')
export PATH=$PATH:$GOPATH/bin

echo "Generating all"

echo "cmd is bash "${CODEGEN_PKG}"/generate-groups.sh "deepcopy,client,lister,informer" \
             ${PKG_PATH}/generated  ${APIS_PATH}/test/v1alpha1  \
             samplecontroller:v1alpha1 \
             --output-base "" \
             --go-header-file /hack/boilerplate.go.txt \ "


bash "${CODEGEN_PKG}"/generate-groups.sh "deepcopy,client,lister,informer" \
${PKG_PATH}/generated  ${APIS_PATH}/test/v1alpha1  \
samplecontroller:v1alpha1 \
--output-base "" \
--go-header-file /hack/boilerplate.go.txt \
#####################样例 start##################################
#注意事项：
#MODULE需和go.mod文件内容一致
#"${CODEGEN_PKG}"/generate-groups.sh "deepcopy,client,informer,lister" \
#  sample-controller/pkg/generated sample-controller/pkg/apis \
#  samplecontroller:v1alpha1 \
#  --output-base "$(dirname "${BASH_SOURCE[0]}")/../.." \
#  --go-header-file "${SCRIPT_ROOT}"/hack/boilerplate.go.txt
#####################样例 end##################################



#
#vendor/k8s.io/code-generator/generate-groups.sh "deepcopy,client,informer,lister" \
#  sample-controller/pkg/generated sample-controller/pkg/apis \
#  samplecontroller:v1alpha1 \
#  --output-base "${GOPATH}/src" \
#  --go-header-file "${GOPATH}/src/sample-controller/hack/boilerplate.go.txt"