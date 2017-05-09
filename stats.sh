#!/usr/bin/env bash

gitDir="$1"
date="${2:-$(date +%d-%m-%Y -d  "1 year ago")}"

# Regex to match: X files changed, Y insertions(+), Z deletions(-)
regexInsertions="([0-9]+) insertions?"
regexDeletions="([0-9]+) deletions?"

# Regex to match: a0b1c2d Merge branch 'branch/name' into branch/name2
regexBranchMerge="[0-9a-f]{7} Merge branch '([^']+)'"

statLinesAdded=0
statLinesDeleted=0
statCommitCount=$(git --git-dir="$gitDir" rev-list --count master)
statCommitMessageWords=$(git --git-dir="$gitDir" log --pretty='%B' --since=01-01-15 | wc -w)
statBranchMergeCount=0
branchList=""

while read line; do

	if [[ $line =~ $regexInsertions ]]; then
		statLinesAdded=$(($statLinesAdded+${BASH_REMATCH[1]}))
	fi

	if [[ $line =~ $regexDeletions ]]; then
		statLinesDeleted=$(($statLinesDeleted+${BASH_REMATCH[1]}))
	fi

	echo -en "\rIns: $statLinesAdded; Dels: $statLinesDeleted" 1>&2

done < <(git --git-dir="$gitDir" log --pretty=tformat: --shortstat --since=01-01-15)

echo 1>&2

while read mergeLog; do

	if [[ $mergeLog =~ $regexBranchMerge ]]; then
		branchList="$branchList\n${BASH_REMATCH[1]}"
		statBranchMergeCount=$(($statBranchMergeCount+1))
	fi

done < <(git --git-dir="$gitDir" log --oneline --since=01-01-15 --merges)

read -r -d '' JSON <<EOF
{
	"commits": {
		"count": ${statCommitCount},
		"messages": {
			"totalWords": ${statCommitMessageWords}
			}
		},
	"lines": {
			"added": ${statLinesAdded},
			"deleted": ${statLinesDeleted}
		},
	"branch": {
			"mergeCount": ${statBranchMergeCount}
		}
}
EOF

echo "${JSON}"