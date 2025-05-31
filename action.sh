#!/usr/bin/env bash

set -eu

INPUT_SLUG="${INPUT_SLUG:-${GITHUB_REPOSITORY#*/}}"
VERSION="${GITHUB_REF_NAME}"
[[ "$VERSION" =~ ^v[0-9] ]] && VERSION="${VERSION#v}"
EXPORT_DIR="${RUNNER_TEMP}/${INPUT_SLUG}-export"
PLUGIN_ZIP="${RUNNER_TEMP}/${INPUT_SLUG}-${VERSION}.zip"


echo "ℹ︎ SLUG:    $INPUT_SLUG"
echo "ℹ︎ VERSION: $VERSION"
echo ""

[[ -z "$GITHUB_REF_TYPE" ]] && echo "✕ Invalid trigger! Only branch or tag." && exit 1


echo "::group::Setting up workspace..."
git config safe.directory "$GITHUB_WORKSPACE"
git config user.email "$GITHUB_ACTOR"
git config user.name "$GITHUB_ACTOR"

if [[ -n "$(git status --porcelain)" ]]; then
	git add .
	git commit -m "From previous step:"
fi

mkdir -p "$EXPORT_DIR"


echo "::endgroup::"
echo "::group::Preparing the files..."
git archive --prefix="${INPUT_SLUG}/" HEAD | tar -tf -
git archive --prefix="${INPUT_SLUG}/" HEAD | tar -xC "$EXPORT_DIR"
git archive --prefix="${INPUT_SLUG}/" --output="$PLUGIN_ZIP" HEAD

echo "export-dir=${EXPORT_DIR}" >> "${GITHUB_OUTPUT}"
echo "plugin-zip=${PLUGIN_ZIP}" >> "${GITHUB_OUTPUT}"
echo "::endgroup::"
echo "✓ Successfully archived!"
