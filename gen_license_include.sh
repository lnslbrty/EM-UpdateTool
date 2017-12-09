#!/bin/sh

set -e

LICENSE="$(dirname $0)/COPYING"
OUTFILE="$(dirname $0)/src/license.h"

echo "$(basename $0): generating ${OUTFILE} from ${LICENSE}"

echo -n >${OUTFILE}
echo '/*' >>${OUTFILE}
echo " * File: ${OUTFILE}" >>${OUTFILE}
echo " * Generated by: $(basename $0) [user: $(id -nu)]" >>${OUTFILE}
echo ' *' >>${OUTFILE}
echo " * Autogenerated license pre-processor macro from ${LICENSE}" >>${OUTFILE}
echo ' * Remember to use std::wstring instead of std::string' >>${OUTFILE}
echo ' *   for ALL_LICENSES (contains non-ASCII characters).' >>${OUTFILE}
echo ' */' >>${OUTFILE}
echo '#ifndef LICENSE_H' >>${OUTFILE}
echo '#define LICENSE_H 1' >>${OUTFILE}
echo "\n" >>${OUTFILE}
echo '#define ALL_LICENSES  \' >>${OUTFILE}
# first sed will escape all existing double quotes
# second sed will C-ify the text
cat "${LICENSE}" | sed 's/\"/\\"/g' | sed 's/\(.*\)/L\"\1\\n\" \\/g' >>${OUTFILE}
echo 'L""' >>${OUTFILE}
echo "\n" >>${OUTFILE}
echo '#endif'  >>${OUTFILE}
