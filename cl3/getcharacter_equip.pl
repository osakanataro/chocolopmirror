#!/usr/bin/perl
#
# キャラクタのステータスシートの装備品
#

require 'config.pl';

#$debug=2;

$sourcedir=$ARGV[0];

if(!-d $sourcedir){
    print "directory not found\n";
    exit;
}

$charstatdir=$basedir."/equip_list_orig";

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
		$st=index($line,"equip_list\.php\?",$nextst);
		if($st>0){
		    $st=rindex($line,"\"",$st);
		    if($st>0){
			$st=$st+length("\"");
			$ed=index($line,"\"",$st);
			$nextst=$ed;
			$tmpurl=substr($line,$st,$ed-$st);
			if($tmpurl =~ /https:/){
			    $charurl=$tmpurl;
			}else{
			    $charurl="https://cl3.chocolop.net/".$tmpurl;
			}
			#print "curl $charurl\n";
			$charurl =~ s/\'//ig;
			$charurl =~ s/location\.href=\.//ig;

			# chara_code
			$st=index($charurl,"chara_code=");
			if($st>0){
			    $st=$st+length("chara_code=");
			    $ed=index($charurl,"&",$st);
			    if($ed>0){
				$charid=substr($charurl,$st,$ed-$st);
			    }else{
				$charid=substr($charurl,$st);
			    }
			    $outputfile=$charstatdir."/".$charid.".html";
			    getfile($charurl,$outputfile);
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
