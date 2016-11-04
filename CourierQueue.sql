select '[dbo].[CourierApplicantIdentityVerificationAudit]', max ([CourierApplicantIdentityVerificationAuditId]) from [dbo].[CourierApplicantIdentityVerificationAudit] 
select '[dbo].[CourierApplicantIdentityVerificationMessage]', max([CourierApplicantIdentityVerificationMessageId]) from [dbo].[CourierApplicantIdentityVerificationMessage]

select max ([CourierBeagleAuditId]) from [dbo].[CourierBeagleAudit] --  null
select max([CourierBeagleMessageId]) from [dbo].[CourierBeagleMessage] -- null
select max([CourierCAPAuditId]) from [dbo].[CourierCAPAudit] -- 19914
select max ([CourierCAPMessageId]) from [dbo].[CourierCAPMessage] --2507
select max ([CourierCarmaxECAIAuditId]) from [dbo].[CourierCarmaxECAIAudit] -- 8305
select max([CourierCarmaxECAIMessageId]) from [dbo].[CourierCarmaxECAIMessage] --831
select max ([CourierCarmaxEDDSAuditId]) from [dbo].[CourierCarmaxEDDSAudit] --21
select max ([CourierCarmaxEDDSMessageId]) from [dbo].[CourierCarmaxEDDSMessage] --1
select max([CourierCarsContractInitializationAuditId]) from [dbo].[CourierCarsContractInitializationAudit] --137590
select max([CourierCarsContractInitializationFinalizerMessageId]) from [dbo].[CourierCarsContractInitializationFinalizerMessage] --528
select max([CourierCarsContractInitializationMessageId]) from [dbo].[CourierCarsContractInitializationMessage] --18621
select max([CourierChromeDataAuditId]) from [dbo].[CourierChromeDataAudit] --1456
select max([CourierChromeDataMessageId]) from [dbo].[CourierChromeDataMessage] -- NULL
select max([CourierChryslerLeadsAuditId]) from [dbo].[CourierChryslerLeadsAudit] -- 750
select max([CourierChryslerLeadsMessageId]) from [dbo].[CourierChryslerLeadsMessage] -- NULL
select max([CourierContactInfoValidationAuditId]) from [dbo].[CourierContactInfoValidationAudit] -- NULL
select max([CourierContactInfoValidationMessageId]) from [dbo].[CourierContactInfoValidationMessage] -- NULL
select max([CourierContractManagementAuditId]) from [dbo].[CourierContractManagementAudit] -- NULL
select max([CourierCreditBureauOutboundCourierAuditId]) from [dbo].[CourierCreditBureauOutboundCourierAudit] -- 57889
select max([CourierCreditBureauOutboundCourierMessageId]) from [dbo].[CourierCreditBureauOutboundCourierMessage] --4492
select max([CourierCudlECAIAuditId]) from [dbo].[CourierCudlECAIAudit] -- NULL
select max([CourierCudlECAIMessageId]) from [dbo].[CourierCudlECAIMessage] -- NULL
select max([CourierDealerTrackAuditId]) from [dbo].[CourierDealerTrackAudit] --16400
select max([CourierDealerTrackMessageId]) from [dbo].[CourierDealerTrackMessage] --3057
select max([CourierAuditId]) from [dbo].[CourierDelayedAutoDecisionAudit] -- 494
select max([CourierDelayedAutoDecisionMessageId]) from [dbo].[CourierDelayedAutoDecisionMessage] --242



select COLUMN_NAME, TABLE_NAME
      from INFORMATION_SCHEMA.COLUMNS
       where TABLE_SCHEMA = 'dbo'
       and COLUMNPROPERTY(object_id(TABLE_NAME), COLUMN_NAME, 'IsIdentity') = 1
       order by TABLE_NAME

SELECT 1 FROM sys.identity_columns
    WHERE [object_id] = sys.tables.[object_id]

select '''' + TABLE_NAME + '''' + '  ' + 'select max(' + COLUMN_NAME + ')  from '+ TABLE_NAME
      from INFORMATION_SCHEMA.COLUMNS
       where TABLE_SCHEMA = 'dbo'
       and COLUMNPROPERTY(object_id(TABLE_NAME), COLUMN_NAME, 'IsIdentity') = 1
       order by TABLE_NAME


  select  'select' + '''' +TABLE_NAME + '''' + ',' +' max(' + COLUMN_NAME + ')  from '+ TABLE_NAME
      from INFORMATION_SCHEMA.COLUMNS
       where TABLE_SCHEMA = 'dbo'
       and COLUMNPROPERTY(object_id(TABLE_NAME), COLUMN_NAME, 'IsIdentity') = 1
       order by TABLE_NAME

  select 'CourierApplicantIdentityVerificationAudit' , max(CourierApplicantIdentityVerificationAuditId)  from CourierApplicantIdentityVerificationAudit



  select  'select' + '''' +TABLE_NAME + '''' + ',' +' max(' + COLUMN_NAME + ')  from '+ TABLE_NAME
      from INFORMATION_SCHEMA.COLUMNS
       where TABLE_SCHEMA = 'dbo'
       and COLUMNPROPERTY(object_id(TABLE_NAME), COLUMN_NAME, 'IsIdentity') = 1
       order by TABLE_NAME

	   select'CourierApplicantIdentityVerificationAudit', max(CourierApplicantIdentityVerificationAuditId)  from CourierApplicantIdentityVerificationAudit


  select  'select' + '''' +TABLE_NAME + '''' + ',' +' max(' + COLUMN_NAME + ')  from '+ TABLE_NAME
      from INFORMATION_SCHEMA.COLUMNS
       where TABLE_SCHEMA = 'dbo'
       and COLUMNPROPERTY(object_id(TABLE_NAME), COLUMN_NAME, 'IsIdentity') = 1
       order by TABLE_NAME


DBCC SQLPERF(LOGSPACE);
GO

sp_who2 'active'
































