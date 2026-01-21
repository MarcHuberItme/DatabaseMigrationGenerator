--liquibase formatted sql

--changeset system:create-alter-view-PtSisTransMessageView context:any labels:c-any,o-view,ot-schema,on-PtSisTransMessageView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtSisTransMessageView
CREATE OR ALTER VIEW dbo.PtSisTransMessageView AS
SELECT     dbo.PtTransMessageSis.*, 
dbo.PtTransMessageOut.Message AS Message, 
dbo.PtTransMessageOut.Status AS StatusOut, 
dbo.PtTransMessageOut.MessageReply AS MessageReplyOut
FROM         
dbo.PtTransMessageOut INNER JOIN
                      dbo.PtTransMessageSis ON dbo.PtTransMessageOut.TransMessageId = dbo.PtTransMessageSis.Id
