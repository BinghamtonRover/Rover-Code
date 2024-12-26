print("Initializing...")

import cv2

from lib.analyzer import ImageAnalyzer

def main():
  print("Loading model...")
  analyzer = ImageAnalyzer()
  no_mallet = cv2.imread("no_mallet.jpg")
  yes_mallet = cv2.imread("yes_Mallet.jpg")

  print("Analyzing no_mallet... ", end = "")
  found_mallet = analyzer.has_mallet(no_mallet)
  if found_mallet:
    print("Failed\nFound mallet when there is no mallet")
    return
  print("Success!")

  print("Analyzing yes_mallet... ", end = "")
  found_mallet = analyzer.has_mallet(yes_mallet)
  if not found_mallet:
    print("Failed\nCould not detect mallet")
    return
  print("Success!")

if __name__ == "__main__":
  main()
