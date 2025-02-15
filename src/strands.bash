function normalize() {

  echo $1 | fold -w1 | sort | fmt | sed -e s/" "//g

}

 

target=$(normalize $1)

#echo $n

 

for word in $(egrep -v [$(echo {a..z}| sed  -e s/" "//g -e s/[$1]//g)] list.txt); do
    if [ "$(normalize $word)" == "$target" ]; then echo $word; fi
done
