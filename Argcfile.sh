#!/usr/bin/env bash
# @describe Neovim build tasks

set -eu

# @cmd Build a release tarball for installation at /usr/local
# @flag --clean  Remove build directory first
pack() {
  if [[ "${argc_clean:-0}" == "1" ]]; then
    make distclean
  fi
  make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=/usr/local \
    CMAKE_EXTRA_FLAGS="-DENABLE_WASMTIME=ON" \
    DEPS_CMAKE_FLAGS="-DENABLE_WASMTIME=ON"
  cd build
  cpack -G TGZ
}

! command -v argc &>/dev/null && echo "Run 'cargo install argc' or see https://github.com/sigoden/argc" && exit 1
eval "$(argc --argc-eval "$0" "$@")"
