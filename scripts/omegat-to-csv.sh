#!/bin/bash
sourcedir='../OmegaT/source'
targetdir='../OmegaT/target'
tmpdir='./tmp'
pofilesext='.po'

cp $targetdir/*.po $tmpdir/
cd $tmpdir
php ../script_final.php

