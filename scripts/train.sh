#!/bin/bash
# The training data directory contains the unsupervised training data in wav format
# The wav files are expected to be single chanelled, sampled at 16 kHz
training_data="/data/training_data/"
manifest_path="/data/wav2vec/manifest/"
model_path="/data/wav2vec/model/"



#Prepare Training Data Manifest
python3 /data/fairseq/examples/wav2vec/wav2vec_manifest.py "${training_data}" --dest ${manifest_path} --ext wav --valid-percent 0.01

#Training a new wav2vec base model
python3 /data/fairseq/train.py "${manifest_path}" \
--save-dir "${model_path}" --fp16 --num-workers 1 --task audio_pretraining --criterion wav2vec --arch wav2vec2 \
--log-keys '["prob_perplexity","code_perplexity","temp"]' --quantize-targets --extractor-mode default \
--conv-feature-layers '[(512, 10, 5)] + [(512, 3, 2)] * 4 + [(512,2,2)] * 2' --final-dim 256 --latent-vars 320 \
--latent-groups 2 --latent-temp '(2,0.5,0.999995)' --infonce --optimizer adam \
--adam-betas '(0.9,0.98)' --adam-eps 1e-06 --lr-scheduler polynomial_decay --total-num-update 400000 \
--lr 0.0005 --warmup-updates 32000 --mask-length 10 --mask-prob 0.65 --mask-selection static --mask-other 0 \
--encoder-layerdrop 0.05 --dropout-input 0.1 --dropout-features 0.1 --feature-grad-mult 0.1 \
--loss-weights '[0.1, 10]' --conv-pos 128 --conv-pos-groups 16 --num-negatives 100 --cross-sample-negatives 0 \
--max-sample-size 250000 --min-sample-size 32000 --dropout 0.1 --attention-dropout 0.1 --weight-decay 0.01 \
--max-tokens 1400000 --max-update 400000 --skip-invalid-size-inputs-valid-test --ddp-backend no_c10d


