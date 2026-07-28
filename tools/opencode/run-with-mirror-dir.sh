#!/usr/bin/env bash

# -----------------------------------------------------------------------------

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

# TODO: as opencode user we got issues:
#
# .local/state
# ```
$ opencode
# EACCES: permission denied, mkdir '/home/opencode/.local/state'
#     path: "/home/opencode/.local/state",
#  syscall: "mkdir",
#    errno: -13,
#     code: "EACCES" 
# ```

# define base paths
MIRROR_BASE="${HOME}/.local/share/opencode-container/project-dirs-mirroring-mounts"
MIRROR_REL="${PWD#/}"
MIRROR_DIR="${MIRROR_BASE}/${MIRROR_REL}"
mkdir -p "${MIRROR_DIR}"
mkdir -p "${MIRROR_DIR}/.opencode"

CONTAINER_HOME_DIR="/root"
HOST_GLOBAL_CONFIG_DIR="${HOME}/.config/opencode-container/opencode"
HOST_DATA_DIR="${HOME}/.local/share/opencode"
mkdir -p "${HOST_DATA_DIR}"

# define the Volume Map [Host Path] -> [Container Path]
declare -A VOLUME_MAP

VOLUME_MAP["$(pwd)"]="/workspace"
VOLUME_MAP["${MIRROR_DIR}"]="/mnt/opencode-project-level-dir-mirror"
VOLUME_MAP["${HOST_DATA_DIR}"]="${CONTAINER_HOME_DIR}/.local/share/opencode"
VOLUME_MAP["opencode-dind-data"]="/var/lib/docker"

# Conditional mount: only add it if the directory exists
if [ -d "${HOST_GLOBAL_CONFIG_DIR}" ]; then
  VOLUME_MAP["${HOST_GLOBAL_CONFIG_DIR}"]="${CONTAINER_HOME_DIR}/.config/opencode"
fi

# if we find an AGENTS.md in the mirroring dir, we mount it to the container global opencode conf dir
# as this is the only way to simulate some kind of AGENTS.md overlay behavior
if [ -f "${MIRROR_DIR}/AGENTS.md" ]; then
  VOLUME_MAP["${MIRROR_DIR}/AGENTS.md"]="${CONTAINER_HOME_DIR}/.config/opencode/AGENTS.md"
fi

# convert the Map into Docker flags (-v host:container)
DOCKER_MOUNTS=()
for host_path in "${!VOLUME_MAP[@]}"; do
  DOCKER_MOUNTS+=("-v" "${host_path}:${VOLUME_MAP[$host_path]}")
done

docker run --rm -it --privileged \
  "${DOCKER_MOUNTS[@]}" \
  -e "OPENCODE_CONFIG_DIR=/mnt/opencode-project-level-dir-mirror/.opencode" \
  -e "XDG_DATA_HOME=${CONTAINER_HOME_DIR}/.local/share/opencode" \
  -e "USER_UID=$(id -u)" \
  -e "USER_GID=$(id -g)" \
  local-opencode bash
