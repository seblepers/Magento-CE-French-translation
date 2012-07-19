<?php
/*
Tool to convert translated csv file to translation memory (TMX)
*/

$dest_lang = 'FR';
$src = 'all.csv';

$src_list = array();
$f_src = fopen($src,"r");
while($r = fgetcsv($f_src,1000)) {
    $src_list[(string)$r[0]] = $r[1];
}
fclose($f_src);
$f_out = fopen('all.tmx','w');
$str = <<<EOT
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE tmx SYSTEM "tmx11.dtd">
<tmx version="1.1">
  <header
    creationtool="OmegaT"
    creationtoolversion="1.7.3_1"
    segtype="sentence"
    o-tmf="OmegaT TMX"
    adminlang="EN-US"
    srclang="EN"
    datatype="plaintext"
  >
  </header>
  <body>
EOT;

fwrite($f_out,$str);
reset($src_list);
while(list($k,$v)=each($src_list)) {
    $k = strip_tags($k); 
    $v = strip_tags($v);
    $str = <<<EOT
    <tu>
      <tuv lang="EN">
        <seg><![CDATA[$k]]></seg>
      </tuv>
      <tuv lang="$dest_lang">
        <seg><![CDATA[$v]]></seg>
      </tuv>
    </tu>
EOT;

    fwrite($f_out,$str . "\n");
}
$str = "</body>\n</tmx>";
fwrite($f_out,$str);
fclose($f_out);

