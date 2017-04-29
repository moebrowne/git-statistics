#!/usr/bin/env bash

gitDir="$1"

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

	echo -en "Commits: $statCommitCount; Ins: $statLinesAdded; Dels: $statLinesDeleted\r"

done < <(git --git-dir="$gitDir" log --pretty=tformat: --shortstat --since=01-01-15)

echo ""

statCommitMessageWords=$(git --git-dir="$gitDir" log --pretty='%B' --since=01-01-15 | wc -w)
