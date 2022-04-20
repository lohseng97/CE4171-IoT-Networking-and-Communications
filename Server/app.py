from flask import Flask, request, jsonify, render_template
from werkzeug.utils import secure_filename
from datetime import datetime
import os

import tensorflow.lite as tflite
import cv2
import numpy as np
from keras.preprocessing.image import load_img
from keras.preprocessing.image import img_to_array

model = tflite.Interpreter('model/imagereg.tflite')
model.allocate_tensors()
model_input_details = model.get_input_details()
model_output_details = model.get_output_details()

app = Flask(__name__)

def prediction(path):
	image = cv2.imread(path)
	image = cv2.resize(image,(320,320))

	input_tensor = np.array(np.expand_dims(image,0), dtype=np.float32)
	input_index = model.get_input_details()[0]["index"]
	model.set_tensor(input_index, input_tensor)
	model.invoke()

	output_details = model.get_output_details()
	output_data = model.get_tensor(output_details[0]['index'])
	pred = np.squeeze(output_data)

	classes = {0: 'Butterfly', 1: 'Cat', 2: 'Chicken', 3: 'Cow', 4: 'Dog', 5: 'Elephant',
	6: 'Horse', 7: 'Sheep', 8: 'Spider', 9: 'Squirrel'}

	highest_pred_loc = np.argmax(pred)
	accuracy = pred[highest_pred_loc]*100
	animal = classes[highest_pred_loc]

	return [accuracy, animal]

def uploadHandler(imagefile):
	filename = secure_filename(imagefile.filename)
	path = './uploadimages/'+filename
	imagefile.save(os.path.join(path))
	results = prediction(path)
	return results

@app.route('/', methods =["GET"])
def homepage():
	return render_template("index.html")
@app.route('/', methods =["POST"])
def homepageUpload():
	imagefile = request.files['image']
	[accuracy, animal] = uploadHandler(imagefile)
	classification = '%s, with %.2f%% accuracy.' % (animal, accuracy)
	return render_template("index.html", prediction = classification)

@app.route('/upload', methods = ["POST"])
def upload():
	imagefile = request.files['image']
	[accuracy, animal] = uploadHandler(imagefile)
	accuracy = str(accuracy)
	accuracy = "{:.2f}".format(float(accuracy)) + '%'
	print("Received imag and sending back predicted results.")
	return jsonify({
		"message": "Success!",
		"filename": imagefile.filename,
		"classname": animal,
		"accuracy": accuracy,
		"uploadtime": datetime.now()
	})

if (__name__ == "__main__"):
	app.run(debug = True, host = '0.0.0.0',  port = 8080)
