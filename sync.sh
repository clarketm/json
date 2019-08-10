#!/usr/bin/env bash

trap 'git checkout --force master' EXIT

git fetch --all
git rebase upstream/master go-master
git checkout go-master
git subtree split --prefix src/encoding/json --branch json-master
git rebase json-master master
git push --all --force
