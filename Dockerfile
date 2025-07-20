# Start from base ComfyUI worker image
FROM runpod/worker-comfyui:5.1.0-base AS base

# Install custom nodes using comfy-cli
RUN comfy-node-install \
    comfyui-kjnodes \
    comfyui-ic-light \
    comfyui_ipadapter_plus \
    comfyui_essentials \
    ComfyUI-Hangover-Nodes

# Download standard models
RUN comfy model download --url https://huggingface.co/KamCastle/jugg/resolve/main/juggernaut_reborn.safetensors \
    --relative-path models/checkpoints \
    --filename juggernaut_reborn.safetensors

RUN comfy model download --url https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-plus_sd15.bin \
    --relative-path models/ipadapter \
    --filename ip-adapter-plus_sd15.bin

RUN comfy model download --url https://huggingface.co/shiertier/clip_vision/resolve/main/SD15/model.safetensors \
    --relative-path models/clip_vision \
    --filename models.safetensors

RUN comfy model download --url https://huggingface.co/lllyasviel/ic-light/resolve/main/iclight_sd15_fcon.safetensors \
    --relative-path models/diffusion_models \
    --filename iclight_sd15_fcon.safetensors

# Download Flux1-Dev-FP8 model
RUN mkdir -p /comfyui/models/checkpoints && \
    wget -q -O /comfyui/models/checkpoints/flux1-dev-fp8.safetensors \
    https://huggingface.co/Comfy-Org/flux1-dev/resolve/main/flux1-dev-fp8.safetensors

# Optional: Copy local static input files into the ComfyUI input directory
# Uncomment if you have an 'input/' folder next to your Dockerfile
# COPY input/ /comfyui/input/
