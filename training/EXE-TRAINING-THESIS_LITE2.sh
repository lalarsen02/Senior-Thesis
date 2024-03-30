#! /bin/bash

## E-MAESTRO_LITE
CURRENT_DIR=$(pwd)

FILE_CONFIG=${CURRENT_DIR}/corpus/MAESTRO_LITE/dataset/config.json
DIR_DATASET=${CURRENT_DIR}/corpus/MAESTRO_LITE/dataset

DIR_CHECKPOINT=${CURRENT_DIR}/checkpoint/MAESTRO_LITE
mkdir -p $DIR_CHECKPOINT
py -3.9 ${CURRENT_DIR}/training/m_training.py -config $FILE_CONFIG -d_out $DIR_CHECKPOINT -d_dataset $DIR_DATASET -n_div_train 4 -n_div_valid 0 -n_div_test 1 -epoch 20 -batch 1 -n_slice 16 -weight_A 1.0 -enc_layer 3 -dec_layer 3
 