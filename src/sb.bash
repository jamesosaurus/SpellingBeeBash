#!/bin/bash
egrep -v [$(echo {a..z}| sed -e s/" "//g -e s/[$1$2]//g)] wordlist.txt | grep $1 | egrep ....
