(1)
-- sp_msforeachtable "ALTER TABLE ? Enable TRIGGER all"

(2) another way
/* Identify Triggers that are DISABLED! */

select 'ENABLE TRIGGER ' + tr.name + ' ON ' + OBJECT_NAME(tr.parent_id) + ';',tr.* 
  from sys.triggers tr
where tr.is_disabled = 1
