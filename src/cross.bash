
function words () {
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  SOURCE=${SOURCE:-${SCRIPT_DIR}/list.txt}
  #echo $SOURCE
  
  if [ $# == 2 ]; then
      REQ=$2
  else
      REQ="."
  fi
  
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
  
  grep -e $REQ $SOURCE | (while read -r line; do
      echo _${#line}_${line^^}_${line}_
  done ) | bash -c "cat $SED_COMMANDS | sort | sort -n"  
}


case $# in 
    1)
        words $1
        ;;
    2)
        words $1$2 $2
        ;;
    3)
        words $1$2 $2 | grep $3
        ;;
esac

