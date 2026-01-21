--liquibase formatted sql

--changeset system:create-alter-procedure-InsertNewsletterMail context:any labels:c-any,o-stored-procedure,ot-schema,on-InsertNewsletterMail,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure InsertNewsletterMail
CREATE OR ALTER PROCEDURE dbo.InsertNewsletterMail

@id uniqueidentifier,
@creator varchar(50)

AS

INSERT INTO PtEbNewsletterMail(HdVersionNo, HdCreator, HdChangeUser, HdTriggerControl, EmailAddress, NewsletterId)
SELECT 1, @creator, @creator, 1, PNS.EmailAddress, @id
FROM PtEbNewsSubscription AS PNS
WHERE EXISTS (SELECT T.NewsSubscriptionId 
              FROM PtEbNewsSubscriptionTopic AS T
	      INNER JOIN PtEbNewsletterAssign AS A ON A.NewsTopicNo = T.NewsTopicNo
              WHERE T.NewsSubscriptionId = PNS.Id
	      AND A.NewsletterId = @id
              AND T.HdVersionNo BETWEEN 1 AND 999999998
              AND A.HdVersionNo BETWEEN 1 AND 999999998)
AND NOT EXISTS(SELECT EmailAddress FROM PtEbNewsletterMail 
               WHERE EmailAddress = PNS.EmailAddress
               AND NewsletterId = @id)
AND PNS.Closed = 0
AND PNS.SubscriptionDate IS NOT NULL
AND PNS.HdVersionNo BETWEEN 1 AND 999999998
