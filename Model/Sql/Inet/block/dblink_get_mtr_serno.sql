DECLARE
  lv_serno VARCHAR2(256);
BEGIN
  SELECT TRIM(MAX(serial))
    INTO lv_serno
    FROM dev_install
   WHERE obj_id = :1 AND inst_date = (SELECT MAX(inst_date)
                                            FROM dev_install
                                           WHERE obj_id = :1);
  :2 := NVL(lv_serno, ' ');
  IF lv_serno IS NULL THEN
   :3:=0;
   return;
  END IF;
  :3:=1;
  return;
END;