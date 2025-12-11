import joblib
import tensorflow as tf
import numpy as np

model = joblib.load("clinical_mental_health_model.pkl")

X_sample = np.random.rand(100, 7)
y_sample = np.random.randint(0, 3, 100)

keras_model = tf.keras.Sequential([
    tf.keras.layers.Dense(64, activation='relu', input_shape=(7,)),
    tf.keras.layers.Dropout(0.3),
    tf.keras.layers.Dense(32, activation='relu'),
    tf.keras.layers.Dense(3, activation='softmax')
])

keras_model.compile(
    optimizer='adam',
    loss='sparse_categorical_crossentropy',
    metrics=['accuracy']
)

keras_model.fit(X_sample, y_sample, epochs=10, verbose=0)

converter = tf.lite.TFLiteConverter.from_keras_model(keras_model)
converter.optimizations = [tf.lite.Optimize.DEFAULT]
tflite_model = converter.convert()

with open('../app/assets/models/clinical_model.tflite', 'wb') as f:
    f.write(tflite_model)

print("✅ Modelo convertido para TensorFlow Lite!")