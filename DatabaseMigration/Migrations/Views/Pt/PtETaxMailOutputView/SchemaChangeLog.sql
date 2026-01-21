--liquibase formatted sql

--changeset system:create-alter-view-PtETaxMailOutputView context:any labels:c-any,o-view,ot-schema,on-PtETaxMailOutputView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtETaxMailOutputView
CREATE OR ALTER VIEW dbo.PtETaxMailOutputView AS
Select J.TaxReportJobNo, D.Id AS TaxReportDataId, D.PartnerId, B.PartnerNo, D.PartnerNoEdited, O.PortfolioNo,
Cast(Case When D.PortfolioId Is Not Null And CPO.AddressId Is Not Null Then CPO.AddressId 
  Else CB.AddressId End As uniqueidentifier) As AddressId,
Cast(Case When D.PortfolioId Is Not Null And CPO.AddressId Is Not Null Then CPO.IsPrimaryCorrAddress 
  Else CB.IsPrimaryCorrAddress End As bit) As IsPrimaryCorrAddress,
Cast(Case When D.PortfolioId Is Not Null And CPO.AddressId Is Not Null Then CPO.AttentionOf 
  Else CB.AttentionOf End As nvarchar(30)) As AttentionOf,
Cast(Case When D.PortfolioId Is Not Null And CPO.AddressId Is Not Null Then CPO.CarrierTypeNo 
  Else CB.CarrierTypeNo End As int) As CarrierTypeNo,
Cast(Case When D.PortfolioId Is Not Null And CPO.AddressId Is Not Null Then CPO.DetourGroup 
  Else CB.DetourGroup End As varchar(32)) As DetourGroup,
CAST(9400 As int) AS DeliveryRuleNo,
Cast(IIF((Case When D.PortfolioId Is Not Null And CPO.AddressId Is Not Null Then CPO.CarrierTypeNo Else CB.CarrierTypeNo End)=51,
	(Case When D.PortfolioId Is Not Null And CPO.AddressId Is Not Null Then IsNull(CPO.CopyNumber,0) Else IsNull(CB.CopyNumber,0) End),0) As tinyint) As CopyNumber,
I.Id As CorrItemId, 
Cast(IIF(EB.Id Is Not Null,1,0) As bit) As CanEBDoc
From PtTaxReportData D Join PtTaxReportJob J ON D.TaxReportJobId = J.Id 
Join PtBase B ON D.PartnerId = B.Id
Join AsParameter P153 On P153.Name='EStvzCorrItemNo'
Join AsParameter GList On GList.Name='EStvzCorrItemGroupNo'
Join AsParameter L51 On L51.Name='CarrierType51List'
Join AsCorrItem I ON I.ItemNo = Cast(P153.Value as int)
Left Outer Join AsParameter VA On VA.Name='VAProvisionPortfolioTypes' 
Left Outer Join PtPortfolio O ON D.PortfolioId = O.Id 
	AND ((VA.Name Is Not Null And CHARINDEX(Cast(O.PortfolioTypeNo As varchar),VA.Value)=0) Or VA.Name Is Null)
Outer Apply (
    Select D.PartnerId, CPO1.PortfolioId, GRP.CopyNumber, 
    CPO1.AddressId, CPO1.AttentionOf, 
    Cast(IIF(CHARINDEX(','+Cast(CPO1.CarrierTypeNo as varchar)+',',','+L51.Value+',')>0,51,CPO1.CarrierTypeNo) As int) As CarrierTypeNo,
    CPO1.DetourGroup, CPO1.IsPrimaryCorrAddress
    From PtCorrPortfolio CPO1 Join (
		Select CPO0.Id, Max(IsNull(CPG.CopyNumber,0)) As CopyNumber
		From PtCorrPortfolio CPO0 Join PtCorrPortfolioItemGroup CPG On CPO0.Id=CPG.CorrPortfolioId 
		  And CHARINDEX(','+Cast(CPG.CorrItemGroupNo as varchar)+',',','+GList.Value+',')>0
		  And CPO0.HdVersionNo<999999999 And CPG.HdVersionNo<999999999 
		Join AsCorrItemAssign GA0 On GA0.CorrItemGroupNo=CPG.CorrItemGroupNo And GA0.CorrItemId=I.Id And GA0.HdVersionNo<999999999
		Where CPO0.PortfolioId=O.Id 
		Group By CPO0.Id) GRP On CPO1.Id=GRP.Id
    ) As CPO
Outer Apply (
	Select CP.PartnerId, Null As PortfolioId, GR.CopyNumber, 
	CP.AddressId, CP.AttentionOf, 
	Cast(IIF(CHARINDEX(','+Cast(CP.CarrierTypeNo as varchar)+',',','+L51.Value+',')>0,51,CP.CarrierTypeNo) As int) As CarrierTypeNo,
	CP.DetourGroup, CP.IsPrimaryCorrAddress
	From PtCorrPartner CP Join (
		Select CP0.Id, Max(IsNull(G.CopyNumber,0)) As CopyNumber
		From PtCorrPartner CP0 Join PtCorrPartnerItemGroup G On CP0.Id=G.CorrPartnerId 
		And CHARINDEX(','+Cast(G.CorrItemGroupNo as varchar)+',',','+GList.Value+',')>0
		And CP0.HdVersionNo<999999999 And G.HdVersionNo<999999999 
		Join AsCorrItemAssign GA1 On GA1.CorrItemGroupNo=G.CorrItemGroupNo And GA1.CorrItemId=I.Id And GA1.HdVersionNo<999999999
		Where 1=1
		And ((CP0.PartnerId=B.Id And D.PortfolioId Is Null) Or (CP0.PartnerId=O.PartnerId And D.PortfolioId Is Not Null And CPO.AddressId Is Null))
		Group By CP0.Id) GR On GR.Id=CP.Id
    ) CB
Outer Apply (Select Top 1 E.*
    From PtAgrEBanking E Join PtAgrPartnerPermission M On M.PartnerId=E.PartnerId And M.EBankingPartnerDocumentAllowed=1
    Where B.Id=E.PartnerId And (E.ExpirationDate Is Null Or E.ExpirationDate>GetDate()) And E.HdVersionNo<999999999 And M.HdVersionNo<999999999) EB	  
Where 1=1
And ((D.PortfolioId Is Null) Or (D.PortfolioId Is Not Null And O.Id Is Not Null))
