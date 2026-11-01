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
  1, --¦¨רק‎נת תנ‎נûנ 1-תנ‎נû, ר‎נ¢ץ ף¨÷ÿÿנ
  ln_parent, --Lפ ¨‏פר×ץû¹¸ת‏ש ף¨÷ÿÿv
  lc.name||' DIAL', --=נקענ‎רץ
  '', --¦¨רüץ¢נ‎רץ
  ln_protocol, --Lפ ÿ¨‏×‏ת‏ûנ
  6, --Lפ ת‏üÿ‏¨×נ
  'atdp;~~~+++~~~ath;0;2;1', --T×¨‏תנ ר‎ר¡רנûרקנ¡רר
  ln_usd, --¦‏üü÷‎רתנ¡ר‏‎vש נפ¨ץ¸¸
  1800, --¦נ÷קנ üץצפ÷ ¡רתûנüר
  2, --¦‏û ÿ‏ÿv×‏ת ¸‏ץפר‎ץ‎ר 
  8, --¦נ÷קנ üץצפ÷ ÿ‏ÿv×תנüר
  0, --+û‏תר¨‏עתנ
  'Srv', --=נקענ‎רץ ‏ÿ¨‏¸¢רתנ
  1, --¦‏üüץ¨¢ץ¸תרץ
  500, --¦‏üüץ¨¢ץ¸תרץ ףû÷סר‎נ
  0, --Tץת÷•רץ
  1, --Tץת÷•רץ ףû÷סר‎נ
  1, --¦נ¨נüץ×¨v ¸ץ×ר
  1, --¦÷¨‎נû ¸‏סv×רש
  '01.03.2004 00:05:00', --=נ¢נû‏ ‏ÿ¨‏¸נ
  '01.03.2004 02:00:00', --+ת‏‎¢נ‎רץ
  NULL, ---ץ‎¹
  NULL, --+ûנע‎vש תנ‎נû
  1, --=ץ ¢ר×נ×¹ ×ץת÷•רץ ¸÷×תר
  60, --T¨ץü  ‏צרפ ÷¸× ¸‏ץפ  (¸ץת)
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
  1, --¦¨רק‎נת תנ‎נûנ 1-תנ‎נû, ר‎נ¢ץ ף¨÷ÿÿנ
  ln_parent, --Lפ ¨‏פר×ץû¹¸ת‏ש ף¨÷ÿÿv
  lc.name||' GSM', --=נקענ‎רץ
  '', --¦¨רüץ¢נ‎רץ
  ln_protocol, --Lפ ÿ¨‏×‏ת‏ûנ
  5, --Lפ ת‏üÿ‏¨×נ
  'atd;~~~+++~~~ath;0;2;1', --T×¨‏תנ ר‎ר¡רנûרקנ¡רר
  ln_usd, --¦‏üü÷‎רתנ¡ר‏‎vש נפ¨ץ¸¸
  1800, --¦נ÷קנ üץצפ÷ ¡רתûנüר
  2, --¦‏û ÿ‏ÿv×‏ת ¸‏ץפר‎ץ‎ר 
  8, --¦נ÷קנ üץצפ÷ ÿ‏ÿv×תנüר
  0, --+û‏תר¨‏עתנ
  'Srv', --=נקענ‎רץ ‏ÿ¨‏¸¢רתנ
  1, --¦‏üüץ¨¢ץ¸תרץ
  500, --¦‏üüץ¨¢ץ¸תרץ ףû÷סר‎נ
  0, --Tץת÷•רץ
  1, --Tץת÷•רץ ףû÷סר‎נ
  1, --¦נ¨נüץ×¨v ¸ץ×ר
  1, --¦÷¨‎נû ¸‏סv×רש
  '01.03.2004 00:05:00', --=נ¢נû‏ ‏ÿ¨‏¸נ
  '01.03.2004 02:00:00', --+ת‏‎¢נ‎רץ
  NULL, ---ץ‎¹
  ln_mcid, --+ûנע‎vש תנ‎נû
  1, --=ץ ¢ר×נ×¹ ×ץת÷•רץ ¸÷×תר
  40, --T¨ץü  ‏צרפ ÷¸× ¸‏ץפ  (¸ץת)
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

