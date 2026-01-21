--liquibase formatted sql

--changeset system:create-alter-procedure-RePfBAllocation_History context:any labels:c-any,o-stored-procedure,ot-schema,on-RePfBAllocation_History,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure RePfBAllocation_History
CREATE OR ALTER PROCEDURE dbo.RePfBAllocation_History
AS
SET NOCOUNT ON

INSERT INTO RePfBAllocationHistory ( RePfBRelBCId , HdVersionNo , BcNumber  
      , AllocationSum , DateHistory , HdCreator , HdChangeUser  
	) SELECT rprb.Id , 1 , rprb.BcNo 
         , (SELECT SUM(lb.TotalAllocation) FROM RePfBLoanBC lb 
              INNER JOIN RePfBRelBC rb ON lb.BCId = rb.Id WHERE lb.BCId = rprb.Id AND lb.HdVersionNo BETWEEN 1 AND 999999998) 
           AS AllocationSum  
         , CONVERT(CHAR(10) , GETDATE() , 112) AS DateHistory 
         , 'PFB\finstarcons', 'PFB\finstarcons'   
      FROM RePfBLoan rpl
      INNER JOIN RePfBLoanBC rplb ON rpl.Id = rplb.LoanId
      INNER JOIN RePfBRelBC rprb ON rplb.bcid = rprb.id 
      WHERE (rplb.HdVersionNo BETWEEN 1 AND 999999998) AND (rprb.HdVersionNo BETWEEN 1 AND 999999998)
         AND (CONVERT(CHAR(10) , GETDATE() , 112) BETWEEN (CONVERT(CHAR(10) , rpl.PaymentDate , 112)) AND CONVERT(CHAR(10) , rpl.ValidTo , 112))
         AND (rpl.HdVersionNo BETWEEN 1 AND 999999998) AND (rprb.IsDirectMember = 1 OR rprb.BcNo = 80000)
      GROUP BY rprb.BcNo , rprb.Id

INSERT INTO RePfBAllocationHistory ( RePfBRelBCId , HdVersionNo , BcNumber  
      , AllocationSum , DateHistory , HdCreator , HdChangeUser  
	) SELECT  rprb.Id , 1, rprb.BcNo  
         , (SELECT SUM(rl.Allocation) FROM RePfBRelLoan rl 
              INNER JOIN RePfBRelBC rb ON rl.BCId = rb.Id WHERE rl.BCId = rprb.Id AND rl.HdVersionNo BETWEEN 1 AND 999999998) 
           AS AllocationSum  
         , CONVERT(CHAR(10) , GETDATE() , 112) AS DateHistory
         , 'PFB\finstarcons', 'PFB\finstarcons'
      FROM RePfBLoan rpl  
      INNER JOIN RePfBRelLoan rprl ON  rpl.Id = rprl.LoanId 
      INNER JOIN RePfBRelBC rprb ON rprl.BCId = rprb.Id  
      WHERE (rprl.HdVersionNo BETWEEN 1 AND 999999998) AND (rprb.HdVersionNo BETWEEN 1 AND 999999998)
         AND (rpl.HdVersionNo BETWEEN 1 AND 999999998) AND (rprb.IsDirectMember = 0) AND rprb.BcNo <> 80000
         AND (CONVERT(CHAR(10) , GETDATE() , 112) BETWEEN (CONVERT(CHAR(10) , rpl.PaymentDate , 112)) AND CONVERT(CHAR(10) , rpl.ValidTo , 112))
      GROUP BY rprb.BcNo , rprb.Id

SET NOCOUNT OFF


