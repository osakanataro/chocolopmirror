#!/usr/bin/perl
#
# マスターの紹介ページ取得
# まず起点は bfroom_stlist.php とするため下記の順序で実行する
#  perl getsingle.pl
#  perl getmaster.pl single_orig
# シナリオ一覧にもあるので
#  perl getquestlist.pl
#  perl getmaster.pl questlist_orig
# また、id=91 は 2016vtwdss023 にのみ登場したので
#  perl getmaster.pl page_orig

require 'config.pl';

#$debug=2;

$sourcedir=$ARGV[0];
if(!-d $sourcedir){
    print "directory not found\n";
    exit;
}

$charstatdir=$basedir."/bfroom_stprsheet_orig";

opendir(DIR,$sourcedir);
while($file=readdir(DIR)){
    $inputfile= $sourcedir."/".$file;
    if(-f $inputfile){
	print $inputfile."=> working \n";

	$skip=0;
	$oneskip=0;
	open(INFILE,$inputfile);
	while($line=<INFILE>){
	    $flag=1;
	    $nextst=0;
	    while($flag==1){
		$st=index($line,"bfroom_stprsheet\.php\?",$nextst);
		if($st>0){
		    $st=rindex($line,"\"",$st);
		    if($st>0){
			$st=$st+length("\"");
			$ed=index($line,"\"",$st);
			$nextst=$ed;
			$tmpurl=substr($line,$st,$ed-$st);
			if($tmpurl =~ /http/){
			    $charurl=$tmpurl;
			}else{
			    $charurl="https://cl3.chocolop.net/".$tmpurl;
			}
			$st=index($charurl,"id=")+length("id=");
			$charid=substr($charurl,$st);
			$outputfile=$charstatdir."/".$charid.".html";
			getfile($charurl,$outputfile);

		    }else{
			$flag=0;
		    }
		}else{
		    $flag=0;
		}
	    }
	}
	close(INFILE);
    }
}
closedir(DIR);
