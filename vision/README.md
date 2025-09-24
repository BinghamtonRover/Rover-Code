# Vision CLI

A simple command-line application with an entry point in `cli.py`.<br>
`cli.py` has 4 main sub commands that can be invoked.

## `cli.py server` 
### Receives frames from the video program and sends them to the Dashboard.<br>
<br>`--load-from` Loads a model from the file path provided. (default: yolo11s.pt)
<br>`--port` Selects the port to listen for incoming frames. (default: 8006)
<br>`--video-host` Host to send annotated frames to. (default: 127.0.0.1)
<br>`--video-port` Port to send annotated frames to. (default: 8002)
<br>`--jpg-quality` JPEG compression quality (1-100). (default: 60)
<br>`--max-packet-size` Maximum UDP packet size in bytes. (default: 60000)
<br>`--show` Display received frames in a window ("none", "before" \[annotation\], or "after" \[annotation\]). (default: none)
   
## `cli.py unit-test`
### Tests the currently running model on a set of test images.<br>
<br>`--images-dir` Selects a directory with a test set of images. (default: test_images)
<br>`--load-from` Loads a model from the file path provided. (default: yolo11s.pt)

## `cli.py test` 
### Sends frames from a video stream to the server.<br>
<br>`--server-host` Host address of the analyzer server. (default: 127.0.0.1)
<br>`--server-port` Port of the analyzer server. (default: 8006)
<br>`--source-port` Local port to send from. (default: 8007)
<br>`--recv-port` Port to listen on for server's responses. (default: 8002)
<br>`--stream` Video stream source ("cam" or "screen"). (default: cam)
<br>`--image-size` Resize frames to this size before sending (px). (default: 640)
<br>`--jpg-quality` JPEG compression quality (1-100). (default: 60)

## `cli.py train` 
### Trains a YOLOv11 model from a dataset.
<br>`--load-from` Loads a model from the file path provided. (default: yolo11s.pt)
<br>`--data` Path to training data YAML file. (default: perception_v1_dataset/data.yaml)
<br>`--epochs` Selects the number of epochs to run. (default: 1000)
<br>`--img-size` Specifies training image size (px). (default: 640)
<br>`--batch-size` Training batch size. (default: 32)
<br>`--learning-rate` Specifies the learning rate. (default: 0.01)
<br>`--patience` Stops the program if improvement is not seen in the specified amount of epochs. (default: 100)
<br>`--validate` Runs validation after training. (default: True)
   
**Example usage**<br>
`python cli.py server --load-from /home/rover/Desktop/test.pt --show after`<br>
`python cli.py unit-test --images-dir /home/rover/Desktop/test-images`<br>
`python cli.py test --stream screen --server-port 8008`<br>
`python cli.py train --epochs 2000 --img-size 360 --learning-rate 0.02 --batch-size 16`
