#!/usr/bin/perl

require 'config.pl';

#$debug=2;

$sourcedir=$ARGV[0];

if(!-d $sourcedir){
    print "directory not found\n";
    exit;
}

$imagedir=$basedir."/images";
$imgbasedir=$basedir;

opendir(DIR,$sourcedir);
while($file=readdir(DIR)){
    $inputfile= $sourcedir."/".$file;
    if(-f $inputfile){
	print $inputfile."=> working\n";

	$skip=0;
	$oneskip=0;
	open(INFILE,$inputfile);
	while($line=<INFILE>){
	    $nextst=0;
	    $flag=1;
	    while($flag==1){
		$st=index($line,"<IMG ",$nextst);
		$st2=index($line,"<img ",$nextst);
		$st3=index($line,"images.php",$nextst);

		if(($st>=0)&&($st2>=0)){
		    if($st<$st2){
			$st=$st;
		    }else{
			$st=$st2;
		    }
		}elsif(($st<0)&&($st2<0)){
		    $st=-1;
		}elsif(($st<0)&&($st2>=0)){
		    $st=$st2;
		}
		# a href=image.php がある場合
		if(($st3>0)&&(($st3<$st)||($st<0))){
		    $st=rindex($line,"\"",$st3)-1;
		}

		if($st>=0){
		    $st=index($line,"\"",$st)+length("\"");
		    $ed=index($line,"\"",$st);
		    $nextst=$ed;
		    $tmpurl=substr($line,$st,$ed-$st);
		    if($tmpurl=~/changeImg/){
			# JavaScript処理のやつはスキップ
		    }else{
			if($tmpurl =~ /http/){
			    $imageurl=$tmpurl;
			}else{
			    $imageurl="https://cl3.chocolop.net/".$tmpurl;
			}
			if($imageurl =~ /images\.php/){
			    # t
			    $st=index($imageurl,"t=");
			    if($st>0){
				$st=$st+length("t=");
				$ed=index($imageurl,"&",$st);
				if($ed>0){
				    $typenum=substr($imageurl,$st,$ed-$st);
				}else{
				    $typenum=substr($imageurl,$st);
				}
			    }else{
				$typenum=-1;
			    }
			    # gi=2 しかなく動作上いらないようなので切り捨て?
			    #  と思ったら、?t=vc_pr_banner2_cl2&i=&gi=2 というiもi2も無い場合があるので
			    # ファイル名生成で利用
			    # CL3だとgi=3もあって、どうやらシリーズ番号を表している可能性
			    $st=index($imageurl,"gi=");
			    if($st>0){
				$st=$st+length("gi=");
				$ed=index($imageurl,"&",$st);
				if($ed>0){
				    $gi=substr($imageurl,$st,$ed-$st);
				}else{
				    $gi=substr($imageurl,$st);
				}
			    }else{
				$gi=-1;
			    }
			    # i
			    $st=index($imageurl,"i=");
			    if($st>0){
				$st=$st+length("i=");
				$ed=index($imageurl,"&",$st);
				if($ed>0){
				    $imnum=substr($imageurl,$st,$ed-$st);
				}else{
				    $imnum=substr($imageurl,$st);
				}
			    }else{
				$imnum=-1;
			    }
			    # i2
			    $st=index($imageurl,"i2=");
			    if($st>0){
				$st=$st+length("i2=");
				$ed=index($imageurl,"&",$st);
				if($ed>0){
				    $imnum2=substr($imageurl,$st,$ed-$st);
				}else{
				    $imnum2=substr($imageurl,$st);
				}
			    }else{
				$imnum2=-1;
			    }
			    #
			    if($debug>0){ print " t=".$typenum." i=".$imnum." i2=".$imnum2." gi=".$gi."\n";	}
			    # ファイル名処理
			    if(($gi==2)&&($imnum==-1)&($imnum2==-1)){
				# ?t=vc_pr_banner2_cl2&i=&gi=2 の特例処理
				$outputfile=$imagedir."/".$typenum."/"."0.png";
			    }elsif(($imnum2==-1)&&($imnum==-1)){
				$outputfile=$imagedir."/".$typenum."-2"."/".$imnum2.".png";
			    }elsif(($imnum2!=-1)&&($imnum==-1)){
				$outputfile=$imagedir."/".$typenum."-2"."/".$imnum2.".png";
			    }elsif($imnum2!=-1){
				$outputfile=$imagedir."/".$typenum."-".$imnum2."/".$imnum.".png";
			    }else{
				$outputfile=$imagedir."/".$typenum."/".$imnum.".png";
			    }
			}elsif($imageurl=~ /img\//){
			    $st=index($imageurl,"img/");
			    $tmpfile=substr($imageurl,$st);
			    $outputfile=$imgbasedir."/".$tmpfile;
			}
			getfile($imageurl,$outputfile);
		    }
		}else{
		    $flag=0;
		}
	    }
	}
    }
    close(INFILE);
}
closedir(DIR);

