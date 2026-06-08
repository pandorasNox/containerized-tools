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

ARCH_OVERRIDE="${1:-}"

if [ -n "$ARCH_OVERRIDE" ]; then
    PLATFORM="$ARCH_OVERRIDE"
else
    case "$(uname -m)" in
        x86_64) PLATFORM="linux/amd64" ;;
        arm64|aarch64) PLATFORM="linux/arm64" ;;
        *) echo "Unsupported architecture"; exit 1 ;;
    esac
fi

echo "Building for $PLATFORM"

docker build --no-cache -f "${SCRIPT_DIR}/Containerfile" -t local-opencode "${SCRIPT_DIR}"

# -----------------------------------------------------------------------------
