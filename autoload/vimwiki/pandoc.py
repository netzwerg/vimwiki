#!/usr/bin/env python

#
# Uses http://johnmacfarlane.net/pandoc to convert vimwiki markdown to html
#
# Configure in g:vimwiki_list: 'custom_wiki2html': 'vimwiki/autoload/vimwiki/pandoc.py'
#
# (Must be executable)
#

import sys, os.path, subprocess, re, tempfile, shutil

output_dirname = sys.argv[4]
input_filename = sys.argv[5]
css_filename = sys.argv[6]
input_basename = os.path.splitext(os.path.basename(input_filename))[0]
diary_title = input_basename if ("diary" in input_filename) else ""
output_filename = output_dirname + input_basename + ".html"

# Replace vimwiki links with markdown links
polished_input_file = tempfile.NamedTemporaryFile(delete=False, suffix=".md")
replaced_links = [re.sub(r"\[\[(.*)\]\]", r"[\g<1>](\g<1>.html)", line) for line in open(input_filename)]
with polished_input_file as f:
    f.write("\r".join(replaced_links))
polished_input_file.close()

pandoc_input = polished_input_file.name

# Prepare call to pandoc executable
options = ['pandoc', pandoc_input, '--output=' + output_filename]
options += ['--standalone', '--from=markdown', '--template=bootstrap.html', '--css=' + css_filename]
options += ['--variable=diaryTitle:' + diary_title]
subprocess.check_call(options)

# Copy CSS (same folder as this script) to html output dir
pwd = os.path.dirname(os.path.realpath(__file__))
shutil.copy(pwd + "/style.css", output_dirname)