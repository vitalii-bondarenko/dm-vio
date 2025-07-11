#!/bin/bash
set -e
DATA_DIR=${1:-/workspace/datasets/MH_01_easy}
SEQUENCE_PATH="$DATA_DIR/MH_01_easy"
if [ ! -d "$SEQUENCE_PATH" ]; then
    echo "Dataset not found at $SEQUENCE_PATH" >&2
    exit 1
fi
cd /workspace/dm-vio/build
./dmvio_dataset \
    files=$SEQUENCE_PATH/mav0/cam0/data \
    vignette=$SEQUENCE_PATH/mav0/cam0/vignette.png \
    imuFile=$SEQUENCE_PATH/mav0/imu0/data.csv \
    gtFile=$SEQUENCE_PATH/mav0/state_groundtruth_estimate0/data.csv \
    tsFile=$SEQUENCE_PATH/mav0/cam0/data.csv \
    calib=../configs/tumvi_calib/camera02.txt \
    gamma=../configs/tumvi_calib/pcalib.txt \
    imuCalib=../configs/tumvi_calib/camchain.yaml \
    mode=0 use16Bit=1 preset=0 nogui=1 \
    resultsPrefix=/workspace/results/ \
    settingsFile=../configs/tumvi.yaml

