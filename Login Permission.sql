SELECT
    SP.name,
    SP.type_desc,
    SP.is_disabled,
    SP.create_date,
    SP.modify_date,
    SP.default_database_name,
    SRBA.bulkadmin,
    SRDC.dbcreator
FROM sys.server_principals AS SP
    CROSS APPLY (
        SELECT CASE WHEN SRM.member_principal_id IS NULL THEN 'N' ELSE 'Y' END AS bulkadmin
        FROM sys.server_principals AS SR
            LEFT JOIN sys.server_role_members AS SRM
                ON SR.principal_id = SRM.role_principal_id
                AND SRM.member_principal_id = SP.principal_id
        WHERE SR.type = 'R'
        AND SR.name = 'bulkadmin'
    ) AS SRBA
    CROSS APPLY (
        SELECT CASE WHEN SRM.member_principal_id IS NULL THEN 'N' ELSE 'Y' END AS dbcreator
        FROM sys.server_principals AS SR
            LEFT JOIN sys.server_role_members AS SRM
                ON SR.principal_id = SRM.role_principal_id
                AND SRM.member_principal_id = SP.principal_id
        WHERE SR.type = 'R'
        AND SR.name = 'dbcreator'
    ) AS SRDC

WHERE SP.type IN ('S', 'U', 'G') /* S = SQL Login, U = Windows Login, G = Windows Group */
ORDER BY SP.type_desc, SP.name

