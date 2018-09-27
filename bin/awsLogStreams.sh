#!/bin/sh

# Simple script to show the total space used in each log stream in an AWS account
# Requires the AWS CLI and jq

for loggroup in `aws logs describe-log-groups | jq -r '.logGroups[].logGroupName'`; do
	printf "%-30s %10.1f MB\n" $loggroup `aws logs describe-log-streams --log-group-name $loggroup | jq '[.logStreams[].storedBytes] | add | . / 1000000'`
done
