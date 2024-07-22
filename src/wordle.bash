#!bash

echo $(echo -n grep  ^$1\$ list.txt \| egrep -v \[_$2\]; for item in ${@:3} ; do echo -n  \| grep $item; done) | bash



