from abc import ABC, abstractmethod
import cv2
from mss import mss
import numpy as np

class VideoStream(ABC):
    @abstractmethod
    def get_cv_frame(self):
        """Returns an OpenCV frame"""
        pass

    @abstractmethod
    def close(self):
        pass

    def __del__(self):
        self.close()

    
class WebcamStream(VideoStream):
    def __init__(self):
        self.capture = cv2.VideoCapture(0)
        if not self.capture.isOpened():
            raise IOError("Cannot open webcam")

    def get_cv_frame(self):
        ret, frame = self.capture.read()
        if not ret:
            return None
        else:
            return frame

    def close(self):
        self.capture.release()

class ScreenStream(VideoStream):
    def __init__(self, bounding_box=None):
        self.bounds = bounding_box
        self.sct = mss()
        
    def get_cv_frame(self):
        img = None
        if self.bounds is None:
            img = self.sct.grab(self.sct.monitors[1])
        else:
            img = self.sct.grab(self.bounds)
            
        img_np = np.array(img)

        return cv2.cvtColor(img_np, cv2.COLOR_BGRA2BGR)

    def close(self):
        pass
