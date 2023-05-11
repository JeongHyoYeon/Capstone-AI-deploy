from flask import Flask, request, jsonify
from face_recognition.face_recognition import face_recognition
from yolov5.run_yolov5 import run_yolov5

app = Flask(__name__)


@app.route('/')
def home():
    return "test"


@app.route('/face', methods=['POST'])
def face():
    payload = request.get_json()
    result = face_recognition(payload['image_list'])
    response = {
        'group_idx_list': result[1],
        'images': result[2]
    }
    return response, 200


@app.route('/yolo', methods=['POST'])
def yolo():
    payload = request.get_json()
    result = run_yolov5(payload['image_list'])
    return jsonify(result), 200


if __name__ == "__main__":
    app.run(host='0.0.0.0', port='5000', debug=True)
