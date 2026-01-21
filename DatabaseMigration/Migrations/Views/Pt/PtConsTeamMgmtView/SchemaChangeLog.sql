--liquibase formatted sql

--changeset system:create-alter-view-PtConsTeamMgmtView context:any labels:c-any,o-view,ot-schema,on-PtConsTeamMgmtView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtConsTeamMgmtView
CREATE OR ALTER VIEW dbo.PtConsTeamMgmtView AS
SELECT TOP 100 PERCENT ptb.Id , ptb.HdCreateDate , ptb.HdCreator  
         , ptb.HdChangeDate , ptb.HdChangeUser , ptb.HdEditStamp   
         , ptb.HdVersionNo , ptb.HdProcessId , ptb.HdStatusFlag   
         , ptb.HdNoUpdateFlag , ptb.HdPendingChanges 
         , ptb.HdPendingSubChanges , ptb.HdTriggerControl
         , ptb.PartnerNo , ptb.FirstName , ptb.Name , ptb.YearOfBirth  
         , ptb.DateOfDeath ,  ptb.BusinessTypeCode , ptb.SegmentNo
         , pta.ZIP , pta.CountryCode , ptb.ConsultantTeamName 
         , pca.EvaluationDate , pca.RegionGroup , pca.SegmentNoEval     
         , pca.AgeGroup , pca.BusinessTypeGroup , pca.ConsTeam 
         , pca.Changed , pca.DateRevised , pca.Id AS CtmId , ax.TextShort AS ConsultantTeam
FROM PtBase ptb 
   INNER JOIN PtAddress pta ON ptb.Id = pta.PartnerId AND pta.AddressTypeNo = 11 
   LEFT OUTER JOIN ( 
         SELECT pa.Id , pa.PartnerId , pa.Changed , pa.DateRevised 
               , pa.ConsTeam , pa.AgeGroup , pa.SegmentNoEval 
               , pa.BusinessTypeGroup , pa.RegionGroup , pam.EvaluationDate
         FROM PtCTMAssignment pa 
             INNER JOIN ( 
                  SELECT  pa1.PartnerId , MAX(pa1.EvaluationDate) AS EvaluationDate
                  FROM PtCTMAssignment pa1
                  WHERE CONVERT(CHAR(10) , pa1.EvaluationDate , 112) <= CONVERT(CHAR(10) , GETDATE() , 112)
                  GROUP BY pa1.PartnerId 
               ) AS pam ON pa.partnerId = pam.PartnerId AND pam.EvaluationDate = pa.EvaluationDate
      ) AS pca ON ptb.Id = pca.PartnerId AND ptb.HdVersionNo BETWEEN 1 AND 999999998 
   LEFT OUTER JOIN AsUserGroup aug ON pca.ConsTeam = aug.UserGroupName AND aug.HdVersionNo BETWEEN 1 AND 999999998
   LEFT OUTER JOIN AsText ax ON aug.Id = ax.MasterId AND ax.LanguageNo = 2
WHERE ptb.HdVersionNo BETWEEN 1 AND 999999998
ORDER BY ptb.PartnerNo , ptb.Name , ptb.ConsultantTeamName
