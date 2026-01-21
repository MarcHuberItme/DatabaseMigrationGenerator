--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenCollateralView context:any labels:c-any,o-view,ot-schema,on-AcFrozenCollateralView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenCollateralView
CREATE OR ALTER VIEW dbo.AcFrozenCollateralView AS
SELECT fc.*, IIF(fc.CollType=7000 And fc.CollSubType<>7000,60,60) As MappingTypeNo, 
IIF(FIN.PortfolioTypeNo=O.PortfolioTypeNo, 'N' +O.PortfolioNoText,  'N' +  Convert(varchar(11),fa.AccountNo)+'-'+Cast(G.ObjectSeqNo as varchar(7))) As Description, 
fc.CoValueTotAdjust * -1 As CoValueTotAdjustNeg,
fpv.FiscalDomicileCountry, ISNULL(fpv.c510_Override,fpv.CodeC510) AS CodeC510, fpv.LargeExpGroupNo, fpv.PartnerId
FROM AcFrozenCollateral fc JOIN AcFrozenAccount fa on fa.AccountId = fc.AccountId and fa.ReportDate = fc.ReportDate
Join PtAccountBase A On Fa.AccountId=A.Id
Join PtPortfolio O On A.PortfolioId=O.Id
Outer Apply (
	Select PT.PortfolioTypeNo
	From AsGroupLabel L Join AsGroup G On L.GroupId=G.Id
	Join AsGroupType T On G.GroupTypeId=T.Id
	Join AsGroupMember M On M.GroupId=G.Id And M.GroupTypeId=T.Id
	Join PtPortfolioType PT On PT.Id=M.TargetRowId
	Where L.Name='Mortgage Portfolios'
	And L.HdVersionNo<999999999 And G.HdVersionNo<999999999 And T.HdVersionNo<999999999 
	And M.HdVersionNo<999999999 And PT.HdVersionNo<999999999 
) FIN
LEFT OUTER JOIN CoBase c on fc.CollNo = c.Collno and fc.CollType = c.CollType --and (fc.CollSubType = c.Collsubtype Or fc.CollSubType In (7100,7200))
Left Outer Join ReObligation G On C.ObligationId=G.Id
LEFT OUTER JOIN AcFrozenPartnerView fpv on fpv.PartnerId = c.OwnerId  and fpv.ReportDate = fc.ReportDate
WHERE fc.FireAccountNo is not null
