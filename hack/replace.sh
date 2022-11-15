#!/bin/bash
#

f=$(cat $1 | grep -E FROM'(\s[a-z\./0-9:A-Z-]*)*') 


# should be only 2 instances
echo -e "INFO: ${f}"
# echo -e "INFO: {$from[1]}"
