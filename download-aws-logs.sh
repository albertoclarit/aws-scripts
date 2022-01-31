#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# LOG_GROUP_NAME="/ecs/dev-reports-populate-job"
# LOG_STREAM_NAME="ecs/dev-reports-populate-job/ff5494226f9946f181b548ce9c1d2c93"
REGION="us-west-2"
OUTPUT_FILE="$(date +"%Y%m%d").log"

result=$(aws logs get-log-events \
    --start-from-head \
    --log-group-name=${LOG_GROUP_NAME} \
    --log-stream-name=${LOG_STREAM_NAME} \
    --region=${REGION})
echo ${result} | jq -r .events[].message >> ${OUTPUT_FILE}

nextToken=$(echo $result | jq -r .nextForwardToken)
while [ -n "$nextToken" ]; do
    echo ${nextToken}
    result=$(aws logs get-log-events \
        --start-from-head \
        --log-group-name=${LOG_GROUP_NAME} \
        --log-stream-name=${LOG_STREAM_NAME} \
        --region=${REGION} \
        --next-token="${nextToken}")

    if [[ $(echo ${result} | jq -e '.events == []') == "true" ]]; then
        echo "response with empty events found -> exiting."
        exit
    fi

    echo ${result} | jq -r .events[].message >> ${OUTPUT_FILE}

    nextToken=$(echo ${result} | jq -r .nextForwardToken)
done
