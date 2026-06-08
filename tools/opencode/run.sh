#!/usr/bin/env bash

set -o errexit
set -o nounset
# set -o xtrace

if set +o | grep -F 'set +o pipefail' > /dev/null; then
  # shellcheck disable=SC3040
  set -o pipefail
fi

if set +o | grep -F 'set +o posix' > /dev/null; then
  # shellcheck disable=SC3040
  set -o posix
fi

# -----------------------------------------------------------------------------

#SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRIPT_DIR=$(dirname "$0"); SCRIPT_DIR=$(eval "cd \"${SCRIPT_DIR}\" && pwd")
echo "SCRIPT_DIR: ${SCRIPT_DIR}"

# -----------------------------------------------------------------------------

docker run --rm -it \
  -v "$(pwd):/workspace" \
  -v "$(pwd)/.config/opencode-container:/config" \
  -v "$(pwd)/.local/share/opencode:/data" \
  -e "HOME=/config" \
  -e "OPENCODE_CONFIG_DIR=/config" \
  -e "XDG_DATA_HOME=/data" \
  --entrypoint=bash \
  local-opencode
