#!/usr/bin/bash

/usr/local/bin/estcmd gather -cl -il ja -sd casket3-quest ./quest
mv casket-quest casket-quest.t
mv casket3-quest casket-quest
rm -rf casket-quest.t


