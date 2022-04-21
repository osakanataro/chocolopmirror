#!/usr/bin/perl

require 'config.pl';

$targetdir=$ARGV[0];
$sourcedir=$targetdir."_orig";

print $targetdir.":".$sourcedir."\n";
if((!-d $targetdir)||(!-d $sourcedir)){
    print "not directory found\n";
    exit;
}

opendir(DIR,$sourcedir);
while($file=readdir(DIR)){
    $inputfile= $sourcedir."/".$file;
    $outputfile= $targetdir."/".$file;
    if(-f $inputfile){
	print $inputfile."=> working \n";

	$skip=0;
	$oneskip=0;
	$formskip=0;
	open(INFILE,$inputfile);
	open(OUTFILE,">$outputfile");
	while($line=<INFILE>){
	    # questページの検索用に metaタグ og:titleを<title>に埋め込む
	    if($line =~ /meta property="og:title"/){
		$skip=0;
		$st=index($line,"『")+length("『");
		$ed=rindex($line,"』");
		$title=substr($line,$st,$ed-$st);
		$st=$ed+length("』");
		$ed=index($line,"\"",$st);
		$author=substr($line,$st,$ed-$st);
		print OUTFILE "<title>".$title."</title>\n";
		print OUTFILE "<meta name=\"author\" content=\"".$author."\">\n";
	    }
	    # コピーサイトであることを表示するものを挿入
	    if($line =~ /<\/body/){
		if($inputfile =~ /index\.html/){
		    # indexだけSJISなので英語にする
		    print OUTFILE "<div id=\"clcopysite\" lang=\"ja\" class=\"clcopysite\">Here is Mirror site.</div>\n";
		}else{
		    print OUTFILE "<div id=\"clcopysite\" lang=\"ja\" class=\"clcopysite\">ここはミラーサイトです</div>\n";
		}
		print OUTFILE <<EOF;
<style type="text/css">
.clcopysite{
  position: fixed;
  bottom: 0;
  left: 0;
  background: #fff;
}
</style>
EOF
		# アクセス解析
#		print OUTFILE <<EOF;
#<!-- Global site tag (gtag.js) - Google Analytics -->
#<script async src="https://www.googletagmanager.com/gtag/js?id=G-1XMZYKJR04"></script>
#<script>
#  window.dataLayer = window.dataLayer || [];
#  function gtag(){dataLayer.push(arguments);}
#  gtag('js', new Date());
#
#  gtag('config', 'G-1XMZYKJR04');
#</script>
#EOF
	    }

	    #
	    if(($line =~ /<li><a href="character_status\.php\?chara_code=/)&&($line =~ /">ステータスシート<\/a><\/li>/)){
		# 各ページのnavigationにあるステータスシートリンクの除去
		$line =~ s/chara_code=[a-zA-Z0-9]*/chara_code=/ig;
	    }elsif($line =~ /id="login_info"/){
		# ログイン情報枠の除去
		$skip=1;
	    }elsif(($line =~ /<table class="menu_aboutes">/)&&($skip==1)){
		# ログイン情報枠の代替を設置
		$skip=0;
		print OUTFILE <<EOF;
                        <div id="login_info">
                                <span><a href="character_status.php?chara_code="><img src="/img/default/default_ic.png"></a></span>

<br>下記よりログインしてください<br>
<br>
                        </div>
                        <div id="login_form">

<form method="post">
<img src="/img/menu/loginid.png">
<input type="text" name="mail" value="" style="margin-top:0px;width:95%;"><br>
<img src="/img/menu/pass.png">
<input type="password" name="pass" value="" style="margin-top:0px;width:95%;"><br>
<input type="submit" name="login_button" value="ログイン" class="button">
</form>

<br><a href="password_ask.php"><img src="/img/menu/pass2.png"></a>

                        </div>
<br>
<div align="center">
<a href="./member_entry.php"><img src="/img/menu/newid.png"><br>
<font size="2">新規ユーザー登録</font></a>


<a href="/page.php?p=story"><img src="/img/menu/story.png"></a>
                        <div class="menu_contents_title">
<img src="/img/menu/users_guid.png">
                        </div>
                        <div class="menu_contents">

EOF
	    }

	    $line=~s/http:\/\/manage.chocolop.net//ig;
	    $line=~s/http:\/\/cl2.chocolop.net//ig;

	    if($oneskip==1){
		$oneskip=0;
	    }elsif($skip==0){
		print OUTFILE $line;
	    }
	}
	close(INFILE);
	close(OUTFILE);
    }
}
closedir(DIR);

