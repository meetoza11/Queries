EXEC sp_addmessage @msgnum = 90000, @severity = 16,@with_log='TRUE',
   @msgtext = N'Disk space is lower than %d percent.  %s', 
   @lang = 'us_english';
   
   EXEC sp_addmessage @msgnum = 90001, @severity = 16,@with_log='TRUE',
   @msgtext = N' %s Database used space is greater than %d percent.', 
   @lang = 'us_english';