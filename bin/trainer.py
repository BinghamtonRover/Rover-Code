import cv2
from roboflow import Roboflow
from ultralytics import YOLO
from dotenv import load_dotenv
import os

class Trainer:
	def __init__(self):
		pass

	def save_model(self):
		self.model.save("trained-model.pt")

	def train_model(self):
		# Load a model
		# Models available are: yolo11n, yolov11s.pt, yolov11m.pt, yolov11l.pt, yolov11x.pt
		self.model = YOLO("yolo11n.pt")  # load a pretrained model (recommended for training)
		results = self.model.train(data="Mallet Images.v1i.yolov11\data.yaml", epochs = 75, imgsz = 256,  auto_augment = "randaugment", crop_fraction=0.5, degrees = 90, shear = 90)
		print(results)

	def validate_model(self):
		metrics = self.model.val()
		print(metrics.box.map)
		print(metrics.box.map50)  # map50
		print(metrics.box.map75)  # map75
		print(metrics.box.maps)  # a list contains map50-95 of each category


if __name__ == "__main__":
	trainer = Trainer()
	print("Training model")
	trainer.train_model()
	print("Validating model")
	trainer.validate_model()
	print("Saving model")
	trainer.save_model()