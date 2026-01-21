--liquibase formatted sql

--changeset system:create-alter-procedure-GetPartnerNoWhenEBankingConnectionIsValid context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPartnerNoWhenEBankingConnectionIsValid,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPartnerNoWhenEBankingConnectionIsValid
CREATE OR ALTER PROCEDURE dbo.GetPartnerNoWhenEBankingConnectionIsValid
@PartnerId UNIQUEIDENTIFIER,
@AgrEBankingId UNIQUEIDENTIFIER

AS

DECLARE @RowCount INT  
DECLARE @PartnerNoEdited VARCHAR(10)

BEGIN
    --Giver = Receiver
    SELECT DISTINCT @PartnerNoEdited = PBReceiver.PartnerNoEdited
    FROM   PtAgrEBanking EB
    INNER JOIN PtBase PBReceiver ON PBReceiver.Id = EB.PartnerId
    WHERE EB.Id = @AgrEBankingId
          AND (EB.ExpirationDate IS NULL OR EB.ExpirationDate > GETDATE())            --nur aktive Verträge
          AND PBReceiver.Id = @PartnerId

    SELECT @RowCount = @@ROWCOUNT
  
    IF @RowCount = 0
    BEGIN
        --Giver <> Receiver mit Vollmacht
        SELECT DISTINCT @PartnerNoEdited = PBReceiver.PartnerNoEdited
        FROM   PtAgrEBanking EB
        INNER JOIN PtBase PBReceiver ON PBReceiver.Id = EB.PartnerId                  --Partner zu dessen EB Vertrag ein Objekt hinzugefügt werden soll
        INNER JOIN PtBase PBGiver ON PBGiver.Id = @PartnerId                          --Partner dessen Konto hinzugefügt werden soll
                   AND PBGiver.TerminationDate IS NULL
        INNER JOIN PtRelationMaster MAS ON MAS.PartnerId = PBGiver.Id                 --Verbindungsauslöser des Givers
                   AND MAS.RelationTypeNo = 30                                        --nur Vollmachten
                   AND MAS.HdVersionNo BETWEEN 1 AND 999999998
        INNER JOIN PtRelationSlave SLA ON SLA.MasterId = MAS.Id                       --Verbindung des Givers
                   AND (SLA.ValidTo IS NULL OR SLA.ValidTo > GETDATE())               --nur aktive Verbindungen
                   AND SLA.ValidFrom IS NOT NULL
                   AND SLA.ValidFrom <= GETDATE()
                   AND SLA.HdVersionNo BETWEEN 1 AND 999999998                        --keine gelöschten Verbindungen
                   AND SLA.RelationRoleNo IN (90, 91, 92, 93, 94, 96)                 --Nur Vollmachtsrollen
                   AND SLA.PartnerId = PBReceiver.Id                                  --Receiver muss eine Vollmacht haben
        WHERE 1=1
              AND EB.Id = @AgrEBankingId
              AND (EB.ExpirationDate IS NULL OR EB.ExpirationDate > GETDATE())         --nur aktive Verträge
              AND PBGiver.Id <> PBReceiver.Id                                          --Partner Receiver <> Partner Giver

        SELECT @RowCount = @@ROWCOUNT
  
        IF @RowCount = 0
        BEGIN
            --Giver <> Receiver ABER ist Mitinhaber
            SELECT DISTINCT @PartnerNoEdited = PBReceiver.PartnerNoEdited
            FROM   PtAgrEBanking EB
            INNER JOIN PtBase PBReceiver ON PBReceiver.Id = EB.PartnerId               --Partner zu dessen EB Vertrag ein Objekt hinzugefügt werden soll
            INNER JOIN PtBase PBGiver ON PBGiver.Id = @PartnerId                       --Partner dessen Konto hinzugefügt werden soll
                       AND PBGiver.TerminationDate IS NULL
            INNER JOIN PtRelationMaster MAS ON MAS.PartnerId = PBGiver.Id              --Verbindungsauslöser des Givers
                       AND MAS.RelationTypeNo = 10                                     --nur Vollmachten
                       AND MAS.HdVersionNo BETWEEN 1 AND 999999998
            INNER JOIN PtRelationSlave SLA ON SLA.MasterId = MAS.Id                    --Verbindung des Givers
                       AND (SLA.ValidTo IS NULL OR SLA.ValidTo > GETDATE())            --nur aktive Verbindungen
                       AND SLA.HdVersionNo BETWEEN 1 AND 999999998                     --keine gelöschten Verbindungen
                       AND SLA.RelationRoleNo = 6                                      --Nur Mitinhaber
                       AND SLA.PartnerId = PBReceiver.Id                               --Receiver muss eine Vollmacht haben
            WHERE 1=1
                  AND EB.Id = @AgrEBankingId
                  AND (EB.ExpirationDate IS NULL OR EB.ExpirationDate > GETDATE())     --nur aktive Verträge
                  AND PBGiver.Id <> PBReceiver.Id                                      --Partner Receiver <> Partner Giver

            SELECT @RowCount = @@ROWCOUNT
  
            IF @RowCount = 0
            BEGIN
                --Giver <> Receiver mit Vollmacht
                SELECT DISTINCT @PartnerNoEdited = PBReceiver.PartnerNoEdited
                FROM   PtAgrEBanking EB
                INNER JOIN PtBase PBReceiver ON PBReceiver.Id = EB.PartnerId           --Partner zu dessen EB Vertrag ein Objekt hinzugefügt werden soll
                INNER JOIN PtBase PBGiver ON PBGiver.Id = @PartnerId                   --Partner dessen Konto hinzugefügt werden soll
                           AND PBGiver.TerminationDate IS NULL
                INNER JOIN PtRelationMaster MAS ON MAS.PartnerId = PBGiver.Id          --Verbindungsauslöser des Givers
                           AND MAS.HdVersionNo BETWEEN 1 AND 999999998
                INNER JOIN PtRelationSlave SLA ON SLA.MasterId = MAS.Id                --Verbindung des Givers
                           AND (SLA.ValidTo IS NULL OR SLA.ValidTo > GETDATE())        --nur aktive Verbindungen
                           AND SLA.HdVersionNo BETWEEN 1 AND 999999998                 --keine gelöschten Verbindungen
                           AND SLA.RelationRoleNo = 7                                  --gleicher Partner
                           AND SLA.PartnerId = PBReceiver.Id                           --Receiver muss eine Vollmacht haben
                WHERE 1=1
                      AND EB.Id = @AgrEBankingId
                      AND (EB.ExpirationDate IS NULL OR EB.ExpirationDate > GETDATE()) --nur aktive Verträge
                      AND PBGiver.Id <> PBReceiver.Id                                  --Partner Receiver <> Partner Giver
            END
        END
    END
END

SELECT @PartnerNoEdited AS PartnerNoEdited

