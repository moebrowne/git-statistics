#!/usr/bin/env bash

# Regex to match: X files changed, Y insertions(+), Z deletions(-)
regexInsertions="([0-9]+) insertions?"
regexDeletions="([0-9]+) deletions?"

statLinesAdded=0
statLinesDeleted=0
statCommitCount=0

while read line; do

	if [[ $line =~ $regexInsertions ]]; then
		statLinesAdded=$(($statLinesAdded+${BASH_REMATCH[1]}))
	fi

	if [[ $line =~ $regexDeletions ]]; then
		statLinesDeleted=$(($statLinesDeleted+${BASH_REMATCH[1]}))
	fi

	statCommitCount=$(($statCommitCount+1))

done < /dev/stdin

echo "Commits: $statCommitCount"
echo "Ins: $statLinesAdded; Dels: $statLinesDeleted"