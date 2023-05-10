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
        'group': result[0],
        'group_idx_list': result[1],
        'images': result[2]
    }
    return jsonify(response)


@app.route('/yolo', methods=['POST'])
def yolo():
    payload = request.get_json()
    result = run_yolov5(payload['image_list'])
    return jsonify(result)


if __name__ == "__main__":
    app.run(debug=True)
