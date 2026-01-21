--liquibase formatted sql

--changeset system:create-alter-view-ExportWithdrawRulesView context:any labels:c-any,o-view,ot-schema,on-ExportWithdrawRulesView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportWithdrawRulesView
CREATE OR ALTER VIEW dbo.ExportWithdrawRulesView AS
SELECT TOP 100 PERCENT     PPRIV.ProductNo AS 'withdrawCommission_product_no',
            PPWR.ValidFrom AS 'withdrawCommission_validFrom',
            PPWR.WithdrawAmount AS 'withdrawCommission_withdrawAmount',
            PPWR.MatchCalendarInterval AS 'withdrawCommission_matchCalenderInterval',
            ATAIWD.TextShort AS 'withdrawCommission_interval_unit',
            PPWR.WithdrawalPeriod AS 'withdrawCommission_interval_number',
            PPWR.WithdrawalPeriodInMonths AS 'withdrawCommission_interval_numberInMonths',
            ATAI.TextShort AS 'withdrawCommission_termination_interval_unit',
            PPWR.NoticePeriod AS 'withdrawCommission_termination_interval_number',
            GETUTCDATE() AS 'lastSyncDate'
FROM        PrPrivate PPRIV
LEFT JOIN   PrPrivateWithdrawRules PPWR ON PPWR.ProductNo=PPRIV.ProductNo
                AND PPWR.ValidFrom =    (
                                        SELECT  MAX(PPWRSub.ValidFrom)
                                        FROM    PrPrivateWithdrawRules PPWRSub
                                        WHERE   PPWRSub.HdVersionNo BETWEEN 1 AND 999999998
                                        AND     PPWRSub.ValidFrom <= GETDATE()
                                        AND     PPWRSub.ProductNo = PPWR.ProductNo)
LEFT JOIN   AsInterval AI ON AI.Interval = PPWR.Interval
LEFT JOIN   AsText ATAI ON ATAI.MasterId = AI.Id
                AND ATAI.LanguageNo = 2
LEFT JOIN   AsInterval AIWD ON AIWD.Interval = PPWR.WithdrawInterval
LEFT JOIN   AsText ATAIWD ON ATAIWD.MasterId = AIWD.Id
                AND ATAIWD.LanguageNo = 2
ORDER BY PPRIV.ProductNo
