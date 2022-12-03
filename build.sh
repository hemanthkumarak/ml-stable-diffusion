#!/bin/bash
set -xeo pipefail

build() {
  local model_version
  model_version="$1"
  local dest
  dest="$2"
  mkdir -p build
  python -m python_coreml_stable_diffusion.torch2coreml \
    --convert-unet --convert-text-encoder --convert-vae-decoder --convert-safety-checker \
    --model-version "$model_version" \
    --bundle-resources-for-swift-cli \
    --chunk-unet \
    -o "./build/$dest"
}

build stabilityai/stable-diffusion-2-base sd2-base
build CompVis/stable-diffusion-v1-4       sd1.4
build runwayml/stable-diffusion-v1-5      sd1.5
