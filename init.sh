#!/bin/bash
# PUBSUB_EMULATOR_HOST must be set, so that topcis and subscriptions are created in the emulator. For this the
# credentials aren't needed, which setting this env var allows to circumvent.
PUBSUB_EMULATOR_HOST=localhost:8085

if [ "$#" -le 2 ]; then
    if [[ (-z "$PUBSUB_PROJECT_ID" || -z "$PUBSUB_TOPIC_ID" || -z "$PUBSUB_SUBSCRIPTION_ID") ]]
    then
	    echo "Either pass the following args or set them as ENV variables with the respective names."
	    echo "Usage: $0 <PROJECT-ID> <TOPIC-ID> <SUBSCRIPTION-ID>"
	    exit 1
	else
	    echo "ENV vars were set -> using env vars"
	    PUBSUB_PROJECT_ID=${PUBSUB_PROJECT_ID}
        PUBSUB_TOPIC_ID=${PUBSUB_TOPIC_ID}
        PUBSUB_SUBSCRIPTION_ID=${PUBSUB_SUBSCRIPTION_ID}
	fi
else
    PUBSUB_PROJECT_ID=$1
    PUBSUB_TOPIC_ID=$2
    PUBSUB_SUBSCRIPTION_ID=$3
fi

# https://github.com/vishnubob/wait-for-it
./wait-for-it.sh 0.0.0.0:8085 -- bash "wait-for-it-sequence.sh" &
gcloud beta emulators pubsub start --data-dir=/var/pubsub --host-port=127.0.0.1:8085 --host-port=0.0.0.0:8085 --log-http --verbosity=debug --user-output-enabled
