#!/usr/bin/env bash

trap 'git checkout --force master' EXIT
trap 'rm -rf "${tmp_orig:-}" "${tmp_new:-}"' EXIT

tmp_orig="$(mktemp)"
tmp_new="$(mktemp)"

# Update "json" package subtree.
git fetch --all
git rebase upstream/master go-master
git checkout go-master
git subtree split --prefix src/encoding/json --branch json-master
git rebase -Xours json-master master

if ! git diff --quiet --exit-code origin/master; then
  # Execute "BenchmarkEncodeMarshaler" benchmark.
  git checkout json-master
  git show master:bench_test.go > bench_test.go
  go test -count=20 -bench=BenchmarkEncodeMarshaler | tee "$tmp_orig"
  git restore .
  git checkout master
  go test -count=20 -bench=BenchmarkEncodeMarshaler | sed '/^pkg:/d' | tee "$tmp_new"
  benchstat "$tmp_orig" "$tmp_new" > bench.txt
  git commit --all --message "update benchstat: $(date +%F)"
fi

git push --all --force

# Manually tag the "Support zero values of structs with omitempty: golang/go#11939" commit.
# git tag v1.14.4 6acb9d8d1d

# Manually push the tags to GitHub.
# git push origin v1.14.4