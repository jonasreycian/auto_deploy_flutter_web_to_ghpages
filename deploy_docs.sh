#!/usr/bin/env sh

# abort on errors
set -e

git config user.name "Jonas Reycian Saraosos"

git config user.email "jonasreycian@gmail.com"

flutter build web --release

cp build/web docs

git add .

git commit -m 'Deploy'

git push origin HEAD --force

rm -r build
