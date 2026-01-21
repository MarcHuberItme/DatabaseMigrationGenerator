--liquibase formatted sql

--changeset system:create-alter-view-PrPublicAssetTypeCollateral context:any labels:c-any,o-view,ot-schema,on-PrPublicAssetTypeCollateral,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPublicAssetTypeCollateral
CREATE OR ALTER VIEW dbo.PrPublicAssetTypeCollateral AS
Select Pub.ISINNo, V.ShortName, 
  Pub.InstrumentTypeNo,TI.TextShort As InstrumentTypeText,
  IA.CountryCode,
  Pub.ExposureCurrency,
  Pub.AssetTypeCalculated, ACX.TextShort As AssetCalText, 
  Pub.AssetTypeManual, AMX.TextShort As AssetManText,
  Pub.CollateralRateManual, Pub.CollateralRateCalculated,
  Cast(Case When Pub.AssetTypeManual Is Null And Pub.AssetTypeCalculated In (0, -1) Then 20
    When Pub.AssetTypeManual Is Not Null And Pub.AssetTypeManual<>Pub.AssetTypeCalculated 
        Then 30
    When Pub.AssetTypeManual Is Not Null And Pub.AssetTypeCalculated Is Not Null
	And Pub.AssetTypeManual=Pub.AssetTypeCalculated Then 40
    Else 10 
  End As tinyint) As AssetTypeException,
  Cast(Case When Pub.CollateralRateManual Is Null And Pub.CollateralRateCalculated =-1 Then 20
    When Pub.CollateralRateManual Is Not Null 
        And Pub.CollateralRateManual<>Pub.CollateralRateCalculated Then 30
    When Pub.CollateralRateManual Is Not Null And Pub.CollateralRateCalculated Is Not Null
	And Pub.CollateralRateManual=Pub.CollateralRateCalculated Then 40
    Else 10 
  End As tinyint) As CollateralRateException,
  V.LanguageNo
From PrPublic Pub Inner Join PrPublicDescriptionView V On Pub.ID=V.ID 
    And Pub.HdVersionNo<999999999
  Inner Join PrPublicInstrumentType PIT On Pub.InstrumentTypeNo=PIT.InstrumentTypeNo
  Inner Join AsText TI On TI.MasterID=PIT.ID And V.LanguageNo=TI.LanguageNo
  Inner Join PtBase IB On Pub.IssuerID=IB.ID And IB.HdVersionNo<999999999
  Inner Join PtAddress IA On IA.PartnerID=IB.ID And IA.AddressTypeNo=11 
    And IA.HdVersionNo<999999999
  Left Outer Join PrPublicAssetType AC On Pub.AssetTypeCalculated=AC.AssetTypeCode 
    And AC.HdVersionNo<999999999
  Left Outer Join AsText ACX On AC.ID=ACX.MasterID And V.LanguageNo=ACX.LanguageNo
  Left Outer Join PrPublicAssetType AM On Pub.AssetTypeManual=AM.AssetTypeCode 
    And AM.HdVersionNo<999999999
  Left Outer Join AsText AMX On AM.ID=AMX.MasterID And V.LanguageNo=AMX.LanguageNo
