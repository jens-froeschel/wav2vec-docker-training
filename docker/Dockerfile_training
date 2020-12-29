FROM nvidia/cuda:10.2-base

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && \
    apt-get install -y apt-utils && \
    apt-get install -y git && \
    apt-get install -y python3 && \
    apt-get install -y python3-pip && \
    apt-get install -y vim && \
    apt-get install -y libsndfile1



#Install pip packages
#Torch is installed with cuda gpu support
RUN pip3 install pyarrow && \
    pip3 install soundfile && \
    pip3 install torch torchvision

#Install torch (pytorch) without gpu support
#RUN pip3 install torch==1.6.0+cpu torchvision==0.7.0+cpu -f https://download.pytorch.org/whl/torch_stable.html


#Install Fairseq
RUN git clone https://github.com/pytorch/fairseq.git /data/fairseq
WORKDIR /data/fairseq
RUN pip3 install --editable ./


#Install NCCL
COPY  nccl-repo.deb /data/nccl-install.deb
RUN dpkg -i /data/nccl-install.deb


#Install NVIDIA Apex (For faster Training)
#RUN git clone https://github.com/NVIDIA/apex /data/apex
#WORKDIR /data/apex
#RUN pip3 install -v --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" \
#  --global-option="--deprecated_fused_adam" --global-option="--xentropy" \
#  --global-option="--fast_multihead_attn" ./

#Copy Scripts into the Docker Image
COPY scripts /data/scripts/
RUN chmod +x /data/scripts/*

#Install Soundfile
RUN mkdir -p /data/wav2vec/model/
RUN mkdir -p /data/wav2vec/manifest/

WORKDIR /data/
