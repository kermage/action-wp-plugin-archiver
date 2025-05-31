FROM catthehacker/ubuntu:act-latest

RUN apt update && apt install -y php

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
