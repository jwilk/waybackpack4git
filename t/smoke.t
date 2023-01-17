#!/bin/sh

# Copyright © 2020-2023 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u
echo 1..1
base="${0%/*}/.."
if [ -z "${WAYBACKPACK4GIT_NETWORK_TESTING-}" ]
then
    echo 'WAYBACKPACK4GIT_NETWORK_TESTING is not set' >&2
    echo 'not ok 1'
    exit 1
fi
tmpdir=$(mktemp -d -t waybackpack4git.XXXXXX)
"$base"/waybackpack4git --quiet --to-date 200206 --dir "$tmpdir"/example.org-wayback http://example.org/
out=$(git -C "$tmpdir"/example.org-wayback/ log -3 --stat)
sed -e 's/^/# / ' <<EOF
$out
EOF
echo 'ok 1'
rm -rf "$tmpdir"

# vim:ts=4 sts=4 sw=4 et ft=sh
