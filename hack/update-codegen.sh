#!/usr/bin/env bash

# Copyright 2017 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_ROOT=$(dirname "${BASH_SOURCE[0]}")/..
CODEGEN_PKG=${CODEGEN_PKG:-$(cd "${SCRIPT_ROOT}"; ls -d -1 ./vendor/k8s.io/code-generator 2>/dev/null || echo ../code-generator)}

bash "${CODEGEN_PKG}"/generate-internal-groups.sh \
  "deepcopy,defaulter,conversion" \
  github.com/jazzsir/scheduler-plugins/pkg/generated \
  github.com/jazzsir/scheduler-plugins/pkg/apis \
  github.com/jazzsir/scheduler-plugins/pkg/apis \
  "config:v1beta1" \
  --go-header-file "${SCRIPT_ROOT}"/hack/boilerplate/boilerplate.generatego.txt

bash "${CODEGEN_PKG}"/generate-groups.sh \
  all \
  github.com/jazzsir/scheduler-plugins/pkg/generated \
  github.com/jazzsir/scheduler-plugins/pkg/apis \
  "scheduling:v1alpha1" \
  --go-header-file "${SCRIPT_ROOT}"/hack/boilerplate/boilerplate.generatego.txt
