#!/usr/bin/perl
#
# quest.php を取得する
# まずは getsingle.pl で取ってきた単独ページを起点として取得していく
#

require 'config.pl';

#$debug=2;

$sourcedir=$ARGV[0];

if(!-d $sourcedir){
    print "not direcotry found\n";
    exit;
}

$outputdir=$basedir."/quest_orig";

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
		$st=index($line,"quest\.php\?",$nextst);
		if($st>0){
		    $st=rindex($line,"\"",$st);
		    if($st>0){
			$st=$st+length("\"");
			$ed=index($line,"\"",$st);
			$nextst=$ed;
			$tmpurl=substr($line,$st,$ed-$st);
			if($tmpurl =~ /http/){
			    $url=$tmpurl;
			}else{
			    $url="https://cl3.chocolop.net/".$tmpurl;
			}

			# qid
			$st=index($url,"qid=");
			if($st>0){
			    $st=$st+length("qid=");
			    $ed=index($url,"\&");
			    if($ed>0){
				$qid=substr($url,$st,$ed-$st);
			    }else{
				$qid=substr($url,$st);
			    }
			}else{
			    $qid=-1;
			}
			# msu
			$st=index($url,"msu=");
			if($st>0){
			    $st=$st+length("msu=");
			    $ed=index($url,"\&");
			    if($ed>0){
				$msu=substr($url,$st,$ed-$st);
			    }else{
				$msu=substr($url,$st);
			    }
			}else{
			    $msu=-1;
			}
			# page
			$st=index($url,"page=");
			if($st>0){
			    $st=$st+length("page=");
			    $ed=index($url,"\&");
			    if($ed>0){
				$page=substr($url,$st,$ed-$st);
			    }else{
				$page=substr($url,$st);
			    }
			}else{
			    $page=-1;
			}
			#
			if($qid!=-1){
			    $outputfile=$outputdir."/".$qid.".html";
			    #
			    getfile($url,$outputfile);
			}
		    }else{
			# quest.php が登場したけど、""で区切られていない場合
			$nextst=$nextst+1;
		    }
		}else{
		    # これ以上quest.phpがない場合
		    $flag=0;
		}
	    }
	}
	close(INFILE);
    }
}
closedir(DIR);
