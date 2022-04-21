#!/usr/bin/perl
#
# キャラクタごとのシナリオ参加履歴取得
# CL2ではログイン必須 (ログインキャラ情報がhtmlに含まれるので注意)
# キャラステータスを取得 perl getcharacter_status.pl quest_orig
# perl login.pl を実行
# そして perl getcharacter_scenario.pl character_status_orig
# perl getcharacter_scenario.pl scenario_record_orig
#
require 'config.pl';

#$debug=2;

$sourcedir=$ARGV[0];

if(!-d $sourcedir){
    print "directory not found\n";
    exit;
}

$charstatdir=$basedir."/scenario_record_orig";

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
		$st=index($line,"scenario_record\.php\?",$nextst);
		if($st>0){
		    $st=rindex($line,"\"",$st);
		    if($st>0){
			$st=$st+length("\"");
			$ed=index($line,"\"",$st);
			$nextst=$ed;
			$tmpurl=substr($line,$st,$ed-$st);
			if($tmpurl =~ /https:/){
			    $listurl=$tmpurl;
			}else{
			    $listurl="https://cl3.chocolop.net/".$tmpurl;
			}
			# キャラID検出
			$st=index($listurl,"chara_code=");
			if($st>0){
			    $st=$st+length("chara_code=");
			    $ed=index($listurl,"&",$st);
			    if($ed>0){
				$charid=substr($listurl,$st,$ed-$st);
			    }else{
				$charid=substr($listurl,$st);
			    }
			}else{
			    $charid=-1;
			}
			# page検出
			$st=index($listurl,"page=");
			if($st>0){
			    $st=$st+length("page=");
			    $ed=index($listurl,"&",$st);
			    if($ed>0){
				$page=substr($listurl,$st,$ed-$st);
			    }else{
				$page=substr($listurl,$st);
			    }
			}else{
			    $page=1;
			}
			# m検出
			$st=index($listurl,"m=");
			if($st>0){
			    $st=$st+length("m=");
			    $ed=index($listurl,"&",$st);
			    if($ed>0){
				$mode=substr($listurl,$st,$ed-$st);
			    }else{
				$mode=substr($listurl,$st);
			    }
			}else{
			    $mode=0;
			}
			#
			if($charid == -1){
			}else{
			    $outputfile=$charstatdir."/".$charid."-".$mode."-".$page.".html";
			    getfile($listurl,$outputfile);
			}
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
