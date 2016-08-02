#!/bin/bash

echo "Loading functions"

lsl () {
    ls --color=always -C $* | less -r
}

cl () {
   if [ $# = 0 ]; then
      cd && ll
   else
      cd "$*" && ll
   fi
}


list () {
     if [ -f "$1" ] ; then
         case "$1" in
             *.tar.bz2)   tar tjf "$1"        ;;
             *.tar.gz)    tar tzf "$1"     ;;
             *.bz2)       bunzip2 -t "$1"       ;;
             *.rar)       rar l "$1"     ;;
             *.gz)        gunzip "$1"     ;;
             *.tar)       tar tf "$1"        ;;
             *.tbz2)      tar tjf "$1"      ;;
             *.tgz)       tar tzf "$1"       ;;
             *.war)       unzip -l "$1"     ;;
             *.zip)       unzip -l "$1"     ;;
             *.Z)         uncompress -l "$1"  ;;
             *.7z)        7z l "$1"    ;;
             *.jar)       jar -tf "$1"    ;;
             *)           echo "'$1' cannot be listed via list()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}


extract () {
     if [ -f "$1" ] ; then
         case "$1" in
             *.tar.bz2)   tar xjf "$1"        ;;
             *.tar.gz)    tar xzf "$1"     ;;
             *.bz2)       bunzip2 "$1"       ;;
             *.rar)       rar x "$1"     ;;
             *.gz)        gunzip "$1"     ;;
             *.tar)       tar xf "$1"        ;;
             *.tbz2)      tar xjf "$1"      ;;
             *.tgz)       tar xzf "$1"       ;;
             *.war)       unzip "$1"     ;;
             *.zip)       unzip "$1"     ;;
             *.Z)         uncompress "$1"  ;;
             *.7z)        7z x "$1"    ;;
             *.jar)       jar -xf "$1"    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

archive () {
     if [ -e "$1" ] ; then
         tarName="$(date +%F)-$(basename $1).tar.gz"
		i=1
		while [ -e "$tarName" ]
		do
			tarName="$(date +%F)-$1-$i.tar.gz"
			i=$[$i+1]
		done
		echo "tar -czf $tarName $1"
		tar -czf "$tarName" "$1"
     else
         echo "'$1' is not a valid file"
     fi
}

netinfo (){
    echo "--------------- Network Information ---------------"
    /sbin/ifconfig | awk /'inet addr/ {print $2}'
    /sbin/ifconfig | awk /'Bcast/ {print $3}'
    /sbin/ifconfig | awk /'inet addr/ {print $4}'
    /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
    echo "---------------------------------------------------"
}

#dirsize - finds directory sizes and lists them for the current directory
dirsize (){
    du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
    egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
    egrep '^ *[0-9.]*M' /tmp/list
    egrep '^ *[0-9.]*G' /tmp/list
    rm -rf /tmp/list
}

fn (){ 
    find . -iname $@ -print; 
}

fngrep (){ 
    find . -iname $1 -exec grep -iH '{}' $2; 
}

nf () {
    pwd="$(pwd)";
    folder="$( basename ${pwd})";
    nextFolder="$( ls -l .. | grep -A 1 " ${folder}" | tail -n1 | awk '{print $8}' )" ;
    cd ../${nextFolder} ;
}

pf () {
    pwd="$(pwd)";
    folder="$( basename ${pwd})";
    nextFolder="$( ls -l .. | grep -B 1 " ${folder}" | head -n1 | awk '{print $8}' )" ;
    cd ../${nextFolder} ;
}

svnlog (){
    LIMIT=10
    if [ -n "$1" ]; then
        LIMIT=$1
    fi
    svn log -l ${LIMIT} | awk 'BEGIN{ line=""} !/^\S*$/ {if ($0 ~ /------/ ) {if(line !~ /$\S*^/ ) print line; getline; line=$0; }else{if($0) line=line ", " $0;} }'
}

rarsplit (){
    if [ -f "$1" ]; then
        rar a -m0 -V750M "/tmp/$1.rar" "$1"
    fi
}
