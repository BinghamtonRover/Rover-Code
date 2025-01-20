import cv2
from roboflow import Roboflow
from ultralytics import YOLO
from dotenv import load_dotenv
import os
from datetime import datetime

class Trainer:
	def __init__(self, load_from=None):
		if load_from is not None:
			self.model = YOLO(load_from)
			print(f"Load model {load_from}")
		else:
			self.model = YOLO("yolo11n.pt")  # load a pretrained model (recommended for training)
			print("Load base model.")

	def save_model(self) -> str:
		out = f"trained-{datetime.now().strftime('%d-%m-%Y %I-%M%p')}.pt"
		self.model.save(out)

	def train_model(self):
		# Load a model
		# Models available are: yolo11n, yolov11s.pt, yolov11m.pt, yolov11l.pt, yolov11x.pt
		results = self.model.train(
			data="Mallet Images.v1i.yolov11/data.yaml", 
			# HEHEHEHAW
			epochs=1000,
			imgsz=640, 
			auto_augment="randaugment",
			mixup=0.3,
			mosaic=1.0,
			# random transformations
			scale=0.5,
			fliplr=0.5,
			flipud=0.3,
			# try to get it adjusted to various lighting
			hsv_h=0.015, 
			hsv_s=0.7,
			hsv_v=0.4,
			# stop if no improvement 
			patience=100, 
        	save_period=25, 
			batch=32,
			# faster  then slower
			cos_lr=True, 
			warmup_epochs=5,
			# try and not overfit the thing
			weight_decay=0.0005, 
			# randomly ignore 20% of neurons
			dropout=0.2,

			lr0=0.01,
			lrf=0.0001,
			# save stuff
			plots=True,
			save=True, 
		)
		print(results)

	def validate_model(self):
		metrics = self.model.val(data="Mallet Images.v1i.yolov11/data.yaml")
		print(metrics.box.map)
		print(metrics.box.map50)  # map50
		print(metrics.box.map75)  # map75
		print(metrics.box.maps)  # a list contains map50-95 of each category


if __name__ == "__main__":
	trainer = Trainer(load_from="trained-model.pt")
	print("Training model")
	trainer.train_model()
	print("Validating model")
	trainer.validate_model()
	print("Saving model")
	trainer.save_model()