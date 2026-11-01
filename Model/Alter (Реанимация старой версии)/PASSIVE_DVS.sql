--SELECT a.mid, a.protocol_id, a.com_id, a.init_str, a.addr, a.cycle_tout,a.retries, a.retries_tout, a.blocking, a.caller_name  FROM passive_dvs a

declare
cursor lcur_sel is select a.mid, a.protocol_id, a.com_id, a.init_str, a.addr, a.cycle_tout,a.retries, a.retries_tout, a.blocking, a.caller_name  FROM passive_dvs a;
ln_cid number;
ln_parent NUMBER default 2864;
ln_protocol number default 14;
ln_tag number;
lV_INFO varchar2(2000);
begin
ln_tag:=2;
lV_INFO:='';

for lc in lcur_sel loop
ln_usd:=ln_usd+1;
CHANNELS_PG.ins_p(
  1, --¦Ёшчэръ ърэрыр 1-ърэры, шэрўх уЁєяяр
  ln_parent, --Lф ЁюфшЄхы№ёъющ уЁєяяv
  lc.name||' DIAL', --=рчтрэшх
  '', --¦Ёшьхўрэшх
  ln_protocol, --Lф яЁюЄюъюыр
  6, --Lф ъюьяюЁЄр
  'atdp;~~~+++~~~ath;0;2;1', --TЄЁюър шэшЎшрышчрЎшш
  ln_usd, --¦юььєэшърЎшюэvщ рфЁхёё
  1800, --¦рєчр ьхцфє Ўшъырьш
  2, --¦юы яюяvЄюъ ёюхфшэхэш 
  8, --¦рєчр ьхцфє яюяvЄърьш
  0, --+ыюъшЁютър
  'Srv', --=рчтрэшх юяЁюёўшър
  1, --¦юььхЁўхёъшх
  500, --¦юььхЁўхёъшх уыєсшэр
  0, --Tхъє•шх
  1, --Tхъє•шх уыєсшэр
  1, --¦рЁрьхЄЁv ёхЄш
  1, --¦єЁэры ёюсvЄшщ
  '01.03.2004 00:05:00', --=рўрыю юяЁюёр
  '01.03.2004 02:00:00', --+ъюэўрэшх
  NULL, ---хэ№
  NULL, --+ыртэvщ ърэры
  1, --=х ўшЄрЄ№ Єхъє•шх ёєЄъш
  60, --TЁхь  юцшф єёЄ ёюхф  (ёхъ)
  ln_cid);
ln_mcid:=ln_cid;

i:=1;
for lcp in lcur_selp(lc.mid) loop
update feeders set CANAL=i,VINFO=decode(lV_INFO,NULL,VINFO,lV_INFO) where mid=lcp.mid;
update points set TAG=decode(ln_tag,NULL,TAG,ln_tag) where mid=lcp.mid;
i:=i+1;
insert into chanpoint(mid,cid) values(lcp.mid,ln_cid);
end loop;


CHANNELS_PG.ins_p(
  1, --¦Ёшчэръ ърэрыр 1-ърэры, шэрўх уЁєяяр
  ln_parent, --Lф ЁюфшЄхы№ёъющ уЁєяяv
  lc.name||' GSM', --=рчтрэшх
  '', --¦Ёшьхўрэшх
  ln_protocol, --Lф яЁюЄюъюыр
  5, --Lф ъюьяюЁЄр
  'atd;~~~+++~~~ath;0;2;1', --TЄЁюър шэшЎшрышчрЎшш
  ln_usd, --¦юььєэшърЎшюэvщ рфЁхёё
  1800, --¦рєчр ьхцфє Ўшъырьш
  2, --¦юы яюяvЄюъ ёюхфшэхэш 
  8, --¦рєчр ьхцфє яюяvЄърьш
  0, --+ыюъшЁютър
  'Srv', --=рчтрэшх юяЁюёўшър
  1, --¦юььхЁўхёъшх
  500, --¦юььхЁўхёъшх уыєсшэр
  0, --Tхъє•шх
  1, --Tхъє•шх уыєсшэр
  1, --¦рЁрьхЄЁv ёхЄш
  1, --¦єЁэры ёюсvЄшщ
  '01.03.2004 00:05:00', --=рўрыю юяЁюёр
  '01.03.2004 02:00:00', --+ъюэўрэшх
  NULL, ---хэ№
  ln_mcid, --+ыртэvщ ърэры
  1, --=х ўшЄрЄ№ Єхъє•шх ёєЄъш
  40, --TЁхь  юцшф єёЄ ёюхф  (ёхъ)
  ln_cid);

 i:=1;
 for lcp in lcur_selp(lc.mid) loop
  update feeders set CANAL=i,VINFO=decode(lV_INFO,NULL,VINFO,lV_INFO) where mid=lcp.mid;
  update points set TAG=decode(ln_tag,NULL,TAG,ln_tag) where mid=lcp.mid;
  i:=i+1;
  insert into chanpoint(mid,cid) values(lcp.mid,ln_cid);
 end loop;

end loop;


end;

