#!/bin/bash -eu
#
_enc_str(){ echo -n "$@" | xxd -p; }
_dec_str(){ echo -n "$@" | xxd -p -r -; }
