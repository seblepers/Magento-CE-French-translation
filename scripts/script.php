<?php
/*
Tool to convert source language files to PO files
*/

$src_csv = 'source.csv';
$src     = 'source';

$dir = scandir($src_csv);
for($i=0;$i<count($dir);$i++) {
    if(is_file($src_csv . '/' . $dir[$i])) {
        $src_list = array();
        $f_src = fopen($src_csv . '/' . $dir[$i],"r");
        while($r = fgetcsv($f_src,1000)) {
            $src_list[(string)$r[0]] = $r[1];
        }
        fclose($f_src);
        $f_out = fopen($src . '/' . $dir[$i] . '.po','w');
        reset($src_list);
        while(list($k,$v)=each($src_list)) {
            $k = str_replace('"','"',$k);
            $v = str_replace('"','"',$v);
//            if ($v === $k) {
//                $v = '';
//            }
            $str = "#: $k\nmsgid \"$k\"\nmsgstr \"$v\"\n\n";
            fwrite($f_out,$str);
        }
        fclose($f_out);
    }
}
