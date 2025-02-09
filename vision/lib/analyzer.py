import cv2
from ultralytics import YOLO

class ImageAnalyzer:
  def __init__(self, load_from="trained-model.pt"):
    self.model = YOLO(load_from, verbose=False)

  def has_mallet(self, frame: cv2.Mat, confidence = 0.80) -> bool:
    results = self.model.predict(frame, stream=True, verbose=False)
    for result in results:
      json = result.summary()
      if not json: return False
      object = json[0]
      print(f"Confidence in analyzer: {object['confidence']}")
      is_mallet = object['name'] == "mallet" and object['confidence'] > confidence
      print("Confidence: " + str(object['confidence']))
      if is_mallet: 
        return True
    else:
      return False
    
  def annotateImage(self, frame: cv2.Mat, confidence = 0.80) -> cv2.Mat:
    results = self.model.predict(frame, stream=True, verbose=False)
    for result in results:
      json = result.summary()
      if not json: return frame
      object = json[0]
      is_mallet = object['name'] == "mallet" and object['confidence'] > confidence
      if(is_mallet):
        return result.plot()
    return frame
    
  def getFrames(self, cam, show = False):
    ret, frame = cam.read()
    if not ret:
      return None
    
    frame = self.annotateImage(frame)
    if show: cv2.imshow("frame", frame)
    cv2.waitKey(1)
    return frame

if __name__ == "__main__":
  camera = ImageAnalyzer()
  cam = cv2.VideoCapture(0)
  while True:
    camera.getFrames(cam, show = True)