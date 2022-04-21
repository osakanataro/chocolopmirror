#!/usr/bin/perl
#
# アトリエ取得
# いらますごとのアトリエ取得
#   いらます一覧取得 perl getsingle.pl
#   次にいらます毎のページ perl getatrie-master.pl single_orig
#   perl getatrie-galary.pl atrie_vcprsheet_orig
#   最後に複数ページがある人用に追加 perl getatrie-galary.pl atrie_galary_orig
# キャラごとのアトリエ取得
#   まずキャラステータスを取得 perl getcharacter_status.pl quest_orig
#   次に perl getatrie-galary.pl character_status_orig
#   最後に複数ページがある人用に追加 perl getatrie-galary.pl atrie_galary_orig
#
require 'config.pl';

#$debug=2;

$sourcedir=$ARGV[0];

if(!-d $sourcedir){
    print "directory not found\n";
    exit;
}

$outputdir=$basedir."/atrie_galary_orig";

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
		$st=index($line,"atrie_galary\.php\?",$nextst);
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
			$charid="";
			$st=index($listurl,"ch=");
			if($st>0){
			    $st=$st+length("ch=");
			    $ed=index($listurl,"&",$st);
			    if($ed>0){
				$charid=substr($listurl,$st,$ed-$st);
			    }else{
				$charid=substr($listurl,$st);
			    }
			}else{
			    $charid="all";
			}
			# page検出
			$page=1;
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
			# view検出
			$view="";
			$st=index($listurl,"view=");
			if($st>0){
			    $st=$st+length("view=");
			    $ed=index($listurl,"&",$st);
			    if($ed>0){
				$view=substr($listurl,$st,$ed-$st);
			    }else{
				$view=substr($listurl,$st);
			    }
			}else{
			    $view="detail";
			}
			# vc検出
			$vc=-1;
			$st=index($listurl,"vc=");
			if($st>0){
			    $st=$st+length("vc=");
			    $ed=index($listurl,"&",$st);
			    if($ed>0){
				$vc=substr($listurl,$st,$ed-$st);
			    }else{
				$vc=substr($listurl,$st);
			    }
			}else{
			    $vc="-1";
			}
			# t検出
			$type="";
			$st=index($listurl,"t=");
			if($st>0){
			    $st=$st+length("t=");
			    $ed=index($listurl,"&",$st);
			    if($ed>0){
				$type=substr($listurl,$st,$ed-$st);
			    }else{
				$type=substr($listurl,$st);
			    }
			}else{
			    $type="0";
			}
			# it検出
			$st=index($listurl,"it=");
			if($st>0){
			    $st=$st+length("it=");
			    $ed=index($listurl,"&",$st);
			    if($ed>0){
				$type=substr($listurl,$st,$ed-$st);
			    }else{
				$type=substr($listurl,$st);
			    }
			    if($type==""){
				$type="0";
			    }
			}
			# lc
			$lc=-1;
			$st=index($listurl,"lc=");
			if($st>0){
			    $st=$st+length("lc=");
			    $ed=index($listurl,"&",$st);
			    if($ed>0){
				$lc=substr($listurl,$st,$ed-$st);
			    }else{
				$lc=substr($listurl,$st);
			    }
			    if($lc==""){
				$lc="-1";
			    }
			}
			# li
			$li=-1;
			$st=index($listurl,"li=");
			if($st>0){
			    $st=$st+length("li=");
			    $ed=index($listurl,"&",$st);
			    if($ed>0){
				$li=substr($listurl,$st,$ed-$st);
			    }else{
				$li=substr($listurl,$st);
			    }
			    if($li==""){
				$li="-1";
			    }
			}
			#

			if($debug>0){ print " charid=".$charid." view=".$view." type=".$type." vc=".$vc." page=".$page." lc=".$lc." li=".$li."\n"; }
			if($lc ne "-1"){
			    $outputfile=$outputdir."/lc-".$lc."-".$type."-".$view."-".$li.".html";
			}elsif($vc eq "-1"){
			    $outputfile=$outputdir."/".$charid."-".$view."-".$page.".html";
			}else{
			    $outputfile=$outputdir."/vc-".$vc."-".$type."-".$view."-".$page.".html";
			}

			if($listurl =~ /\?p=/){
			}else{
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
