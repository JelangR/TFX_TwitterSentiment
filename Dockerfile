FROM tensorflow/serving:latest

# Salin model SavedModel
COPY ./serving_model/twittersentiment-model /models/cc-model

# Tambahkan file konfigurasi monitoring
COPY monitoring_config.txt /config/monitoring_config.txt

# Tentukan nama model
ENV MODEL_NAME=cc-model

# Railway menggunakan variabel $PORT, jadi kita arahkan REST API ke sana
# dan aktifkan Prometheus endpoint
CMD tensorflow_model_server \
  --rest_api_port=$PORT \
  --rest_api_host=0.0.0.0 \
  --model_name=${MODEL_NAME} \
  --model_base_path=/models/${MODEL_NAME} \
  --monitoring_config_file=/config/monitoring_config.txt
