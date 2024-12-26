import cv2
from ultralytics import YOLO

class ImageAnalyzer:
  def __init__(self):
    self.model = YOLO("trained-model.pt", verbose=False)

  def has_mallet(self, frame: cv2.Mat, confidence = 0.5) -> bool:
    results = self.model.predict(frame, stream=True, verbose=False)
    for result in results:
      json = result.summary()
      if not json: return False
      object = json[0]
      is_mallet = object['name'] == "mallet" and object['confidence'] > confidence
      if is_mallet: return True
    else:
      return False
