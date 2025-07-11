#!/bin/bash
set -e
DATA_DIR=${1:-/workspace/datasets}
mkdir -p "$DATA_DIR"
SEQUENCE=MH_01_easy
URL="https://rpg.ifi.uzh.ch/datasets/davis/$SEQUENCE.zip"
ZIP_FILE="$DATA_DIR/$SEQUENCE.zip"
if [ ! -f "$ZIP_FILE" ]; then
    echo "Downloading $SEQUENCE dataset..."
    wget -O "$ZIP_FILE" "$URL"
    echo "Unpacking..."
    unzip "$ZIP_FILE" -d "$DATA_DIR/$SEQUENCE"
fi

