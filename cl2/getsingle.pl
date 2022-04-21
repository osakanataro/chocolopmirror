#!/bin/perl

require 'config.pl';

$outputdir=$basedir."/single_orig";

geturl("http://cl2.chocolop.net/atrie_vclist.php","atrie_vclist.html");
geturl("http://cl2.chocolop.net/bfroom_stlist.php","bfroom_stlist.html");
geturl("http://cl2.chocolop.net/acceptance_top.php","acceptance_top.html");
geturl("http://cl2.chocolop.net/atrie_newvclist.php","atrie_newvclist.html");
geturl("http://cl2.chocolop.net/lounge_top.php","lounge_top.html");
geturl("http://cl2.chocolop.net/shop_top.php","shop_top.html");
geturl("http://cl2.chocolop.net/mcoin_top.php","mcoin_top.html");
geturl("http://cl2.chocolop.net/mcoin_exchange.php","mcoin_exchange.html");
geturl("http://cl2.chocolop.net/change_classify.php","change_classify.html");
geturl("http://cl2.chocolop.net/ruins_exploration_play.php","ruins_exploration_play.html");
geturl("http://cl2.chocolop.net/familiar_evolution.php","familiar_evolution.html");
geturl("http://cl2.chocolop.net/etc_top.php","etc_top.html");
geturl("http://cl2.chocolop.net/quest.php","quest.html");
geturl("http://cl2.chocolop.net/atrie_top.php","atrie_top.html");
geturl("http://cl2.chocolop.net/character_npclist.php","character_npclist.html");
geturl("http://cl2.chocolop.net/atrie_galary.php","atrie_galary.html");
geturl("http://cl2.chocolop.net/top.php","top.html");
geturl("http://cl2.chocolop.net/atrie_search.php","atrie_search.html");
geturl("http://cl2.chocolop.net/","index.html");
geturl("http://cl2.chocolop.net/member_entry.php","member_entry.html");
geturl("http://cl2.chocolop.net/character_search.php","character_search.html");
geturl("http://cl2.chocolop.net/questsearch.php","questsearch.html");
geturl("http://cl2.chocolop.net/item_set.php","item_set.html");
geturl("http://cl2.chocolop.net/item_enhance_list.php","item_enhance_list.html");
geturl("http://cl2.chocolop.net/shop.php","shop.html");
geturl("http://cl2.chocolop.net/item_booster_list.php","item_booster_list.html");
geturl("http://cl2.chocolop.net/team_list.php","team_list.html");
geturl("http://cl2.chocolop.net/character_status.php?chara_code=","character_status.html");
geturl("http://cl2.chocolop.net/letter_send.php?id=","letter_send.html");
#geturl("http://cl2.chocolop.net/feeling_manage.php?chara_code=","feeling_manage.html");
#geturl("","");
#geturl("","");
#geturl("","");
#geturl("","");
#geturl("","");
#geturl("","");

sub geturl
{
    local($url,$filename)=@_;
    $filename=$outputdir."/".$filename;
    getfile($url,$filename);
}


