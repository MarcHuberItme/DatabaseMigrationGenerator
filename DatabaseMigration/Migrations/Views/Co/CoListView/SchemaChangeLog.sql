--liquibase formatted sql

--changeset system:create-alter-view-CoListView context:any labels:c-any,o-view,ot-schema,on-CoListView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoListView
CREATE OR ALTER VIEW dbo.CoListView AS
select
       cob.Id as 'Id',
       'Account' as 'TypeName',
       cob.CollType as 'TypeNo',
       sub.Id as 'SubTypeId',
       sub.Collsubtype as 'SubTypeNo',
       subt.TextShort as 'SubTypeTranslationKey',
       cob.OwnerId as 'OwnerId',
       cob.Collno as 'SequenceNumber',
       cob.Inactflag as 'IsInactive',
       cob.ActivateDate as 'ActivationDate',
       cob.AccountId as 'ReferenceId',
       CONCAT ('{Produkt}: ', pri.ProductNo, ' ', prit.TextShort, ' ', '{Konto}: ', acb.AccountNoEdited, ' ', acb.CustomerReference) as 'Description', 
       cob.Bvalue as 'Value',
       prit.LanguageNo as 'LanguageNo'
from CoBase cob
left outer join CoSubtype sub on sub.Collsubtype = cob.Collsubtype
left outer join AsText subt on subt.MasterId = sub.Id and subt.MasterTableName = 'CoSubtype' and subt.LanguageNo = 0 -- This shall be supported in the future: the language code for translationKeys
left outer join PtAccountBase acb on acb.Id = cob.AccountId
left outer join PrReference pre on pre.AccountId = acb.Id
left outer join PrPrivate pri on pri.ProductId = pre.ProductId
left outer join AsText prit on prit.MasterId = pri.Id and prit.MasterTableName = 'PrPrivate'
where cob.CollType = 1000

UNION

select
       cob.Id as 'Id',
       'CustodyAccount' as 'TypeName',
       cob.CollType as 'TypeNo',
       sub.Id as 'SubTypeId',
       sub.Collsubtype as 'SubTypeNo',
       subt.TextShort as 'SubTypeTranslationKey',
       cob.OwnerId as 'OwnerId',
       cob.Collno as 'SequenceNumber',
       cob.Inactflag as 'IsInactive',
       cob.ActivateDate as 'ActivationDate',
       cob.PortfolioId as 'ReferenceId',
       CONCAT ('{Portfoliotyp}: ', por.PortfolioTypeNo, ' ', pott.TextShort, ' ', '{Portfolio}: ',por.PortfolioNoEdited, ' ', por.CustomerReference) as 'Description', 
       cob.Bvalue as 'Value',
       pott.LanguageNo as 'LanguageNo'
from CoBase cob
left outer join CoSubtype sub on sub.Collsubtype = cob.Collsubtype
left outer join AsText subt on subt.MasterId = sub.Id and subt.MasterTableName = 'CoSubtype' and subt.LanguageNo = 0 -- This shall be supported in the future: the language code for translationKeys
left outer join PtPortfolio por on por.Id = cob.PortfolioId
left outer join PtPortfolioType pot on pot.PortfolioTypeNo = por.PortfolioTypeNo
left outer join AsText pott on pott.MasterId = pot.Id and pott.MasterTableName = 'PtPortfolioType'
where cob.CollType = 2000

UNION

select
       cob.Id as 'Id',
       'Guarantee' as 'TypeName',
       cob.CollType as 'TypeNo',
       sub.Id as 'SubTypeId',
       sub.Collsubtype as 'SubTypeNo',
       subt.TextShort as 'SubTypeTranslationKey',
       cob.OwnerId as 'OwnerId',
       cob.Collno as 'SequenceNumber',
       cob.Inactflag as 'IsInactive',
       cob.ActivateDate as 'ActivationDate',
       cob.Id as 'ReferenceId', -- Self reference??
       cob.Description as 'Description', 
       cob.Bvalue as 'Value',
       null as 'LanguageNo'
from CoBase cob
left outer join CoSubtype sub on sub.Collsubtype = cob.Collsubtype
left outer join AsText subt on subt.MasterId = sub.Id and subt.MasterTableName = 'CoSubtype' and subt.LanguageNo = 0 -- This shall be supported in the future: the language code for translationKeys
where cob.CollType = 4000

