
#!/bin/bash


function pairwise() {
    for f in $(echo "$1" | grep -o .); do
	for s in $(echo "$2" | grep -o .); do
	    echo -n $f$s"|"
	done
    done
}

valid=$(echo -n "(";pairwise $1 $2; pairwise $1 $3; pairwise $1 $4; pairwise $2 $1; pairwise $2 $3; pairwise $2 $4; pairwise $3 $1; pairwise $3 $2; pairwise $3 $4; pairwise $4 $1; pairwise $4 $2; pairwise $4 $3; echo "__)")

function pairs() {
    for (( i=0; i<${#1} - 1; i++ )); do
	echo "${word:$i:2}"
    done
}

function word_is_valid() {
    pairs=$(pairs $1)
    for p in $pairs; do	
	if [[ ! $p =~ $valid ]]; then
	    #echo puked on \! $p \=\~ $valid
	    return 1
	fi
    done
    return 0
}

candidates=$(
    for word in $(egrep -v [$(echo {a..z}| sed -e s/" "//g -e s/[$1$2$3$4]//g)] list.txt ); do 
	word_is_valid $word  && echo $word
    done
	  )
function normalize() {
  echo $1 | fold -w1 | sort -u | fmt | sed -e s/" "//g
}

for candidate in $candidates; do
    normal=$(normalize $candidate)
    if [ ${#candidate} = ${#normal} ]; then echo -n \#; else echo -n +; fi
    echo " "$candidate
done
