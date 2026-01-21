--liquibase formatted sql

--changeset system:create-alter-procedure-CheckIdentification context:any labels:c-any,o-stored-procedure,ot-schema,on-CheckIdentification,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CheckIdentification
CREATE OR ALTER PROCEDURE dbo.CheckIdentification

@PartnerId uniqueidentifier

AS

SELECT ISNULL(I2.IdentificationType, I.IdentificationType) AS IdentificationType
FROM PtIdentification AS I
LEFT OUTER JOIN PtIdentification AS I2 ON I.ThirdPartnerId = I2.PartnerId 
WHERE I.Id = @PartnerId
AND(I.HdVersionNo IS NULL OR I.HdVersionNo BETWEEN 0 AND 999999998)
AND(I2.HdVersionNo IS NULL OR I2.HdVersionNo BETWEEN 0 AND 999999998)
AND 
(I.IdentificationType IN(

		 SELECT GC.Id FROM AsGroupType AS GT 
		 INNER JOIN AsGroup AS G ON GT.Id = G.GroupTypeId 
		 INNER JOIN AsGroupTypeLabel AS GTL ON GT.Id = GTL.GroupTypeId 
		 INNER JOIN AsGroupMember AS GM ON G.Id = GM.GroupId AND G.GroupTypeId = GM.GroupTypeId 
		 INNER JOIN AsGroupLabel AS GL ON GL.GroupId = G.Id
		 INNER JOIN PtIdentificationType AS GC ON GM.TargetRowId = GC.Id
		 WHERE GTL.Name = 'VsbIdentification'
		 AND GL.Name = 'ValidIdentification')

OR

(I2.IdentificationType IN(

		 SELECT GC.Id FROM AsGroupType AS GT 
		 INNER JOIN AsGroup AS G ON GT.Id = G.GroupTypeId 
		 INNER JOIN AsGroupTypeLabel AS GTL ON GT.Id = GTL.GroupTypeId 
		 INNER JOIN AsGroupMember AS GM ON G.Id = GM.GroupId AND G.GroupTypeId = GM.GroupTypeId 
		 INNER JOIN AsGroupLabel AS GL ON GL.GroupId = G.Id
		 INNER JOIN PtIdentificationType AS GC ON GM.TargetRowId = GC.Id
		 WHERE GTL.Name = 'VsbIdentification'
		 AND GL.Name = 'ValidIdentification')
AND I2.ThirdPartnerId IS NULL)
)