UNION

select
       cob.Id as 'Id',
       'InsurancePolicy' as 'TypeName',
       cob.CollType as 'TypeNo',
       sub.Id as 'SubTypeId',
       sub.Collsubtype as 'SubTypeNo',
       subt.TextShort as 'SubTypeTranslationKey',
       cob.OwnerId as 'OwnerId',
       cob.Collno as 'SequenceNumber',
       cob.Inactflag as 'IsInactive',
       cob.ActivateDate as 'ActivationDate',
       cob.Insurancepolice as 'ReferenceId', -- Self reference??
       CONCAT ('{Policen-Nr}: ', ins.PoliceNo, ' ', '{versicherte Persin}: ', ins.InsuredPerson, ' ', '{Wert}: ', ins.Value) as 'Description', 
       cob.Bvalue as 'Value',
       null as 'LanguageNo'
from CoBase cob
left outer join CoSubtype sub on sub.Collsubtype = cob.Collsubtype
left outer join AsText subt on subt.MasterId = sub.Id and subt.MasterTableName = 'CoSubtype' and subt.LanguageNo = 0 -- This shall be supported in the future: the language code for translationKeys
left outer join PrInsurancePolice ins on ins.Id = cob.Insurancepolice
where cob.CollType = 5000

UNION

select
       cob.Id as 'Id',
       'Other' as 'TypeName',
       cob.CollType as 'TypeNo',
       sub.Id as 'SubTypeId',
       sub.Collsubtype as 'SubTypeNo',
       subt.TextShort as 'SubTypeTranslationKey',
       cob.OwnerId as 'OwnerId',
       cob.Collno as 'SequenceNumber',
       cob.Inactflag as 'IsInactive',
       cob.ActivateDate as 'ActivationDate',
       cob.Id as 'ReferenceId', -- Self reference??
       CONCAT('{Beschreibung}: ', cob.Description, ' ', '{Konto-Nr}: ', cob.Uaccountnr, ' ', '{Versicherungs-Nr.}: ', cob.Uinsurancenr, ' ', '{Name Institut}: ',cob.Unameinsbank, ' ', '{BVG verfügbar}: ', cob.Ubvgfree, ' ', '{BVG verpfändbar}: ', cob.Ubvgfreeple) as 'Description',
       cob.Bvalue as 'Value',
       null as 'LanguageNo'
from CoBase cob
left outer join CoSubtype sub on sub.Collsubtype = cob.Collsubtype
left outer join AsText subt on subt.MasterId = sub.Id and subt.MasterTableName = 'CoSubtype' and subt.LanguageNo = 0 -- This shall be supported in the future: the language code for translationKeys
where cob.CollType = 6000

UNION

select
       cob.Id as 'Id',
       'RightOfLien' as 'TypeName',
       cob.CollType as 'TypeNo',
       sub.Id as 'SubTypeId',
       sub.Collsubtype as 'SubTypeNo',
       subt.TextShort as 'SubTypeTranslationKey',
       cob.OwnerId as 'OwnerId',
       cob.Collno as 'SequenceNumber',
       cob.Inactflag as 'IsInactive',
       cob.ActivateDate as 'ActivationDate',
       cob.ObligationId as 'ReferenceId',
       CONCAT('{Schuldbrieftyp}: ', obl.ObligTypeNo, ' ', obtt.TextLong, '{Nominal}: ', obl.ObligAmount, '{Rang}: ', obl.ObligRank, ' ', '{Vorgang}: ', obl.AntecedentAmount, ' ', '{Beschreibung}: ', obl.Description) as 'Description',
       cob.Bvalue as 'Value',
       obtt.LanguageNo as 'LanguageNo'
from CoBase cob
left outer join CoSubtype sub on sub.Collsubtype = cob.Collsubtype
left outer join AsText subt on subt.MasterId = sub.Id and subt.MasterTableName = 'CoSubtype' and subt.LanguageNo = 0 -- This shall be supported in the future: the language code for translationKeys
left outer join ReObligation obl on obl.Id = cob.ObligationId
left outer join ReObligType obt on obt.ObligTypeNo = obl.ObligTypeNo
left outer join AsText obtt on obtt.MasterId = obt.Id and obtt.MasterTableName = 'ReObligType'
where cob.CollType = 7000
