FROM google/cloud-sdk:243.0.0-alpine

COPY env.yaml /var/pubsub/env.yaml

RUN apk --update add openjdk7-jre
RUN gcloud components install --quiet beta pubsub-emulator
RUN gcloud components update

RUN apk --no-cache add py-pip
RUN pip install --upgrade pip
RUN apk --no-cache add --upgrade python-dev

RUN apk --no-cache add build-base

# We need google-cloud-pubsub to execute the subscriber.py and the publisher.py
RUN pip install google-cloud-pubsub

VOLUME /var/pubsub

EXPOSE 8085

ADD subscriber.py subscriber.py
ADD publisher.py publisher.py
ADD wait-for-it.sh wait-for-it.sh
ADD init.sh init.sh
ADD wait-for-it-sequence.sh wait-for-it-sequence.sh

ENTRYPOINT ["./init.sh"]
