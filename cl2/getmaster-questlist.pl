#!/usr/bin/perl
#
# マスターのシナリオ一覧
# CL2ではログイン必須 (ログインキャラ情報がhtmlに含まれるので注意)
# まず perl getmaster.pl でマスターページを取得した後に
# perl login.pl を実行
# perl getmaster-questlist.pl 

require 'config.pl';

#$debug=2;

$sourcedir=$basedir."/bfroom_stprsheet_orig";
$charstatdir=$basedir."/questlist_orig";

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
		$st=index($line,"questlist\.php\?",$nextst);
		if($st>0){
		    $st=rindex($line,"\"",$st);
		    if($st>0){
			$st=$st+length("\"");
			$ed=index($line,"\"",$st);
			$nextst=$ed;
			$tmpurl=substr($line,$st,$ed-$st);
			if($tmpurl =~ /http:/){
			    $charurl=$tmpurl;
			}else{
			    $charurl="http://cl2.chocolop.net/".$tmpurl;
			}
			#print "curl $charurl\n";
			
			# マスターID検出
			$st=index($charurl,"st=")+length("st=");
			$ed=index($charurl,"&",$st);
			if($ed>0){
			    $charid=substr($charurl,$st,$ed-$st);
			}else{
			    $charid=substr($charurl,$st);
			}
			# msu検出
			$st=index($charurl,"msu=");
			if($st>0){
			    $st=$st+length("msu=");
			    $ed=index($charurl,"&",$st);
			    if($ed>0){
				$msu=substr($charurl,$st,$ed-$st);
			    }else{
				$msu=substr($charurl,$st);
			    }
			}else{
			    $msu=0;
			}
			$outputfile=$charstatdir."/".$charid."-".$msu.".html";
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
