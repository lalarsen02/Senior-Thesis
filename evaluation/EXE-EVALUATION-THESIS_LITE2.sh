#! /bin/bash
CURRENT_DIR=$(pwd)

FILE_LIST=$CURRENT_DIR/corpus/MAESTRO_LITE/list/$2.list
FILE_CONFIG=$CURRENT_DIR/corpus/MAESTRO_LITE/dataset/config.json
DIR_FEATURE=$CURRENT_DIR/corpus/MAESTRO_LITE/feature
DIR_REFERENCE=$CURRENT_DIR/corpus/MAESTRO_LITE/reference

DIR_CHECKPOINT=$CURRENT_DIR/checkpoint/MAESTRO_LITE

DIR_RESULT=$CURRENT_DIR/result/MAESTRO_LITE
mkdir -p $DIR_RESULT

# 2FDT/1FLT
# MODE=combination
# OUTPUT=2nd
# 1FDN
MODE=combination
OUTPUT=2nd

# inference
py -3.9 $CURRENT_DIR/evaluation/m_inference.py -f_list $FILE_LIST -f_config $FILE_CONFIG -d_cp $DIR_CHECKPOINT -m $1 -d_fe $DIR_FEATURE -d_mpe $DIR_RESULT -d_note $DIR_RESULT -calc_transcript -mode $MODE -thred_mpe 0.5 -thred_onset 0.5 -thred_offset 0.5

# mir_eval
py -3.9 $CURRENT_DIR/evaluation/m_transcription.py -f_list $FILE_LIST -d_ref $DIR_REFERENCE -d_est $DIR_RESULT -d_out $DIR_RESULT -output $OUTPUT
py -3.9 $CURRENT_DIR/evaluation/m_transcription.py -f_list $FILE_LIST -d_ref $DIR_REFERENCE -d_est $DIR_RESULT -d_out $DIR_RESULT -output $OUTPUT -velocity
py -3.9 $CURRENT_DIR/evaluation/m_mpe.py -f_config $FILE_CONFIG -f_list $FILE_LIST -d_ref $DIR_REFERENCE -d_est $DIR_RESULT -d_out $DIR_RESULT -output $OUTPUT -thred_mpe 0.5
