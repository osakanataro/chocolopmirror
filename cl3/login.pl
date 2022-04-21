#!/bin/perl
#
# サイトにログインする場合はコレを最初に実行します
#
require 'config.pl';

$ret=system("curl","-F","mail=".$loginuser,"-F","pass=".$loginpass,"-F","login_button=ログイン","https://cl3.chocolop.net/top.php","--cookie-jar",$cookienew,"-s","-o","test1.txt");
