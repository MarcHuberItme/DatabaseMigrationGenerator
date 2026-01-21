--liquibase formatted sql

--changeset system:create-alter-view-PtPortfolioViewMortgage context:any labels:c-any,o-view,ot-schema,on-PtPortfolioViewMortgage,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPortfolioViewMortgage
CREATE OR ALTER VIEW dbo.PtPortfolioViewMortgage AS
SELECT        TOP (100) PERCENT 
                      O.Id, O.HdPendingChanges, O.HdPendingSubChanges, O.HdVersionNo,
                      O.PortfolioNoEdited, O.PortfolioNo,  
                         P.PartnerNo, P.PartnerNoEdited, 
                         P.FirstName,  P.Name,   A.Town 
FROM            dbo.PtPortfolio AS O INNER JOIN
                         dbo.PtBase AS P ON O.PartnerId = P.Id LEFT OUTER JOIN
                         dbo.PtAddress AS A ON P.Id = A.PartnerId AND A.AddressTypeNo = 11 INNER JOIN
                         dbo.PtPortfolioType AS T ON O.PortfolioTypeNo = T.PortfolioTypeNo AND T.HdVersionNo BETWEEN 1 AND 999999998
WHERE        (O.TerminationDate IS NULL)  AND (T.PortfolioTypeNo =
                             (SELECT       TOP 1 Port.PortfolioTypeNo
                               FROM            dbo.PtPortfolioType AS Port INNER JOIN
                                                         dbo.AsGroupMember AS mem ON Port.Id = mem.TargetRowId
                               WHERE        (mem.GroupId =
                                                             (SELECT        TOP (1) GroupId
                                                               FROM            dbo.AsGroupLabel
                                                               WHERE        (Name = 'Mortgage Portfolios'))) AND (mem.GroupTypeId =
                                                             (SELECT        TOP (1) GroupTypeId
                                                               FROM            dbo.AsGroupTypeLabel
                                                               WHERE        (Name = 'Portfolio Classes')))))
