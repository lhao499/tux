#! /bin/bash

export SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export PROJECT_DIR="$( cd -- "$( dirname -- "$SCRIPT_DIR" )" &> /dev/null && pwd )"
cd $PROJECT_DIR
export PYTHONPATH="$PYTHONPATH:$PROJECT_DIR"

python3 -m scripts.cls_head_jax \
    --load_llama_config 7b \
    --update_llama_config="dict(max_sequence_length=32,scan_attention=False,scan_query_chunk_size=8,scan_key_chunk_size=8,remat_attention='nothing_saveable',scan_mlp=False,scan_mlp_chunk_size=8,remat_mlp='nothing_saveable',remat_block='nothing_saveable',scan_layers=True,attention_type='blockwise')" \
    --load_checkpoint "params::$HOME/openllamav2_7b_jax_streaming_scan" \
    --output_dir "$HOME/openllamav2_7b_jax_streaming_scan_cls" \
|& tee $HOME/output.txt


read
