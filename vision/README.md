A simple command-line application with an entry point in `cli.py`.<br>
`cli.py` has 4 main sub commands that can be invoked.
1. `cli.py server` Receives frames from the video program and sends them to the Dashboard.<br>
   **Server arguments**
   1. `--load-from` Loads a model from the file path provided. (default: yolo11s.pt)
   2. `--port` Selects the port to listen for incoming frames. (default: 8006)
   3. `--video-host` Host to send annotated frames to. (default: 127.0.0.1)
   4. `--video-port` Port to send annotated frames to. (default: 8002)
   5. `--jpg-quality` JPEG compression quality (1-100). (default: 60)
   6. `--max-packet-size` Maximum UDP packet size in bytes. (default: 60000)
   7. `--show` Display received frames in a window ("none", "before" \[annotation\], or "after" \[annotation\]). (default: none)
   
2. `cli.py unit-test` Tests the currently running model on a set of test images.<br>
   **unit-test arguments**
   1. `--images-dir` Selects a directory with a test set of images. (default: test_images)
   2. `--load-from` Loads a model from the file path provided. (default: yolo11s.pt)

3. `cli.py test` Sends frames from a video stream to the server.<br>
   **test arguments**
   1. `--server-host` Host address of the analyzer server. (default: 127.0.0.1)
   2. `--server-port` Port of the analyzer server. (default: 8006)
   3. `--source-port` Local port to send from. (default: 8007)
   4. `--recv-port` Port to listen on for server's responses. (default: 8002)
   5. `--stream` Video stream source ("cam" or "screen"). (default: cam)
   6. `--image-size` Resize frames to this size before sending (px). (default: 640)
   7. `--jpg-quality` JPEG compression quality (1-100). (default: 60)

4. `cli.py train` Trains a YOLOv11 model from a dataset.<br>
   **train arguments**
   1. `--load-from` Loads a model from the file path provided. (default: yolo11s.pt)
   2. `--data` Path to training data YAML file. (default: perception_v1_dataset/data.yaml)
   3. `--epochs` Selects the number of epochs to run. (default: 1000)
   4. `--img-size` Specifies training image size (px). (default: 640)
   5. `--batch-size` Training batch size. (default: 32)
   6. `--learning-rate` Specifies the learning rate. (default: 0.01)
   7. `--patience` Stops the program if improvement is not seen in the specified amount of epochs. (default: 100)
   8. `--validate` Runs validation after training. (default: True)
   
**Example usage**<br>
`python cli.py server --load-from /home/rover/Desktop/test.pt --show after`<br>
`python cli.py unit-test --images-dir /home/rover/Desktop/test-images`<br>
`python cli.py test --stream screen --server-port 8008`<br>
`python cli.py train --epochs 2000 --img-size 360 --learning-rate 0.02 --batch-size 16`
