from flask import Flask, jsonify
import RPi.GPIO as GPIO
import time
import numpy as np
from tensorflow.keras.models import load_model
import joblib

app = Flask(_name_)

# Pin Configurations

BUZZER_PIN = 18
PIR_SENSOR_PIN = 21        # PIR sensor on GPIO 21
MICROWAVE_SENSOR_PIN = 4    # Microwave sensor on GPIO 4
DHT_SENSOR = 3
# GPIO Setup
GPIO.setmode(GPIO.BCM)
GPIO.setup(LED_PIN, GPIO.OUT)
GPIO.setup(BUZZER_PIN, GPIO.OUT)
GPIO.setup(PIR_SENSOR_PIN, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)   # PIR sensor with pull-down resistor
GPIO.setup(MICROWAVE_SENSOR_PIN, GPIO.IN)                         # Microwave sensor

# Load Model and Scaler
try:
    lstm_model = load_model('lstm_model.h5')
    scaler = joblib.load('scaler.pkl')
    print("Model and scaler loaded successfully!")
except Exception as e:
    print(f"Error loading model or scaler: {e}")
    exit(1)

SEQUENCE_LENGTH = 10
NUM_FEATURES = 3  # Input features: motion, temperature, humidity

def collect_sensor_data():
    """
    Collect sensor data over a fixed sequence length.
    Only the motion value (OR of PIR and microwave sensors) affects detection.
    Temperature and humidity are set to fixed values unless they are None.
    """
    data = []
    for _ in range(SEQUENCE_LENGTH):
        # Read sensors
        pir_motion = GPIO.input(PIR_SENSOR_PIN)
        microwave_motion = GPIO.input(MICROWAVE_SENSOR_PIN)
        # OR operation: if either sensor detects motion, motion is 1
        motion = int(pir_motion or microwave_motion)
        
        # Fixed values for temperature and humidity
        temperature, humidity = 30.0, 60.0
        # If sensor read fails, assign random values
        if humidity is None or temperature is None:
            humidity, temperature = np.random.uniform(50, 80), np.random.uniform(25, 43)
        
        print(f"PIR: {pir_motion}, Microwave: {microwave_motion} -> Motion: {motion}, Temp: {temperature}, Humidity: {humidity}")
        data.append([motion, temperature, humidity])
        time.sleep(0.1)
    return np.array(data)

def preprocess_data(data):
    """
    Scales only the temperature and humidity features using the loaded scaler,
    and leaves the motion feature unchanged.
    """
    data_reshaped = data.reshape(-1, NUM_FEATURES)
    # Extract the motion feature (column 0) and the other features (columns 1 and 2)
    motion = data_reshaped[:, :1]
    other_features = data_reshaped[:, 1:3]
    
    # Scale temperature and humidity using the scaler fit on 2 features
    other_features_scaled = scaler.transform(other_features)
    
    # Concatenate the unscaled motion with the scaled temperature and humidity
    data_scaled = np.concatenate((motion, other_features_scaled), axis=1)
    data_scaled = data_scaled.reshape(1, SEQUENCE_LENGTH, NUM_FEATURES)
    return data_scaled

@app.route('/detect', methods=['GET'])
def detect_motion():
    print("Collecting sensor data...")
    sensor_data = collect_sensor_data()
    sensor_data_scaled = preprocess_data(sensor_data)
    
    try:
        prediction = lstm_model.predict(sensor_data_scaled)
        motion_detected = prediction[0][0] > 0.5
    except Exception as e:
        print(f"Error during prediction: {e}")
        return jsonify({'error': 'Model prediction failed'}), 500
    
    GPIO.output(LED_PIN, GPIO.HIGH if motion_detected else GPIO.LOW)
    GPIO.output(BUZZER_PIN, GPIO.HIGH if motion_detected else GPIO.LOW)
    
    print(f"Intruder Detected: {motion_detected}")
    return jsonify({
        'motion_detected': bool(motion_detected),
        'temperature': 30.0,
        'humidity': 60.0
    })

if _name_ == '_main_':
    try:
        print("Starting Intruder Detection Server...")
        app.run(host='0.0.0.0', port=5000, debug=True)
    except KeyboardInterrupt:
        print("Shutting down server...")
    finally:
        GPIO.cleanup()
        print("GPIO cleaned up.")