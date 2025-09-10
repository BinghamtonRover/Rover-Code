import cv2
import numpy as np
import torch
import torch.nn.functional as F
from torchvision import transforms
import matplotlib.pyplot as plt
from PIL import Image
import requests
from io import BytesIO
import os
import sys

DEPTH_PRO_AVAILABLE = False
MIDAS_AVAILABLE = False

try:
    import depth_pro
    DEPTH_PRO_AVAILABLE = True
    print("Depth Pro loaded successfully")
except ImportError as e:
    print(f"Depth Pro not available: {e}")
    print("Falling back to MiDaS depth estimation")
    
    try:
        import torch.hub
        MIDAS_AVAILABLE = True
        print("MiDaS available as fallback")
    except ImportError:
        print("MiDaS also not available")

class KeyboardDepthEstimator:
    def __init__(self, model_path=None, use_depth_pro=True):  
        self.device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
        print(f"Using device: {self.device}")
        
        self.depth_model = None
        self.transform = None
        self.model_type = None
        
        if use_depth_pro and DEPTH_PRO_AVAILABLE:
            self._load_depth_pro()
        elif MIDAS_AVAILABLE:
            self._load_midas()
        else:
            print("No depth estimation model available")
            
        self.focal_length_mm = 4.25  
        self.sensor_width_mm = 3.68  
        self.key_size_mm = 15.0 
        
    def _download_depth_pro_model(self):
        import urllib.request
        import ssl
        import os
        from pathlib import Path
        
        possible_paths = [
            Path.home() / ".cache" / "depth_pro" / "depth_pro.pt",
            Path.cwd() / "checkpoints" / "depth_pro.pt",
            Path.cwd() / "depth_pro.pt"
        ]
        
        for path in possible_paths:
            if path.exists():
                file_size = path.stat().st_size
                print(f"Found Depth Pro model at: {path}")
                print(f"File size: {file_size / (1024*1024):.1f} MB")
                
                if file_size < 100 * 1024 * 1024:  
                    print("File is too small")
                elif file_size > 1000 * 1024 * 1024:  
                    print("File is too large")
                else:
                    print("File size can be used")
                
                return str(path)
        
        model_url = "https://ml-site.cdn-apple.com/models/depth-pro/depth_pro.pt"
        download_path = Path.home() / ".cache" / "depth_pro"
        download_path.mkdir(parents=True, exist_ok=True)
        model_path = download_path / "depth_pro.pt"
        
        print(f"Downloading Depth Pro model to {model_path}...")
        
        try:
            ssl_context = ssl.create_default_context()
            ssl_context.check_hostname = False
            ssl_context.verify_mode = ssl.CERT_NONE
            
            def progress_hook(count, block_size, total_size):
                percent = int(count * block_size * 100 / total_size)
                print(f"\rDownloading... {percent}%", end="", flush=True)
            
            urllib.request.urlretrieve(
                model_url, 
                str(model_path), 
                reporthook=progress_hook,
                context=ssl_context
            )
            print("Model downloaded successfully")
            return str(model_path)
            
        except Exception as e:
            print(f"Failed to download model: {e}")
            return None

    def _load_depth_pro(self):
        try:
            model_path = self._download_depth_pro_model()  
            
            if model_path and os.path.exists(model_path):
                print(f"Using Depth Pro model from: {model_path}")
                try:
                    self.depth_model, self.transform = depth_pro.create_model_and_transforms(
                        checkpoint_path=model_path
                    )
                    print("Loaded checkpoint parameter successfully")
                except Exception as e1:
                    print("Method 1 failed")
                    try:
                        import depth_pro.depth_pro as dp_model
                        self.depth_model = dp_model.DepthPro.load_from_checkpoint(model_path)
                        from depth_pro.depth_pro import DepthProConfig
                        config = DepthProConfig()
                        self.transform = depth_pro.transform.DepthProTransform(config)
                        print("Loaded checkpoint paramter successfully")
                    except Exception as e2:
                        print("Method 2 failed")
                        try:
                            os.environ['DEPTH_PRO_CHECKPOINT'] = model_path
                            self.depth_model, self.transform = depth_pro.create_model_and_transforms()
                            print("Loaded environment variable successfully")
                        except Exception as e3:
                            print("Method 3 failed")
                            raise e3
                            
                self.depth_model.to(self.device)
                self.depth_model.eval()
                self.model_type = "depth_pro"
                print("Depth Pro model loaded successfully")
                
            else:
                raise Exception("Model file not found")
                
        except Exception as e:
            print("All Depth Pro loading methods failed")
            if MIDAS_AVAILABLE:
                self._load_midas()
            else:
                print("MiDaS not available")
    
    def _load_midas(self):
        try:
            self.depth_model = torch.hub.load("intel-isl/MiDaS", "MiDaS")
            self.depth_model.to(self.device)
            self.depth_model.eval()
            
            # MiDaS transforms
            midas_transforms = torch.hub.load("intel-isl/MiDaS", "transforms")
            self.transform = midas_transforms.default_transform
            self.model_type = "midas"
            print("MiDaS model loaded successfully")
        except Exception as e:
            print("✗ Failed to load MiDaS")
            self.depth_model = None
    
    def preprocess_image(self, image):
        if self.model_type == "depth_pro":
            if isinstance(image, np.ndarray):
                image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
                image = Image.fromarray(image)
            image_tensor = self.transform(image)
            return image_tensor.unsqueeze(0).to(self.device)
        
        elif self.model_type == "midas":
            if isinstance(image, np.ndarray):
                image_rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
            else:
                image_rgb = np.array(image)
            
            input_tensor = self.transform(image_rgb).to(self.device)
            return input_tensor.unsqueeze(0)
        
        return None
    
    def estimate_depth(self, image):
        if self.depth_model is None:
            print("No depth model available")
            return None
            
        try:
            with torch.no_grad():
                if self.model_type == "depth_pro":
                    image_tensor = self.preprocess_image(image)
                    prediction = self.depth_model.infer(image_tensor)
                    depth = prediction["depth"]  
                    depth_map = depth.cpu().numpy().squeeze()
                    
                elif self.model_type == "midas":
                    input_tensor = self.preprocess_image(image)
                    prediction = self.depth_model(input_tensor)
                    
                    prediction = torch.nn.functional.interpolate(
                        prediction.unsqueeze(1),
                        size=image.shape[:2] if isinstance(image, np.ndarray) else (image.height, image.width),
                        mode="bicubic",
                        align_corners=False,
                    ).squeeze()
                    
                    depth_map = prediction.cpu().numpy()
                    depth_map = 1.0 / (depth_map + 1e-6)
                    depth_map = (depth_map - depth_map.min()) / (depth_map.max() - depth_map.min()) * 2.0 + 0.3
                
                return depth_map
                
        except Exception as e:
            print("Error in depth estimation")
            return None
    
    def detect_keys(self, image):
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        blurred = cv2.GaussianBlur(gray, (5, 5), 0)
        edges = cv2.Canny(blurred, 50, 150)
        
        kernel = np.ones((3, 3), np.uint8)
        closed = cv2.morphologyEx(edges, cv2.MORPH_CLOSE, kernel)
        
        contours, _ = cv2.findContours(closed, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        
        key_contours = []
        min_area = 200
        max_area = 2000
        min_aspect_ratio = 0.7
        max_aspect_ratio = 1.5
        
        for contour in contours:
            area = cv2.contourArea(contour)
            if min_area < area < max_area:
                x, y, w, h = cv2.boundingRect(contour)
                aspect_ratio = w / h
                
                if min_aspect_ratio < aspect_ratio < max_aspect_ratio:
                    key_contours.append({
                        'contour': contour,
                        'bbox': (x, y, w, h),
                        'center': (x + w//2, y + h//2),
                        'area': area
                    })
        
        return key_contours
    
    def calculate_distance_focal_length(self, object_size_pixels, image_width):
        focal_length_pixels = (self.focal_length_mm * image_width) / self.sensor_width_mm
        distance_mm = (self.key_size_mm * focal_length_pixels) / object_size_pixels
        distance_m = distance_mm / 1000.0
        return distance_m
    
    def process_keyboard_image(self, image_path_or_array):
        if isinstance(image_path_or_array, str):
            image = cv2.imread(image_path_or_array)
        else:
            image = image_path_or_array.copy()
        
        if image is None:
            print("Image loading failed")
            return None
        
        print("Detecting keyboard keys")
        key_detections = self.detect_keys(image)
        print(f"Found {len(key_detections)} potential keys")
        
        if len(key_detections) == 0:
            print("No keys detected. Try adjusting the detection parameters")
            return None
        
        print(f"Estimating depth using {self.model_type}")
        depth_map = self.estimate_depth(image)
        
        if depth_map is None:
            print("Failed to estimate depth")
            return None
        
        results = []
        image_height, image_width = image.shape[:2]
        
        vis_image = image.copy()
        
        depth_normalized = ((depth_map - depth_map.min()) / (depth_map.max() - depth_map.min()) * 255).astype(np.uint8)
        depth_vis = cv2.applyColorMap(depth_normalized, cv2.COLORMAP_JET)
        
        for i, key in enumerate(key_detections):
            x, y, w, h = key['bbox']
            center_x, center_y = key['center']
            
            if 0 <= center_y < depth_map.shape[0] and 0 <= center_x < depth_map.shape[1]:
                depth_at_key = depth_map[center_y, center_x]
            else:
                depth_at_key = np.nan
            
            key_width_pixels = w
            distance_focal = self.calculate_distance_focal_length(key_width_pixels, image_width)
            
            result = {
                'key_id': i,
                'bbox': (x, y, w, h),
                'center': (center_x, center_y),
                'depth_estimate': depth_at_key,
                'focal_length_distance': distance_focal,
                'key_width_pixels': key_width_pixels
            }
            results.append(result)
            
            cv2.rectangle(vis_image, (x, y), (x + w, y + h), (0, 255, 0), 2)
            cv2.circle(vis_image, (center_x, center_y), 3, (0, 0, 255), -1)
            
            # Add distance text
            depth_text = f"D: {depth_at_key:.2f}m" if not np.isnan(depth_at_key) else "D: N/A"
            focal_text = f"FL: {distance_focal:.2f}m"
            
            cv2.putText(vis_image, depth_text, (x, y - 25), 
                       cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 0, 0), 1)
            cv2.putText(vis_image, focal_text, (x, y - 10), 
                       cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 1)
            cv2.putText(vis_image, f"Key {i}", (x, y + h + 15), 
                       cv2.FONT_HERSHEY_SIMPLEX, 0.4, (255, 255, 255), 1)
        
        return {
            'results': results,
            'original_image': image,
            'visualization': vis_image,
            'depth_map': depth_map,
            'depth_visualization': depth_vis,
            'model_used': self.model_type
        }
    
    def display_results(self, processing_result):
        """Display the results using matplotlib"""
        if processing_result is None:
            print("No results to display")
            return
        
        fig, axes = plt.subplots(2, 2, figsize=(15, 12))
        
        # Original image
        axes[0, 0].imshow(cv2.cvtColor(processing_result['original_image'], cv2.COLOR_BGR2RGB))
        axes[0, 0].set_title('Original Image')
        axes[0, 0].axis('off')
        
        # Key detection visualization
        axes[0, 1].imshow(cv2.cvtColor(processing_result['visualization'], cv2.COLOR_BGR2RGB))
        axes[0, 1].set_title(f'Key Detection & Distance Estimation ({processing_result["model_used"]})')
        axes[0, 1].axis('off')
        
        # Depth map
        im = axes[1, 0].imshow(processing_result['depth_map'], cmap='jet')
        axes[1, 0].set_title(f'Depth Map ({processing_result["model_used"]})')
        axes[1, 0].axis('off')
        plt.colorbar(im, ax=axes[1, 0], label='Depth (m)')
        
        # Depth visualization
        axes[1, 1].imshow(cv2.cvtColor(processing_result['depth_visualization'], cv2.COLOR_BGR2RGB))
        axes[1, 1].set_title('Depth Visualization')
        axes[1, 1].axis('off')
        
        plt.tight_layout()
        plt.show()
        
        # Print detailed results
        print(f"\nDetailed Results (using {processing_result['model_used']}):")
        print("-" * 80)
        for result in processing_result['results']:
            print(f"Key {result['key_id']}:")
            print(f"  Position: {result['center']}")
            print(f"  Bounding Box: {result['bbox']}")
            print(f"  Width (pixels): {result['key_width_pixels']}")
            print(f"  Depth Estimate: {result['depth_estimate']:.3f}m")
            print(f"  Focal Length Distance: {result['focal_length_distance']:.3f}m")
            print()

# Image loading functions (same as before)
def load_image_from_file(image_path):
    """Load image from file path"""
    try:
        image = cv2.imread(image_path)
        if image is None:
            print(f"Error: Could not load image from {image_path}")
            print("Supported formats: .jpg, .jpeg, .png, .bmp, .tiff")
            return None
        print(f"Successfully loaded image: {image.shape}")
        return image
    except Exception as e:
        print(f"Error loading image: {e}")
        return None

def load_image_from_webcam(camera_id=0):
    """Capture image from webcam"""
    try:
        cap = cv2.VideoCapture(camera_id)
        if not cap.isOpened():
            print(f"Error: Could not open camera {camera_id}")
            return None
        
        print("Press SPACE to capture image, ESC to exit")
        while True:
            ret, frame = cap.read()
            if not ret:
                print("Error: Could not read frame")
                break
            
            cv2.imshow('Webcam - Press SPACE to capture, ESC to exit', frame)
            key = cv2.waitKey(1) & 0xFF
            
            if key == 32:  # Space key
                print("Image captured!")
                cap.release()
                cv2.destroyAllWindows()
                return frame
            elif key == 27:  # ESC key
                break
        
        cap.release()
        cv2.destroyAllWindows()
        return None
    except Exception as e:
        print(f"Error with webcam: {e}")
        return None

def interactive_image_loader():
    """Interactive function to choose how to load the image"""
    print("\nHow would you like to load the image?")
    print("1. From file path")
    print("2. From webcam")
    print("3. Use example (if available)")
    
    choice = input("Enter your choice (1-3): ").strip()
    
    if choice == "1":
        image_path = input("Enter the image file path: ").strip()
        image_path = image_path.strip('"\'')  
        return load_image_from_file(image_path)
    
    elif choice == "2":
        camera_id = input("Enter camera ID (0 for default): ").strip()
        try:
            camera_id = int(camera_id) if camera_id else 0
        except ValueError:
            camera_id = 0
        return load_image_from_webcam(camera_id)
    
    elif choice == "3":
        # Create a simple test pattern if no image available
        print("Creating test pattern...")
        test_image = np.ones((480, 640, 3), dtype=np.uint8) * 128
        
        # Draw some rectangles to simulate keys
        for i in range(5):
            for j in range(10):
                x = 50 + j * 50
                y = 150 + i * 50
                cv2.rectangle(test_image, (x, y), (x + 40, y + 40), (200, 200, 200), -1)
                cv2.rectangle(test_image, (x, y), (x + 40, y + 40), (0, 0, 0), 2)
        
        return test_image
    
    else:
        print("Invalid choice")
        return None

def main():
    """Main function with installation check"""
    print("=" * 60)
    print("Keyboard Depth Estimation with Apple Depth Pro")
    print("=" * 60)
    
    # Ask user which model to use
    print("\nWhich depth model would you like to use?")
    print("1. Apple Depth Pro (high quality, requires download)")
    print("2. MiDaS (good quality, automatic download)")
    
    model_choice = input("Enter choice (1 or 2): ").strip()
    use_depth_pro = (model_choice == "1")
    
    # Check installation status
    if not DEPTH_PRO_AVAILABLE and not MIDAS_AVAILABLE:
        print("\n⚠ INSTALLATION REQUIRED ⚠")
        print("\nTo use this script, you need to install depth estimation models.")
        print("\nFor Apple Depth Pro (recommended):")
        print("1. pip install git+https://github.com/apple/ml-depth-pro.git")
        print("\nFor MiDaS fallback:")
        print("1. Make sure you have internet connection for torch.hub")
        print("\nThen run this script again.")
        return
    
    # Initialize the estimator
    try:
        estimator = KeyboardDepthEstimator(use_depth_pro=use_depth_pro)
        
        if estimator.depth_model is None:
            print("Failed to load any depth model. Please check installation.")
            return
        
        # Load image
        image = interactive_image_loader()
        
        if image is not None:
            print("\nProcessing image...")
            result = estimator.process_keyboard_image(image)
            
            if result:
                estimator.display_results(result)
                
                # Save option
                save_choice = input("\nSave visualization? (y/n): ").strip().lower()
                if save_choice == 'y':
                    output_path = input("Enter output filename: ").strip()
                    if output_path:
                        cv2.imwrite(output_path, result['visualization'])
                        print(f"Saved to {output_path}")
            else:
                print("Failed to process image")
        else:
            print("No image loaded")
            
    except Exception as e:
        print(f"Error: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    main()