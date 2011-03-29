#!/bin/bash
sourcedir='../OmegaT/source'
targetdir='../OmegaT/target'
tmpdir='./tmp'
pofilesext='.po'

cp $targetdir/*.po $tmpdir/
cd $tmpdir
php ../script_final.php

cp *.csv ../../extension/app/locale/fr_FR/

# Copie sur l'instance de test et vidage du cache
magentotest='../../../../Dev/magento1501'
cp *.csv $magentotest/app/locale/fr_FR/
rm -rf $magentotest/var/cache/*

