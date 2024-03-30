#! /bin/bash

## E-GMD
CURRENT_DIR=$(pwd)

# 1. download E-GMD data and expand them

# 2. make lists that include train/valid/test split
mkdir -p $CURRENT_DIR/corpus/E-GMD/list
py -3.9 $CURRENT_DIR/corpus/make_list_e-gmd.py -i $CURRENT_DIR/corpus/E-GMD/e-gmd-v1.0.0/e-gmd-v1.0.0.csv -d_list $CURRENT_DIR/corpus/E-GMD/list

# 3. rename the files
mkdir -p $CURRENT_DIR/corpus/E-GMD/midi
mkdir -p $CURRENT_DIR/corpus/E-GMD/wav
py -3.9 $CURRENT_DIR/corpus/rename_e-gmd.py -d_i $CURRENT_DIR/corpus/E-GMD/e-gmd-v1.0.0 -d_o $CURRENT_DIR/corpus/E-GMD -d_list $CURRENT_DIR/corpus/E-GMD/list

# 4. convert wav to log-mel spectrogram
mkdir -p $CURRENT_DIR/corpus/E-GMD/feature
py -3.9 $CURRENT_DIR/corpus/conv_wav2fe.py -d_list $CURRENT_DIR/corpus/E-GMD/list -d_wav $CURRENT_DIR/corpus/E-GMD/wav -d_feature $CURRENT_DIR/corpus/E-GMD/feature -config $CURRENT_DIR/corpus/config.json

# 5. convert midi to note
mkdir -p $CURRENT_DIR/corpus/E-GMD/note
py -3.9 $CURRENT_DIR/corpus/conv_midi2note.py -d_list $CURRENT_DIR/corpus/E-GMD/list -d_midi $CURRENT_DIR/corpus/E-GMD/midi -d_note $CURRENT_DIR/corpus/E-GMD/note -config $CURRENT_DIR/corpus/config.json

# 6. convert note to label
mkdir -p $CURRENT_DIR/corpus/E-GMD/label
py -3.9 $CURRENT_DIR/corpus/conv_note2label.py -d_list $CURRENT_DIR/corpus/E-GMD/list -d_note $CURRENT_DIR/corpus/E-GMD/note -d_label $CURRENT_DIR/corpus/E-GMD/label -config $CURRENT_DIR/corpus/config.json

# 7. convert txt to reference for evaluation
mkdir -p $CURRENT_DIR/corpus/E-GMD/reference
py -3.9 $CURRENT_DIR/corpus/conv_note2ref.py -f_list $CURRENT_DIR/corpus/E-GMD/list/valid.list -d_note $CURRENT_DIR/corpus/E-GMD/note -d_ref $CURRENT_DIR/corpus/E-GMD/reference
py -3.9 $CURRENT_DIR/corpus/conv_note2ref.py -f_list $CURRENT_DIR/corpus/E-GMD/list/test.list -d_note $CURRENT_DIR/corpus/E-GMD/note -d_ref $CURRENT_DIR/corpus/E-GMD/reference

# 8. make dataset
mkdir -p $CURRENT_DIR/corpus/E-GMD/dataset
py -3.9 $CURRENT_DIR/corpus/make_dataset.py -f_config_in $CURRENT_DIR/corpus/config.json -f_config_out $CURRENT_DIR/corpus/E-GMD/dataset/config.json -d_dataset $CURRENT_DIR/corpus/E-GMD/dataset -d_list $CURRENT_DIR/corpus/E-GMD/list -d_feature $CURRENT_DIR/corpus/E-GMD/feature -d_label $CURRENT_DIR/corpus/E-GMD/label -n_div_train 4 -n_div_valid 1 -n_div_test 1
