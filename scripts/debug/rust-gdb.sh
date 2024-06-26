#!/bin/sh
# Copied from https://github.com/rust-lang/rust/blob/master/src/etc/rust-gdb
# Exit if anything fails
set -e

# Prefer rustc in the same directory as this script
DIR="$(dirname "$0")"
if [ -x "$DIR/rustc" ]; then
  RUSTC="$DIR/rustc"
else
  RUSTC="rustc"
fi

# Find out where the pretty printer Python module is
RUSTC_SYSROOT="$("$RUSTC" --print=sysroot)"
GDB_PYTHON_MODULE_DIRECTORY="$RUSTC_SYSROOT/lib/rustlib/etc"
# Get the commit hash for path remapping
RUSTC_COMMIT_HASH="$("$RUSTC" -vV | sed -n 's/commit-hash: \([a-zA-Z0-9_]*\)/\1/p')"

echo "set substitute-path /rustc/$RUSTC_COMMIT_HASH $RUSTC_SYSROOT/lib/rustlib/src/rust"

# Run GDB with the additional arguments that load the pretty printers
# Set the environment variable `RUST_GDB` to overwrite the call to a
# different/specific command (defaults to `gdb-multiarch`).
RUST_GDB="${RUST_GDB:-gdb-multiarch}"
PYTHONPATH="$PYTHONPATH:$GDB_PYTHON_MODULE_DIRECTORY" exec ${RUST_GDB} \
  --directory="$GDB_PYTHON_MODULE_DIRECTORY" \
  -iex "add-auto-load-safe-path $GDB_PYTHON_MODULE_DIRECTORY" \
  -iex "set substitute-path /rustc/$RUSTC_COMMIT_HASH $RUSTC_SYSROOT/lib/rustlib/src/rust" \
  # -iex "source $GDB_PYTHON_MODULE_DIRECTORY/gdb_load_rust_pretty_printers.py" \
  "$@"