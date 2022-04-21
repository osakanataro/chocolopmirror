#!/usr/bin/perl
#
# page.php を取得する
# まずは getsingle.pl で取ってきた単独ページを起点として取得していく
#   perl getpages.pl single_orig
#   perl getpages.pl page_orig
#  page_origに対しては3回以上実施する
#

require 'config.pl';

#$debug=2;

$sourcedir=$ARGV[0];

if(!-d $sourcedir){
    print "not direcotry found\n";
    exit;
}

$outputdir=$basedir."/page_orig";

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
		$st=index($line,"page\.php\?",$nextst);
		if($st>0){
		    $st=rindex($line,"\"",$st);
		    if($st<0){
			# CL3のtop.phpで "がない事例が発生
			$ed=index($line,"\"",$nextst);
		    }else{
			$st=$st+length("\"");
			$ed=index($line,"\"",$st);
		    }
		    $nextst=$ed;
		    $tmpurl=substr($line,$st,$ed-$st);
		    if($tmpurl =~ /http/){
			$url=$tmpurl;
		    }else{
			$url="https://cl3.chocolop.net/".$tmpurl;
		    }

		    $st=index($url,"p=");
		    if($st>0){
			$st=$st+length("p=");
			$ed=index($url,"#");
			if($ed>0){
			    $pageid=substr($url,$st,$ed-$st);
			}else{
			    $pageid=substr($url,$st);
			}
			$outputfile=$outputdir."/".$pageid.".html";
			if($debug>0){ print "  ".$url." ".$pageid." -> ".$outputfile."\n"}
			if(!-f $outputfile){
			    getfile($url,$outputfile);
			}
		    }
		}else{
		    # これ以上page.phpがない場合
		    $flag=0;
		}
	    }
	}
	close(INFILE);
    }
}
closedir(DIR);
