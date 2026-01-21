--liquibase formatted sql

--changeset system:create-alter-view-ReVwPfBInventar context:any labels:c-any,o-view,ot-schema,on-ReVwPfBInventar,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ReVwPfBInventar
CREATE OR ALTER VIEW dbo.ReVwPfBInventar AS
SELECT	RePfBRelBC.PfBNo AS [ Bc No],
	AsText_2.TextShort AS Kunde,
	RePledgeType.PledgeTypeNo AS Objektcode, 
	AsText_1.TextLong AS Pfandobjekttyp,	
	RePledgeRegister.PledgeAmount AS Pfandforderung,
	(SELECT	SUM(ObligAmountChargeable)
		FROM	ReObligationView
		WHERE	RePledgeRegister.Id = ReObligationView.PRId) AS Titelnominal,
	(SELECT	SUM(DebitAmount)
		FROM          RePledgeRegisterAccount
		WHERE      RePledgeRegister.Id = RePledgeRegisterAccount.PledgeRegisterId) AS Saldo, 
	RePledgeRegister.ValueAmount AS Deckungswert, 
	RePledgeRegister.ValueDate AS [bewertet am],
	RePledgeRegister.ValuationOperator AS durch,
                ReBase.BaseTypeNo as [Liegenschaft-No]
FROM	RePledgeRegister INNER JOIN
	RePfBRelBC ON dbo.RePledgeRegister.PfBNo = RePfBRelBC.PfBNo INNER JOIN
	RePledgeType ON dbo.RePledgeRegister.PledgeTypeId = RePledgeType.Id INNER JOIN
	AsText AsText_1 ON dbo.RePledgeType.Id = AsText_1.MasterId INNER JOIN
	AsText AsText_2 ON dbo.RePfBRelBC.Id = AsText_2.MasterId INNER JOIN ReBase ON RePledgeRegister.ReBaseId = ReBase.Id
WHERE	(AsText_1.LanguageNo = 2) AND (AsText_2.LanguageNo = 2)
