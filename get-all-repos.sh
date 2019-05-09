#!/usr/bin/env sh
#Author: SriniP

if [ $# -eq 0 ] || [ "$1" == "-?" ] || [ "$1" == "--help" ] || [ "$1" == "-h" ]
  then
    echo "Usage: `basename $0` <USERNAME> <PROJECTNAME>"
    echo "e.g. `basename $0` some_user some_project"
    exit 1
fi
bitBucketUrl=ultigit.ultimatesoftware.com
echo $bitBucketUrl
curl -u ${1} https://$bitBucketUrl/rest/api/1.0/projects/${2}/repos?limit=100 > repos.json

for repo_name in `cat repos.json | jq -r '.values[] .slug'`
do
  echo "cloning" $repo_name
  git clone https://${1}@$bitBucketUrl/scm/${2}/$repo_name.git ./${2}/$repo_name
done
echo "enter to close"
read anyChar
echo "Good Bye"

