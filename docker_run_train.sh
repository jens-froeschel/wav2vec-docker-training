#!/bin/bash

IMAGE_NAME="wav2vec"

#docker run -it --gpus all --shm-size="16g" --memory="32g" --memory-swap="32g" -v $PWD//training_data:/data/training_data/ wav2vec:latest /bin/bash
docker run -d --gpus all --shm-size="16g" -v $PWD/data:/data/wav2vec/ -v $PWD/training_data:/data/training_data/ ${IMAGE_NAME} /data/scripts/train.sh

