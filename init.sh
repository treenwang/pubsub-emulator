#!/bin/bash

if [ "$#" -le 2 ]; then
	echo "Usage: $0 <PROJECT-ID> <TOPIC-ID> <SUBSCRIPTION-ID>"
	exit 1
fi

PROJECT_ID=$1
TOPIC_ID=$2
SUBSCRIPTION_ID=$3

# https://github.com/vishnubob/wait-for-it
./wait-for-it.sh 0.0.0.0:8085 -- python "publisher.py $PROJECT_ID create $TOPIC_ID" &
./wait-for-it.sh 0.0.0.0:8085 -- python "subscriber.py $PROJECT_ID create $TOPIC_ID $SUBSCRIPTION_ID" &

gcloud beta emulators pubsub start --data-dir=/var/pubsub --host-port=127.0.0.1:8085 --host-port=0.0.0.0:8085 --log-http --verbosity=debug --user-output-enabled
