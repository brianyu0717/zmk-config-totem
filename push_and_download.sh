#! /bin/bash

usage() {
    echo "-c [just commit, prompt for message]" 
    echo "-a [commit amend]" 
    echo "-n [commit amend no-edit]"
}

while test $# -gt 0; do
  case "$1" in
    -a|--amend)
      AMEND=1
      ;;
    -n|--no-edit)
      AMEND=1
      NO_EDIT=1
      ;;
    -h|--help)
      usage
      ;;
    *)
      usage
      ;;
  esac
  shift
done

if [[ $AMEND -eq 0 ]]; then
    read -p "Commit message: " COMMIT_MSG
    git add . && git commit -m "$COMMIT_MSG" && git push
fi

if [[ $AMEND -eq 1 ]] || [[ $NO_EDIT -eq 1 ]]; then
    if [[ $NO_EDIT -eq 1 ]] then
        git add . && git commit --amend --no-edit && git push -f
    else
        read -p "Commit message: " COMMIT_MSG
        git add . && git commit --amend -m "$COMMIT_MSG" && git push -f
    fi
fi


DOWNLOAD_DIR=download
STATUS=started

echo "Wait a little bit for github to start the workflow to build the new firmware, then start polling.."
sleep 10

while true; do
    LATEST=$(gh run list -R brianyu0717/zmk-config-totem --json databaseId\,displayTitle\,status | jq '.[0]')
    ID=$(echo $LATEST | jq '.databaseId')
    STATUS=$(echo $LATEST | jq '.status' | tr -d '"')
    if [[ $STATUS == 'completed' ]] then
        break
    fi
    echo "Waiting for status to transition from" $STATUS "to completed for " $(echo $LATEST | jq '.displayTitle')
    sleep 5
done

echo "Downloading" $LATEST
rm -rf $DOWNLOAD_DIR
gh run download $ID -R brianyu0717/zmk-config-totem --dir $DOWNLOAD_DIR
echo "Download completed"