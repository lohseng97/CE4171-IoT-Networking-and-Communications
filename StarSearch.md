# NTU CE/CZ4171 Internet of Things: Communications and Networking

## StarSearch - Flutter Application for Animals Detection

### Project Description
The objective of the project is to:
- Host a Virtual Machine with convolutional neural network capability to do animal detection
- Create Android application ("StarSearch") to communicate with the Virtual Machine

### Contents
In this submission folder, the following files are available:
- Image_Recognition.ipynb: Google Colab Notebook used for training.
    - Dataset used: Animals-10 dataset. Source: https://www.kaggle.com/datasets/alessiocorrado99/animals10
    - Statistics: 
        - Training Loss: 0.2541
        - Training Accuracy: 91.55%
        - Validation Loss: 0.5997
        - Validation Accuracy: 81.16%
- image_org.zip: Zipped file containing the TensorFlow Model file.
    - Note: TensorFlow Lite Model (uploaded to GCP) is in "/Server Code/Model"
- /Android App Code/starsearch_iot: Folder containing the source code for the Flutter Application
    - pubspec.yaml: File used to import modules in the Flutter Application.
    - AndroidManifest.xml: File required for permission controls in Android.
        - To be stored in "/android/app/build/src/main" folder
    - /lib: Folder containing all the dart files to build the Flutter application
- /Server Code: Folder containing the source code to be implemented in the Virtual Machine
    - app.py: Code used to run the Flask Application. TensorFlow Lite is imported in this application as well.
    - /model/imagereg.tflite: TensorFlow Lite Model used for inference. Exported from the Image_Recognition.ipynb file.
    - /templates/index.html: HTML file to allow users to upload the image to the server through the web browser
    - requirements.txt: Text file containing the list of dependencies for the server application.
- StarSearch Readme.txt: Readme file.

### Additional Materials
Available for reference (until 31 October 2022):
- Presentation Video:
    - Video title: StarSearch - Application Demonstration
    - Video link: https://www.youtube.com/watch?v=nJmaZFWRzYg&ab_channel=LohSeng
- OneDrive for Business:
    - Includes Original PowerPoint Slides, Presentation Video, and StarSearch Application ("app-debug.apk" file)
    - Folder Name: CE4171 IoT Communications and Networking Submission
    - OneDrive Link (Requires NTU Account): https://entuedu-my.sharepoint.com/:f:/g/personal/chew0398_e_ntu_edu_sg/Emj_zpfwwIFIsV6FvPUWy74BKpbeoxSAMifYQp7lwmaxlw?e=xPXewR
