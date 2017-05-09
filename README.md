# Git Statistics

> Git repository statistics generator that produces machine readable reports

This script allows you to extract various statistics from a Git repository and makes them available in machine readable
 format so that the data can be used with other tools, dashboards, APIs etc.

## Usage

To get the statistics for a repo run the following

```sh
./stats.sh path/to/git/repo/.git [date]
```

The `date` argument is optional. It represents the minimum date to collect stats from. If not provided it will default 
 to 1 year ago from today.

## Statistics

### Commits

- [x] Total count
- [x] Message word count
- [ ] Rate (commits per day/month/year)

### Code

- [x] Lines added
- [x] Lines deleted

### Branches

- [ ] Count
- [x] Merge count
- [ ] PR merge count

### Contributors

- [ ] Count

## Formats

- [x] JSON
- [ ] CSV
