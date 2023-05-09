FROM python:3.9-slim-buster
ENV PYTHONUNBUFFERED 1

RUN mkdir /app
WORKDIR /app

RUN pip install --upgrade pip
COPY requirements.txt /requirements.txt
RUN pip install -r requirements.txt

# Now copy in our code, and run it
COPY . /app/