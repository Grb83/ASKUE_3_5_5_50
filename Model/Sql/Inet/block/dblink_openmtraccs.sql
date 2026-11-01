BEGIN
  SELECT COUNT(*)
    INTO :2
    FROM DUAL
   WHERE EXISTS( SELECT *
                   FROM objects
                  WHERE obj_id = :1);
END;