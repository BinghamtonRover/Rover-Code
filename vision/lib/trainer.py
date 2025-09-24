from ultralytics import YOLO
from datetime import datetime


class Trainer:
    def __init__(self, load_from: str):
        self.model = YOLO(load_from)
        print(f"Load model {load_from}")

    def save_model(self) -> str:
        out = f"trained-{datetime.now().strftime('%d-%m-%Y %I-%M%p')}.pt"
        self.model.save(out)
        return out

    def train_model(
        self,
        data: str,
        epochs=1000,
        img_size=640,
        batch_size=32,
        learning_rate=0.01,
        patience=100,
    ):
        try:
            results = self.model.train(
                data=data,
                epochs=epochs,
                imgsz=img_size,
                batch=batch_size,
                lr0=learning_rate,
                patience=patience,
                auto_augment="randaugment",
                mixup=0.3,
                mosaic=1.0,
                scale=0.5,
                fliplr=0.5,
                flipud=0.3,
                hsv_h=0.015,
                hsv_s=0.7,
                hsv_v=0.4,
                save_period=25,
                cos_lr=True,
                warmup_epochs=5,
                weight_decay=0.0005,
                dropout=0.2,
                lrf=0.0001,
                plots=True,
                save=True,
            )

            print("training complete, saving model")
            saved_path = self.save_model()
            print(f"model saved as {saved_path}")

            return results
        except KeyboardInterrupt:
            print("\ntraining interrupted, saving model")
            saved_path = self.save_model()
            print(f"model saved as {saved_path}")
            return None

    def validate_model(self, data: str):
        metrics = self.model.val(data=data)
        print(f"mAP50-95: {metrics.box.map}")
        print(f"mAP50: {metrics.box.map50}")
        print(f"mAP75: {metrics.box.map75}")
        return metrics
