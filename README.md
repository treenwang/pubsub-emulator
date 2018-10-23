# eGym Docker Image for the Google PubSub Emulator

This image is based on the google/cloud-sdk:162.0.0-alpine image. 

It is correctly configured to allow running tests with the pubsub emulator during your build.

docker exec -it pubsub apk add py-pip
docker exec -it pubsub pip install google-cloud-core
docker exec -it pubsub pip install google-api-python-client
docker exec -it pubsub pip install --upgrade pip
docker exec -it pubsub apk --no-cache add --upgrade python-dev
docker exec -it pubsub pip install google-cloud-pubsub
