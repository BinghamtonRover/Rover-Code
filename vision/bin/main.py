import subprocess

command = ["python3", "-m", "cli", "server"]

try:
    result = subprocess.run(command, text=True, check=True)
except subprocess.CalledProcessError as e:
    print(f"Error when trying to run server: {e}")
