#!/bin/bash

#
# This script converts gitit's into html, to be used with vimwiki's
# "customwiki2html" option.
#
# To use this script, you must have the Pandoc installed.
#
#   http://johnmacfarlane.net/pandoc/
#
# To verify your installation, check that the commands pandoc,
# is on your path.
#
# Also verify that this file is executable.

PANDOC=pandoc

FORCE="$1"
EXTENSION="$3"
OUTPUTDIR="$4"
INPUT="$5"
CSSFILE="$6"

FORCEFLAG=

[ $FORCE -eq 0 ] || { FORCEFLAG="-f"; };

OUTPUT="$OUTPUTDIR"/$(basename "$INPUT" .$EXTENSION).html

VALID_CHARS='[^][\\]'  # ']' must be the first character in the '[...]' or '[^...]
PROTOCOLS='\(https:\/\/\|http:\/\/\|www.\|ftp:\/\/\|file:\/\/\|mailto:\)'
SED_CMD1="s/\[\($VALID_CHARS\+\)\](\($VALID_CHARS\+\))/[\1](\2.html)/g"
SED_CMD2="s/\[\($VALID_CHARS\+\)\](\($PROTOCOLS\($VALID_CHARS\)\+\).html)/[\1](\2)/g"
SED_CMD3="s/\[\($VALID_CHARS\+\)\]()/[\1](\1.html)/g"

cat "$INPUT" | \
    sed "$SED_CMD1; $SED_CMD2; $SED_CMD3;" |
    "$PANDOC" -s --template bootstrap.html -f markdown -c "$CSSFILE" -o "$OUTPUT"
cp ~/.vim/bundle/vimwiki/autoload/vimwiki/style.css $OUTPUTDIR
