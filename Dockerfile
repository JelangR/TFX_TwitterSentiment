FROM tensorflow/serving:latest

# Salin model SavedModel ke direktori yang sesuai
COPY ./serving_model/twittersentiment-model /models/twittersentiment-model

# Salin konfigurasi Prometheus
COPY ./monitoring/prometheus.config /model_config/prometheus.config

# Set environment variables
ENV MODEL_NAME=twittersentiment-model
ENV MODEL_BASE_PATH=/models
ENV MONITORING_CONFIG=/model_config/prometheus.config
ENV PORT=8501

# Buat skrip entrypoint untuk menjalankan tensorflow_model_server dengan monitoring
RUN echo '#!/bin/bash\n\
tensorflow_model_server \\\n\
  --port=8500 \\\n\
  --rest_api_port=${PORT} \\\n\
  --rest_api_host=0.0.0.0 \\\n\
  --model_name=${MODEL_NAME} \\\n\
  --model_base_path=${MODEL_BASE_PATH}/${MODEL_NAME} \\\n\
  --monitoring_config_file=${MONITORING_CONFIG} \\\n\
  "$@"' > /usr/bin/tf_serving_entrypoint.sh && chmod +x /usr/bin/tf_serving_entrypoint.sh

# Gunakan skrip sebagai entrypoint
ENTRYPOINT ["/usr/bin/tf_serving_entrypoint.sh"]
