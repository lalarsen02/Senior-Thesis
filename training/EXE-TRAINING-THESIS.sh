#! /bin/bash

## E-GMD
CURRENT_DIR=$(pwd)

FILE_CONFIG=${CURRENT_DIR}/corpus/E-GMD/dataset/config.json
DIR_DATASET=${CURRENT_DIR}/corpus/E-GMD/dataset

DIR_CHECKPOINT=${CURRENT_DIR}/checkpoint/E-GMD
mkdir -p $DIR_CHECKPOINT
py -3.9 ${CURRENT_DIR}/training/m_training.py -config $FILE_CONFIG -d_out $DIR_CHECKPOINT -d_dataset $DIR_DATASET -n_div_train 4 -n_div_valid 1 -n_div_test 1 -epoch 20 -batch 2 -n_slice 16 -weight_A 1.0 -cnn_channel 2 -cnn_kernel 5
