#!/usr/bin/perl
# クエストのファイルのタイムスタンプを
#  公開の日付に設定するためのスクリプト

require 'config.pl';
use Time::Local;

$targetdir=$basedir."/quest";

opendir(DIR,$targetdir);
while($file=readdir(DIR)){
    $inputfile= $targetdir."/".$file;
    if(-f $inputfile){
	if($inputfile =~ /\.html/){
	    open(FILE,"$inputfile");
	    while($line=<FILE>){
		if($line =~ /公開日<br>/){
		    $st=index($line,"年");
		    $st=rindex($line,">",$st)+length(">");
		    $ed=index($line,"<",$st);
		    $date=substr($line,$st,$ed-$st);
		    #print $date."\n";
		    $ed=index($date,"年");
		    $year=substr($date,0,$ed);
		    $st=$ed+length("年");
		    $ed=index($date,"月",$st);
		    $month=substr($date,$st,$ed-$st);
		    $st=$ed+length("月");
		    $ed=index($date,"日",$st);
		    $day=substr($date,$st,$ed-$st);
		    #$tmp=$year."-".$month."-".$day."T00:00:00";
		    $tmp=timelocal("00","00","00",$day,$month-1,$year);
		    print $tmp."\n";
		    utime $tmp,$tmp,$inputfile;
		}
	    }
	    close(FILE);
	}
    }
}
closedir(DIR);
