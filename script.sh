#!/bin/bash

SITE=$1;
LEVEL=$2;
REJECT="css,js,jpg,jpeg,png,mp4,flv,swf,gif";  
USER_AGENT="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0";
TMP_OUTPUT="./tmp_output";
OUTPUT="./output"

# Download HTML files
wget --execute robots=off --reject "$REJECT" --directory-prefix=$TMP_OUTPUT/ --no-directories --recursive --level $LEVEL --user-agent "$USER_AGENT" "$SITE"

# Extract mp4 URLS
grep -orh "http://.*mp4[/,\"}]" $TMP_OUTPUT --exclude mp4_files.txt >> $TMP_OUTPUT/mp4_files.txt

# Download mp4's
wget -i $TMP_OUTPUT/mp4_files.txt --directory-prefix=$OUTPUT/

# Rename mp4's
count=0;
for f in $TMP_OUTPUT/*; do mv "$f" $TMP_OUTPUT/"$count.mp4"; count=`expr $count + 1`; done
