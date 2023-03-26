# rebase-prs

Peter's branch management solution.

It's not pretty, but its mine.

## Overview

rebase-prs is a script which takes configuration from a branches.conf

Roughly speaking, it takes any branches starting with "pr/" and attempts to rebase them on your master branch.  It then tries to delete the branch - which will fail unless the branch is fully merged into master.

Assumes that your remote is called "github"

## Note

This Works For Me.  It may Not Work For You.  It may, in fact, delete all of your branches.  It's here as-is from my work environment with minimal modifications .es
