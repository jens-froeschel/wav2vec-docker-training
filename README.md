# Wav2vec Docker Images

The goal of this Project is to provide an easy to use Implementation for Training and Evaluating wav2vec 2.0 Models.
The Implementations will be provided as multiple Docker Images. 

The Docker Images are not yet provided on dockerhub and must therefore be build manually.

## Requirements
* NVIDIA GPU
* Docker
* NVIDIA Docker

### Testsed on
* Docker with GPU support in WSL2 


## Training a wav2vec Base Model
Provide unsupervised Training Data in the directory /data/unsupervised/
The data must be in the form of single channelled, 16 kHz wav files.

1. Build the Docker Image for the Model Training

```shell script
bash build_training_docker.sh 
```
2. Provide the training data in a subdirectory "data/training_data/"
3. Run the training
```shell script
bash run_training_docker.sh 
```
For the logs of the training run
```shell script
docker logs --follow wav2vec
```

To stop the training
```shell script
docker stop wav2vec
```

To cleanup the training docker image
```shell script
docker rm wav2vec 
```

