-- 既存データに消費税率を設定
-- 見積：更新日
UPDATE ESTIMATE_SHEET_TRN_XXXXX SET CTAX_RATE = 5 
WHERE UPD_DATETM < CAST('2014-04-01 00:00:00' AS DATETIME);

UPDATE ESTIMATE_SHEET_TRN_XXXXX SET CTAX_RATE = 8 
WHERE UPD_DATETM >= CAST('2014-04-01 00:00:00' AS DATETIME);


-- 受注：更新日
UPDATE RO_SLIP_TRN_XXXXX SET CTAX_RATE = 5 
WHERE UPD_DATETM < CAST('2014-04-01 00:00:00' AS DATETIME);

UPDATE RO_SLIP_TRN_XXXXX SET CTAX_RATE = 8 
WHERE UPD_DATETM >= CAST('2014-04-01 00:00:00' AS DATETIME);


-- 売上：売上日
UPDATE SALES_SLIP_TRN_XXXXX SET CTAX_RATE = 5 
WHERE SALES_DATE < CAST('2014-04-01' AS DATE);

UPDATE SALES_SLIP_TRN_XXXXX SET CTAX_RATE = 8 
WHERE SALES_DATE >= CAST('2014-04-01' AS DATE);


-- 発注：発注日
UPDATE PO_SLIP_TRN_XXXXX SET CTAX_RATE = 5 
WHERE PO_DATE < CAST('2014-04-01' AS DATE);

UPDATE PO_SLIP_TRN_XXXXX SET CTAX_RATE = 8 
WHERE PO_DATE >= CAST('2014-04-01' AS DATE);


-- 仕入：仕入日
UPDATE SUPPLIER_SLIP_TRN_XXXXX SET CTAX_RATE = 5 
WHERE SUPPLIER_DATE < CAST('2014-04-01' AS DATE);

UPDATE SUPPLIER_SLIP_TRN_XXXXX SET CTAX_RATE = 8 
WHERE SUPPLIER_DATE >= CAST('2014-04-01' AS DATE);