--liquibase formatted sql

--changeset system:create-alter-view-PtProxyView context:any labels:c-any,o-view,ot-schema,on-PtProxyView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtProxyView
CREATE OR ALTER VIEW dbo.PtProxyView AS
SELECT g.Id As GeberPartnerId, g.PartnerNo As GeberPartnerNo, g.Name As GeberName, g.FirstName As GeberVorName, g.TerminationDate As GeberSaldDatum,
       n.Id As NehmerId, n.PartnerNo As NehmerPartnerNo, n.Name As NehmerName, n.FirstName As NehmerVorname, n.TerminationDate As NehmerSaldDatum,
       c.Name AS KontaktpersonName, c.FirstName AS KontaktpersonVorname,
       r.RoleNo,
       s.ValidTo As ValidToAgreement, s.HdVersionNo As AgreementVersionNo, s.HdChangeDate As AgreementChangeDate,
       pd.ValidTo As ValidToDetail, pd.HdVersionNo As DetailVersionNo, pd.HdChangeDate As DetailChangeDate,
       p.Id As PortfolioId, p.PortfolioNo, p.TerminationDate As PortfolioTerminationDate,
       b.Id As AccountId, b.AccountNo, b.TerminationDate As AccountTerminationDate,
       'RelationSlave' As Origin
FROM PtBase g
   JOIN  PtRelationMaster m on m.PartnerId = g.id
   JOIN PtRelationSlave s on s.MasterId = m.Id
   JOIN PtBase n on n.Id = s.PartnerId
   LEFT OUTER JOIN PtProxyDetail pd on pd.RelationSlaveId = s.Id and pd.HdVersionNo < 999999999
   LEFT OUTER JOIN PtPortfolio p on p.Id = pd.PortfolioId
   LEFT OUTER JOIN PtAccountBase b on b.Id = pd.AccountId 
   LEFT OUTER JOIN PtContactPerson c ON c.Id = s.ContactPersonId and c.HdVersionNo < 999999999
   LEFT OUTER JOIN PtContactPersonRole r on r.Id = c.ContactPersonRoleId
WHERE m.RelationTypeNo = 30 
   AND (m.HdVersionNo < 999999999 or Datediff(YYYY,m.HdChangeDate, GetDate()) <= 10)
   AND (s.HdVersionNo < 999999999 or Datediff(YYYY,s.HdChangeDate, GetDate()) <= 10)
   
UNION

SELECT g.Id As GeberPartnerId, g.PartnerNo As GeberPartnerNo, g.Name As GeberName, g.FirstName As GeberVorName, g.TerminationDate As GeberSaldDatum,
       n.Id As NehmerId, n.PartnerNo As NehmerPartnerNo, n.Name As NehmerName, n.FirstName As NehmerVorname, n.TerminationDate As NehmerSaldDatum,
       c.Name AS KontaktpersonName, c.FirstName AS KontaktpersonVorname,
       r.RoleNo,
       ValidToAgreement = CASE
          WHEN a.ExpirationDate >= '22990101' THEN NULL
          ELSE a.ExpirationDate
       END, a.HdVersionNo As AgreementVersionNo, a.HdChangeDate As AgreementChangeDate,
       ValidToDetail = CASE 
          WHEN d.ValidTo >= '99991231' THEN NULL
          ELSE d.ValidTo
       END,  d.HdVersionNo As DetailVersionNo, d.HdChangeDate As DetailChangeDate,
       Null As PortfolioId, Null As PortfolioNo, NULL As PortfolioTerminationDate,
       b.Id As AccountId, b.AccountNo, b.TerminationDate As AccountTerminationDate,
       'E-Banking' As Origin
FROM PtBase n
   JOIN PtAgrEbanking a on a.PartnerId = n.Id
   JOIN PtAgrEbankingDetail d on d.AgrEbankingId = a.Id
   JOIN PtAccountBase b on b.Id = d.AccountId
   JOIN PtPortfolio p on p.Id = b.PortfolioId
   JOIN PtBase g on g.Id = p.PartnerId
   LEFT OUTER JOIN PtContactPerson c ON c.Id = a.ContactPersonId and c.HdVersionNo < 999999999
   LEFT OUTER JOIN PtContactPersonRole r on r.Id = c.ContactPersonRoleId
WHERE (a.HdVersionNo < 999999999 OR Datediff(YYYY,a.HdChangeDate, GetDate()) <= 10)
   AND (d.HdVersionNo < 999999999 OR Datediff(YYYY,d.HdChangeDate, GetDate()) <= 10)
   AND NOT (a.ContactPersonId IS NULL AND g.Id = n.Id)

UNION

SELECT g.Id As GeberPartnerId, g.PartnerNo As GeberPartnerNo, g.Name As GeberName, g.FirstName As GeberVorName, g.TerminationDate As GeberSaldDatum,
       n.Id As NehmerId, n.PartnerNo As NehmerPartnerNo, n.Name As NehmerName, n.FirstName As NehmerVorname, n.TerminationDate As NehmerSaldDatum,
       c.Name AS KontaktpersonName, c.FirstName AS KontaktpersonVorname,
       r.RoleNo,
       ValidToAgreement = CASE
          WHEN a.ExpirationDate >= '22990101' THEN NULL
          ELSE a.ExpirationDate
       END, a.HdVersionNo As AgreementVersionNo, a.HdChangeDate As AgreementChangeDate,
       ValidToDetail = CASE 
          WHEN d.ValidTo >= '99991231' THEN NULL
          ELSE d.ValidTo
       END, d.HdVersionNo As DetailVersionNo, d.HdChangeDate As DetailChangeDate,
       p.Id As PortfolioId, p.PortfolioNo, p.TerminationDate As PortfolioTerminationDate,
       Null As AccountId, Null As AccountNo, Null As AccountTerminationDate,
       'E-Banking' As Origin
FROM PtBase n
   JOIN PtAgrEbanking a on a.PartnerId = n.Id
   JOIN PtAgrEbankingDetail d on d.AgrEbankingId = a.Id
   JOIN PtPortfolio p on p.Id = d.PortfolioId
   JOIN PtBase g on g.Id = p.PartnerId
   LEFT OUTER JOIN PtContactPerson c ON c.Id = a.ContactPersonId and c.HdVersionNo < 999999999
   LEFT OUTER JOIN PtContactPersonRole r on r.Id = c.ContactPersonRoleId
WHERE (a.HdVersionNo < 999999999 OR Datediff(YYYY,a.HdChangeDate, GetDate()) <= 10)
   AND (d.HdVersionNo < 999999999 OR Datediff(YYYY,d.HdChangeDate, GetDate()) <= 10)
   AND NOT (a.ContactPersonId IS NULL AND g.Id = n.Id)


