import os
from flask import Flask, render_template, send_file
import json

app = Flask(__name__)

# Function to load the configuration file
def load_config(config_path="config.json"):
    try:
        with open(config_path, "r") as file:
            config = json.load(file)
        return config.get("welcome_message", "Welcome to the Photo Viewer!")
    except FileNotFoundError:
        return "Welcome to the Photo Viewer!"

# Function to get photos from a local folder
def get_local_photos(folder_path="photos"):
    try:
        if os.path.exists(folder_path):
            return [
                file for file in os.listdir(folder_path)
                if file.lower().endswith((".png", ".jpg", ".jpeg"))
            ]
        else:
            print(f"Error: Folder '{folder_path}' does not exist.")
            return []
    except Exception as e:
        print(f"Error retrieving files from folder: {e}")
        return []

@app.route("/")
def index():
    # Local folder path
    folder_path = os.getenv("PHOTO_FOLDER", "photos")

    welcome_message = load_config()
    photos = get_local_photos(folder_path)

    return render_template("index.html", welcome_message=welcome_message, photos=photos)

@app.route("/photo/<path:photo_key>")
def photo(photo_key):
    folder_path = os.getenv("PHOTO_FOLDER", "photos")
    file_path = os.path.join(folder_path, photo_key)
    if os.path.exists(file_path):
        return send_file(file_path, mimetype="image/jpeg")
    return "Error: Photo not found.", 404

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001)
