FROM tensorflow/serving:latest

# Menyalin model ke direktori TensorFlow Serving
COPY serving_model/twittersentiment-model /models/cc-model

# Menentukan nama model yang akan dilayani
ENV MODEL_NAME=cc-model

# Port REST API TensorFlow Serving
EXPOSE 8501
