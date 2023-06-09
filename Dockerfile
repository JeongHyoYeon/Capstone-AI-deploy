FROM python:3.9-slim-buster
ENV PYTHONUNBUFFERED 1

RUN mkdir /app
WORKDIR /app

RUN apt-get update -y && apt-get install -y build-essential libglib2.0-0 libgl1-mesa-glx ffmpeg libsm6 libxext6
RUN pip install --upgrade pip

# By copying over requirements first, we make sure that Docker will cache
# our installed requirements rather than reinstall them on every build
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt
RUN pip install -U numpy

# Now copy in our code, and run it
COPY . /app/