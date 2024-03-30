#! /bin/bash

## MAESTRO v3.0.0
CURRENT_DIR=$(pwd)

# 1. download MAESTRO v3.0.0 data and expand them
# $ ($CURRENT_DIR/corpus/MAESTRO_LITE/maestro-v3.0.0)

# 2. make lists that include train/valid/test split
mkdir -p $CURRENT_DIR/corpus/MAESTRO_LITE/list
py -3.9 $CURRENT_DIR/corpus/make_list_maestro.py -i $CURRENT_DIR/corpus/MAESTRO_LITE/maestro-v3.0.0/maestro-v3.0.0.csv -d_list $CURRENT_DIR/corpus/MAESTRO_LITE/list

# 3. rename the files
mkdir -p $CURRENT_DIR/corpus/MAESTRO_LITE/midi
mkdir -p $CURRENT_DIR/corpus/MAESTRO_LITE/wav
py -3.9 $CURRENT_DIR/corpus/rename_maestro.py -d_i $CURRENT_DIR/corpus/MAESTRO_LITE/maestro-v3.0.0 -d_o $CURRENT_DIR/corpus/MAESTRO_LITE -d_list $CURRENT_DIR/corpus/MAESTRO_LITE/list

# 4. convert wav to log-mel spectrogram
mkdir -p $CURRENT_DIR/corpus/MAESTRO_LITE/feature
py -3.9 $CURRENT_DIR/corpus/conv_wav2fe.py -d_list $CURRENT_DIR/corpus/MAESTRO_LITE/list -d_wav $CURRENT_DIR/corpus/MAESTRO_LITE/wav -d_feature $CURRENT_DIR/corpus/MAESTRO_LITE/feature -config $CURRENT_DIR/corpus/config.json

# 5. convert midi to note
mkdir -p $CURRENT_DIR/corpus/MAESTRO_LITE/note
py -3.9 $CURRENT_DIR/corpus/conv_midi2note.py -d_list $CURRENT_DIR/corpus/MAESTRO_LITE/list -d_midi $CURRENT_DIR/corpus/MAESTRO_LITE/midi -d_note $CURRENT_DIR/corpus/MAESTRO_LITE/note -config $CURRENT_DIR/corpus/config.json

# 6. convert note to label
mkdir -p $CURRENT_DIR/corpus/MAESTRO_LITE/label
py -3.9 $CURRENT_DIR/corpus/conv_note2label.py -d_list $CURRENT_DIR/corpus/MAESTRO_LITE/list -d_note $CURRENT_DIR/corpus/MAESTRO_LITE/note -d_label $CURRENT_DIR/corpus/MAESTRO_LITE/label -config $CURRENT_DIR/corpus/config.json

# 7. convert txt to reference for evaluation
mkdir -p $CURRENT_DIR/corpus/MAESTRO_LITE/reference
py -3.9 $CURRENT_DIR/corpus/conv_note2ref.py -f_list $CURRENT_DIR/corpus/MAESTRO_LITE/list/train.list -d_note $CURRENT_DIR/corpus/MAESTRO_LITE/note -d_ref $CURRENT_DIR/corpus/MAESTRO_LITE/reference
py -3.9 $CURRENT_DIR/corpus/conv_note2ref.py -f_list $CURRENT_DIR/corpus/MAESTRO_LITE/list/valid.list -d_note $CURRENT_DIR/corpus/MAESTRO_LITE/note -d_ref $CURRENT_DIR/corpus/MAESTRO_LITE/reference
py -3.9 $CURRENT_DIR/corpus/conv_note2ref.py -f_list $CURRENT_DIR/corpus/MAESTRO_LITE/list/test.list -d_note $CURRENT_DIR/corpus/MAESTRO_LITE/note -d_ref $CURRENT_DIR/corpus/MAESTRO_LITE/reference

# 8. make dataset
mkdir -p $CURRENT_DIR/corpus/MAESTRO_LITE/dataset
py -3.9 $CURRENT_DIR/corpus/make_dataset.py -f_config_in $CURRENT_DIR/corpus/config.json -f_config_out $CURRENT_DIR/corpus/MAESTRO_LITE/dataset/config.json -d_dataset $CURRENT_DIR/corpus/MAESTRO_LITE/dataset -d_list $CURRENT_DIR/corpus/MAESTRO_LITE/list -d_feature $CURRENT_DIR/corpus/MAESTRO_LITE/feature -d_label $CURRENT_DIR/corpus/MAESTRO_LITE/label -n_div_train 4 -n_div_valid 1 -n_div_test 1
