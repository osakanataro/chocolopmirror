#!/usr/bin/perl
#
# いらますごとのアトリエ参加履歴取得
# perl getatrie-master.pl single_orig
#
require 'config.pl';

#$debug=2;

$sourcedir=$ARGV[0];

if(!-d $sourcedir){
    print "directory not found\n";
    exit;
}

$outputdir=$basedir."/atrie_vcprsheet_orig";

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
		$st=index($line,"atrie_vcprsheet\.php\?",$nextst);
		if($st>0){
		    $st=rindex($line,"\"",$st);
		    if($st>0){
			$st=$st+length("\"");
			$ed=index($line,"\"",$st);
			$nextst=$ed;
			$tmpurl=substr($line,$st,$ed-$st);
			if($tmpurl =~ /http:/){
			    $listurl=$tmpurl;
			}else{
			    $listurl="http://cl2.chocolop.net/".$tmpurl;
			}
			# マスターID検出
			$st=index($listurl,"id=");
			if($st>0){
			    $st=$st+length("id=");
			    $ed=index($listurl,"&",$st);
			    if($ed>0){
				$charid=substr($listurl,$st,$ed-$st);
			    }else{
				$charid=substr($listurl,$st);
			    }
			}else{
			    $charid=-1;
			}

			$outputfile=$outputdir."/".$charid.".html";
			if($charid == -1){
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
