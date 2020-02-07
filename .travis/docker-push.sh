#!/usr/bin/env bash

performSnykAnalysisIfEnabled() {
  if [ -n "${SNYK_ORG}" ] && [ -n "${SNYK_TOKEN}" ]; then
      snyk monitor --org="${SNYK_ORG}" --docker "${TRAVIS_REPO_SLUG}:${TRAVIS_COMMIT}" --policy-path=.snyk
      snyk monitor --org="${SNYK_ORG}" --file=requirements.txt --policy-path=.snyk
      if [[ -n "$TRAVIS_TAG" ]]; then
          snyk monitor --org="${SNYK_ORG}" --docker "${TRAVIS_REPO_SLUG}:${TRAVIS_TAG}"
      fi
  fi

docker login -u "$REGISTRY_USER" -p "$REGISTRY_PASS"

if [ "${TRAVIS_TAG}" ]; then
	docker push "${TRAVIS_REPO_SLUG}:${TRAVIS_TAG}"
fi
docker push "${TRAVIS_REPO_SLUG}:latest" && \
docker push "${TRAVIS_REPO_SLUG}:${TRAVIS_COMMIT}"

performSnykAnalysisIfEnabled
