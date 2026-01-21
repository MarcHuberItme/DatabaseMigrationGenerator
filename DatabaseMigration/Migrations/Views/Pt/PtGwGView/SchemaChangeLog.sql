--liquibase formatted sql

--changeset system:create-alter-view-PtGwGView context:any labels:c-any,o-view,ot-schema,on-PtGwGView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtGwGView
CREATE OR ALTER VIEW dbo.PtGwGView AS
SELECT      PtBase.PartnerNoEdited,
                    PtBase.BusinessTypeCode,
                    PtBase.FirstName,
                    PtBase.Name,
                    PtBase.NameCont,
                    PtBase.DateOfBirth,
                    PtBase.ConsultantTeamName,
                    PtProfile.MoneyLaunderSuspect,
                    PtProfile.MoneyLaunderRemark,
                    PtProfile.ProfessionId,
                    PtProfile.EducationLevelNo
FROM          PtProfile INNER JOIN
                    PtBase ON  PtProfile.PartnerId =  PtBase.Id
