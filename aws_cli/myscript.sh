#!/bin/bash
read -p "Enter the desired server location: " serverName
echo $serverName

function showAll {
  echo "Show all snapshots with ID and StartTime"
  aws ec2 describe-snapshots --owner-ids self --query 'Snapshots[]' --region=$serverName | jq -r '.[] | {SnapshotId, StartTime}'
}

function filterByDate {
  echo "This will allow U to filter snapshots by date and time"
  read -p "Enter how old snapshots to display in format: 4:4:8 (15 - days, 4 - hours, 8 - minutes): " dateTime
  days=$(($(echo $dateTime | cut -f1 -d:) * 86400))
  hours=$(($(echo $dateTime | cut -f2 -d:) * 3600))
  minutes=$(($(echo $dateTime | cut -f3 -d:) * 60))
  dateTime=$(($(date +%s) - days - hours - minutes))
  dateTime=$(date +'%Y-%m-%d %H:%M:%S' -d "@$dateTime")
  echo $dateTime
  aws ec2 describe-snapshots --owner-ids self --region=$serverName --query "Snapshots[?StartTime<='$dateTime']" | jq -r '.[] | {SnapshotId, StartTime, Description, VolumeSize}'
}

function filterByTag {
  echo "This will allow U to filter the snapshots by Tag:Value"
  read -p "Enter the tag and value without spaces (tag:value): " tag
  tagName=$(echo $tag | cut -f1 -d:)
  tagValue=$(echo $tag | cut -f2 -d:)
  aws ec2 describe-snapshots --owner-ids self --region=$serverName --filters Name=tag:$tagName,Values="$tagValue" | jq -r '.Snapshots[] | {SnapshotId, StartTime, Description, VolumeSize}'
}

function upload {
  echo "This function will help U to upload selected snapshots to S3 at another regions"
  read -p "Enter snapshot id: " snapshotId
  read -p "Enter the desired region: " region
  aws ec2 copy-snapshot --source-snapshot-id $snapshotId --destination-region $region --source-region $serverName
  echo "Copy completed"
}

PS3="Select the operation: "

select opt in "Show all EBSSnapshot ID and StartTime" "Show the list of snapshots with are older then N period of time" "Filter snapshots by Tag:Value" "Upload selected snapshots to S3 at another region" quit; do

  case $opt in
  "Show all EBSSnapshot ID and StartTime")
    showAll
    ;;
  "Show the list of snapshots with are older then N period of time")
    filterByDate
    ;;
  "Filter snapshots by Tag:Value")
    filterByTag
    ;;
  "Upload selected snapshots to S3 at another region")
    upload
    ;;
  quit)
    break
    ;;
  *)
    echo "Invalid option $REPLY"
    ;;
  esac
done
