#!/bin/bash
cd flask
gunicorn wsgi:app

