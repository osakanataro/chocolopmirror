# chocolopmirror
Chocolop PBWの"新-アラタナル-"と"MagiaSteam"のサイトをミラーし、Apacheサーバ化で閲覧できるようにするためのスクリプト群です

(1) config.pl を作成

　cl3は$loginuser,$loginpassは無しでOK
 
(2) 「perl login.pl」 を実行

　→ トップページを test.txt として保存
 
(3) 「perl getsingle.pl」を実行してトップページからアクセスできるページを取得

　→ single_orig ディレクトリに保存
 
(4) 「perl getpages.pl single_orig」を実行して(3)で取得したページ群からさらにその先を取得

　→ page_orig ディレクトリに保存
 
(5) 「perl getpages.pl page_orig」を実行してpage_orig にあるリンク先を取得

(5a) 「perl getpages.pl page_orig」をさらに2回実行

(6)「perl getatrie-galary-all.pl」を実行してアトリエページ取得

 → atrie_galary_orig ディレクトリに保存
 
　　なお、ページ数決め打ちになっているので、実行前に最終ページを確認のこと。2022/04/19時点での最終ページ
  
  https://cl3.chocolop.net/atrie_galary.php?page=209&view=detail
  https://cl3.chocolop.net/atrie_galary.php?page=70&view=list

(7)「perl getatrie-master.pl single_orig」でイラストマスターページ取得1

 → atrie_vcprsheet_orig ディレクトリに保存
 
(7a)「perl getatrie-galary.pl atrie_vcprsheet_orig」でイラストマスターページ取得2

 → atrie_galary_orig ディレクトリに保存
 
(7b)「perl getatrie-galary.pl atrie_galary_orig」でイラストマスターページ取得3

 → atrie_galary_orig ディレクトリに保存
 
(8)「perl getquestlist.pl」でシナリオ一覧取得

 → questlist_orig ディレクトリに保存
 
 　　2022/04/19時点での最終ページ
   
　　https://cl3.chocolop.net/quest.php?page=14&msu=1#list
  
(8a)「perl getquest.pl questlist_orig」を実行してそれぞれのシナリオ取得

 → quest_orig ディレクトリに保存


(9)「perl getmaster.pl single_orig」でもマスター紹介ページ取得

 → bfroom_stprsheet_orig ディレクトリに保存
 
(9a)「perl getmaster.pl questlist_orig」でシナリオページにあるマスター紹介起点でも取得

 → bfroom_stprsheet_orig ディレクトリに保存
 
(9b)「perl getmaster.pl page_orig」でも取得


(10)「perl getcharacter_status.pl quest_orig」でキャラ情報取得

 → character_status_orig ディレクトリに保存
 
(10a)「perl getcharacter-quest.pl character_status_orig」

 → character_status_orig ディレクトリに保存
 
(10b)「perl getcharacter-quest.pl scenario_record_orig」

 → character_status_orig ディレクトリに保存
 
(10c)「perl getatrie-galary.pl character_status_orig」でキャラアトリエページ補完

 → atrie_galary_orig ディレクトリに保存
 
(10c)「perl getatrie-galary.pl atrie_galary_orig」を２回実行してキャラアトリエページ補完

 → atrie_galary_orig ディレクトリに保存

(11)「perl getmaster-questlist.pl bfroom_stprsheet_orig」でマスタページ起点でシナリオ一覧取得

→ questlist_orig ディレクトリに保存

(11a)「perl getmaster-questlist.pl questlist_orig」

→ questlist_orig ディレクトリに保存


(1x)  「perl getstatic-files.pl」でcssファイルなどを取得

(1x)各種画像ファイルの取得

perl getimage.pl atrie_galary_orig

perl getimage.pl atrie_vcprsheet_orig

perl getimage.pl page_orig

perl getimage.pl quest_orig

perl getimage.pl questlist_orig

perl getimage.pl single_orig

perl getimage.pl bfroom_stprsheet_orig

perl getimage.pl character_status

perl getimage.pl scenario_record_orig



(1x) 閲覧用ページへの変換

mkdir single

perl convert.pl single

mkdir atrie_galary

perl convert.pl atrie_galary

mkdir atrie_vcprsheet

perl convert.pl atrie_vcprsheet

mkdir page

perl convert.pl page

mkdir quest

perl convert.pl quest

mkdir questlist

perl convert.pl questlist

mkdir bfroom_stprsheet character_status

perl convert.pl bfroom_stprsheet

perl convert.pl character_status


メモ

perl convert2.pl atrie_galary; perl convert2.pl atrie_vcprsheet;perl convert2.pl bfroom_stprsheet;perl convert2.pl character_status;perl convert2.pl page;perl convert2.pl quest;perl convert2.pl questlist;perl convert2.pl scenario_record;perl convert2.pl single

cp -r css images img js ../clm/cl2/

cp -r atrie_galary atrie_vcprsheet bfroom_stprsheet character_status page quest questlist scenario_record single .htaccess ../clm/cl2/


perl convert2.pl atrie_galary; perl convert2.pl atrie_vcprsheet;perl convert2.pl bfroom_stprsheet;perl convert2.pl character_status;perl convert2.pl page;perl convert2.pl quest;perl convert2.pl questlist;perl convert2.pl scenario_record;perl convert2.pl single

cp -r css images img js ../clm/cl3/

cp -r atrie_galary atrie_vcprsheet bfroom_stprsheet character_status page quest questlist scenario_record single ../clm/cl3/


