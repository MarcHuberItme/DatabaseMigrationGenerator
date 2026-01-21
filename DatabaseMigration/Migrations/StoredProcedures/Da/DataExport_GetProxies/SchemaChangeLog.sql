--liquibase formatted sql

--changeset system:create-alter-procedure-DataExport_GetProxies context:any labels:c-any,o-stored-procedure,ot-schema,on-DataExport_GetProxies,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DataExport_GetProxies
CREATE OR ALTER PROCEDURE dbo.DataExport_GetProxies
    @PartnerId uniqueidentifier,
    @LanguageNo int AS
SELECT  'G' As Art,
        IsNull(t2.TextShort, '') As Beziehung,
        CASE WHEN c.id Is NULL 
           THEN Convert(varchar(10),b.DateOfBirth,104)  
           ELSE Convert(varchar(10), c.DateOfBirth, 104)
        END AS GeburtsDatumFormatted,
        'Inhaber' As Legitimation, 
        '1' As LegitimationCode,
        s.ProxyRightNo As ZeichnungsrechtCode,
        CASE WHEN c.id Is NULL 
           THEN dbo.DataExport_BuildName(b.Name, b.MaidenName, b.ChangeNameOrder) 
          ELSE c.Name 
        END AS 'Name',
        CASE WHEN c.id Is NULL 
           THEN dbo.DataExport_GetNationality(b.Id, @LanguageNo)
           ELSE IsNull(t1.textShort, c.Nationality)
        END AS Nationalitaet,
        CASE WHEN c.id Is NULL
           THEN dbo.DataExport_BuildFirstName(b.FirstName, b.MiddleName, b.UseMiddleName)
           ELSE IsNull(c.FirstName,'')
        END AS Vorname

FROM PtBase b
   Join PtRelationSlave s on s.PartnerId = b.Id
   Join PtRelationMaster m on m.Id = s.masterId
   Left Outer Join PtContactPerson c on c.Id = s.ContactPersonId and c.HdVersionNo BETWEEN 1 AND 999999998
   Left Outer Join AsCountry n on n.IsoCode = c.Nationality
   LEFT OUTER JOIN AsText t1 on t1.MasterId = n.Id and t1.LanguageNo = @LanguageNo
   LEFT OUTER JOIN PtRelationSlaveCloseRelType r on r.CloseRelTypeNo = s.CloseRelTypeNo
   LEFT OUTER JOIN AsText t2 on t2.MasterId = r.Id and t2.LanguageNo = @LanguageNo
   
WHERE m.PartnerId = @PartnerId
   AND m.RelationTypeNo = 30
   AND m.HdVersionNo BETWEEN 1 and 999999998
   AND s.HdVersionNo BETWEEN 1 and 999999998
   AND s.ValidTo Is Null
ORDER BY PartnerNo

