#!/bin/bash
newversiondir='../new-version'
sourcedir='../OmegaT/source'
targetdir='../OmegaT/target'
pofilesext='.po'
backupdir='./backups'

backupfilename="source-target-`date +%Y%m%d-%H%M%S`.tar.gz"
tar -cvzf "$backupdir/$backupfilename" $sourcedir $targetdir

rm -f $sourcedir/*
ls -alph $sourcedir/
cp $targetdir/* $sourcedir/
ls -alph $sourcedir/

for csvfilename in `cd $newversiondir; ls *.csv;`
do
    csvfile="$newversiondir/$csvfilename";
    pofilename="$csvfilename$pofilesext";
    echo "**** $csvfile ****";

    sed 's/^"\(.*\)"\s*,\s*".*"$/\1/' < $csvfile | while read line
    do
        line=`echo "$line" | sed 's/""/\\\"/g'`;
        escapedline=`echo "$line" | sed 's/\\\\/\\\\\\\\/g' | sed 's/\\*/\\\\*/g' | sed 's/\\]/\\\\]/g' | sed 's/\\[/\\\\[/g'`
        searchresult=`grep "msgid\s*\"$escapedline\"" "$sourcedir/$pofilename"`;

        if [ "$searchresult" = "" ]
        then
            echo "Cette chaîne n'existe pas dans le fichier $pofilename : $line";

            echo "#: $line" >> "$sourcedir/$pofilename";
            echo "msgid \"$line\"" >> "$sourcedir/$pofilename";
            echo "msgstr \"\"" >> "$sourcedir/$pofilename";
            echo "" >> "$sourcedir/$pofilename";

        fi
    done

done

