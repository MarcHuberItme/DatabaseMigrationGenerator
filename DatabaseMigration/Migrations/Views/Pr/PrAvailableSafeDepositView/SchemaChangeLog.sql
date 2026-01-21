--liquibase formatted sql

--changeset system:create-alter-view-PrAvailableSafeDepositView context:any labels:c-any,o-view,ot-schema,on-PrAvailableSafeDepositView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrAvailableSafeDepositView
CREATE OR ALTER VIEW dbo.PrAvailableSafeDepositView AS
SELECT
B.Id,
B.HdPendingChanges,
B.HdPendingSubChanges,
B.HdVersionNo,
B.BranchNo,
X.TextShort AS BranchText,
B.BoxNo,
B.TypeNo,
E.TextShort AS TypeText,
P.ValidFrom AS PriceValidFrom,
P.Price,
P.MinAmount,
E.LanguageNo AS TypeLanguageNo,
X.LanguageNo AS BranchLanguageNo,
IsNull(X.TextShort + ': ','') + str(B.BoxNo,5) + ' (' + IsNull(E.TextShort + ')',')') DepositDescription
FROM PrSafeDepositBox B
LEFT OUTER JOIN PtAgrSafeDepositBox A ON B.Id = A.SafeDepositBoxId
LEFT OUTER JOIN PrSafeDepositBoxType T ON B.TypeNo = T.TypeNo
LEFT OUTER JOIN PrSafeDepositBoxPrice P ON T.TypeNo = P.TypeNo
LEFT OUTER JOIN AsText E ON T.Id = E.MasterId
LEFT OUTER JOIN AsBranch H ON B.BranchNo = H.BranchNo
LEFT OUTER JOIN AsText X ON H.Id = X.MasterId
WHERE (A.PartnerId IS NULL AND A.ExpirationDate IS NULL)
   OR B.Id NOT IN (SELECT SafeDepositBoxId FROM PtAgrSafeDepositBox
                          WHERE ExpirationDate > GETDATE() OR ExpirationDate is Null)

