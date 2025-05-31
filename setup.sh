#!/usr/bin/env bash

set -eu

INSTALLED=""
PACKAGES=""
MISSING=""
SUCCESS=""
FAILED=""

declare -A MAP=(
	[svn]=subversion
)


has() {
	command -v "$1" > /dev/null 2>&1
}

ensure() {
	for COMMAND in "$@"; do
		if has "$COMMAND"; then
			INSTALLED+="$COMMAND "
		else
			PACKAGE=${MAP[$COMMAND]:-$COMMAND}
			PACKAGES+="$PACKAGE "
			MISSING+="$COMMAND "
		fi
	done

	INSTALLED=${INSTALLED% }
	MISSING=${MISSING% }
	PACKAGES=${PACKAGES% }


	if [ -n "$INSTALLED" ]; then
		echo "ℹ︎ Already installed: $INSTALLED"
	fi

	if [ -z "$MISSING" ]; then
		exit;
	fi


	echo "ℹ︎ To install: $MISSING"
	echo ""

	echo "::group::Updating package list..."
	if ! sudo apt update; then
		exit 1
	fi
	echo "::endgroup::"
	echo "::group::Installing packages..."
	if ! sudo apt install -y $PACKAGES; then
		echo "✕ Failed to install: $MISSING"
		exit 1
	fi
	echo "::endgroup::"
	echo ""


	IFS=' ' read -r -a COMMANDS <<< "$MISSING"
	for COMMAND in "${COMMANDS[@]}"; do
		if has "$COMMAND"; then
			SUCCESS+="$COMMAND "
		else
			FAILED+="$COMMAND "
		fi
	done

	SUCCESS=${SUCCESS% }
	FAILED=${FAILED% }


	if [ -n "$FAILED" ]; then
		echo "✕ Failed to install: $FAILED"
		exit 1
	fi

	echo "✓ Successfully installed: $SUCCESS"
	echo ""
}


ensure git
