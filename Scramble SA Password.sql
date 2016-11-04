--Scrambles the SA password
DECLARE @String varchar(81)
SET @String = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz~`!@#$%^&*()_-+=?<>'

DECLARE @Cnt as int
DECLARE @Pwd varchar(128)
SET @Cnt = 0
SET @Pwd=''
WHILE @Cnt < 128
BEGIN 
  SET @Pwd=@Pwd + SUBSTRING(@String,CONVERT(tinyint,RAND()*81)+1,1)
  SET @Cnt=@Cnt+1
END
SELECT @pwd
EXECUTE master..sp_password null,@pwd,'sa'
