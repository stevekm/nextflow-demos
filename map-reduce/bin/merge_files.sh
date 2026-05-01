#!/bin/bash
set -euo pipefail

FILES="${@}"
DEFAULT_OUTPUT=output.txt
OUTPUT="${OUTPUT:-$DEFAULT_OUTPUT}"

paste $FILES > "${OUTPUT}"