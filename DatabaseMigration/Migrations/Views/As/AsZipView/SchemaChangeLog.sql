--liquibase formatted sql

--changeset system:create-alter-view-AsZipView context:any labels:c-any,o-view,ot-schema,on-AsZipView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsZipView
CREATE OR ALTER VIEW dbo.AsZipView AS
SELECT TOP 100 PERCENT Id, HdVersionNo, HdPendingChanges, 
               HdPendingSubChanges, Zip, SubZip, Town, LanguageNo,
               SwissTownNo, 
               IsNull(Zip + '¦','') + IsNull(SubZip + '¦','') + IsNull(Town + '¦','') +  
               IsNull(SwissTownNo,'') ZipView
    FROM AsZip WHERE HdVersionNo BETWEEN 1 AND 999999998
