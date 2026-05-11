#!/bin/bash
# Setup server script for LM Studio with Qwen3.6-35B-A3B-GGUF model

set -e # exit immediately if a command exits with a non-zero status

MODEL_PATH=/mnt/c/Users/Brett/.lmstudio/models/lmstudio-community/Qwen3.6-35B-A3B-GGUF/Qwen3.6-35B-A3B-Q8_0.gguf
MODEL_SPECULATIVE_DECODE_PATH=/mnt/c/Users/Brett/.lmstudio/models/lmstudio-community/Qwen3.5-0.8B-GGUF/Qwen3.5-0.8B-Q8_0.gguf
SERVER_PORT=1234
LOG_FILE="llama_server.log"

echo "Starting server... Logs being written to $LOG_FILE"

# The 2>&1 redirects stderr (where stats live) into stdout so they both go into the log file.
./build/bin/llama-server \
    -m "$MODEL_PATH" \
    -md "$MODEL_SPECULATIVE_DECODE_PATH" \
    -ngl 999 \
    --port "$SERVER_PORT" \
    --host 0.0.0.0 \
    -t 16 \
    -ub 1024 \
    -c 232144 \
    --no-warmup \
    --verbose 2>&1 | tee "$LOG_FILE"