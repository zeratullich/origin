#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

OS_ROOT=$(dirname "${BASH_SOURCE}")/..
source "${OS_ROOT}/hack/lib/init.sh"

if ! git status &> /dev/null; then
  echo "SKIPPED: Not a Git repository"
  exit 0
fi

"${OS_ROOT}/hack/build-go.sh" tools/rebasehelpers/commitchecker

# Find binary
commitchecker="$(os::build::find-binary commitchecker)"
echo "===== Verifying UPSTREAM Commits ====="
$commitchecker
echo "SUCCESS: All commits are valid."
