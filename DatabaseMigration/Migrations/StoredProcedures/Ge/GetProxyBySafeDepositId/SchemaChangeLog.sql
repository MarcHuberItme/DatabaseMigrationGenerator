--liquibase formatted sql

--changeset system:create-alter-procedure-GetProxyBySafeDepositId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetProxyBySafeDepositId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetProxyBySafeDepositId
CREATE OR ALTER PROCEDURE dbo.GetProxyBySafeDepositId
@MasterId UniqueIdentifier,
@SafeDepositId UniqueIdentifier,
@Date Datetime

AS

Select R.ID As RelationSlaveID, R.PartnerId, R.ContactPersonId,
    Case When P.ValidFrom Is Null Then R.ValidFrom
         When P.ValidFrom Is Not Null And R.ValidFrom > P.ValidFrom  Then R.ValidFrom 
         Else P.ValidFrom End As ValidFrom,  
    Case When P.ValidTo Is Null Then R.ValidTo
         When P.ValidTo Is Not Null And R.ValidTo > P.ValidTo Then P.ValidTo 
         Else R.ValidTo End As ValidTo,  
    P.ProxyRightNo, R.ProxyRightNo as AuthorityType,
    R.DisposalRightNo,R.Instruction, R.InstructionVerifyFlag, P.Instruction as InstructionDetail,
	P.PortfolioID, P.AccountID, P.SafeDepositId,
	Case When BS.ID Is Not Null Then BS.Name
		When BS.ID Is Null And BC.ID Is Not Null Then BC.Name End As Name,
	Case When BS.ID Is Not Null Then BS.FirstName
		When BS.ID Is Null And BC.ID Is Not Null Then BC.FirstName End As FirstName,
	Case When BS.ID Is Not Null Then BS.NameCont
		When BS.ID Is Null And BC.ID Is Not Null Then '' End As NameCont,
	Case When BS.ID Is Not Null Then BS.DateOfBirth
		When BS.ID Is Null And BC.ID Is Not Null Then BC.DateOfBirth End As DateOfBirth,
	Case When BS.ID Is Not Null Then BS.PartnerNoEdited
		When BS.ID Is Null And BC.ID Is Not Null Then '' End As PartnerNoEdited
From PtRelationSlave R Inner Join PtRelationMaster M On R.MasterID=M.ID
Inner Join PtProxyDetail P  On R.Id = P.RelationSlaveId And P.HdVersionNo < 999999999
	And (P.ValidFrom Is Null Or (P.ValidFrom <= @Date And (P.ValidTo >= @Date Or P.ValidTo is Null) ))
Left Outer Join PtBase BS On R.PartnerID=BS.ID And R.PartnerID<>M.PartnerID
Left Outer Join PtContactPerson BC On R.ContactPersonID=BC.ID And R.PartnerID=M.PartnerID
Where R.MasterID = @MasterId And M.HdVersionNo<999999999 And R.HdVersionNo < 999999999 
	And (R.ValidFrom <= @Date) And (R.ValidTo >= @Date Or R.ValidTo is Null) 
	And (P.SafeDepositId = @SafeDepositId
     Or (P.PortfolioId Is NULL And P.AccountId Is NULL And P.SafeDepositId Is NULL) )  --And P.ProxyRightNo<>3
Order By Name, FirstName, P.ProxyRightNo ASC
