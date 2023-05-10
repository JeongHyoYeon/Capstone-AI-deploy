# BUILDER #
###########

# pull official base image
FROM python:3.9-slim-buster as builder

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# set work directory
WORKDIR /usr/src/app

RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN apt-get update -y && apt-get install -y build-essential libglib2.0-0 libgl1-mesa-glx ffmpeg libsm6 libxext6
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /usr/src/app/wheels -r requirements.txt


#########
# FINAL #
#########

# pull official base image
FROM python:3.9-alpine

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN mkdir -p /home/app
RUN addgroup -S app && adduser -S app -G app
ENV HOME=/home/app
ENV APP_HOME=/home/app/ai
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY --from=builder /usr/src/app/wheels /wheels
COPY --from=builder /usr/src/app/requirements.txt .
RUN apk add --no-cache build-base libglib2.0-0 libgl1-mesa-glx ffmpeg libsm6 libxext6
RUN pip install --upgrade pip
RUN pip install --no-cache /wheels/*

COPY ./config/docker/entrypoint.prod.sh $APP_HOME
COPY . $APP_HOME
RUN chown -R app:app $APP_HOME
USER app
