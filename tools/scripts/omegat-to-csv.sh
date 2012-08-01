#!/bin/bash
sourcedir='../../source'
targetdir='../../target'
tmpdir='./tmp'
pofilesext='.po'

cp $targetdir/*.po $tmpdir/
cd $tmpdir
php ../script_final.php

