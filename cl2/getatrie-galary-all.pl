#!/bin/perl
#
# アトリエ全一覧ページ取得
#

require 'config.pl';
#$debug=2;

$outputdir=$basedir."/atrie_galary_orig";

for($i=1;$i<=531;$i++){
    $filename=$outputdir."/all-"."detail"."-".$i.".html";
    $url="http://cl2.chocolop.net/atrie_galary.php?page=".$i."&view=detail";
    getfile($url,$filename);
}

for($i=1;$i<=531;$i++){
    $filename=$outputdir."/all-"."detail2"."-".$i.".html";
    $url="http://cl2.chocolop.net/atrie_galary.php?page=".$i."&view=detail2";
    getfile($url,$filename);
}

for($i=1;$i<=177;$i++){
    $filename=$outputdir."/all-"."list"."-".$i.".html";
    $url="http://cl2.chocolop.net/atrie_galary.php?page=".$i."&view=list";
    getfile($url,$filename);
}

