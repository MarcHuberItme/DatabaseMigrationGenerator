--liquibase formatted sql

--changeset system:create-alter-procedure-TwintAllowedAccountsOverProductGroup context:any labels:c-any,o-stored-procedure,ot-schema,on-TwintAllowedAccountsOverProductGroup,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure TwintAllowedAccountsOverProductGroup
CREATE OR ALTER PROCEDURE dbo.TwintAllowedAccountsOverProductGroup
@AccountNoIbanElect varchar(40)

AS
 
SELECT Acc.AccountNo, Acc.AccountNoIbanElect, Pr.ProductNo, Pt.Name
FROM PtAccountBase AS Acc
INNER JOIN PtPortfolio as Pf ON Pf.Id = Acc.PortfolioId
INNER JOIN PtBase as Pt ON Pt.Id = Pf.PartnerId
INNER JOIN PrReference as Ref ON acc.Id = Ref.AccountId
INNER JOIN PrPrivate as Pr ON Ref.ProductId = Pr.ProductId
WHERE Pr.ProductNo IN (
						SELECT Pr.ProductNo from AsGroupMember as GM
						INNER JOIN AsGroupType GT ON GM.GroupTypeId = GT.Id
						INNER JOIN AsGroupTypeLabel as GTL ON GM.GroupTypeId = GTL.GroupTypeId
						INNER JOIN AsGroupLabel as GL ON GM.GroupId = GL.GroupId
						INNER JOIN PrPrivate as Pr ON GM.TargetRowId = Pr.Id
						where GTL.Name = 'TwintProductGroup'
						AND GL.Name = 'ProdAllowedForTwint'
						AND GT.TableName = 'PrPrivate')
						
AND (Acc.AccountNoIbanElect = @AccountNoIbanElect)
AND (Acc.HdVersionNo BETWEEN 1 AND 999999998)

