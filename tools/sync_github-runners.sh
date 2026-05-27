#!/usr/bin/env bash
#
# Sync the local `highs` package working tree into the public GitHub mirror
# `../r-highs_github`, used by the GitHub Actions runners.
#
#   source : the package root (the parent of this tools/ directory)
#   dest   : ../r-highs_github (a sibling of the package root)
#
# Behaviour:
#   * `--delete` makes the mirror an exact copy of the source (stale files
#     such as old *.tar.gz are removed from the destination).
#   * `.git` is excluded everywhere. This skips both the top-level repo and the
#     `inst/HiGHS` submodule pointer file, so inst/HiGHS is copied as a plain
#     folder of normal files - exactly like any other directory.
#   * `.github` is excluded so the destination keeps its own runner workflows
#     (they live only in the mirror).
#   * Build artifacts are excluded too: the `*.tar.gz` package tarball and the
#     `highs.Rcheck/` check directory. `--delete-excluded` makes sure stale
#     copies of these are also cleaned out of the mirror, so it never keeps an
#     old tarball or check dir around.
#   * `.git` and `.github` get explicit `protect` filters: `--delete-excluded`
#     would otherwise remove them from dest, but the protect rules keep the
#     mirror's own git history and runner workflows safe.
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
	--exclude='.git' \
	--exclude='.github' \
	--exclude='*.tar.gz' \
	--exclude='highs.Rcheck/' \
	--exclude='README.md' \
	"$@" \
	"$src/" "$dest/"
