#!/bin/bash

[ -f speech.env ] && . speech.env

echo "First startup may download 2GB of speech models. Please wait."

bash download_voices_tts-1.sh
bash download_voices_tts-1-hd.sh $PRELOAD_MODEL

cd wyoming-piper
script/run --piper '/usr/share/piper/piper' --voice en_US-lessac-medium --uri 'tcp://0.0.0.0:10200' --data-dir /data --download-dir /data &
cd ..

python speech.py ${PRELOAD_MODEL:+--preload $PRELOAD_MODEL} $EXTRA_ARGS $@
