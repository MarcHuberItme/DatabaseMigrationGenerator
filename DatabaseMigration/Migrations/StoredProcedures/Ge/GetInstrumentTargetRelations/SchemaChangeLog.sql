--liquibase formatted sql

--changeset system:create-alter-procedure-GetInstrumentTargetRelations context:any labels:c-any,o-stored-procedure,ot-schema,on-GetInstrumentTargetRelations,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetInstrumentTargetRelations
CREATE OR ALTER PROCEDURE dbo.GetInstrumentTargetRelations
@ParentTableId UniqueIdentifier,
@LanguageNo tinyint
AS
    SELECT PD.PublicDescription, PR.NumberSource, PR.NumberTarget,
           PR.AssimilationDate, PR.SeparationFromDate, PR.SeparationToDate,
           AT.TextShort As DependencyTypeText
      FROM PrPublicRelation As PR
      JOIN PrPublicDescriptionView As PD
           ON PR.SourcePublicId = PD.Id
      LEFT OUTER JOIN PrPublicDependencyType As DT
           ON DT.DependencyTypeNo = PR.DependencyTypeNo
      LEFT OUTER JOIN AsText As AT
           ON AT.MasterId = PR.Id AND AT.LanguageNo = @LanguageNo
      WHERE PR.TargetPublicId = @ParentTableId
           AND (PD.HdVersionNo BETWEEN 1 AND 999999998)
           AND (PD.LanguageNo = @LanguageNo OR PD.LanguageNo IS NULL)
      ORDER BY PD.PublicDescription
