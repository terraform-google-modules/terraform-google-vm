#!/usr/bin/env bash

# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Create a temporary directory that's auto-cleaned, even if the process aborts.
DELETE_AT_EXIT="$(mktemp -d)"
finish() {
  [[ -d "${DELETE_AT_EXIT}" ]] && rm -rf "${DELETE_AT_EXIT}"
}
trap finish EXIT
# Create a temporary file in the auto-cleaned up directory while avoiding
# overwriting TMPDIR for other processes.
# shellcheck disable=SC2120 # (Arguments may be passed, e.g. maketemp -d)
maketemp() {
  TMPDIR="${DELETE_AT_EXIT}" mktemp "$@"
}

# find_files is a helper to exclude .git directories and match only regular
# files to avoid double-processing symlinks.
find_files() {
  local pth="$1"
  shift
  find "${pth}" '(' \
    -path '*/.git' \
    -o -path '*/.terraform' \
    -o -path '*/.kitchen' \
    ')' \
    -prune -o -type f "$@"
}

# Compatibility with both GNU and BSD style xargs.
compat_xargs() {
  local compat=() rval
  # Test if xargs is GNU or BSD style.  GNU xargs will succeed with status 0
  # when given --no-run-if-empty and no input on STDIN.  BSD xargs will fail and
  # exit status non-zero If xargs fails, assume it is BSD style and proceed.
  # stderr is silently redirected to avoid console log spam.
  if xargs --no-run-if-empty </dev/null 2>/dev/null; then
    compat=("--no-run-if-empty")
  fi
  xargs "${compat[@]}" "$@"
  rval="$?"
  if [[ -z "${NOWARN:-}" ]] && [[ "${rval}" -gt 0 ]]; then
    echo "Warning: compat_xargs $* failed with exit code ${rval}" >&2
  fi
  return "${rval}"
}

function check_bash() {
find . -name "*.sh" | while IFS= read -d '' -r file;
do
  if [[ "$file" != *"bash -e"* ]];
  then
    echo "$file is missing shebang with -e";
    exit 1;
  fi;
done;
}

# This function makes sure that the required files for
# releasing to OSS are present
function basefiles() {
  echo "Checking for required files"
  test -f LICENSE || echo "Missing LICENSE"
  test -f README.md || echo "Missing README.md"
}

# This function runs 'terraform validate' and 'terraform fmt'
# against all directory paths which contain *.tf files.
function check_terraform() {
  local rval=125
  # fmt is before validate for faster feedback, validate requires terraform
  # init which takes time.
  echo "Running terraform fmt"
  find . -type f -name "*.tf" -exec terraform fmt -diff -check=true -write=false {} \;
  rval="$?"
  if [[ "${rval}" -gt 0 ]]; then
    echo "Error: terraform fmt failed with exit code ${rval}" >&2
    echo "Check the output for diffs and correct using terraform fmt <dir>" >&2
    return "${rval}"
  fi
  echo "Running terraform validate"
  find_files . -not -path "./test/fixtures/shared/*" -name "*.tf" -print0 \
    | compat_xargs -0 -n1 dirname \
    | sort -u \
    | compat_xargs -t -n1 helpers/terraform_validate
}

# This function runs 'go fmt' and 'go vet' on every file
# that ends in '.go'
function golang() {
  echo "Running go fmt and go vet"
  find . -name "*.go" -exec go fmt {} \;
  find . -name "*.go" -exec go vet {} \;
}

# This function runs the flake8 linter on every file
# ending in '.py'
function check_python() {
  echo "Running flake8"
  find . -name "*.py" -exec flake8 {} \;
}

# This function runs the shellcheck linter on every
# file ending in '.sh'
function check_shell() {
  echo "Running shellcheck"
  find . -name "*.sh" -exec shellcheck -x {} \;
}

# This function makes sure that there is no trailing whitespace
# in any files in the project.
# There are some exclusions
function check_trailing_whitespace() {
  echo "The following lines have trailing whitespace"
  grep -r '[[:blank:]]$' --exclude-dir=".terraform" --exclude-dir=".kitchen" --exclude="*.png" --exclude="*.pyc" --exclude-dir=".git" .
  rc=$?
  if [ $rc = 0 ]; then
    exit 1
  fi
}

function generate_docs() {
  echo "Generating markdown docs with terraform-docs"
  local pth helper_dir rval
  helper_dir="$(pwd)/helpers"
  while read -r pth; do
    if [[ -e "${pth}/README.md" ]]; then
      (cd "${pth}" || return 3; "${helper_dir}"/terraform_docs .;)
      rval="$?"
      if [[ "${rval}" -gt 0 ]]; then
        echo "Error: terraform_docs in ${pth} exit code: ${rval}" >&2
        return "${rval}"
      fi
    else
      echo "Skipping ${pth} because README.md does not exist."
    fi
  done < <(find_files . -name '*.tf' -print0 \
    | compat_xargs -0 -n1 dirname \
    | sort -u)
}
