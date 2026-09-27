SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE=${SOURCE:-${SCRIPT_DIR}/list.txt}
echo $SOURCE

SED_COMMANDS=""
WLD_COMMANDS=""
for (( i=0; i<${#1}; i++ )); do
    char=${1:$i:1}
    if [ $char == "." ]; then
        char=\[a-z\]
        WLD_COMMANDS=$WLD_COMMANDS" | sed -e s/[A-Z]//"1
    else
        SED_COMMANDS=$SED_COMMANDS" | sed -e s/${char^}//"1
    fi

done

SED_COMMANDS=${SED_COMMANDS}${WLD_COMMANDS}"| grep __"

echo $SED_COMMANDS


#(for word in $(echo paste \<\(cat ${SOURCE} \| sed -e s/\^// -e s/\$//\) \<\(cat ${SOURCE} \| tr [a-z] [A-Z]\) $SED_COMMANDS| bash |sed -e s/__"      "// | tr [A-Z] [a-z]); do
#    echo $(echo -n $word| wc -c)${word}
#done)| sort -n

(while read -r line; do
    echo _${#line}_${line^^}_${line}_
done < $SOURCE) | bash -c "cat $SED_COMMANDS"| sort | sort -n

