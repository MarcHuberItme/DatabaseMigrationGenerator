--liquibase formatted sql

--changeset system:create-alter-function-GetDateFromParts context:any labels:c-any,o-function,ot-schema,on-GetDateFromParts,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetDateFromParts
CREATE OR ALTER FUNCTION dbo.GetDateFromParts
(
    @Year INT,
    @Month INT,
    @DayOfMonth INT,
    @Hour INT = 0,  -- based on 24 hour clock (add 12 for PM :)
    @Min INT = 0,
    @Sec INT = 0
)
RETURNS DATETIME
AS
BEGIN

    RETURN DATEADD(second, @Sec, 
            DATEADD(minute, @Min, 
            DATEADD(hour, @Hour,
            DATEADD(day, @DayOfMonth - 1, 
            DATEADD(month, @Month - 1, 
            DATEADD(Year, @Year-1900, 0))))))

END

