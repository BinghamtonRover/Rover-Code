A simple command-line application with an entry point in `cli.py`.<br>
`cli.py` has 4 main sub commands that can be invoked.
1. `cli.py server` Receives frames from the video program and sends them to the Dashboard.<br>
   **Server arguments**
   1. `--load-from` Loads a model from the file path provided.
   2. `--port` Selects the port to listen for incoming frames. (default: 8006)
   
2. `cli.py unit-test` Tests the currently running model on a set of test images.<br>
   **unit-test arguments**
   1. `--images-dir` Selects a directory with a test set of images.
   2. `--load-from` Loads a model from the file path provided.
   
3. `cli.py test` Sends frames from the video stream to the server.
4. `cli.py train` Trains a YOLOv11 model from a dataset.<br>
   **train arguments**
   1. `--epochs` Selects the number of epochs to run. (default: 1000)
   2. `--image-size` Specifies a custom image size. (default: 640 px)
   3. `--learning-rate` Specifies the learning rate. (default: 0.01)
   4. `--patience` Stops the program if improvement is not seen in the specified amount of epochs. (default: 100)
   5. `--validate` Runs validation after training. (default: True)
   
**Example usage**<br>
`python cli.py server --load-from /home/rover/Desktop/test.pt`<br>
`python cli.py unit-test --images-dir /home/rover/Desktop/test-images`<br>
`python cli.py test`<br>
`python cli.py train --epochs 2000 --image-size 360 --learning-rate 0.02`
