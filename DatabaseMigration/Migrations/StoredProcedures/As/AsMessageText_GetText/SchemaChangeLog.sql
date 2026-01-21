--liquibase formatted sql

--changeset system:create-alter-procedure-AsMessageText_GetText context:any labels:c-any,o-stored-procedure,ot-schema,on-AsMessageText_GetText,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AsMessageText_GetText
CREATE OR ALTER PROCEDURE dbo.AsMessageText_GetText
@TextNo int,
@LanguageNo tinyint AS
	SELECT Text
	FROM AsMessageText WITH (READCOMMITTED)
	WHERE TextNo = @TextNo AND LanguageNo = @LanguageNo
