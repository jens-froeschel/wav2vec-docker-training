#!/bin/bash

image_name="wav2vec"
#The directory containing training data (for details see the README.md)
training_data_directory="${1:-$PWD/data/training_data}"
#wav2vec dir contains a model dir with the currently trained model and the manifest
wav2vec_directory="${2:-$PWD/data/wav2vec}"

container_name="${3:-wav2vec}"


#docker run -it --gpus all --shm-size="16g" --memory="32g" --memory-swap="32g" -v $PWD//training_data:/data/training_data/ wav2vec:latest /bin/bash
docker run -d --gpus all --shm-size="16g" --name "${container_name}" -v "${wav2vec_directory}:/data/wav2vec/" -v "${training_data_directory}:/data/training_data/" ${image_name} /data/scripts/train.sh

