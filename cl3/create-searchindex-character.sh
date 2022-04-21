#!/usr/bin/bash

/usr/local/bin/estcmd gather -cl -il ja -sd casket-char3 ./character_status
mv casket-char casket-char.t
mv casket-char3 casket-char
rm -rf casket-char.t

