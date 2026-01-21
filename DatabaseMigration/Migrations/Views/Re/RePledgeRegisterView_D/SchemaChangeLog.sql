--liquibase formatted sql

--changeset system:create-alter-view-RePledgeRegisterView_D context:any labels:c-any,o-view,ot-schema,on-RePledgeRegisterView_D,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view RePledgeRegisterView_D
CREATE OR ALTER VIEW dbo.RePledgeRegisterView_D AS
SELECT prg.Id, prg.ReBaseId, prg.PledgeRegisterNo, prg.PledgeRegisterPartNo
		, prg.PledgeTypeId, ast0.TextShort as PledgeTypeTxt
		, prg.PledgeTransTypeNo, ast1.TextShort as PledgeTransTypeTxt
		, prg.StatusNo, ast2.TextShort as StatusNoTxt
		, prg.StatusNoPfB, ast3.TextShort as StatusNoPfBTxt
		, prg.PartnerId, prg.BCNumber, prg.PfBNo, prg.OpeningDate
		, prg.Currency, prg.PledgeAmount, prg.PledgeAmountAdjusted
		, prg.AcceptanceDate, prg.AcceptanceOperator, prg.ValueDate
		, prg.ValuationOperator, prg.ValueAmount, prg.ValueAmountAdjusted
		, prg.ValueAmountManual, prg.ValueAmountMaximum, prg.TotalDebitAmount
		, prg.TotalColateralValue, prg.EarningAmount
		, prg.ExposureValueTypeNo, ast4.TextShort As ExposureValueTypeTxt
		, prg.ExposureRate, prg.ExposureValue, prg.ExposureDate
		, prg.Internaltext, prg.UserText, prg.Externaltext
		, prg.ImportantExternalText, prg.ExternalTextDate, prg.ExternalTextCode
		, prg.ChangeContactPersonId, prg.SignerContactPersonId     -- PtContactPerson
		, prg.HistoryVersion, prg.OverallLien, prg.MemberUniqueKey
		, prg.PledgeOrderField, prg.Recalculation, prg.TotalExit
		, prg.GenerateReply, prg.PremisesId, prg.AuditDate
		, prg.AuditRemark, prg.AuditName, prg.PfBSendDate

FROM RePledgeRegister prg

INNER JOIN RePledgeType				rpt	ON prg.PledgeTypeId = rpt.Id
INNER JOIN AsText ast0					ON rpt.Id = ast0.MasterId

INNER JOIN RePledgeTransType		                ptt	ON prg.PledgeTransTypeNo = ptt.PledgeTransTypeNo
INNER JOIN AsText ast1					ON ptt.ID = ast1.MasterId

INNER JOIN RePledgeRegisterStatus	                                prs	ON prg.StatusNo = prs.StatusNo
INNER JOIN AsText ast2					ON prs.Id = ast2.MasterId

INNER JOIN RePledgeRegisterStatus	                                prs2	ON prg.StatusNoPfB = prs2.StatusNo
INNER JOIN AsText ast3					ON prs2.Id = ast3.MasterId

INNER JOIN ReValueType				rvt	ON prg.ExposureValueTypeNo = rvt.ValueTypeNo
INNER JOIN AsText ast4					ON rvt.Id = ast4.MasterId

WHERE	ast0.LanguageNo = 2
AND	ast1.LanguageNo = 2
AND	ast2.LanguageNo = 2
AND	ast3.LanguageNo = 2
AND	ast4.LanguageNo = 2

