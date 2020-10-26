#!/usr/bin/env bash

# Args:
# $1 - inputs.working-directory
# $2 - inputs.lint-glob
# $3 - inputs.only-changed

set -e

# Get into the right directory, using the working-directory input.
cd $GITHUB_WORKSPACE
cd $1

# Get the main branch. Historically it defaulted to "master" but it is being
# changed to "main". We should work in both cases.
GIT_MAIN=$(git remote show origin | awk '/HEAD branch/ {print $NF}')

if [ $3 == "true" ]; then
  echo "Only checking changed files..."

  # grep returns a non-zero code if it doesn't match anything. We don't want to
  # bail out in that case, so temporarily allow the script to continue even if
  # there is a non-zero exit.
  set +e

  # Get just the JS files that have changed. We're searching on file extensions,
  # and we include a few that come up from time to time in our projects. We have
  # to filter this list down because eslint doesn't have an option to ignore
  # files it doesn't understand and it'll just complain.
  CHANGED=$(
    git diff --diff-filter=ACMR --name-only --relative origin/${GIT_MAIN} -- . |
    grep -E "\.(js|jsx|es6)$"
  )

  # Now back to bailing out if there's an error.
  set -e

  if [ -n "$CHANGED" ]; then
    npm install @18f/18f-eslint@^1.1.0

    npx @18f/18f-eslint $(
      echo $CHANGED |
      xargs
    )
  else
    echo "No files changed. Skipping."
  fi
else
  # Do the lint
  npm install @18f/18f-eslint@^1.1.0
  npx @18f/18f-eslint $2
fi
