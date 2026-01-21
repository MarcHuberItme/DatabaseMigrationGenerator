--liquibase formatted sql

--changeset system:create-alter-procedure-GetRelationMasters context:any labels:c-any,o-stored-procedure,ot-schema,on-GetRelationMasters,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetRelationMasters
CREATE OR ALTER PROCEDURE dbo.GetRelationMasters
@ParentTableId UniqueIdentifier,
@LanguageNo tinyint
AS
    SELECT P.PartnerNoEdited,P.DateOfBirth,P.PtDescription,X.TextShort As TypeText,IsNull(Z.TextShort,Y.TextShort) As RoleText,
           S.ValidFrom,S.ValidTo, S.Instruction, P.Id AS PartnerId, P.PartnerNo FROM PtRelationSlave As S
      JOIN PtRelationMaster As M
           ON S.MasterId = M.Id
      JOIN PtDescriptionView As P
           ON M.PartnerId = P.Id
      JOIN PtRelationType As T
           ON M.RelationTypeNo = T.RelationTypeNo
      LEFT OUTER JOIN PtRelationRole As R
           ON R.RelationRoleNo = S.RelationRoleNo
      LEFT Outer JOIN PtRelationRole As Rp
           On R.RelationPassiveRoleNo = Rp.RelationRoleNo
      LEFT OUTER JOIN AsText As X
           ON T.Id = X.MasterId AND X.LanguageNo = @LanguageNo
      LEFT OUTER JOIN AsText As Y
           ON R.Id = Y.MasterId AND Y.LanguageNo = @LanguageNo
      LEFT OUTER JOIN AsText As Z
           ON Rp.Id = Z.MasterId AND Z.LanguageNo = @LanguageNo
      WHERE S.PartnerId = @ParentTableId
           AND (S.HdVersionNo BETWEEN 1 AND 999999998)
      ORDER BY X.TextShort, P.PartnerNoEdited
