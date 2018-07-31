#!/bin/bash
[ -z "${GITHUB_PAT}" ] && exit 0
echo "Your path is ${TRAVIS_BRANCH}"
echo "You are on branch ${TRAVIS_BRANCH}"
echo "The TRAVIS_PULL_REQUEST_BRANCH is ${TRAVIS_PULL_REQUEST_BRANCH}"
if [[ "${TRAVIS_PULL_REQUEST_BRANCH}" != "" ]]
then
  echo "Deploying Netlify preview."
  cd _book
  netlify deploy -t ${NETLIFYKEY} --draft
elif [[ "${TRAVIS_BRANCH}" == "master" ]]
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
fi
