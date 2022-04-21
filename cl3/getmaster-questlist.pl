#!/usr/bin/perl
#
# マスターのシナリオ一覧
# CL2ではログイン必須 (ログインキャラ情報がhtmlに含まれるので注意)
# CL3はログイン不要
# まず perl getmaster.pl でマスターページを取得した後に
# perl login.pl を実行
# perl getmaster-questlist.pl bfroom_stprsheet_orig
# perl getmaster-questlist.pl questlist_orig


require 'config.pl';

#$debug=2;

$sourcedir=$ARGV[0];

if(!-d $sourcedir){
    print "directory not found\n";
    exit;
}

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
			if($tmpurl =~ /http/){
			    $charurl=$tmpurl;
			}else{
			    $charurl="https://cl3.chocolop.net/".$tmpurl;
			}
			#print "curl $charurl\n";

			# #listがついてる場合の除去
			$charurl=~ s/#list//ig;

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
			# page検出
			$st=index($charurl,"page=");
			if($st>0){
			    $st=$st+length("page=");
			    $ed=index($charurl,"&",$st);
			    if($ed>0){
				$page=substr($charurl,$st,$ed-$st);
			    }else{
				$page=substr($charurl,$st);
			    }
			}else{
			    $page=1;
			}
			#

			$outputfile=$charstatdir."/".$charid."-".$msu."-".$page.".html";
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
