#!/bin/bash

# First create topic
python publisher.py $PUBSUB_PROJECT_ID create $PUBSUB_TOPIC_ID

# Then create subscription
python subscriber.py $PUBSUB_PROJECT_ID create $PUBSUB_TOPIC_ID $PUBSUB_SUBSCRIPTION_ID
