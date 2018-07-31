#!/bin/bash
[ -z "${GITHUB_PAT}" ] && exit 0
echo "Environment variables:"
echo "  PATH: ${PATH}"
echo "  TRAVIS_BRANCH: ${TRAVIS_BRANCH}"
echo "  TRAVIS_PULL_REQUEST: ${TRAVIS_PULL_REQUEST}"
echo "  TRAVIS_PULL_REQUEST_BRANCH: ${TRAVIS_PULL_REQUEST_BRANCH}"
if [[ "${TRAVIS_BRANCH}" == "master" && "${TRAVIS_PULL_REQUEST}" == "false" ]]
then
  echo "Deploying to production."
  git config --global user.email "will.landau@gmail.com"
  git config --global user.name "wlandau"
  git clone -b gh-pages https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git gh-pages
  cd gh-pages
  cp -r ../_book/* ./
  git add --all *
  git commit -m "Update the manual" || true
  git push -q origin gh-pages
elif [[ "${TRAVIS_PULL_REQUEST_BRANCH}" != "" ]]
then
  echo "Deploying Netlify preview."
  cd _book
  netlify deploy -t ${NETLIFYKEY} --draft
fi
