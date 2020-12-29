# Wav2vec Docker Images

The goal of this Project is to provide an easy to use Implementation for Training and Evaluating wav2vec 2.0 Models.
The Implementations will be provided as multiple Docker Images. 

The Docker Images are not yet provided on dockerhub and must therefore be build manually.

## Requirements
* NVIDIA GPU
* Docker
* NVIDIA Docker

### Testsed on
* Docker with GPU support in WSL2 on a single NVIDIA GeForce GTX 1060


## Training a wav2vec Base Model
Provide unsupervised Training Data in the directory "$PWD/data/training_data/"
The training data must be in the form of single channelled, 16 kHz wav files.

The training is set to use 1 GPU. To change the ammount of GPUs change the parameter in scripts/train.sh (Warning:untestet)
The training uses the default wav2vec2_base_librispeech.yaml as configuration (https://github.com/pytorch/fairseq/blob/master/examples/wav2vec/config/pretraining/wav2vec2_base_librispeech.yaml)
The configuration can be changed in data/config/pretraining.yaml

* Build the Docker Image for the Model Training
```shell script
bash build_training_docker.sh 
```
* Provide the training data in a subdirectory "data/training_data/"
* Run the training
```shell script
bash run_training_docker.sh 
```
* For the logs of the training run
```shell script
docker logs --follow wav2vec
```
* To stop the training
```shell script
docker stop wav2vec
```
* To cleanup the training docker image
```shell script
docker rm wav2vec 
```


