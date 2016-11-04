
-- search by either/or/both (leave blank or null)
declare @imp nvarchar(128)        = '11363' ;
declare @dba nvarchar(128)        = '' ;

-- ten days back, ignoring Ks
declare @dys int                  = 10 ;
declare @ign char(1)              = 'K' ;

select
       fl.[FOp],
       fl.[dOn],
       fl.[cWho],
       [path] = vi.[ImpFilePath],
       vi.[ImpSubDir],
       fl.[name],
       fl.[file_type]
from
       [SQLImplementations].dbo.[foplog] fl
       left outer join [SQLImplementations].dbo.[ImplementationHeader] ih on fl.[stream_id] = ih.[stream_id]
       left outer join [SQLImplementations].dbo.[vw_Implementations] vi on ih.[stream_id] = vi.[stream_id]
where
       fl.[FOp] <> @ign
       and fl.[dOn] > DateAdd(dd, -@dys, getdate())
       and (@imp is null or @imp = '' or vi.[ImpSubDir] like '%' + @imp + '%')
       and (@dba is null or @dba = '' or fl.[cWho] like '%' + @dba + '%')
order by
       fl.[ID] desc ;
