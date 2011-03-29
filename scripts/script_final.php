<?php
foreach (glob("*.po") as $csv) file_put_contents(str_replace(".po", "", $csv), str_replace('\\"', '""', str_replace('\\\\', '\\', trim(preg_replace("/[\r\n]+/", "\n", str_replace("[fuzzy] ", "", preg_replace('/(^|\n)[^"][^\n]*\n/', "\n", preg_replace(array("/s*\nmsgid /", "/s*\nmsgstr /"), array("\n", ","), file_get_contents($csv)))))))));

