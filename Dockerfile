FROM python:3.9-slim-buster
ENV PYTHONUNBUFFERED 1

RUN mkdir -p /home/app
RUN adduser --system --group app
ENV HOME=/home/app
ENV APP_HOME=/home/app/ai
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN pip install --upgrade pip
COPY requirements.txt /requirements.txt
RUN pip install -r requirements.txt

COPY ./config/docker/entrypoint.prod.sh $APP_HOME
COPY . $APP_HOME
RUN chown -R app:app $APP_HOME
USER app