#!/bin/perl

#$debug=2;

require 'config.pl';

for($i=1;$i<=30;$i++){
    $storyurl="http://cl2.chocolop.net/quest.php\?page=".$i."&msu=1";
    $outputfile=$basedir."/questlist_orig/msu-".$i.".html";
    getfile($storyurl,$outputfile);
}



