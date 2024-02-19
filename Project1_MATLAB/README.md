# Object Classification and Real-Time Video Processing Project

This project aims to detect and classify objects into two categories: recyclable (R) or organic (O), using real-time video input. It leverages a trained Convolutional Neural Network (CNN) for classification and integrates with a pre-trained YOLO model for object detection in video frames. This README provides an overview of the project.

## Setup Instructions

### Prerequisites
- MATLAB (R2020a or later recommended)
- Deep Learning Toolbox
- Computer Vision Toolbox
- Image Processing Toolbox
- Webcam Support Package (for real-time video processing)

### Installation
1. Clone or download this project to your local machine.
2. Ensure all required MATLAB toolboxes are installed (specified in the Prerequisites above).
3. Make sure the dataset is in the `DATASET/` directory.
4. If using a pre-trained YOLO model for object detection, ensure it is compatible with your MATLAB version and properly configured.

### Running the Project
1. Open MATLAB and navigate to the project directory.
2. Run the `Main.m` script to start the project. This script will automatically load and preprocess the dataset, train the model (if not already trained), and perform real-time video processing for object classification.

## Usage

### Training the Model
The model is trained automatically when you run the `Main.m` script if a trained model is not found in the `models/` directory. Training parameters can be adjusted in the `trainModel.m` script.
**(p.s. It took me approximately 70 minutes to train the model on M1 Macbook Air)**

### Real-Time Video Processing
After training, the project uses your webcam to capture video frames in real-time, detect objects using YOLO, and classify them as recyclable or organic. The classification results are displayed on the video feed.

### Testing the Model
The `testModel.m` script evaluates the trained model on the test dataset, providing metrics such as accuracy, precision, recall, and generates a confusion matrix along with precision-recall and Accuracy vs. Label Frequency graphs for performance analysis.
All the graphs generated from `testModel.m` are saved in the `results` directory.

## Demo

![Demo GIF](results/Demo_README.gif)
