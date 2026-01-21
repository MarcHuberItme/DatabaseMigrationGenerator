--liquibase formatted sql

--changeset system:bootstrap-AcAmountType context:any labels:c-any,o-table,ot-schema,on-AcAmountType,fin-13659
--comment: Bootstrap AcAmountType (if for example a function is used in views)
select * from zzDatabaseChangelog