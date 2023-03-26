#!/bin/bash

# takes a string of the form "repositoryname:branchname".  This format
# is used in the github UI where a branch is specified - clicking on a
# "copy" symbol next to a URL will copy it to your clipboard.

# on the PR screen this is next to the text reading "peterbarker wants to merge 1 commit into ArduPilot:master from peterbarker:pr/remove-dead-script"

# Assumes that repositoryname exists on github.com as a repository (username)
# creates a remote repositoryname and fetches it.
# checks branchname out as a detached head

# so, for example, "gco peterbarker:pr/remove-dead-script" will create
# a remote for peterbarker if it doesn't exist, fetch that remote and
# then check the "pr/remote-dead-script" from that repo out as a
# detached head.

# primary use case is for quickly testing a contributor's PR.

# see companion script "toggle-remote-type" for modifying URLs so you
# can push fixed versions back up

set -e
set -x

WHAT="$1"

test -z "$WHAT" && {
    echo "need an arg (e.g. peterbarker:pr/ahrs-gps-3D)"
    exit 1
}

REMOTE=$(echo "$WHAT" | perl -pe 's/:.*//')
BRANCH=$(echo "$WHAT" | perl -pe 's/.*://')

if [ "$REMOTE" == "$BRANCH" ]; then
    echo "failed to parse"
    exit 1
fi
test -z "$REMOTE" && {
    echo "failed to parse"
    exit 1
}
test -z "$BRANCH" && {
    echo "failed to parse"
    exit 1
}

echo "remote=$REMOTE"
echo "branch=$BRANCH"

if git remote -v | grep "^$REMOTE\s"; then
    echo "Already have remote for $REMOTE"
else
    git remote add $REMOTE https://github.com/$REMOTE/$REPONAME
fi

git fetch $REMOTE
git checkout remotes/$REMOTE/$BRANCH
