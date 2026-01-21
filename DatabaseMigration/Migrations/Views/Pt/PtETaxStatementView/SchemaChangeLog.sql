--liquibase formatted sql

--changeset system:create-alter-view-PtETaxStatementView context:any labels:c-any,o-view,ot-schema,on-PtETaxStatementView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtETaxStatementView
CREATE OR ALTER VIEW dbo.PtETaxStatementView AS
Select J.TaxReportJobNo, D.Id As TaxReportDataId, D.PartnerId, D.PartnerNoEdited,
Cast('CH'+RIGHT('00000'+Para.Value,5)
+FORMAT(IIF(D.PortfolioId Is Null, B.PartnerNo, O.PortfolioNo), REPLICATE('0', 14))
+Format(D.ValidPeriodEndDate,'yyyyMMdd')+'01' As varchar(80)) As Id,
Cast(GetDate() As datetime) As CreationDate,
Cast(Year(D.ValidPeriodEndDate) As smallint) As TaxPeriod,
D.ValidPeriodBeginDate As PeriodFrom, D.ValidPeriodEndDate As PeriodTo,
Cast('CH' As char(2)) As Country, D.FiscalDomicileCanton As Canton,
Cast(0 As money) As TotalTaxValue, 
Cast(0 As money) As TotalGrossRevenueA,
Cast(Null As money) As TotalGrossRevenueACanton, 
Cast(0 As money) As TotalGrossRevenueB,
Cast(Null As money) As TotalGrossRevenueBCanton, 
Cast(0 As money) As TotalWithHoldingTaxClaim,
Cast(21 As smallint) As MinorVersion,
D.PartnerNoEdited As ClientNumber, 
Cast(Case When B.SexStatusNo=1 Then 1 When B.SexStatusNo=2 Then 2 Else Null End As smallint) As Salutation,
Cast(LEFT((Case When B.FirstName Is Not Null Then Replace(FirstName,',',' ' +PN.Value+ ' ')
 When B.NameCont Is Not Null Then B.Name Else '' End)
  + IIF(B.UseMiddleName=1,' ' + Middlename,''),30) As nvarchar(50)) As FirstName, 
Cast(LEFT((Case When B.FirstName Is Not Null Then B.Name 
 When B.FirstName Is Null And B.NameCont Is Not Null Then B.NameCont Else B.Name End)
  + IIF(B.MaidenName Is Not Null And B.SexStatusNo<>5,'-'+B.MaidenName,''),30) As nvarchar(50)) As LastName,
CC.CountryCode As HelpDomicileCountry
From PtTaxReportData D Join PtTaxReportJob J On D.TaxReportJobId=J.Id
Join PtBase B On D.PartnerId=B.Id
Left Outer Join PtPortfolio O On D.PortfolioId=O.Id
Left Outer Join PtFiscalCountry CC On CC.PartnerId=D.PartnerId And CC.IsPrimaryCountry=1 
Join AsParameter Para On Para.Name='BCNo' 
Join AsParameterGroup PGS On Para.ParamGroupId=PGS.Id And PGS.GroupName='System'
Join AsParameter PN On PN.Name='AndWord'
Join AsParameterGroup PGN On PN.ParamGroupId=PGN.Id And PGN.GroupName='PartnerFunctions'
