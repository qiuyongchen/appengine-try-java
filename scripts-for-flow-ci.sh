#!/usr/bin/env bash

set -e

if [[ -z "${GOOGLE_APPLICATION_CREDENTIALS}" ]]; then
  echo "GOOGLE_APPLICATION_CREDENTIALS must be set" 1>&2
	exit 1
fi

if [[ -z "${GOOGLE_CLOUD_PROJECT}" ]]; then
  echo "GOOGLE_CLOUD_PROJECT must be set" 1>&2
	exit 1
fi

pwd

wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz
tar xzf google-cloud-sdk.tar.gz
./google-cloud-sdk/install.sh --usage-reporting false --path-update false --command-completion false


source ./google-cloud-sdk/completion.bash.inc
source ./google-cloud-sdk/path.bash.inc
gcloud -q components update app-engine-java

gcloud -q auth activate-service-account --key-file "${GOOGLE_APPLICATION_CREDENTIALS}"
gcloud -q config set project "${GOOGLE_CLOUD_PROJECT}"
gcloud info