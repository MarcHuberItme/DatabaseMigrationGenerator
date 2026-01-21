--liquibase formatted sql

--changeset system:create-alter-procedure-GetAllUsersForAuditors context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAllUsersForAuditors,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAllUsersForAuditors
CREATE OR ALTER PROCEDURE dbo.GetAllUsersForAuditors
@DateFrom as datetime, 
@DateTo as datetime

 /* 17.01.2023 MCT
    Retrieve all active users and additionally inactive users that have been deleted last year
	Used for the end of year data export of the auditors
	MJET
*/

AS

	Select Id, UserName, FullName, Department 
	From AsUser
	Where HdVersionNo < 999999999

	UNION ALL

	Select Id, UserName, FullName, Department + ' (User gelöscht)'
	From AsUser
	Where HdVersionNo = 999999999 and HdCreateDate < @DateTo AND HdChangeDate > @DateFrom
	order by UserName
