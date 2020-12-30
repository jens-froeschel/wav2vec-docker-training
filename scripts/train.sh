#!/bin/bash
# The training data directory contains the unsupervised training data in wav format
# The wav files are expected to be single chanelled, sampled at 16 kHz
training_data="/data/training_data/"
manifest_directory="/data/wav2vec/manifest/"
model_directory="/data/wav2vec/model/"
config_directory="/data/config/"
ammount_of_gpus=1


#Prepare Training Data Manifest
python3 /data/fairseq/examples/wav2vec/wav2vec_manifest.py "${training_data}" --dest ${manifest_directory} --ext wav --valid-percent 0.01

#The old way to train a wav2vec base model
#python3 /data/fairseq/train.py "${manifest_directory}" \
#--save-dir "${model_directory}" --fp16 --num-workers 1 --task audio_pretraining --criterion wav2vec --arch wav2vec2 \
#--log-keys '["prob_perplexity","code_perplexity","temp"]' --quantize-targets --extractor-mode default \
#--conv-feature-layers '[(512, 10, 5)] + [(512, 3, 2)] * 4 + [(512,2,2)] * 2' --final-dim 256 --latent-vars 320 \
#--latent-groups 2 --latent-temp '(2,0.5,0.999995)' --infonce --optimizer adam \
#--adam-betas '(0.9,0.98)' --adam-eps 1e-06 --lr-scheduler polynomial_decay --total-num-update 400000 \
#--lr 0.0005 --warmup-updates 32000 --mask-length 10 --mask-prob 0.65 --mask-selection static --mask-other 0 \
#--encoder-layerdrop 0.05 --dropout-input 0.1 --dropout-features 0.1 --feature-grad-mult 0.1 \
#--loss-weights '[0.1, 10]' --conv-pos 128 --conv-pos-groups 16 --num-negatives 100 --cross-sample-negatives 0 \
#--max-sample-size 250000 --min-sample-size 32000 --dropout 0.1 --attention-dropout 0.1 --weight-decay 0.01 \
#--max-tokens 1400000 --max-update 400000 --skip-invalid-size-inputs-valid-test --ddp-backend no_c10d


#Training a new wav2vec 2.0 base model
mkdir -p "${model_directory}"
pushd "${model_directory}"
update_frequency=$((64/ammount_of_gpus))
echo "GPUs: $ammount_of_gpus  Update Frequency: $update_frequency"
fairseq-hydra-train task.data="${manifest_directory}" distributed_training.distributed_world_size="${ammount_of_gpus}" optimization.update_freq="[${update_frequency}]" --config-dir "${config_directory}" --config-name pretraining
popd
