#!/usr/bin/env bash

testSnykIfEnabled() {
  if [ -n "${SNYK_ORG}" ] && [ -n "${SNYK_TOKEN}" ]; then
      local errors_found=false
      snyk test --org="${SNYK_ORG}" --docker "${TRAVIS_REPO_SLUG}" --policy-path=.snyk --file=Dockerfile || errors_found=true
      snyk test --org="${SNYK_ORG}" --policy-path=.snyk --file=requirements.txt || errors_found=true
      if ${errors_found} && [ "${SNYK_MODE}" != "WARN" ] ; then
          exit 1
      fi
  fi
}

VERSION="$TRAVIS_COMMIT"
if [ -n "${TRAVIS_TAG}" ]; then
  VERSION="${TRAVIS_TAG}"
fi

docker build --pull --cache-from "$TRAVIS_REPO_SLUG" --tag "$TRAVIS_REPO_SLUG" \
  --label="org.label-schema.build-date=$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
  --label="org.label-schema.vendor=Ocado Technology" \
  --label="org.label-schema.schema-version=1.0" \
  --label="org.label-schema.vcs-url=${VCS_SOURCE}" \
  --label="org.label-schema.version=${VERSION}" \
  --label="org.label-schema.vcs-ref=${TRAVIS_COMMIT}" \
  --label="org.opencontainers.image.created=$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
  --label="org.opencontainers.image.vendor=Ocado Technology" \
  --label="org.opencontainers.image.source=${VCS_SOURCE}" \
  --label="org.opencontainers.image.version=${VERSION}" \
  --label="org.opencontainers.image.revision=${TRAVIS_COMMIT}" \
  --label="org.opencontainers.image.authors=$(git log --format='%aE' Dockerfile | sort -u | tr '\n' ' ')" .

testSnykIfEnabled

if [ "${TRAVIS_TAG}" ]; then
  docker tag "${TRAVIS_REPO_SLUG}" "${TRAVIS_REPO_SLUG}:${TRAVIS_TAG}"
fi
docker tag "${TRAVIS_REPO_SLUG}" "${TRAVIS_REPO_SLUG}:latest"
docker tag "${TRAVIS_REPO_SLUG}" "${TRAVIS_REPO_SLUG}:${TRAVIS_COMMIT}"