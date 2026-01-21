--liquibase formatted sql

--changeset system:create-alter-view-PtAdmDebitAccountByProductView context:any labels:c-any,o-view,ot-schema,on-PtAdmDebitAccountByProductView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAdmDebitAccountByProductView
CREATE OR ALTER VIEW dbo.PtAdmDebitAccountByProductView AS
Select OO.Id As AdmPortfolioId, B.Id As PartnerId, O.Id As PortfolioId, A.Id As AccountId, 
 OO.PortfolioNo As AdmPortfolioNo, B.PartnerNo, O.PortfolioNo, A.AccountNo, Pos.ValueProductCurrency As Balance, Pri.ProductNo, Ref.Currency 
From PtPortfolio OO Join PtBase B On OO.PartnerId=B.Id 
Join PtPortfolio O On B.Id=O.PartnerId And B.HdVersionNo<999999999 And B.TerminationDate Is Null
    And O.TerminationDate Is Null And O.HdVersionNo<999999999 
Join PtAccountBase A On A.PortfolioId=O.Id And A.HdVersionNo<999999999 And A.TerminationDate Is Null 
Join PrReference Ref On Ref.AccountId=A.Id And Ref.HdVersionNo<999999999 
Join PtPosition Pos On Ref.Id=Pos.ProdReferenceId And Pos.HdVersionNo<999999999 
Join PrPrivate Pri On Ref.ProductId=Pri.ProductId And Pri.HdVersionNo<999999999 
Join (Select GL.Name As GroupName, G.SortNo, P.ProductNo
    From AsGroupTypeLabel TL Inner Join AsGroupType GT On TL.GroupTypeID=GT.ID And GT.TableName='PrPrivate'    
    Join AsGroup G On G.GroupTypeID=GT.ID And G.IsDefault=0    
    Join AsGroupLabel GL On G.ID=GL.GroupID    
    Join AsGroupMember M On M.GroupTypeID=GT.ID And M.GroupID=G.ID    
    Join PrPrivate P On M.TargetRowID =P.ID    
Where TL.Name='ForDebitProducts'
 And TL.HdVersionNo<999999999 
 And GT.HdVersionNo<999999999 And G.HdVersionNo<999999999  And GL.HdVersionNo<999999999 
 And M.HdVersionNo<999999999 And P.HdVersionNo<999999999) GG On Pri.ProductNo=GG.ProductNo 
