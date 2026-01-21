--liquibase formatted sql

--changeset system:create-alter-view-PrSafeDepositView context:any labels:c-any,o-view,ot-schema,on-PrSafeDepositView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrSafeDepositView
CREATE OR ALTER VIEW dbo.PrSafeDepositView AS
Select
B.*,
X.TextShort AS BranchText,
E.TextShort AS TypeText,
P.ValidFrom AS PriceValidFrom,
P.Price,
IsNull(X.TextShort + ': ','') + str(B.BoxNo,5) + ' (' + IsNull(E.TextShort + ')',')') DepositDescription
FROM PrSafeDepositBox B
LEFT OUTER JOIN PrSafeDepositBoxType T ON B.TypeNo = T.TypeNo
LEFT OUTER JOIN PrSafeDepositBoxPrice P ON T.TypeNo = P.TypeNo
LEFT OUTER JOIN AsText E ON T.Id = E.MasterId
LEFT OUTER JOIN AsBranch H ON B.BranchNo = H.BranchNo
LEFT OUTER JOIN AsText X ON H.Id = X.MasterId
Where X.LanguageNo=2 And E.LanguageNo=2 
	And P.ID In (Select a.ID from PrSafeDepositBoxPrice a 
		Inner Join (Select TypeNo, Max(ValidFrom) As ValidFrom From PrSafeDepositBoxPrice Group By TypeNo) b
			On a.TypeNo=b.TypeNo And a.ValidFrom=b.ValidFrom)
