# eGym Docker Image for the Google PubSub Emulator

This image is based on the google/cloud-sdk:221.0.0-alpine image. 

It is correctly configured to allow running tests with the pubsub emulator during your build. 

A topic, subscriber and subscription is needed to start a container from this image. They will be all
created upon start up. 

Example:
```
docker run --name pubsub -d -p 8085:8085 -e PUBSUB_EMULATOR_HOST=0.0.0.0:8085 egymgmbh/pubsub-emulator:latest your-project-id your-topic-id your-subscribtion-if 
```
