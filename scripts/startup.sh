#!/bin/bash

#
# Startup script for 'notebook'.
#
# Tong Zhang <zhangt@frib.msu.edu>
# 2017-12-06 10:31:02 AM EST
#

jupyter_params=()

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        *)
            # e.g.:
            # --NotebookApp.base_url="'tong/'"
            # --NotebookApp.token="'1234567'"
            # --NotebookApp.password="''"
            #
            jupyter_params+=("$1")
            jupyter_params+=("$2")
            shift
            ;;
    esac
    shift
done

jupyter notebook \
    "${jupyter_params[@]}" \
    --allow-root  \
    --notebook-dir=/phyapps
