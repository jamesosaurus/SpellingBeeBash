
SOURCE=${SOURCE:-list.txt}
#echo $SOURCE

sedc=""
for (( i=0; i<${#1}; i++ )); do
    char=${1:$i:1}
    if [ $char == "." ]; then
	char=\[a-z\]
	fi
    sedc=$sedc" | sed -e s/$char//"1
done

sedc=$sedc"| grep __"

(for word in $(echo paste \<\(cat ${SOURCE} \| sed -e s/\^/_/ -e s/\$/_/\) \<\(cat ${SOURCE} \| tr [a-z] [A-Z]\) $sedc| bash |sed -e s/__"	"// | tr [A-Z] [a-z]); do
    echo $(echo $word | wc -c) $word
done)| sort -n
