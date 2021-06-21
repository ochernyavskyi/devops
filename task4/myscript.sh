#!/bin/bash

echo "This is script which will deal with github API"
read -p "Enter the github url (example: https://github.com/testuser/myrep: " input_data
input_data=${input_data,,}
input_data=${input_data#https://github.com/}
echo ${input_data}

function pull_request_exist {
  echo "This function shows, the names of pull requests, if they are available"
  curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/${input_data}/pulls?per_page=100 | jq '.[].title'
}

function contributors {
  echo "This function will print the list of most productive contributors, which have more than 1 open PR"
  curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/${input_data}/pulls?state=opened?per_page=100 | jq '.[].user.login' | uniq -cd
}

function pull_request_count {
  echo "This function will print the number of PRs each contributor has created with the labels"
  contributor_lables=($(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/${input_data}/pulls | jq '.[] | .labels | length'))
  contributor_names=($(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/${input_data}/pulls | jq '.[].user.login'))
  echo
  for ((i = 0; i < ${#contributor_names[@]}; i++)); do
    echo "${contributor_names[i]} : ${contributor_lables[i]}"
  done
}

function custom_func {
  echo "This function will show U all public repositories of user"
  username=${input_data%/*}
  echo $username
  curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/users/${username}/repos?per_page=100 | jq -r '.[] | .name'
}

PS3="Select the operation: "

select opt in "Check if pull request exists" "Print the list of most productive contributors" "Print the number of PRs each contributor has created with the labels" "Show all public repositories of user" quit; do

  case $opt in
  "Check if pull request exists")
    pull_request_exist
    ;;
  "Print the list of most productive contributors")
    contributors
    ;;
  "Print the number of PRs each contributor has created with the labels")
    pull_request_count
    ;;
  "Show all public repositories of user")
    custom_func
    ;;
  quit)
    break
    ;;
  *)
    echo "Invalid option $REPLY"
    ;;
  esac
done
