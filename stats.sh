#!/usr/bin/env bash

# Regex to match: X files changed, Y insertions(+), Z deletions(-)
regexInsertions="([0-9]+) insertions?"
regexDeletions="([0-9]+) deletions?"

statInsertions=0
statDeletions=0
statCommitCount=0

while read line; do

	if [[ $line =~ $regexInsertions ]]; then
		statInsertions=$(($statInsertions+${BASH_REMATCH[1]}))
	fi

	if [[ $line =~ $regexDeletions ]]; then
		statDeletions=$(($statDeletions+${BASH_REMATCH[1]}))
	fi

	statCommitCount=$(($statCommitCount+1))

done < /dev/stdin

echo "Commits: $statCommitCount"
echo "Ins: $statInsertions; Dels: $statDeletions"