print("Initializing...")

import cv2
import os

from lib.analyzer import ImageAnalyzer

def main(): 
  analyzer = ImageAnalyzer()
  for file in os.listdir("test_images"): 
    filename, _ = file.split(".")
    if not filename: continue 
    background, has_mallet = filename.split("_")  # chair_yes --> chair, yes
    has_mallet = has_mallet == "yes"              # yes --> True
    frame = cv2.imread(f"test_images/{file}")
    result = analyzer.has_mallet(frame)
    if result == has_mallet: 
      print(f"{background} image passed -- {result}")
    else: 
      print(f"{background} image failed: Analyzer detected {result} instead of {has_mallet}")

if __name__ == "__main__":
  main()
