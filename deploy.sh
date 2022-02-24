#!/usr/bin/env sh

# abort on errors
set -e

git checkout --orphan gh-pages

flutter build web --release

git --work-tree build/web add --all

git --work-tree build/web commit -m 'Deploy'

git push origin HEAD:gh-pages --force

rm -r build

git checkout -f master

git branch -D gh-pages