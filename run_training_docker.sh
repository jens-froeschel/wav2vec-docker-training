#!/bin/bash

image_name="wav2vec"
#The directory containing training data (for details see the README.md)
training_data_directory="${1:-$PWD/data/training_data/}"
#wav2vec dir contains a model dir with the currently trained model and the manifest
wav2vec_directory="${2:-$PWD/data/wav2vec/}"
config_directory="${3:-$PWD/data/config/}"
container_name="${4:-wav2vec}"

#Run the Model Training Docker with Bash for Debugging
#docker run -it --gpus all --shm-size="16g" --name "${container_name}" -v "${wav2vec_directory}:/data/wav2vec/" -v "${training_data_directory}:/data/training_data/" -v "${config_directory}:/data/config/" ${image_name} /bin/bash

#Run the Model Training Docker
docker run -d --gpus all --shm-size="16g" --name "${container_name}" -v "${wav2vec_directory}:/data/wav2vec/" -v "${training_data_directory}:/data/training_data/" -v "${config_directory}:/data/config/" ${image_name} /data/scripts/train.sh
