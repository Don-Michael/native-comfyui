FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=1

WORKDIR /app

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    wget \
    ffmpeg \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    && rm -rf /var/lib/apt/lists/*

RUN ln -sf /usr/bin/python3 /usr/bin/python

RUN pip install --upgrade pip && \
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

RUN git clone https://github.com/comfyanonymous/ComfyUI.git /app/ComfyUI

WORKDIR /app/ComfyUI

RUN if [ -f requirements.txt ]; then pip install -r requirements.txt; fi

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8188