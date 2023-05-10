from flask import Flask
from face_recognition.face_recognition import face_recognition
from yolov5.run_yolov5 import run_yolov5

app = Flask(__name__)

@app.route('/')
def home():
    return "test"


@app.route('/face')
def face(images):
    return face_recognition(images)


@app.route('/yolo')
def yolo(images):
    return run_yolov5(images)


if __name__ == "__main__":
    app.run(host='0.0.0.0', port='5000', debug=True)