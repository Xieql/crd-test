#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail




SCRIPT_ROOT=$(dirname "${BASH_SOURCE[0]}")/..
CODEGEN_PKG=${CODEGEN_PKG:-$(cd "${SCRIPT_ROOT}"; ls -d -1 ./vendor/k8s.io/code-generator 2>/dev/null || echo ../code-generator)}
MODULE=crd-test
VERSION=v1alpha1
GROUP=samplecontroller

OUTPUT_PKG=pkg/generated
APIS_PKG=pkg/apis
echo "SCRIPT_ROOT ${SCRIPT_ROOT} CODEGEN_PKG ${CODEGEN_PKG}   MODULE ${MODULE}"

bash "${CODEGEN_PKG}"/generate-groups.sh "deepcopy,client,lister,informer" \
${OUTPUT_PKG} ${APIS_PKG} \
${GROUP}:${VERSION} \
--output-base "${SCRIPT_ROOT}" \
--go-header-file "${SCRIPT_ROOT}"/hack/boilerplate.go.txt \
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