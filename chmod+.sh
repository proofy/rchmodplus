#!/bin/bash
#
#@(#) rhmod+ V0.6
#
# shell script zum Aendern der Dateirechte
#
# Autor: Sven Joerns

# $# Anzahl der Uebergabeparameter
([ $# != 2 ]) && \
{ echo "Call Convention: $0 file-permission-mode directory-permission-mode\n Example: $0 664 775"; exit 1; }
# 
# aendert die zugriffsatribute der files und directories rekursiv in allen  
# Unerverzeichnissen vom aktuellen Verzeichnis aus
OPTION_FILE=$1
OPTION_DIR=$2
ORG_IFS=$IFS
IFS='
'
function rfchmod
{
        # ls -1 = in einer Spalte, b =quoted
        # leider wird nicht ` und andere Zeichen mit -b gequoted -> Fehler

        for i in `ls -1`     
        do
                if [ ! -d $i ]
                then

                        echo "$i wird mit $OPTION_FILE veraendert"
                        eval chmod '$OPTION_FILE $i'
                else
                        echo "$1 wird mit $OPTION_DIR veraendert"
                        chmod $OPTION_DIR $i
                        echo " ... wechsel ins Verzeichnis $i"
                        eval cd '$i' || break
                        rfchmod
                        cd ..
                fi

        done
        return 0
}
rfchmod

IFS=$ORG_IFS
