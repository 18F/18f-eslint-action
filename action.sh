#!/usr/bin/env bash

cd $GITHUB_WORKSPACE

npm install @18f/18f-eslint@^1.0.0
npx @18f/18f-eslint $1