#!/bin/bash

set -e

[ -z "${GITHUB_PAT}" ] && exit 0
[ "${TRAVIS_BRANCH}" != "master" ] && exit 0

git config --global user.email "will.landau@gmail.com"
git config --global user.name "wlandau"

git clone -b gh-pages https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git gh-pages
cd gh-pages
cp -r ../_book/* ./
git add --all *
git commit -m "Update the manual" || true
git push -q origin gh-pages
