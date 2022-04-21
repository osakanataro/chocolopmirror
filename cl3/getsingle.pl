#!/bin/perl

require 'config.pl';

$outputdir=$basedir."/single_orig";

geturl("https://cl3.chocolop.net/bfroom_stlist.php","bfroom_stlist.html");
geturl("https://cl3.chocolop.net/acceptance_top.php","acceptance_top.html");
geturl("https://cl3.chocolop.net/atrie_newvclist.php","atrie_newvclist.html");
geturl("https://cl3.chocolop.net/lounge_top.php","lounge_top.html");
geturl("https://cl3.chocolop.net/shop_top.php","shop_top.html");
geturl("https://cl3.chocolop.net/mcoin_top.php","mcoin_top.html");
geturl("https://cl3.chocolop.net/mcoin_exchange.php","mcoin_exchange.html");
geturl("https://cl3.chocolop.net/change_classify.php","change_classify.html");
geturl("https://cl3.chocolop.net/ruins_exploration_play.php","ruins_exploration_play.html");
geturl("https://cl3.chocolop.net/etc_top.php","etc_top.html");
geturl("https://cl3.chocolop.net/quest.php","quest.html");
geturl("https://cl3.chocolop.net/character_npclist.php","character_npclist.html");
geturl("https://cl3.chocolop.net/atrie_galary.php","atrie_galary.html");
geturl("https://cl3.chocolop.net/top.php","top.html");
geturl("https://cl3.chocolop.net/atrie_search.php","atrie_search.html");
geturl("https://cl3.chocolop.net/","index.html");
geturl("https://cl3.chocolop.net/member_entry.php","member_entry.html");
geturl("https://cl3.chocolop.net/character_search.php","character_search.html");
geturl("https://cl3.chocolop.net/questsearch.php","questsearch.html");
geturl("https://cl3.chocolop.net/item_set.php","item_set.html");
geturl("https://cl3.chocolop.net/item_enhance_list.php","item_enhance_list.html");
geturl("https://cl3.chocolop.net/shop.php","shop.html");
geturl("https://cl3.chocolop.net/item_booster_list.php","item_booster_list.html");
geturl("https://cl3.chocolop.net/team_list.php","team_list.html");
geturl("https://cl3.chocolop.net/character_status.php?chara_code=","character_status.html");
geturl("https://cl3.chocolop.net/character_create.php","character_create.html");
geturl("https://cl3.chocolop.net/birthday_list.php","birthday_list.html");
geturl("https://cl3.chocolop.net/team.php?id=1","team.html");
geturl("https://cl3.chocolop.net/casino.php","casino.html");
geturl("https://cl3.chocolop.net/poker.php","poker.html");
geturl("https://cl3.chocolop.net/casino_exchange.php","casino_exchange.html");
geturl("https://cl3.chocolop.net/collection.php","collection.html");
geturl("https://cl3.chocolop.net/letter_send.php","letter_send.html");
geturl("https://cl3.chocolop.net/feeling_manage.php","feeling_manage.html");
geturl("https://cl3.chocolop.net/class_change.php","class_change.html");
geturl("https://cl3.chocolop.net/change_status.php","change_status.html");
geturl("https://cl3.chocolop.net/feeling_view.php","feeling_view.html");
exit;
geturl("https://cl3.chocolop.net/","");
geturl("https://cl3.chocolop.net/","");
geturl("https://cl3.chocolop.net/","");
geturl("https://cl3.chocolop.net/","");
geturl("https://cl3.chocolop.net/","");
geturl("https://cl3.chocolop.net/","");
geturl("https://cl3.chocolop.net/","");
geturl("https://cl3.chocolop.net/","");
geturl("https://cl3.chocolop.net/","");
geturl("https://cl3.chocolop.net/","");
geturl("https://cl3.chocolop.net/","");
geturl("https://cl3.chocolop.net/","");

sub geturl
{
    local($url,$filename)=@_;
    $filename=$outputdir."/".$filename;
    getfile($url,$filename);
}


