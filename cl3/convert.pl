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
	    if(($line =~ /meta property="og:title"/)&&($inputfile =~ /quest\//)){
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
#		print OUTFILE <<EOF;
#<!-- Global site tag (gtag.js) - Google Analytics -->
#<script async src="https://www.googletagmanager.com/gtag/js?id=G-Y3TWFXZPW2"></script>
#<script>
#  window.dataLayer = window.dataLayer || [];
#  function gtag(){dataLayer.push(arguments);}
#  gtag('js', new Date());
#
#  gtag('config', 'G-Y3TWFXZPW2');
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
	    }elsif(($line =~ /<!--■twitter■-->/)&&($skip==1)){
		# ログイン情報枠の代替を設置
		$skip=0;
		print OUTFILE <<EOF;
<div id="login_info">
  <span><a href="character_status.php?chara_code="><img src="/img/default/default_ic.png"></a></span>
  <br>下記よりログインしてください<br>
  <br>
  <div id="login_form">
    <form method="post">
      <span style="color:#ffffff; font-size:8pt">ID(mail)</span>
      <input type="text" name="mail" value="" style="margin-top:0px;width:95%;"><br>
      <span style="color:#ffffff; font-size:8pt">password</span>
      <input type="password" name="pass" value="" style="margin-top:0px;width:95%;"><br>
      <input type="submit" name="login_button" value="ログイン" class="button">
    </form>
    <br><a href="password_ask.php"><div class="ybox">パスワード問合わせ</div></a>
  </div>
</div>

<div align="center">
  <!-- 　手紙を受け取り中 -->
  <!-- アイテムを受け取り中 -->
  <br>
  <a href="/page.php?p=manual_new"><img src="/img/menu/newpc.png"><br></a>
  <a href="./member_entry.php"><img src="/img/menu/newid.png"><br></a>

  <script>
    \$(function() {
      \$(".accordion dd").css("display","none");
      \$(".accordion dt").click(function(){
        \$(this).toggleClass("open").next().slideToggle("fast");
      });
    });
  </script>
  <ul style="list-style:none;">
    <li>
      <dl class="accordion">
        <dt>ご利用ガイド</dt>
        <dd>
          <ul>
            <li><a href="/page.php?p=manual_new">はじめての方へ　　</a></li>
            <li><a href="/page.php?p=manual_glossary">用語集　　　　　　</a></li>
            <li><a href="/page.php?p=manual_0top">ゲームマニュアル　</a></li>
            <li><a href="/page.php?p=manual_quest">シナリオマニュアル</a></li>
            <li><a href="/page.php?p=manual_atrie">アトリエマニュアル</a></li>
          </ul>
        </dd>
      </dl>
    </li>
    <li>
      <dl class="accordion">
        <dt>お知らせ</dt>
        <dd>
          <ul style="list-style:none;">
            <li><a href="http://www.chocolop.net/nijiinfo.htm" target="blank">二次使用について　</a></li>
            <li><a href="http://www.chocolop.net/rule2.htm" target="blank">　プライバシーポリシー</a></li>
          </ul>
        </dd>
      </dl>
    </li>
  </ul>

  <a href="/user_own_bbs.php"><img src="/img/world/fl.png"><span style="color:#ffffff"><b>お問い合せ</b></span></a>
  <a href="https://cl3.chocolop.net/page.php?p=story"><img src="/img/menu/story.png"></a><br>
  <a href="https://cl3.chocolop.net/page.php?p=quick"><img src="/img/menu/quick.png"></a><br>

  <a href="http://www.chocolop.net/acceptindex.htm"><img src="/img/menu/creator.png"></a><br>
  <a href="http://www.chocolop.net/"><img src="/img/menu/chocolop.jpg"></a>
  <br>
</div>

</div></div><img src="/img/menu/menubottom.png" style="vertical-align:bottom">
EOF
	    }

	    $line=~s/http:\/\/manage.chocolop.net//ig;
	    $line=~s/http:\/\/cl3.chocolop.net//ig;
	    $line=~s/https:\/\/manage.chocolop.net//ig;
	    $line=~s/https:\/\/cl3.chocolop.net//ig;
	    $line=~s/http:\/\/ajax.googleapis.com/https:\/\/ajax.googleapis.com/ig;

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

