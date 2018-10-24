FROM google/cloud-sdk:221.0.0-alpine

#RUN mkdir -p /var/pubsub
COPY env.yaml /var/pubsub/env.yaml

RUN apk --update add openjdk7-jre
RUN gcloud components install --quiet beta pubsub-emulator
RUN gcloud components update

# Check which of these can be removed
RUN apk --no-cache add py-pip
RUN pip install --upgrade pip
RUN apk --no-cache add python-dev
RUN apk --no-cache add musl-dev
RUN apk --no-cache add make
RUN apk --no-cache add linux-headers
RUN apk --no-cache add dumb-init
RUN apk --no-cache add libc6-compat
RUN apk --no-cache add build-base
RUN apk --no-cache add bash

RUN apk --no-cache add readline-dev
RUN apk --no-cache add zlib-dev
RUN apk --no-cache add bzip2-dev
RUN apk --no-cache add libressl-dev

RUN apk --no-cache add --upgrade python-dev
RUN pip install google-cloud-pubsub

VOLUME /var/pubsub

EXPOSE 8085

ADD subscriber.py subscriber.py
ADD publisher.py publisher.py
ADD wait-for-it.sh wait-for-it.sh
ADD init.sh init.sh

CMD ["./init.sh"]
