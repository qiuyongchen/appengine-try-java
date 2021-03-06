#!/usr/bin/env bash
# Copyright 2016 Google Inc. All Rights Reserved.
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

set -e
set -x
# Set pipefail so that `egrep` does not eat the exit code.
set -o pipefail

#2018-02-12 17:55:14 s

source /home/travis/google-cloud-sdk/completion.bash.inc

source /home/travis/google-cloud-sdk/path.bash.inc

GOOGLE_CLOUD_SDK_ROOT="$(gcloud --format='value(installation.sdk_root)' info)"

#mvn --batch-mode clean verify | egrep -v "(^\[INFO\] Download|^\[INFO\].*skipping)"


# Run tests using App Engine local devserver.
test_localhost() {
  if [[ ! -d java-repo-tools ]]; then
		git clone https://github.com/qiuyongchen/java-repo-tools.git
	fi
  ./java-repo-tools/scripts/test-localhost.sh appengine:run . -- -DcloudSdkPath="$GOOGLE_CLOUD_SDK_ROOT"

  curl --silent --output /dev/stderr  http://localhost:8080/demo

#  mvn appengine:deploy --debug

  mvn appengine:deploy

  echo "deploy success"
}

test_localhost

