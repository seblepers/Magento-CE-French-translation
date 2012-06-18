#!/bin/bash
tmpdir='./tmp'
emaildir='../emails'
extdir='../extension'

# Transformation des fichiers OmegaT (.po) en csv
./omegat-to-csv.sh

# Préparation des fichiers de l'extension
if [ -f $tmpdir/00-adminhtml-translate.csv ]
then
    mv $tmpdir/00-adminhtml-translate.csv $extdir/app/design/adminhtml/default/default/locale/fr_FR/translate.csv
fi
if [ -f $tmpdir/00-frontend-translate.csv ]
then
    mv $tmpdir/00-frontend-translate.csv $extdir/app/design/frontend/default/default/locale/fr_FR/translate.csv
fi
cp $tmpdir/*.csv $extdir/app/locale/fr_FR/
cp -R $emaildir/* $extdir/app/locale/fr_FR/template/email/

# Copie sur l'instance de test et vidage du cache
magentotest='../../../Dev/magento1700'
cp -R $extdir/* $magentotest/
rm -rf $magentotest/var/cache/*

