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

OUTPUT="$OUTPUTDIR"/$(basename "$INPUT" .$EXTENSION).html

cat "$INPUT" | \
  sed "s/\[\[\(.*\)\]\]/\[\1\]\(\1.html\)/g" | \
    "$PANDOC" -s --template bootstrap.html -f markdown -c "$CSSFILE" -o "$OUTPUT"
cp ~/.vim/bundle/vimwiki/autoload/vimwiki/style.css $OUTPUTDIR
