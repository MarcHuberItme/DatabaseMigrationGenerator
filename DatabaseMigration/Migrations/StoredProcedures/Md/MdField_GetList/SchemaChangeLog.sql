--liquibase formatted sql

--changeset system:create-alter-procedure-MdField_GetList context:any labels:c-any,o-stored-procedure,ot-schema,on-MdField_GetList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure MdField_GetList
CREATE OR ALTER PROCEDURE dbo.MdField_GetList
   @LanguageNo TINYINT AS
   SELECT m.*, t.TextShort 
      FROM MdField AS m LEFT OUTER JOIN asText AS t 
         ON m.Id = t.MasterId 
            AND t.LanguageNo = @LanguageNo 
      WHERE m.HdVersionNo > 0 AND m.HdVersionNo < 999999999
