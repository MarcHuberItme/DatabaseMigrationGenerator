--liquibase formatted sql

--changeset system:create-alter-procedure-GetReportPartnerInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetReportPartnerInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetReportPartnerInfo
CREATE OR ALTER PROCEDURE dbo.GetReportPartnerInfo
@PortfolioId UniqueIdentifier

AS

SELECT B.PartnerNo, B.YearOfBirth, B.LegalStatusNo, B.BranchNo, B.ProfitCenterNo,
               B.SegmentNo, B.BusinessTypeCode, B.ConsultantTeamName, B.NogaCode2008, B.NogaCode2008Ok,
               F.PartnerId, FD.SwissTownNo, ST.CantonSymbol, NA.CountryCode AS NationalityCountryCode,
               PtAddress.CountryCode, BR.Employees, UB.RankNo, PRC.Result, RC.RatingCode, RC.Rate
FROM   PtPortFolio F                    
             JOIN PtBase B     ON F.PartnerId = B.Id 
             JOIN PtAddress    ON F.PartnerId = PtAddress.PartnerId 
             LEFT OUTER JOIN PtFiscalDomicile FD   ON F.PartnerId = FD.PartnerId                      AND   (FD.HdVersionNo BETWEEN 1 AND 999999998 OR FD.HdVersionNo IS NULL)
             LEFT OUTER JOIN AsSwissTown   ST     ON FD.SwissTownNo = ST.SwissTownNo  AND   (ST.HdVersionNo BETWEEN 1 AND 999999998 OR ST.HdVersionNo IS NULL)
             LEFT OUTER JOIN PtNationality NA         ON F.PartnerId = NA.PartnerId                     AND   (NA.HdVersionNo BETWEEN 1 AND 999999998 OR NA.HdVersionNo IS NULL)
             LEFT OUTER JOIN PtBusinessRatio BR   ON F.PartnerId = BR.PartnerId
		    AND (BR.HdVersionNo < 999999999 OR BR.HdVersionNo IS NULL)
                                    AND  BR.Date = (SELECT Max(R.Date) FROM PtBusinessRatio R 
                                                                WHERE R.PartnerId = BR.PartnerId 
                                                                AND       R.HdVersionNo < 999999999)
             LEFT OUTER JOIN PtUserBase UB         ON F.PartnerId = UB.PartnerId
             LEFT OUTER JOIN PtRatingConsolidation PRC ON PRC.PartnerId = F.PartnerId
                                    AND  PRC.RatingTypeNo = 12 
                                    AND (PRC.HdVersionNo < 999999999 OR PRC.HdVersionNo IS NULL)
                                    AND  PRC.Ratingdate = (SELECT Max(A.Ratingdate) FROM PtRatingConsolidation A 
                                                                            WHERE  A.PartnerId = PRC.PartnerId 
                                                                            AND        A.RatingTypeNo = 12 AND A.HdVersionNo < 999999999)
             LEFT OUTER JOIN AsRatingCode RC ON PRC.Result = RC.CalculatedValue  AND (RC.HdVersionNo BETWEEN 1 AND 999999998 OR RC.HdVersionNo IS NULL)
WHERE  F.Id = @PortfolioId
AND        PtAddress.AddressTypeNo = 11
ORDER BY FD.IsPrimaryDomicile DESC, NationalityCountryCode ASC
