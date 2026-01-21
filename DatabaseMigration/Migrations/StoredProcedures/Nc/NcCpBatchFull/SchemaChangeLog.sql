--liquibase formatted sql

--changeset system:create-alter-procedure-NcCpBatchFull context:any labels:c-any,o-stored-procedure,ot-schema,on-NcCpBatchFull,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure NcCpBatchFull
CREATE OR ALTER PROCEDURE dbo.NcCpBatchFull
@LastContactPersonId uniqueidentifier,
@LastExecutionDate DateTime
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP 500 cp.Id, cp.Name, cp.FirstName, cp.DateOfBirth, cp.SexStatusNo, cp.CountryCode, cp.Nationality + ';' +
	STUFF((
		SELECT ';' + n.CountryCode
		FROM PtNationalityContactPerson n
		WHERE n.ContactPersonId = cp.Id
		AND n.HdVersionNo < 999999999
		FOR XML PATH('')
	),1,1,'') AS Nationlist
	FROM PtContactPerson as cp
	INNER JOIN PtBase pb ON pb.Id = cp.PartnerId
		WHERE cp.Id > @LastContactPersonId
		AND cp.HdVersionNo < 999999999
		AND pb.HdVersionNo < 999999999
		AND pb.TerminationDate IS NULL
		ORDER BY cp.Id

END
