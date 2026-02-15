import cv2
from ultralytics import YOLO
import torch

from lib.network.src.generated import vision_pb2


class ImageAnalyzer:
    def __init__(self, load_from="trained-model.pt"):
        if torch.cuda.is_available():
            torch.cuda.set_device(0)
            self.device = "cuda"
        else:
            self.device = "cpu"
            print("CUDA not available - using CPU")

        self.model = YOLO(load_from, task="detect")

    def has_mallet(self, frame: cv2.Mat, confidence=0.80) -> tuple[bool, float]:
        annotated, detections = self.analyze_frame(frame, confidence=confidence)
        for detection in detections:
            if detection.object_type == vision_pb2.HAMMER:
                return True, confidence
        return False, 0.0

    def annotateImage(self, frame: cv2.Mat, confidence=0.80) -> cv2.Mat:
        annotated, _ = self.analyze_frame(frame, confidence=confidence)
        return annotated

    def analyze_frame(self, frame: cv2.Mat, confidence=0.80):
        results = self.model.predict(frame, verbose=False)
        if not results:
            return frame, []

        result = results[0]
        detections = []

        boxes = getattr(result, "boxes", None)
        if boxes is None or boxes.xyxy is None:
            return frame, []

        names = self.model.names
        height, width = frame.shape[:2]

        for idx in range(len(boxes)):
            conf = float(boxes.conf[idx])
            if conf < confidence:
                continue

            cls_id = int(boxes.cls[idx])
            label = str(names.get(cls_id, "")).lower()
            object_type = self._map_label_to_object_type(label)
            if object_type is None:
                continue

            x1, y1, x2, y2 = boxes.xyxy[idx].tolist()
            center_x = int((x1 + x2) / 2.0)
            center_y = int((y1 + y2) / 2.0)
            area = max(0.0, (x2 - x1) * (y2 - y1))

            x_position = 0.0
            if width > 0:
                x_position = (center_x / width) * 2.0 - 1.0

            detection = vision_pb2.DetectedObject(
                object_type=object_type,
                x_position=x_position,
                relative_size=(area / (width * height)) if width > 0 and height > 0 else 0.0,
                center_x=center_x,
                center_y=center_y,
            )
            detections.append(detection)

        annotated = result.plot() if hasattr(result, "plot") else frame
        return annotated, detections

    def _map_label_to_object_type(self, label: str):
        if "hammer" in label and "rock" in label:
            return vision_pb2.ROCK_HAMMER
        if "hammer" in label or "mallet" in label:
            return vision_pb2.HAMMER
        if "bottle" in label:
            return vision_pb2.BOTTLE
        return None

    def getFrames(self, cam, show=False):
        ret, frame = cam.read()
        if not ret:
            return None

        frame = self.annotateImage(frame)
        if show:
            cv2.imshow("frame", frame)
        cv2.waitKey(1)
        return frame

