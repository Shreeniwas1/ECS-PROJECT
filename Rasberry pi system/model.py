This is for training ml model
import numpy as np
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import LSTM, Dense
from tensorflow.keras.optimizers import Adam
from sklearn.preprocessing import StandardScaler
import joblib


def generate_synthetic_data(num_samples, sequence_length, num_features):
    X = np.random.rand(num_samples, sequence_length, num_features)
    y = np.random.randint(0, 2, num_samples)
    return X, y


def preprocess_data(X):
    scaler = StandardScaler()
    num_samples, sequence_length, num_features = X.shape
    X_reshaped = X.reshape(-1, num_features)
    X_scaled = scaler.fit_transform(X_reshaped)
    X_scaled = X_scaled.reshape(num_samples, sequence_length, num_features)
    return X_scaled, scaler

def build_lstm_model(sequence_length, num_features):
    model = Sequential([
        LSTM(64, input_shape=(sequence_length, num_features)),
        Dense(32, activation='relu'),
        Dense(1, activation='sigmoid')
    ])
    model.compile(optimizer=Adam(learning_rate=0.001), loss='binary_crossentropy', metrics=['accuracy'])
    return model

def main():

    sequence_length = 10
    num_features = 1
    num_samples = 1000
    epochs = 10
    batch_size = 32


    X, y = generate_synthetic_data(num_samples, sequence_length, num_features)
    X_scaled, scaler = preprocess_data(X)


    lstm_model = build_lstm_model(sequence_length, num_features)
    lstm_model.fit(X_scaled, y, epochs=epochs, batch_size=batch_size, validation_split=0.1)


    lstm_model.save('lstm_model.h5')
    joblib.dump(scaler, 'scaler.pkl')
    print("saved")

if _name_ == "_main_":
    main()