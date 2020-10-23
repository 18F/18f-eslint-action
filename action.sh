#!/usr/bin/env bash

set -e

cd $GITHUB_WORKSPACE
cd $1

npm install @18f/18f-eslint@^1.1.0
npx @18f/18f-eslint $2