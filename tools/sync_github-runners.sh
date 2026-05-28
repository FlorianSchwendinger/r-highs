#!/usr/bin/env bash
#
# Sync the local `highs` package working tree into the public GitHub mirror
# `../r-highs_github`, used by the GitHub Actions runners.
#
#   source : the package root (the parent of this tools/ directory)
#   dest   : ../r-highs_github (a sibling of the package root)
#
# Any extra arguments are passed straight through to rsync, e.g. for a preview:
#   ./tools/sync_github-runners.sh --dry-run
#
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
src="$(cd "$script_dir/.." && pwd)"
dest="$(cd "$src/.." && pwd)/r-highs_github"

if [[ ! -d "$dest" ]]; then
	echo "error: destination '$dest' does not exist" >&2
	exit 1
fi

echo "Syncing:"
echo "  from: $src/"
echo "  to:   $dest/"
echo

rsync -avh --delete --delete-excluded \
	--filter='protect .git' \
	--filter='protect .github' \
	--filter='protect /README.md' \
	--exclude='.git' \
	--exclude='.github' \
	--exclude='*.tar.gz' \
	--exclude='highs.Rcheck/' \
	--exclude='/README.md' \
	"$@" \
	"$src/" "$dest/"
