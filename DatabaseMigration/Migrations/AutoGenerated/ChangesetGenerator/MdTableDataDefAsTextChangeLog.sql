--liquibase formatted sql

--changeset system:generated-update-data-AsText-AcAmountType context:any labels:c-any,o-table,ot-schema,on-AcAmountType,fin-13659 runOnChange:true
--comment: Generate AsText for AcAmountType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a9887eff-6f5b-8237-9bb4-87bc441c14fd';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a9887eff-6f5b-8237-9bb4-87bc441c14fd',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Amount type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a9887eff-6f5b-8237-9bb4-87bc441c14fd',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Betragstyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a9887eff-6f5b-8237-9bb4-87bc441c14fd',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type de montant'
);

--changeset system:generated-update-data-AsText-AcBalanceSheetType context:any labels:c-any,o-table,ot-schema,on-AcBalanceSheetType,fin-13659 runOnChange:true
--comment: Generate AsText for AcBalanceSheetType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='93236a7f-90d9-7237-98ab-6e95977eba88';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '93236a7f-90d9-7237-98ab-6e95977eba88',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Balance Sheet Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '93236a7f-90d9-7237-98ab-6e95977eba88',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bilanz Typ'
);

--changeset system:generated-update-data-AsText-AcBalanceSource context:any labels:c-any,o-table,ot-schema,on-AcBalanceSource,fin-13659 runOnChange:true
--comment: Generate AsText for AcBalanceSource
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='078d0e36-85c5-cc33-9c23-71fac70dcdf0';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '078d0e36-85c5-cc33-9c23-71fac70dcdf0',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Balance Source'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '078d0e36-85c5-cc33-9c23-71fac70dcdf0',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bilanz Inputdata'
);

--changeset system:generated-update-data-AsText-AcBalanceStructure context:any labels:c-any,o-table,ot-schema,on-AcBalanceStructure,fin-13659 runOnChange:true
--comment: Generate AsText for AcBalanceStructure
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a94c9397-bb6f-d03d-a83c-0f2884004236';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a94c9397-bb6f-d03d-a83c-0f2884004236',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Balance structure'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a94c9397-bb6f-d03d-a83c-0f2884004236',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bilanzstruktur'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a94c9397-bb6f-d03d-a83c-0f2884004236',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Structure du bilan'
);

--changeset system:generated-update-data-AsText-AcBalanceStructureAL1 context:any labels:c-any,o-table,ot-schema,on-AcBalanceStructureAL1,fin-13659 runOnChange:true
--comment: Generate AsText for AcBalanceStructureAL1
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='329d0faf-fcf2-0132-abb7-2c576d7ed16c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '329d0faf-fcf2-0132-abb7-2c576d7ed16c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Balance Structure Level 1'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '329d0faf-fcf2-0132-abb7-2c576d7ed16c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bilanzstruktur Level 1'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '329d0faf-fcf2-0132-abb7-2c576d7ed16c',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Structure du bilan Level1'
);

--changeset system:generated-update-data-AsText-AcBalanceStructureAL2 context:any labels:c-any,o-table,ot-schema,on-AcBalanceStructureAL2,fin-13659 runOnChange:true
--comment: Generate AsText for AcBalanceStructureAL2
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='98823611-df72-263d-9c31-7b06a9527d3a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '98823611-df72-263d-9c31-7b06a9527d3a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Balance Structure Level 2'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '98823611-df72-263d-9c31-7b06a9527d3a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bilanzstruktur Level 2'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '98823611-df72-263d-9c31-7b06a9527d3a',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Structure du bilan Level2'
);

--changeset system:generated-update-data-AsText-AcBalanceStructureAL3 context:any labels:c-any,o-table,ot-schema,on-AcBalanceStructureAL3,fin-13659 runOnChange:true
--comment: Generate AsText for AcBalanceStructureAL3
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='fa1037b3-4466-8430-b776-1410e60b3082';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fa1037b3-4466-8430-b776-1410e60b3082',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Balance Structure Level 3'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fa1037b3-4466-8430-b776-1410e60b3082',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bilanzstruktur Level 3'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fa1037b3-4466-8430-b776-1410e60b3082',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Structure du bilan Level3'
);

--changeset system:generated-update-data-AsText-AcBalanceStructureAL4 context:any labels:c-any,o-table,ot-schema,on-AcBalanceStructureAL4,fin-13659 runOnChange:true
--comment: Generate AsText for AcBalanceStructureAL4
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='82cf8e19-1b8f-393b-a4a0-859680689ba6';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '82cf8e19-1b8f-393b-a4a0-859680689ba6',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Balance Structure Level 4'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '82cf8e19-1b8f-393b-a4a0-859680689ba6',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bilanzstruktur Level 4'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '82cf8e19-1b8f-393b-a4a0-859680689ba6',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Structure du bilan Level4'
);

--changeset system:generated-update-data-AsText-AcBalanceStructureAL5 context:any labels:c-any,o-table,ot-schema,on-AcBalanceStructureAL5,fin-13659 runOnChange:true
--comment: Generate AsText for AcBalanceStructureAL5
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='22e8ceaf-eab6-db3c-9511-ffd81dc38a87';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '22e8ceaf-eab6-db3c-9511-ffd81dc38a87',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Balance Structure Level 5'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '22e8ceaf-eab6-db3c-9511-ffd81dc38a87',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bilanzstruktur Level 5'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '22e8ceaf-eab6-db3c-9511-ffd81dc38a87',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Structure du bilan Level5'
);

--changeset system:generated-update-data-AsText-AcDerivativeType context:any labels:c-any,o-table,ot-schema,on-AcDerivativeType,fin-13659 runOnChange:true
--comment: Generate AsText for AcDerivativeType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='734c8427-e4f0-5839-b87c-1615efbfe692';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '734c8427-e4f0-5839-b87c-1615efbfe692',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Underlying Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '734c8427-e4f0-5839-b87c-1615efbfe692',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Art des Basiswertes'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '734c8427-e4f0-5839-b87c-1615efbfe692',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Types sous-jacents'
);

--changeset system:generated-update-data-AsText-AcEmployeeNoGroup context:any labels:c-any,o-table,ot-schema,on-AcEmployeeNoGroup,fin-13659 runOnChange:true
--comment: Generate AsText for AcEmployeeNoGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d73bdfb3-17e0-7e39-9966-305688655f8c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd73bdfb3-17e0-7e39-9966-305688655f8c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Employee Group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd73bdfb3-17e0-7e39-9966-305688655f8c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Mitarbeiteranzahlgruppe'
);

--changeset system:generated-update-data-AsText-AcFaOwnResourcesCalcType context:any labels:c-any,o-table,ot-schema,on-AcFaOwnResourcesCalcType,fin-13659 runOnChange:true
--comment: Generate AsText for AcFaOwnResourcesCalcType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9d90b9b7-9d2f-3c3b-b497-59434444e5fe';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9d90b9b7-9d2f-3c3b-b497-59434444e5fe',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Own Resources calculation'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9d90b9b7-9d2f-3c3b-b497-59434444e5fe',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Eigenmittel Berechnungtyp'
);

--changeset system:generated-update-data-AsText-AcFireC026 context:any labels:c-any,o-table,ot-schema,on-AcFireC026,fin-13659 runOnChange:true
--comment: Generate AsText for AcFireC026
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a36fbc4c-92e5-e034-ab35-97514b28bfcc';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a36fbc4c-92e5-e034-ab35-97514b28bfcc',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Central Counterparty'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a36fbc4c-92e5-e034-ab35-97514b28bfcc',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zentrale Gegenpartei'
);

--changeset system:generated-update-data-AsText-AcFireC520 context:any labels:c-any,o-table,ot-schema,on-AcFireC520,fin-13659 runOnChange:true
--comment: Generate AsText for AcFireC520
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='65d14eff-d39b-0838-ac1d-12db94847b91';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '65d14eff-d39b-0838-ac1d-12db94847b91',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Geschäftsart (Fire C520)'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '65d14eff-d39b-0838-ac1d-12db94847b91',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Geschäftsart (Fire C520)'
);

--changeset system:generated-update-data-AsText-AcFireC533 context:any labels:c-any,o-table,ot-schema,on-AcFireC533,fin-13659 runOnChange:true
--comment: Generate AsText for AcFireC533
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='af5abeb8-a4b9-1039-9626-302977f62221';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'af5abeb8-a4b9-1039-9626-302977f62221',
    1,
    'MdTableDataDef',
    NULL,
    N'Related parties',
    N'Related parties'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'af5abeb8-a4b9-1039-9626-302977f62221',
    2,
    'MdTableDataDef',
    NULL,
    N'Nahestehende Parteien',
    N'Nahestehende Parteien'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'af5abeb8-a4b9-1039-9626-302977f62221',
    3,
    'MdTableDataDef',
    NULL,
    N'Nahestehende Parteien',
    N'Nahestehende Parteien'
);

--changeset system:generated-update-data-AsText-AcFireC536 context:any labels:c-any,o-table,ot-schema,on-AcFireC536,fin-13659 runOnChange:true
--comment: Generate AsText for AcFireC536
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='cc410722-b553-7839-99fb-60884a9887d6';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cc410722-b553-7839-99fb-60884a9887d6',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Art der Deckung (Fire)'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cc410722-b553-7839-99fb-60884a9887d6',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Art der Deckung (Fire)'
);

--changeset system:generated-update-data-AsText-AcFireC541 context:any labels:c-any,o-table,ot-schema,on-AcFireC541,fin-13659 runOnChange:true
--comment: Generate AsText for AcFireC541
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='831afeb6-3e8c-e532-b288-7dc0c8ac6ed2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '831afeb6-3e8c-e532-b288-7dc0c8ac6ed2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Konsolid. Beteil. (FiRE)'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '831afeb6-3e8c-e532-b288-7dc0c8ac6ed2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Konsolid. Beteil. (FiRE)'
);

--changeset system:generated-update-data-AsText-AcFireConversionType context:any labels:c-any,o-table,ot-schema,on-AcFireConversionType,fin-13659 runOnChange:true
--comment: Generate AsText for AcFireConversionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2476cc7e-7979-fa3f-9e1a-ec0f7d6e93db';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2476cc7e-7979-fa3f-9e1a-ec0f7d6e93db',
    1,
    'MdTableDataDef',
    NULL,
    N'Fiere Field Conversion Type',
    N'Fiere Field Conversion Ty'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2476cc7e-7979-fa3f-9e1a-ec0f7d6e93db',
    2,
    'MdTableDataDef',
    NULL,
    N'Fiere Field Conversion Type',
    N'Fiere Field Conversion Ty'
);

--changeset system:generated-update-data-AsText-AcFireDepositType context:any labels:c-any,o-table,ot-schema,on-AcFireDepositType,fin-13659 runOnChange:true
--comment: Generate AsText for AcFireDepositType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='417daba0-c014-0630-9097-9543052a7a10';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '417daba0-c014-0630-9097-9543052a7a10',
    1,
    'MdTableDataDef',
    NULL,
    N'Firecode für Deckungen',
    N'Firecode für Deckungen'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '417daba0-c014-0630-9097-9543052a7a10',
    2,
    'MdTableDataDef',
    NULL,
    N'Firecode für Deckungen',
    N'Firecode für Deckungen'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '417daba0-c014-0630-9097-9543052a7a10',
    3,
    'MdTableDataDef',
    NULL,
    N'Firecode für Deckungen',
    N'Firecode für Deckungen'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '417daba0-c014-0630-9097-9543052a7a10',
    4,
    'MdTableDataDef',
    NULL,
    N'Firecode für Deckungen',
    N'Firecode für Deckungen'
);

--changeset system:generated-update-data-AsText-AcFireMappingType context:any labels:c-any,o-table,ot-schema,on-AcFireMappingType,fin-13659 runOnChange:true
--comment: Generate AsText for AcFireMappingType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6b53980b-dfe3-ae38-912b-3537e2ad4d62';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6b53980b-dfe3-ae38-912b-3537e2ad4d62',
    1,
    'MdTableDataDef',
    NULL,
    N'Migrationsregel Typ',
    N'Migrationsregel Typ'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6b53980b-dfe3-ae38-912b-3537e2ad4d62',
    2,
    'MdTableDataDef',
    NULL,
    N'Migrationsregel Typ',
    N'Migrationsregel Typ'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6b53980b-dfe3-ae38-912b-3537e2ad4d62',
    3,
    'MdTableDataDef',
    NULL,
    N'Migrationsregel Typ',
    N'Migrationsregel Typ'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6b53980b-dfe3-ae38-912b-3537e2ad4d62',
    4,
    'MdTableDataDef',
    NULL,
    N'Migrationsregel Typ',
    N'Migrationsregel Typ'
);

--changeset system:generated-update-data-AsText-AcFrozenPtEarningType context:any labels:c-any,o-table,ot-schema,on-AcFrozenPtEarningType,fin-13659 runOnChange:true
--comment: Generate AsText for AcFrozenPtEarningType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3ac2fd0f-cd50-1b31-be20-a1552d5c8ae2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3ac2fd0f-cd50-1b31-be20-a1552d5c8ae2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ertragstyp für Summary'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3ac2fd0f-cd50-1b31-be20-a1552d5c8ae2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ertragstyp für Summary'
);

--changeset system:generated-update-data-AsText-AcInterestRateGroup context:any labels:c-any,o-table,ot-schema,on-AcInterestRateGroup,fin-13659 runOnChange:true
--comment: Generate AsText for AcInterestRateGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4bad6779-4acb-ef3f-ab80-673f31b7557e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4bad6779-4acb-ef3f-ab80-673f31b7557e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Interest Rate Group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4bad6779-4acb-ef3f-ab80-673f31b7557e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zinssatzgruppe'
);

--changeset system:generated-update-data-AsText-AcMaturityGroup context:any labels:c-any,o-table,ot-schema,on-AcMaturityGroup,fin-13659 runOnChange:true
--comment: Generate AsText for AcMaturityGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='270990c4-2fb0-3d35-afbd-7acac6711517';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '270990c4-2fb0-3d35-afbd-7acac6711517',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Maturity Group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '270990c4-2fb0-3d35-afbd-7acac6711517',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Verfallgruppe'
);

--changeset system:generated-update-data-AsText-AiTaxAIAStatus context:any labels:c-any,o-table,ot-schema,on-AiTaxAIAStatus,fin-13659 runOnChange:true
--comment: Generate AsText for AiTaxAIAStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='058d0b5b-ef48-be38-88e3-137d654b7892';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '058d0b5b-ef48-be38-88e3-137d654b7892',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax AIA status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '058d0b5b-ef48-be38-88e3-137d654b7892',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuer AIA Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '058d0b5b-ef48-be38-88e3-137d654b7892',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Statut fiscal AIA'
);

--changeset system:generated-update-data-AsText-AiTaxCarfStatus context:any labels:c-any,o-table,ot-schema,on-AiTaxCarfStatus,fin-13659 runOnChange:true
--comment: Generate AsText for AiTaxCarfStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='971f5a48-2d63-dc30-8b24-3c77949ac7c9';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '971f5a48-2d63-dc30-8b24-3c77949ac7c9',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax CARF status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '971f5a48-2d63-dc30-8b24-3c77949ac7c9',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuer CARF Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '971f5a48-2d63-dc30-8b24-3c77949ac7c9',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Statut fiscal CARF'
);

--changeset system:generated-update-data-AsText-AiTaxDetailQIChap3Status context:any labels:c-any,o-table,ot-schema,on-AiTaxDetailQIChap3Status,fin-13659 runOnChange:true
--comment: Generate AsText for AiTaxDetailQIChap3Status
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0d091674-afef-6b33-894c-86c28c3ec70f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0d091674-afef-6b33-894c-86c28c3ec70f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Detail QI Chapter 3'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0d091674-afef-6b33-894c-86c28c3ec70f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Detail QI Chapter 3'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0d091674-afef-6b33-894c-86c28c3ec70f',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Détails QI chapter 3'
);

--changeset system:generated-update-data-AsText-AiTaxFatcaAssetAmount context:any labels:c-any,o-table,ot-schema,on-AiTaxFatcaAssetAmount,fin-13659 runOnChange:true
--comment: Generate AsText for AiTaxFatcaAssetAmount
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0d6a023d-8674-1834-a8dd-2f3b43fc5407';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0d6a023d-8674-1834-a8dd-2f3b43fc5407',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Asset Amount'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0d6a023d-8674-1834-a8dd-2f3b43fc5407',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Vermögenswert'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0d6a023d-8674-1834-a8dd-2f3b43fc5407',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Montant de l''actif'
);

--changeset system:generated-update-data-AsText-AiTaxFatcaStatus context:any labels:c-any,o-table,ot-schema,on-AiTaxFatcaStatus,fin-13659 runOnChange:true
--comment: Generate AsText for AiTaxFatcaStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b70dbc73-d80c-dd35-a523-282fe2512648';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b70dbc73-d80c-dd35-a523-282fe2512648',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax Fatca status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b70dbc73-d80c-dd35-a523-282fe2512648',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuer Fatca Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b70dbc73-d80c-dd35-a523-282fe2512648',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fiscalité Fatca'
);

--changeset system:generated-update-data-AsText-AiTaxIndiciaAssessmentType context:any labels:c-any,o-table,ot-schema,on-AiTaxIndiciaAssessmentType,fin-13659 runOnChange:true
--comment: Generate AsText for AiTaxIndiciaAssessmentType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f2380005-f625-9439-a1ac-d11d0feadd1c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f2380005-f625-9439-a1ac-d11d0feadd1c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax indicia assessment'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f2380005-f625-9439-a1ac-d11d0feadd1c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuer Indiz Beurteilung'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f2380005-f625-9439-a1ac-d11d0feadd1c',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Éval. des indices fiscaux'
);

--changeset system:generated-update-data-AsText-AiTaxIndiciaStatus context:any labels:c-any,o-table,ot-schema,on-AiTaxIndiciaStatus,fin-13659 runOnChange:true
--comment: Generate AsText for AiTaxIndiciaStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='71aa3a07-928d-f335-b5d3-79e081cfc856';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '71aa3a07-928d-f335-b5d3-79e081cfc856',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax Indicia status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '71aa3a07-928d-f335-b5d3-79e081cfc856',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuer Indiz Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '71aa3a07-928d-f335-b5d3-79e081cfc856',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Indice fiscal Statut'
);

--changeset system:generated-update-data-AsText-AiTaxLOBCodes context:any labels:c-any,o-table,ot-schema,on-AiTaxLOBCodes,fin-13659 runOnChange:true
--comment: Generate AsText for AiTaxLOBCodes
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bb147309-dd9e-1f34-b3b8-c6341d177d84';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bb147309-dd9e-1f34-b3b8-c6341d177d84',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax LOB Codes'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bb147309-dd9e-1f34-b3b8-c6341d177d84',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuer LOB Codes'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bb147309-dd9e-1f34-b3b8-c6341d177d84',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'LOB Codes'
);

--changeset system:generated-update-data-AsText-AiTaxPoolReportType context:any labels:c-any,o-table,ot-schema,on-AiTaxPoolReportType,fin-13659 runOnChange:true
--comment: Generate AsText for AiTaxPoolReportType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='800b8f7a-fdc5-ac3e-acd3-460eeabaf6da';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '800b8f7a-fdc5-ac3e-acd3-460eeabaf6da',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Pool report type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '800b8f7a-fdc5-ac3e-acd3-460eeabaf6da',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Pool Meldungstyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '800b8f7a-fdc5-ac3e-acd3-460eeabaf6da',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type de rapport de pool'
);

--changeset system:generated-update-data-AsText-AiTaxProgram context:any labels:c-any,o-table,ot-schema,on-AiTaxProgram,fin-13659 runOnChange:true
--comment: Generate AsText for AiTaxProgram
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3ed27d06-718e-0e3b-ac54-3e7754aeb61a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3ed27d06-718e-0e3b-ac54-3e7754aeb61a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax program'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3ed27d06-718e-0e3b-ac54-3e7754aeb61a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuerprogramm'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3ed27d06-718e-0e3b-ac54-3e7754aeb61a',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Programme fiscal'
);

--changeset system:generated-update-data-AsText-AiTaxQIStatus context:any labels:c-any,o-table,ot-schema,on-AiTaxQIStatus,fin-13659 runOnChange:true
--comment: Generate AsText for AiTaxQIStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ae766f9b-3871-1335-b651-428699067b2a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ae766f9b-3871-1335-b651-428699067b2a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax QI status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ae766f9b-3871-1335-b651-428699067b2a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuer QI Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ae766f9b-3871-1335-b651-428699067b2a',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Statut fiscal QI'
);

--changeset system:generated-update-data-AsText-AiTaxRegulationDBA context:any labels:c-any,o-table,ot-schema,on-AiTaxRegulationDBA,fin-13659 runOnChange:true
--comment: Generate AsText for AiTaxRegulationDBA
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f351c340-0c10-b93e-925b-87015a55768f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f351c340-0c10-b93e-925b-87015a55768f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Double taxation treaty'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f351c340-0c10-b93e-925b-87015a55768f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Doppelbesteuerungsabkomme'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f351c340-0c10-b93e-925b-87015a55768f',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Traité double imposition'
);

--changeset system:generated-update-data-AsText-AiTaxReportAcctHolderType context:any labels:c-any,o-table,ot-schema,on-AiTaxReportAcctHolderType,fin-13659 runOnChange:true
--comment: Generate AsText for AiTaxReportAcctHolderType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1f9ac53f-b57b-2536-b966-60103a41a646';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1f9ac53f-b57b-2536-b966-60103a41a646',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Holder type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1f9ac53f-b57b-2536-b966-60103a41a646',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kontoinhaber Typ'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1f9ac53f-b57b-2536-b966-60103a41a646',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type titulaire de compte'
);

--changeset system:generated-update-data-AsText-AiTaxReportCtrlPersonType context:any labels:c-any,o-table,ot-schema,on-AiTaxReportCtrlPersonType,fin-13659 runOnChange:true
--comment: Generate AsText for AiTaxReportCtrlPersonType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bf169113-9e91-a139-a835-3ae802f5b746';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bf169113-9e91-a139-a835-3ae802f5b746',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Controlling Person Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bf169113-9e91-a139-a835-3ae802f5b746',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Controlling Person Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bf169113-9e91-a139-a835-3ae802f5b746',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Contrôle type de person'
);

--changeset system:generated-update-data-AsText-AiTaxReportEntryStatus context:any labels:c-any,o-table,ot-schema,on-AiTaxReportEntryStatus,fin-13659 runOnChange:true
--comment: Generate AsText for AiTaxReportEntryStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2d516251-2dc0-3f31-af09-31389f0c46dc';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2d516251-2dc0-3f31-af09-31389f0c46dc',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Entry status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2d516251-2dc0-3f31-af09-31389f0c46dc',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Verarbeitungsstatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2d516251-2dc0-3f31-af09-31389f0c46dc',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Statut de traitement'
);

--changeset system:generated-update-data-AsText-AiTaxReportPartnerType context:any labels:c-any,o-table,ot-schema,on-AiTaxReportPartnerType,fin-13659 runOnChange:true
--comment: Generate AsText for AiTaxReportPartnerType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4d377f0d-ef29-3c3c-9240-d4782949edee';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4d377f0d-ef29-3c3c-9240-d4782949edee',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Partner type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4d377f0d-ef29-3c3c-9240-d4782949edee',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Partnertyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4d377f0d-ef29-3c3c-9240-d4782949edee',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type de partenaire'
);

--changeset system:generated-update-data-AsText-AiTaxReportPaymentType context:any labels:c-any,o-table,ot-schema,on-AiTaxReportPaymentType,fin-13659 runOnChange:true
--comment: Generate AsText for AiTaxReportPaymentType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='03dda83d-fbde-6a3e-8e88-cb686d1b3281';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '03dda83d-fbde-6a3e-8e88-cb686d1b3281',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Payment type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '03dda83d-fbde-6a3e-8e88-cb686d1b3281',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zahlungstyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '03dda83d-fbde-6a3e-8e88-cb686d1b3281',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type de paiement'
);

--changeset system:generated-update-data-AsText-AiTaxReportStatus context:any labels:c-any,o-table,ot-schema,on-AiTaxReportStatus,fin-13659 runOnChange:true
--comment: Generate AsText for AiTaxReportStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2446f533-7d1f-ff34-986a-1f1b3d66c3d4';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2446f533-7d1f-ff34-986a-1f1b3d66c3d4',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax report status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2446f533-7d1f-ff34-986a-1f1b3d66c3d4',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuermeldung Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2446f533-7d1f-ff34-986a-1f1b3d66c3d4',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'État du rapport d''impôt'
);

--changeset system:generated-update-data-AsText-AiTaxReportType context:any labels:c-any,o-table,ot-schema,on-AiTaxReportType,fin-13659 runOnChange:true
--comment: Generate AsText for AiTaxReportType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b11fb65e-ea54-d232-ac13-b5d11224957d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b11fb65e-ea54-d232-ac13-b5d11224957d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax report type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b11fb65e-ea54-d232-ac13-b5d11224957d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuermeldung Typ'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b11fb65e-ea54-d232-ac13-b5d11224957d',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type de décl. fiscale'
);

--changeset system:generated-update-data-AsText-AsAccountClosingSet context:any labels:c-any,o-table,ot-schema,on-AsAccountClosingSet,fin-13659 runOnChange:true
--comment: Generate AsText for AsAccountClosingSet
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bc63ad7b-10d7-9f3a-ba5e-1357f5a0f53a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bc63ad7b-10d7-9f3a-ba5e-1357f5a0f53a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Account Closing Sets'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bc63ad7b-10d7-9f3a-ba5e-1357f5a0f53a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kontoabschluss Sets'
);

--changeset system:generated-update-data-AsText-AsActivityRule context:any labels:c-any,o-table,ot-schema,on-AsActivityRule,fin-13659 runOnChange:true
--comment: Generate AsText for AsActivityRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4b0cc050-786e-da33-9ff4-a81ddd17e4c5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4b0cc050-786e-da33-9ff4-a81ddd17e4c5',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Activity Rule'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4b0cc050-786e-da33-9ff4-a81ddd17e4c5',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Aktionstyp'
);

--changeset system:generated-update-data-AsText-AsAdviceRule context:any labels:c-any,o-table,ot-schema,on-AsAdviceRule,fin-13659 runOnChange:true
--comment: Generate AsText for AsAdviceRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1c7ce46f-9613-193d-928e-c95dc10c1d98';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1c7ce46f-9613-193d-928e-c95dc10c1d98',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Advice'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1c7ce46f-9613-193d-928e-c95dc10c1d98',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Anzeigensteuerung'
);

--changeset system:generated-update-data-AsText-AsAKTType context:any labels:c-any,o-table,ot-schema,on-AsAKTType,fin-13659 runOnChange:true
--comment: Generate AsText for AsAKTType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='dcd92761-37f1-463d-9b8b-298e28969036';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'dcd92761-37f1-463d-9b8b-298e28969036',
    1,
    'MdTableDataDef',
    NULL,
    N'Type of the AKT',
    N'Type of the AKT'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'dcd92761-37f1-463d-9b8b-298e28969036',
    2,
    'MdTableDataDef',
    NULL,
    N'Typ des AKT',
    N'Typ des AKT'
);

--changeset system:generated-update-data-AsText-AsATMConfig context:any labels:c-any,o-table,ot-schema,on-AsATMConfig,fin-13659 runOnChange:true
--comment: Generate AsText for AsATMConfig
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='25b6f0bf-42be-9e33-9cc1-c41b5bf8c8a0';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '25b6f0bf-42be-9e33-9cc1-c41b5bf8c8a0',
    1,
    'MdTableDataDef',
    NULL,
    N'Bancomat',
    N'Bancomat'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '25b6f0bf-42be-9e33-9cc1-c41b5bf8c8a0',
    2,
    'MdTableDataDef',
    NULL,
    N'Bancomat',
    N'Bancomat'
);

--changeset system:generated-update-data-AsText-AsATMText context:any labels:c-any,o-table,ot-schema,on-AsATMText,fin-13659 runOnChange:true
--comment: Generate AsText for AsATMText
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6e9fd79a-aaaf-673b-9752-ba233132ddb9';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6e9fd79a-aaaf-673b-9752-ba233132ddb9',
    1,
    'MdTableDataDef',
    NULL,
    N'ATMText',
    N'ATMText'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6e9fd79a-aaaf-673b-9752-ba233132ddb9',
    2,
    'MdTableDataDef',
    NULL,
    N'ATMText',
    N'ATMText'
);

--changeset system:generated-update-data-AsText-AsBarcodeSettings context:any labels:c-any,o-table,ot-schema,on-AsBarcodeSettings,fin-13659 runOnChange:true
--comment: Generate AsText for AsBarcodeSettings
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='52595efd-a043-1932-84c6-196d89beea8c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '52595efd-a043-1932-84c6-196d89beea8c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Barcode settings'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '52595efd-a043-1932-84c6-196d89beea8c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Barcodeeinstellungen'
);

--changeset system:generated-update-data-AsText-AsBoolean context:any labels:c-any,o-table,ot-schema,on-AsBoolean,fin-13659 runOnChange:true
--comment: Generate AsText for AsBoolean
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='51b2ece2-e551-f132-8513-e8a015a9bdab';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '51b2ece2-e551-f132-8513-e8a015a9bdab',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Translate type boolean'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '51b2ece2-e551-f132-8513-e8a015a9bdab',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Übersetzt Typ Boolean'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '51b2ece2-e551-f132-8513-e8a015a9bdab',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Traduire le type booléen'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '51b2ece2-e551-f132-8513-e8a015a9bdab',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Traduci tipo booleano'
);

--changeset system:generated-update-data-AsText-AsBranch context:any labels:c-any,o-table,ot-schema,on-AsBranch,fin-13659 runOnChange:true
--comment: Generate AsText for AsBranch
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1bfd318b-e46f-e23d-a6a8-c2e6e0bb1bac';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1bfd318b-e46f-e23d-a6a8-c2e6e0bb1bac',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Branches'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1bfd318b-e46f-e23d-a6a8-c2e6e0bb1bac',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Filialen'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1bfd318b-e46f-e23d-a6a8-c2e6e0bb1bac',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Branches'
);

--changeset system:generated-update-data-AsText-AsBranchSignAuthority context:any labels:c-any,o-table,ot-schema,on-AsBranchSignAuthority,fin-13659 runOnChange:true
--comment: Generate AsText for AsBranchSignAuthority
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a3a74508-fb52-473a-9e96-6a0b0fcf339a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a3a74508-fb52-473a-9e96-6a0b0fcf339a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Signature AuthorityText'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a3a74508-fb52-473a-9e96-6a0b0fcf339a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Unterschriftsberechtigung'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a3a74508-fb52-473a-9e96-6a0b0fcf339a',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Autorisation de signer'
);

--changeset system:generated-update-data-AsText-AsBusinessRule context:any labels:c-any,o-table,ot-schema,on-AsBusinessRule,fin-13659 runOnChange:true
--comment: Generate AsText for AsBusinessRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='93161b1f-ef1d-2833-b932-6d04811441de';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '93161b1f-ef1d-2833-b932-6d04811441de',
    1,
    'MdTableDataDef',
    NULL,
    N'Business Rule Definition',
    N'Business Rule Definition'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '93161b1f-ef1d-2833-b932-6d04811441de',
    2,
    'MdTableDataDef',
    NULL,
    N'Geschäftsregeldefinition',
    N'Geschäftsregeldefinition'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '93161b1f-ef1d-2833-b932-6d04811441de',
    3,
    'MdTableDataDef',
    NULL,
    N'Déf des règles métier',
    N'Déf des règles métier'
);

--changeset system:generated-update-data-AsText-AsBusinessRuleInvokeEvent context:any labels:c-any,o-table,ot-schema,on-AsBusinessRuleInvokeEvent,fin-13659 runOnChange:true
--comment: Generate AsText for AsBusinessRuleInvokeEvent
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='50f75202-0cd4-0531-90e0-fa2bfaf0680c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '50f75202-0cd4-0531-90e0-fa2bfaf0680c',
    1,
    'MdTableDataDef',
    NULL,
    N'Rule Invokation point',
    N'Rule Invokation point'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '50f75202-0cd4-0531-90e0-fa2bfaf0680c',
    2,
    'MdTableDataDef',
    NULL,
    N'Regelaufrufpunkt',
    N'Regelaufrufpunkt'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '50f75202-0cd4-0531-90e0-fa2bfaf0680c',
    3,
    'MdTableDataDef',
    NULL,
    N'Point d''appel de règle',
    N'Point d''appel de règle'
);

--changeset system:generated-update-data-AsText-AsBusinessRuleType context:any labels:c-any,o-table,ot-schema,on-AsBusinessRuleType,fin-13659 runOnChange:true
--comment: Generate AsText for AsBusinessRuleType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3df92249-5509-4b39-98cb-68c8dd576fda';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3df92249-5509-4b39-98cb-68c8dd576fda',
    1,
    'MdTableDataDef',
    NULL,
    N'Rule Type',
    N'Rule Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3df92249-5509-4b39-98cb-68c8dd576fda',
    2,
    'MdTableDataDef',
    NULL,
    N'Regeltyp',
    N'Regeltyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3df92249-5509-4b39-98cb-68c8dd576fda',
    3,
    'MdTableDataDef',
    NULL,
    N'Type de règle',
    N'Type de règle'
);

--changeset system:generated-update-data-AsText-AsCanton context:any labels:c-any,o-table,ot-schema,on-AsCanton,fin-13659 runOnChange:true
--comment: Generate AsText for AsCanton
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='061f517b-7fad-1a3a-9922-bae50e669f23';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '061f517b-7fad-1a3a-9922-bae50e669f23',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Canton'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '061f517b-7fad-1a3a-9922-bae50e669f23',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kanton'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '061f517b-7fad-1a3a-9922-bae50e669f23',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Canton'
);

--changeset system:generated-update-data-AsText-AsCardType context:any labels:c-any,o-table,ot-schema,on-AsCardType,fin-13659 runOnChange:true
--comment: Generate AsText for AsCardType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bb8c28f7-d8a3-5e35-a126-99a94622b645';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bb8c28f7-d8a3-5e35-a126-99a94622b645',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Card type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bb8c28f7-d8a3-5e35-a126-99a94622b645',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kartentyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bb8c28f7-d8a3-5e35-a126-99a94622b645',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type de carte'
);

--changeset system:generated-update-data-AsText-AsCarrierType context:any labels:c-any,o-table,ot-schema,on-AsCarrierType,fin-13659 runOnChange:true
--comment: Generate AsText for AsCarrierType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e222bcbd-8a3f-ee3a-a299-5b8f1635f41f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e222bcbd-8a3f-ee3a-a299-5b8f1635f41f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Carrier Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e222bcbd-8a3f-ee3a-a299-5b8f1635f41f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Versandart'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e222bcbd-8a3f-ee3a-a299-5b8f1635f41f',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type de transporteur'
);

--changeset system:generated-update-data-AsText-AsCheckDigitRule context:any labels:c-any,o-table,ot-schema,on-AsCheckDigitRule,fin-13659 runOnChange:true
--comment: Generate AsText for AsCheckDigitRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d06c366f-2c33-273f-b488-3cde4032de64';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd06c366f-2c33-273f-b488-3cde4032de64',
    1,
    'MdTableDataDef',
    NULL,
    N'Check Digit Rules',
    N'Check Digit Rules'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd06c366f-2c33-273f-b488-3cde4032de64',
    2,
    'MdTableDataDef',
    NULL,
    N'Check Digit Rules',
    N'Check Digit Rules'
);

--changeset system:generated-update-data-AsText-AsCollateralType context:any labels:c-any,o-table,ot-schema,on-AsCollateralType,fin-13659 runOnChange:true
--comment: Generate AsText for AsCollateralType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='76ddd0aa-8b4a-553e-90c9-c2b9661a57ec';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '76ddd0aa-8b4a-553e-90c9-c2b9661a57ec',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Collateral'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '76ddd0aa-8b4a-553e-90c9-c2b9661a57ec',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Hinterlage / Sicherheit'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '76ddd0aa-8b4a-553e-90c9-c2b9661a57ec',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type de garantie'
);

--changeset system:generated-update-data-AsText-AsCommand context:any labels:c-any,o-table,ot-schema,on-AsCommand,fin-13659 runOnChange:true
--comment: Generate AsText for AsCommand
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d4fa66af-10c0-5a3e-ade6-1f13a623adb5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd4fa66af-10c0-5a3e-ade6-1f13a623adb5',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Commands'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd4fa66af-10c0-5a3e-ade6-1f13a623adb5',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kommandos'
);

--changeset system:generated-update-data-AsText-AsContactInitiator context:any labels:c-any,o-table,ot-schema,on-AsContactInitiator,fin-13659 runOnChange:true
--comment: Generate AsText for AsContactInitiator
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='91a1b322-5443-be38-96f7-d685e16c066c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '91a1b322-5443-be38-96f7-d685e16c066c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Contact Initiator'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '91a1b322-5443-be38-96f7-d685e16c066c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kontaktanlass'
);

--changeset system:generated-update-data-AsText-AsContactInitiatorGroup context:any labels:c-any,o-table,ot-schema,on-AsContactInitiatorGroup,fin-13659 runOnChange:true
--comment: Generate AsText for AsContactInitiatorGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='cf8b2324-f0e6-b833-9b9f-74e7ab47030d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cf8b2324-f0e6-b833-9b9f-74e7ab47030d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Contact Initiator Group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cf8b2324-f0e6-b833-9b9f-74e7ab47030d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kontaktanlass Gruppe'
);

--changeset system:generated-update-data-AsText-AsContactMedia context:any labels:c-any,o-table,ot-schema,on-AsContactMedia,fin-13659 runOnChange:true
--comment: Generate AsText for AsContactMedia
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a5dfbd05-394a-0138-ae08-01912501b3a8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a5dfbd05-394a-0138-ae08-01912501b3a8',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Contact Media'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a5dfbd05-394a-0138-ae08-01912501b3a8',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kontaktart'
);

--changeset system:generated-update-data-AsText-AsContactTopic context:any labels:c-any,o-table,ot-schema,on-AsContactTopic,fin-13659 runOnChange:true
--comment: Generate AsText for AsContactTopic
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e22d1df2-2a13-bd3c-b6f7-cf575d734b2e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e22d1df2-2a13-bd3c-b6f7-cf575d734b2e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Contact Topic'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e22d1df2-2a13-bd3c-b6f7-cf575d734b2e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kontaktthema'
);

--changeset system:generated-update-data-AsText-AsContactTopicGroup context:any labels:c-any,o-table,ot-schema,on-AsContactTopicGroup,fin-13659 runOnChange:true
--comment: Generate AsText for AsContactTopicGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d575a403-dae4-5b33-8f66-9faf0991f1d0';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd575a403-dae4-5b33-8f66-9faf0991f1d0',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Contact Topic Group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd575a403-dae4-5b33-8f66-9faf0991f1d0',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kontaktthema Gruppe'
);

--changeset system:generated-update-data-AsText-AsContactTrigger context:any labels:c-any,o-table,ot-schema,on-AsContactTrigger,fin-13659 runOnChange:true
--comment: Generate AsText for AsContactTrigger
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ab435697-5b6c-d734-96d3-7eaac56b7cac';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ab435697-5b6c-d734-96d3-7eaac56b7cac',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Contact Trigger'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ab435697-5b6c-d734-96d3-7eaac56b7cac',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kontaktauslöser'
);

--changeset system:generated-update-data-AsText-AsCorrItem context:any labels:c-any,o-table,ot-schema,on-AsCorrItem,fin-13659 runOnChange:true
--comment: Generate AsText for AsCorrItem
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='54d8df03-5fe3-e83d-b361-3907a8958a69';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '54d8df03-5fe3-e83d-b361-3907a8958a69',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'possible document types'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '54d8df03-5fe3-e83d-b361-3907a8958a69',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'mögliche Dokumente'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '54d8df03-5fe3-e83d-b361-3907a8958a69',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Types de documents possib'
);

--changeset system:generated-update-data-AsText-AsCorrItemGroup context:any labels:c-any,o-table,ot-schema,on-AsCorrItemGroup,fin-13659 runOnChange:true
--comment: Generate AsText for AsCorrItemGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='da78cc67-d8c4-1b35-a042-ff6df979e975';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'da78cc67-d8c4-1b35-a042-ff6df979e975',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'document item group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'da78cc67-d8c4-1b35-a042-ff6df979e975',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Dokumentengruppe'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'da78cc67-d8c4-1b35-a042-ff6df979e975',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'groupe d''éléments documen'
);

--changeset system:generated-update-data-AsText-AsCountry context:any labels:c-any,o-table,ot-schema,on-AsCountry,fin-13659 runOnChange:true
--comment: Generate AsText for AsCountry
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a4bca369-f437-f63f-a450-fd487b12ead3';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a4bca369-f437-f63f-a450-fd487b12ead3',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Country'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a4bca369-f437-f63f-a450-fd487b12ead3',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Länder'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a4bca369-f437-f63f-a450-fd487b12ead3',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Pays'
);

--changeset system:generated-update-data-AsText-AsCountryRisk context:any labels:c-any,o-table,ot-schema,on-AsCountryRisk,fin-13659 runOnChange:true
--comment: Generate AsText for AsCountryRisk
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0ade77ba-2456-f331-92a1-52524c719724';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0ade77ba-2456-f331-92a1-52524c719724',
    1,
    'MdTableDataDef',
    NULL,
    N'Länderrisiko Seba',
    N'Länderrisiko Seba'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0ade77ba-2456-f331-92a1-52524c719724',
    2,
    'MdTableDataDef',
    NULL,
    N'Länderrisiko Seba',
    N'Länderrisiko Seba'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0ade77ba-2456-f331-92a1-52524c719724',
    3,
    'MdTableDataDef',
    NULL,
    N'Länderrisiko Seba',
    N'Länderrisiko Seba'
);

--changeset system:generated-update-data-AsText-AsDigit0To9 context:any labels:c-any,o-table,ot-schema,on-AsDigit0To9,fin-13659 runOnChange:true
--comment: Generate AsText for AsDigit0To9
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2dedc1b1-cc63-de39-b6b8-8b376c6065b1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2dedc1b1-cc63-de39-b6b8-8b376c6065b1',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Digit 0 - 9'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2dedc1b1-cc63-de39-b6b8-8b376c6065b1',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Anzahl 0 - 9'
);

--changeset system:generated-update-data-AsText-AsDirectJump context:any labels:c-any,o-table,ot-schema,on-AsDirectJump,fin-13659 runOnChange:true
--comment: Generate AsText for AsDirectJump
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='fc15f976-dd8a-5b39-87f2-81fe463a6828';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fc15f976-dd8a-5b39-87f2-81fe463a6828',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Direct Jump'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fc15f976-dd8a-5b39-87f2-81fe463a6828',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Direktsprung'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fc15f976-dd8a-5b39-87f2-81fe463a6828',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Saut direct'
);

--changeset system:generated-update-data-AsText-AsDocLocation context:any labels:c-any,o-table,ot-schema,on-AsDocLocation,fin-13659 runOnChange:true
--comment: Generate AsText for AsDocLocation
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='576b332f-2aac-1533-b124-bc3456963112';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '576b332f-2aac-1533-b124-bc3456963112',
    1,
    'MdTableDataDef',
    NULL,
    N'document location',
    N'document location'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '576b332f-2aac-1533-b124-bc3456963112',
    2,
    'MdTableDataDef',
    NULL,
    N'Dokument Location',
    N'Dokument Location'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '576b332f-2aac-1533-b124-bc3456963112',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Emplacement du document'
);

--changeset system:generated-update-data-AsText-AsDocScanFailureReason context:any labels:c-any,o-table,ot-schema,on-AsDocScanFailureReason,fin-13659 runOnChange:true
--comment: Generate AsText for AsDocScanFailureReason
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0c9f0e56-59e3-5035-b91f-b98e0c03825b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0c9f0e56-59e3-5035-b91f-b98e0c03825b',
    1,
    'MdTableDataDef',
    NULL,
    N'Scanimport failure reason',
    N'Scanimport failure reason'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0c9f0e56-59e3-5035-b91f-b98e0c03825b',
    2,
    'MdTableDataDef',
    NULL,
    N'Scanimport Fehlertyp',
    N'Scanimport Fehlertyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0c9f0e56-59e3-5035-b91f-b98e0c03825b',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Raison de l''échec de Scan'
);

--changeset system:generated-update-data-AsText-AsDocScanStatus context:any labels:c-any,o-table,ot-schema,on-AsDocScanStatus,fin-13659 runOnChange:true
--comment: Generate AsText for AsDocScanStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0ca6c8d8-0b56-f232-a652-8cf9fed9fb8a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0ca6c8d8-0b56-f232-a652-8cf9fed9fb8a',
    1,
    'MdTableDataDef',
    NULL,
    N'docimport scanstatus',
    N'docimport scanstatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0ca6c8d8-0b56-f232-a652-8cf9fed9fb8a',
    2,
    'MdTableDataDef',
    NULL,
    N'Dokimport Scanstatus',
    N'Dokimport Scanstatus'
);

--changeset system:generated-update-data-AsText-AsDocumentFormat context:any labels:c-any,o-table,ot-schema,on-AsDocumentFormat,fin-13659 runOnChange:true
--comment: Generate AsText for AsDocumentFormat
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='73d6a388-ec68-0b37-b274-3752079e49f2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '73d6a388-ec68-0b37-b274-3752079e49f2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Document Format'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '73d6a388-ec68-0b37-b274-3752079e49f2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Dokument Format'
);

--changeset system:generated-update-data-AsText-AsDocumentStatus context:any labels:c-any,o-table,ot-schema,on-AsDocumentStatus,fin-13659 runOnChange:true
--comment: Generate AsText for AsDocumentStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c51ed349-0d6b-7530-9e72-559416592662';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c51ed349-0d6b-7530-9e72-559416592662',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Document Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c51ed349-0d6b-7530-9e72-559416592662',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Dokument Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c51ed349-0d6b-7530-9e72-559416592662',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Statut du document'
);

--changeset system:generated-update-data-AsText-AsDocumentVerification context:any labels:c-any,o-table,ot-schema,on-AsDocumentVerification,fin-13659 runOnChange:true
--comment: Generate AsText for AsDocumentVerification
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b854a59a-1a27-e939-bb65-de73d9de6c67';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b854a59a-1a27-e939-bb65-de73d9de6c67',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'AsDocumentVerification'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b854a59a-1a27-e939-bb65-de73d9de6c67',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Dokument Überprüfung'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b854a59a-1a27-e939-bb65-de73d9de6c67',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'AsDocumentVerification'
);

--changeset system:generated-update-data-AsText-AsDynamicMenu context:any labels:c-any,o-table,ot-schema,on-AsDynamicMenu,fin-13659 runOnChange:true
--comment: Generate AsText for AsDynamicMenu
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7432ecc9-6cea-bf39-9d74-74515fa37e2d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7432ecc9-6cea-bf39-9d74-74515fa37e2d',
    1,
    'MdTableDataDef',
    NULL,
    N'AsDynamicMenu',
    N'AsDynamicMenu'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7432ecc9-6cea-bf39-9d74-74515fa37e2d',
    2,
    'MdTableDataDef',
    NULL,
    N'AsDynamicMenu',
    N'AsDynamicMenu'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7432ecc9-6cea-bf39-9d74-74515fa37e2d',
    3,
    'MdTableDataDef',
    NULL,
    N'AsDynamicMenu',
    N'AsDynamicMenu'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7432ecc9-6cea-bf39-9d74-74515fa37e2d',
    4,
    'MdTableDataDef',
    NULL,
    N'AsDynamicMenu',
    N'AsDynamicMenu'
);

--changeset system:generated-update-data-AsText-AsExcelTemplate context:any labels:c-any,o-table,ot-schema,on-AsExcelTemplate,fin-13659 runOnChange:true
--comment: Generate AsText for AsExcelTemplate
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='549f17a4-0acb-2639-9c0d-5d56e6a7fa70';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '549f17a4-0acb-2639-9c0d-5d56e6a7fa70',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Excel Template'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '549f17a4-0acb-2639-9c0d-5d56e6a7fa70',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Excel Vorlage'
);

--changeset system:generated-update-data-AsText-AsExcelTemplateDef context:any labels:c-any,o-table,ot-schema,on-AsExcelTemplateDef,fin-13659 runOnChange:true
--comment: Generate AsText for AsExcelTemplateDef
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2263a318-25cd-cd3e-ac3d-126555fa7494';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2263a318-25cd-cd3e-ac3d-126555fa7494',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Excel Template Def'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2263a318-25cd-cd3e-ac3d-126555fa7494',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Excel Template Def'
);

--changeset system:generated-update-data-AsText-AsFunctionGroup context:any labels:c-any,o-table,ot-schema,on-AsFunctionGroup,fin-13659 runOnChange:true
--comment: Generate AsText for AsFunctionGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5ceeb022-d497-9a31-9c4a-ba528d0ca052';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5ceeb022-d497-9a31-9c4a-ba528d0ca052',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Function Permission Group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5ceeb022-d497-9a31-9c4a-ba528d0ca052',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Berechtigungen Funktionen'
);

--changeset system:generated-update-data-AsText-AsGroup context:any labels:c-any,o-table,ot-schema,on-AsGroup,fin-13659 runOnChange:true
--comment: Generate AsText for AsGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a70a0648-5e46-5e39-86e9-fd7a8e609e04';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a70a0648-5e46-5e39-86e9-fd7a8e609e04',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a70a0648-5e46-5e39-86e9-fd7a8e609e04',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gruppe'
);

--changeset system:generated-update-data-AsText-AsGroupType context:any labels:c-any,o-table,ot-schema,on-AsGroupType,fin-13659 runOnChange:true
--comment: Generate AsText for AsGroupType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bb688bb3-aeb8-f731-ae36-ce1bb00b5d0f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bb688bb3-aeb8-f731-ae36-ce1bb00b5d0f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Group Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bb688bb3-aeb8-f731-ae36-ce1bb00b5d0f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gruppierung'
);

--changeset system:generated-update-data-AsText-AsInternalCostType context:any labels:c-any,o-table,ot-schema,on-AsInternalCostType,fin-13659 runOnChange:true
--comment: Generate AsText for AsInternalCostType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3f72868a-f64f-8c30-b754-a1cfc0551a35';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3f72868a-f64f-8c30-b754-a1cfc0551a35',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'internal cost type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3f72868a-f64f-8c30-b754-a1cfc0551a35',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kostenart'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3f72868a-f64f-8c30-b754-a1cfc0551a35',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type de coût interne'
);

--changeset system:generated-update-data-AsText-AsInternRatingCode context:any labels:c-any,o-table,ot-schema,on-AsInternRatingCode,fin-13659 runOnChange:true
--comment: Generate AsText for AsInternRatingCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a1b86d78-b046-cd33-9827-5fd0b745e5f0';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a1b86d78-b046-cd33-9827-5fd0b745e5f0',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Intern Rating Code'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a1b86d78-b046-cd33-9827-5fd0b745e5f0',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Internes Rating'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a1b86d78-b046-cd33-9827-5fd0b745e5f0',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Code de notation interne'
);

--changeset system:generated-update-data-AsText-AsIntEventInboxProcessingState context:any labels:c-any,o-table,ot-schema,on-AsIntEventInboxProcessingState,fin-13659 runOnChange:true
--comment: Generate AsText for AsIntEventInboxProcessingState
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='43a8a886-c785-a032-a328-8c72f5aa6f5f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '43a8a886-c785-a032-a328-8c72f5aa6f5f',
    1,
    'MdTableDataDef',
    NULL,
    N'Defines possible processing states for incoming integration events.',
    N'Processing State'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '43a8a886-c785-a032-a328-8c72f5aa6f5f',
    2,
    'MdTableDataDef',
    NULL,
    N'Definiert mögliche Verarbeitungszustände für eingehende Ereignisse aus Integrationen.',
    N'Eing.Verarbeitungszustand'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '43a8a886-c785-a032-a328-8c72f5aa6f5f',
    3,
    'MdTableDataDef',
    NULL,
    N'Defines possible processing states for incoming integration events.',
    N'Processing State'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '43a8a886-c785-a032-a328-8c72f5aa6f5f',
    4,
    'MdTableDataDef',
    NULL,
    N'Defines possible processing states for incoming integration events.',
    N'Processing State'
);

--changeset system:generated-update-data-AsText-AsIntEventNode context:any labels:c-any,o-table,ot-schema,on-AsIntEventNode,fin-13659 runOnChange:true
--comment: Generate AsText for AsIntEventNode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='47ed85dc-ff49-373f-889e-924f47e2d40f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '47ed85dc-ff49-373f-889e-924f47e2d40f',
    1,
    'MdTableDataDef',
    NULL,
    N'Event nodes can be applications, processors or brokers which produce and consume events.',
    N'Event Node'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '47ed85dc-ff49-373f-889e-924f47e2d40f',
    2,
    'MdTableDataDef',
    NULL,
    N'Knoten sind Applikationen, Prozessoren oder Broker, welche Ereignisse produzieren oder konsumieren',
    N'Ereignisknoten'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '47ed85dc-ff49-373f-889e-924f47e2d40f',
    3,
    'MdTableDataDef',
    NULL,
    N'Event nodes can be applications, processors or brokers which produce and consume events.',
    N'Noeud d''événement'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '47ed85dc-ff49-373f-889e-924f47e2d40f',
    4,
    'MdTableDataDef',
    NULL,
    N'Event nodes can be applications, processors or brokers which produce and consume events.',
    N'Nodo Evento'
);

--changeset system:generated-update-data-AsText-AsIntEventNodeType context:any labels:c-any,o-table,ot-schema,on-AsIntEventNodeType,fin-13659 runOnChange:true
--comment: Generate AsText for AsIntEventNodeType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='23e9a534-4dc1-3337-866c-d4f4d257615d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '23e9a534-4dc1-3337-866c-d4f4d257615d',
    1,
    'MdTableDataDef',
    NULL,
    N'The type of event node with which the system sends events to or consumes events from.',
    N'Event Node Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '23e9a534-4dc1-3337-866c-d4f4d257615d',
    2,
    'MdTableDataDef',
    NULL,
    N'Die Art von Ereignisknoten mit denen Kommuniziert wird um Ereignisse zu sender oder empfangen.',
    N'Ereignis-Knotentyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '23e9a534-4dc1-3337-866c-d4f4d257615d',
    3,
    'MdTableDataDef',
    NULL,
    N'The type of event node with which the system sends events to or consumes events from.',
    N'Type de noeud d''événement'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '23e9a534-4dc1-3337-866c-d4f4d257615d',
    4,
    'MdTableDataDef',
    NULL,
    N'The type of event node with which the system sends events to or consumes events from.',
    N'Tipo di nodo evento'
);

--changeset system:generated-update-data-AsText-AsIntEventOutboxProcState context:any labels:c-any,o-table,ot-schema,on-AsIntEventOutboxProcState,fin-13659 runOnChange:true
--comment: Generate AsText for AsIntEventOutboxProcState
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2079da03-7383-2c3c-8f71-927eb29832b3';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2079da03-7383-2c3c-8f71-927eb29832b3',
    1,
    'MdTableDataDef',
    NULL,
    N'The possible publishing states for the integration event outbox',
    N'Outbox Processing State'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2079da03-7383-2c3c-8f71-927eb29832b3',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ausg.Verarbeitungszustand'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2079da03-7383-2c3c-8f71-927eb29832b3',
    3,
    'MdTableDataDef',
    NULL,
    N'The possible publishing states for the integration event outbox',
    N'Outbox Processing State'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2079da03-7383-2c3c-8f71-927eb29832b3',
    4,
    'MdTableDataDef',
    NULL,
    N'The possible publishing states for the integration event outbox',
    N'Outbox Processing State'
);

--changeset system:generated-update-data-AsText-AsIntEventTopic context:any labels:c-any,o-table,ot-schema,on-AsIntEventTopic,fin-13659 runOnChange:true
--comment: Generate AsText for AsIntEventTopic
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6f797a40-7b99-9336-982a-52e597b05659';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6f797a40-7b99-9336-982a-52e597b05659',
    1,
    'MdTableDataDef',
    NULL,
    N'Defines topics for consuming and publishing events of various types.',
    N'Topic'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6f797a40-7b99-9336-982a-52e597b05659',
    2,
    'MdTableDataDef',
    NULL,
    N'Definiert ein Thema für das Veröffentlichen und Konsumieren von verschiedenartigen Ereignissen',
    N'Thema (Topic)'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6f797a40-7b99-9336-982a-52e597b05659',
    3,
    'MdTableDataDef',
    NULL,
    N'Defines topics for consuming and publishing events of various types.',
    N'Sujet (Topic)'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6f797a40-7b99-9336-982a-52e597b05659',
    4,
    'MdTableDataDef',
    NULL,
    N'Defines topics for consuming and publishing events of various types.',
    N'Argomento (Topic)'
);

--changeset system:generated-update-data-AsText-AsIntEventType context:any labels:c-any,o-table,ot-schema,on-AsIntEventType,fin-13659 runOnChange:true
--comment: Generate AsText for AsIntEventType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3c3be6a5-371b-4433-9952-f68c197aad2b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3c3be6a5-371b-4433-9952-f68c197aad2b',
    1,
    'MdTableDataDef',
    NULL,
    N'The type of an event, an occurrence, something that happened in the past',
    N'Event Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3c3be6a5-371b-4433-9952-f68c197aad2b',
    2,
    'MdTableDataDef',
    NULL,
    N'Der Typ eines Ereignisses, einer Vorkommnis, etwas, das in der Vergangenheit passiert ist.',
    N'Ereignistyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3c3be6a5-371b-4433-9952-f68c197aad2b',
    3,
    'MdTableDataDef',
    NULL,
    N'The type of an event, an occurrence, something that happened in the past',
    N'Type d''événement'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3c3be6a5-371b-4433-9952-f68c197aad2b',
    4,
    'MdTableDataDef',
    NULL,
    N'The type of an event, an occurrence, something that happened in the past',
    N'Tipo di evento'
);

--changeset system:generated-update-data-AsText-AsInvoiceType context:any labels:c-any,o-table,ot-schema,on-AsInvoiceType,fin-13659 runOnChange:true
--comment: Generate AsText for AsInvoiceType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='454f4a9a-20f0-963f-adf0-bc8f4fbac5a9';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '454f4a9a-20f0-963f-adf0-bc8f4fbac5a9',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Invoice type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '454f4a9a-20f0-963f-adf0-bc8f4fbac5a9',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rechnungstyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '454f4a9a-20f0-963f-adf0-bc8f4fbac5a9',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type de facture'
);

--changeset system:generated-update-data-AsText-AsLanguage context:any labels:c-any,o-table,ot-schema,on-AsLanguage,fin-13659 runOnChange:true
--comment: Generate AsText for AsLanguage
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ed468185-6168-aa33-a699-699001d75737';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ed468185-6168-aa33-a699-699001d75737',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Language'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ed468185-6168-aa33-a699-699001d75737',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Sprache'
);

--changeset system:generated-update-data-AsText-AsMailConfigSet context:any labels:c-any,o-table,ot-schema,on-AsMailConfigSet,fin-13659 runOnChange:true
--comment: Generate AsText for AsMailConfigSet
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e7ca7959-149b-5c3a-9a5d-8f0ee8a47dae';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e7ca7959-149b-5c3a-9a5d-8f0ee8a47dae',
    1,
    'MdTableDataDef',
    NULL,
    N'MailConfigSet',
    N'MailConfigSet'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e7ca7959-149b-5c3a-9a5d-8f0ee8a47dae',
    2,
    'MdTableDataDef',
    NULL,
    N'MailConfigSet',
    N'MailConfigSet'
);

--changeset system:generated-update-data-AsText-AsMailInset context:any labels:c-any,o-table,ot-schema,on-AsMailInset,fin-13659 runOnChange:true
--comment: Generate AsText for AsMailInset
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c7738b25-ec6f-2031-8f49-35bbd2456ed3';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c7738b25-ec6f-2031-8f49-35bbd2456ed3',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Mail Attachment'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c7738b25-ec6f-2031-8f49-35bbd2456ed3',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Mail Attachment'
);

--changeset system:generated-update-data-AsText-AsMailJobCategory context:any labels:c-any,o-table,ot-schema,on-AsMailJobCategory,fin-13659 runOnChange:true
--comment: Generate AsText for AsMailJobCategory
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b84941aa-8f74-8a36-8647-2c52cbb2b472';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b84941aa-8f74-8a36-8647-2c52cbb2b472',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Mail Job Category'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b84941aa-8f74-8a36-8647-2c52cbb2b472',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Druckkategorie'
);

--changeset system:generated-update-data-AsText-AsMailOutputDevice context:any labels:c-any,o-table,ot-schema,on-AsMailOutputDevice,fin-13659 runOnChange:true
--comment: Generate AsText for AsMailOutputDevice
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='dd6010e9-883d-c234-8e2b-bdb4f5d4af4b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'dd6010e9-883d-c234-8e2b-bdb4f5d4af4b',
    1,
    'MdTableDataDef',
    NULL,
    N'Virtual Print Devices',
    N'VirtualPrintDevices'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'dd6010e9-883d-c234-8e2b-bdb4f5d4af4b',
    2,
    'MdTableDataDef',
    NULL,
    N'Virtual Print Devices',
    N'VirtualPrintDevices'
);

--changeset system:generated-update-data-AsText-AsMailOutputExternalSla context:any labels:c-any,o-table,ot-schema,on-AsMailOutputExternalSla,fin-13659 runOnChange:true
--comment: Generate AsText for AsMailOutputExternalSla
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ecaab85d-f292-1432-b83a-22adecba602e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ecaab85d-f292-1432-b83a-22adecba602e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'External Mail Print SLA'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ecaab85d-f292-1432-b83a-22adecba602e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ext. Jobspez. MailOutput'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ecaab85d-f292-1432-b83a-22adecba602e',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Mail spéc. externe SLA'
);

--changeset system:generated-update-data-AsText-AsMarketingEvent context:any labels:c-any,o-table,ot-schema,on-AsMarketingEvent,fin-13659 runOnChange:true
--comment: Generate AsText for AsMarketingEvent
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='26e1da27-8ae0-9b37-9cce-05b7d9f3cbee';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '26e1da27-8ae0-9b37-9cce-05b7d9f3cbee',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Marketing Events'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '26e1da27-8ae0-9b37-9cce-05b7d9f3cbee',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Marketing Events'
);

--changeset system:generated-update-data-AsText-AsMotiveCloseType context:any labels:c-any,o-table,ot-schema,on-AsMotiveCloseType,fin-13659 runOnChange:true
--comment: Generate AsText for AsMotiveCloseType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4a0d6891-58af-8d3f-a478-2179a9930c98';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4a0d6891-58af-8d3f-a478-2179a9930c98',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Motive Close Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4a0d6891-58af-8d3f-a478-2179a9930c98',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Saldierungsgrund'
);

--changeset system:generated-update-data-AsText-AsMotiveOpenType context:any labels:c-any,o-table,ot-schema,on-AsMotiveOpenType,fin-13659 runOnChange:true
--comment: Generate AsText for AsMotiveOpenType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e3085f99-65c9-d63d-a839-9a65ac03c19d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e3085f99-65c9-d63d-a839-9a65ac03c19d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Motive Open Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e3085f99-65c9-d63d-a839-9a65ac03c19d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Eröffnungsgrund'
);

--changeset system:generated-update-data-AsText-AsNavigationFolder context:any labels:c-any,o-table,ot-schema,on-AsNavigationFolder,fin-13659 runOnChange:true
--comment: Generate AsText for AsNavigationFolder
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6ab88360-6df4-533c-8860-eacb289324bc';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6ab88360-6df4-533c-8860-eacb289324bc',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Navigation Folder'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6ab88360-6df4-533c-8860-eacb289324bc',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Naviagtion Ordner'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6ab88360-6df4-533c-8860-eacb289324bc',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'dossier de navigation'
);

--changeset system:generated-update-data-AsText-AsNavigationForm context:any labels:c-any,o-table,ot-schema,on-AsNavigationForm,fin-13659 runOnChange:true
--comment: Generate AsText for AsNavigationForm
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='13e52cca-7f6e-2f38-821e-d8e2e978aa3b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '13e52cca-7f6e-2f38-821e-d8e2e978aa3b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Navigation Forms'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '13e52cca-7f6e-2f38-821e-d8e2e978aa3b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Naviagtionforms'
);

--changeset system:generated-update-data-AsText-AsNotificationActionType context:any labels:c-any,o-table,ot-schema,on-AsNotificationActionType,fin-13659 runOnChange:true
--comment: Generate AsText for AsNotificationActionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='29173144-a962-a93e-844d-dec8c04042ed';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '29173144-a962-a93e-844d-dec8c04042ed',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Action Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '29173144-a962-a93e-844d-dec8c04042ed',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Aktionstyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '29173144-a962-a93e-844d-dec8c04042ed',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Catalogue des actions'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '29173144-a962-a93e-844d-dec8c04042ed',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Catalogo delle azioni'
);

--changeset system:generated-update-data-AsText-AsNotificationConditionType context:any labels:c-any,o-table,ot-schema,on-AsNotificationConditionType,fin-13659 runOnChange:true
--comment: Generate AsText for AsNotificationConditionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ee8976e2-30e4-a333-9b15-f4d1cbda4d8c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ee8976e2-30e4-a333-9b15-f4d1cbda4d8c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Condition Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ee8976e2-30e4-a333-9b15-f4d1cbda4d8c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Konditionstyp'
);

--changeset system:generated-update-data-AsText-AsOperatingSystem context:any labels:c-any,o-table,ot-schema,on-AsOperatingSystem,fin-13659 runOnChange:true
--comment: Generate AsText for AsOperatingSystem
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0661df07-4cd8-8337-8e2b-6bca8e91ceb8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0661df07-4cd8-8337-8e2b-6bca8e91ceb8',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Operating Systems'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0661df07-4cd8-8337-8e2b-6bca8e91ceb8',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Betriebssysteme'
);

--changeset system:generated-update-data-AsText-AsPaybackType context:any labels:c-any,o-table,ot-schema,on-AsPaybackType,fin-13659 runOnChange:true
--comment: Generate AsText for AsPaybackType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='222cb91d-ef0a-9a3e-b170-02f6b4cc3a23';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '222cb91d-ef0a-9a3e-b170-02f6b4cc3a23',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Payback Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '222cb91d-ef0a-9a3e-b170-02f6b4cc3a23',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Amortisationstyp'
);

--changeset system:generated-update-data-AsText-AsPaymentType context:any labels:c-any,o-table,ot-schema,on-AsPaymentType,fin-13659 runOnChange:true
--comment: Generate AsText for AsPaymentType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f5380399-3bee-233a-95f5-87fda08f714c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f5380399-3bee-233a-95f5-87fda08f714c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'PaymentType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f5380399-3bee-233a-95f5-87fda08f714c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Buchungsvorschrift Code'
);

--changeset system:generated-update-data-AsText-AsPeriodRule context:any labels:c-any,o-table,ot-schema,on-AsPeriodRule,fin-13659 runOnChange:true
--comment: Generate AsText for AsPeriodRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f4bd5776-9a4f-3a3f-ae11-72e6cf10e711';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f4bd5776-9a4f-3a3f-ae11-72e6cf10e711',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Period Role'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f4bd5776-9a4f-3a3f-ae11-72e6cf10e711',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Periodizität'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f4bd5776-9a4f-3a3f-ae11-72e6cf10e711',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Périodicité'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f4bd5776-9a4f-3a3f-ae11-72e6cf10e711',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Periodicità'
);

--changeset system:generated-update-data-AsText-AsPositionCalcType context:any labels:c-any,o-table,ot-schema,on-AsPositionCalcType,fin-13659 runOnChange:true
--comment: Generate AsText for AsPositionCalcType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='eab56559-a469-1730-95e4-6654b0826a15';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'eab56559-a469-1730-95e4-6654b0826a15',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Position calculation type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'eab56559-a469-1730-95e4-6654b0826a15',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Art der Saldoberechung'
);

--changeset system:generated-update-data-AsText-AsPriceLimitType context:any labels:c-any,o-table,ot-schema,on-AsPriceLimitType,fin-13659 runOnChange:true
--comment: Generate AsText for AsPriceLimitType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='aa25c97b-76c8-5433-a894-853be57da730';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'aa25c97b-76c8-5433-a894-853be57da730',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Price limit type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'aa25c97b-76c8-5433-a894-853be57da730',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Preise Limitenart'
);

--changeset system:generated-update-data-AsText-AsPrivacyGroup context:any labels:c-any,o-table,ot-schema,on-AsPrivacyGroup,fin-13659 runOnChange:true
--comment: Generate AsText for AsPrivacyGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3af531f6-5787-013a-97f4-c72d6556f43e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3af531f6-5787-013a-97f4-c72d6556f43e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Data Permission Group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3af531f6-5787-013a-97f4-c72d6556f43e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Berechtigungen Daten'
);

--changeset system:generated-update-data-AsText-AsPrivacyLock context:any labels:c-any,o-table,ot-schema,on-AsPrivacyLock,fin-13659 runOnChange:true
--comment: Generate AsText for AsPrivacyLock
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='84852c00-a465-2930-b93e-c954aed2d5b9';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '84852c00-a465-2930-b93e-c954aed2d5b9',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Privacy Lock'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '84852c00-a465-2930-b93e-c954aed2d5b9',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Datenschutz'
);

--changeset system:generated-update-data-AsText-AsProcessState context:any labels:c-any,o-table,ot-schema,on-AsProcessState,fin-13659 runOnChange:true
--comment: Generate AsText for AsProcessState
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c05fb091-c895-9f35-ab11-1f98d6dc5b00';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c05fb091-c895-9f35-ab11-1f98d6dc5b00',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Process state'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c05fb091-c895-9f35-ab11-1f98d6dc5b00',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Prozess Status'
);

--changeset system:generated-update-data-AsText-AsProfitCenter context:any labels:c-any,o-table,ot-schema,on-AsProfitCenter,fin-13659 runOnChange:true
--comment: Generate AsText for AsProfitCenter
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='60ffc098-0ef1-fd38-ae58-547a85bc6095';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '60ffc098-0ef1-fd38-ae58-547a85bc6095',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'PC, CC, SC'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '60ffc098-0ef1-fd38-ae58-547a85bc6095',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'PC, CC, SC'
);

--changeset system:generated-update-data-AsText-AsRanking context:any labels:c-any,o-table,ot-schema,on-AsRanking,fin-13659 runOnChange:true
--comment: Generate AsText for AsRanking
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='57af44d9-6809-6c31-9459-397936012787';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '57af44d9-6809-6c31-9459-397936012787',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ranking'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '57af44d9-6809-6c31-9459-397936012787',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rangstellung'
);

--changeset system:generated-update-data-AsText-AsRatingAgency context:any labels:c-any,o-table,ot-schema,on-AsRatingAgency,fin-13659 runOnChange:true
--comment: Generate AsText for AsRatingAgency
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bdce4ff3-8b5d-3935-b14a-58f7db9c19d1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bdce4ff3-8b5d-3935-b14a-58f7db9c19d1',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rating Agency'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bdce4ff3-8b5d-3935-b14a-58f7db9c19d1',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rating Agenturen'
);

--changeset system:generated-update-data-AsText-AsRatingImFunction context:any labels:c-any,o-table,ot-schema,on-AsRatingImFunction,fin-13659 runOnChange:true
--comment: Generate AsText for AsRatingImFunction
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='780d87ed-85b2-f039-b1ce-69fd04aafcf2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '780d87ed-85b2-f039-b1ce-69fd04aafcf2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Immaterial functions'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '780d87ed-85b2-f039-b1ce-69fd04aafcf2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Immaterielle Funktionen'
);

--changeset system:generated-update-data-AsText-AsRatingImModel context:any labels:c-any,o-table,ot-schema,on-AsRatingImModel,fin-13659 runOnChange:true
--comment: Generate AsText for AsRatingImModel
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4189f01a-ac1b-163b-8501-2f7be4a94acd';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4189f01a-ac1b-163b-8501-2f7be4a94acd',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'immaterial model'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4189f01a-ac1b-163b-8501-2f7be4a94acd',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Immaterielles Model'
);

--changeset system:generated-update-data-AsText-AsRequestStatus context:any labels:c-any,o-table,ot-schema,on-AsRequestStatus,fin-13659 runOnChange:true
--comment: Generate AsText for AsRequestStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='fbaf9985-6d21-e031-aa76-a937a8d35e3a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fbaf9985-6d21-e031-aa76-a937a8d35e3a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'RequestStatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fbaf9985-6d21-e031-aa76-a937a8d35e3a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Anfragestatus'
);

--changeset system:generated-update-data-AsText-AsRole context:any labels:c-any,o-table,ot-schema,on-AsRole,fin-13659 runOnChange:true
--comment: Generate AsText for AsRole
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f05f5243-562f-4c3d-ad15-c7d12566b720';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f05f5243-562f-4c3d-ad15-c7d12566b720',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'User Role'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f05f5243-562f-4c3d-ad15-c7d12566b720',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Benutzerrolle'
);

--changeset system:generated-update-data-AsText-AsRoundingRule context:any labels:c-any,o-table,ot-schema,on-AsRoundingRule,fin-13659 runOnChange:true
--comment: Generate AsText for AsRoundingRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3835561e-6031-5738-adec-a24145c2708b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3835561e-6031-5738-adec-a24145c2708b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rounding rule'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3835561e-6031-5738-adec-a24145c2708b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rundungsregel'
);

--changeset system:generated-update-data-AsText-AsSecurityAgrType context:any labels:c-any,o-table,ot-schema,on-AsSecurityAgrType,fin-13659 runOnChange:true
--comment: Generate AsText for AsSecurityAgrType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f55ea0c4-3510-d33a-a302-3740c4a73810';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f55ea0c4-3510-d33a-a302-3740c4a73810',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Security Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f55ea0c4-3510-d33a-a302-3740c4a73810',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Sicherheitsvereinb.Typ'
);

--changeset system:generated-update-data-AsText-AsServerRole context:any labels:c-any,o-table,ot-schema,on-AsServerRole,fin-13659 runOnChange:true
--comment: Generate AsText for AsServerRole
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='68fc4c04-8329-b83f-8669-340e06d0318c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '68fc4c04-8329-b83f-8669-340e06d0318c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Server Role'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '68fc4c04-8329-b83f-8669-340e06d0318c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Server Rolle'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '68fc4c04-8329-b83f-8669-340e06d0318c',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Server Role'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '68fc4c04-8329-b83f-8669-340e06d0318c',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Server Role'
);

--changeset system:generated-update-data-AsText-AsServerRoleServer context:any labels:c-any,o-table,ot-schema,on-AsServerRoleServer,fin-13659 runOnChange:true
--comment: Generate AsText for AsServerRoleServer
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2a48a590-2b75-8238-98d9-b6761d3f9fe1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2a48a590-2b75-8238-98d9-b6761d3f9fe1',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Server role assignment'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2a48a590-2b75-8238-98d9-b6761d3f9fe1',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Serverrollen Zuordnung'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2a48a590-2b75-8238-98d9-b6761d3f9fe1',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Server role assignment'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2a48a590-2b75-8238-98d9-b6761d3f9fe1',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Server role assignment'
);

--changeset system:generated-update-data-AsText-AsSmsDispatchType context:any labels:c-any,o-table,ot-schema,on-AsSmsDispatchType,fin-13659 runOnChange:true
--comment: Generate AsText for AsSmsDispatchType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='12b95449-6d2f-6c32-9219-be58f446726d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '12b95449-6d2f-6c32-9219-be58f446726d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Sms Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '12b95449-6d2f-6c32-9219-be58f446726d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Sms Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '12b95449-6d2f-6c32-9219-be58f446726d',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Sms Type'
);

--changeset system:generated-update-data-AsText-AsSwissCityDistrict context:any labels:c-any,o-table,ot-schema,on-AsSwissCityDistrict,fin-13659 runOnChange:true
--comment: Generate AsText for AsSwissCityDistrict
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e6aab481-0fb2-4d35-a4a3-4bc5fc9d0507';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e6aab481-0fb2-4d35-a4a3-4bc5fc9d0507',
    1,
    'MdTableDataDef',
    NULL,
    N'AsSwissCityDistrict',
    N'AsSwissCityDistrict'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e6aab481-0fb2-4d35-a4a3-4bc5fc9d0507',
    2,
    'MdTableDataDef',
    NULL,
    N'AsSwissCityDistrict',
    N'AsSwissCityDistrict'
);

--changeset system:generated-update-data-AsText-AsSwissTownPart context:any labels:c-any,o-table,ot-schema,on-AsSwissTownPart,fin-13659 runOnChange:true
--comment: Generate AsText for AsSwissTownPart
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='849a2434-1733-f035-b2ed-5b3139c9f54e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '849a2434-1733-f035-b2ed-5b3139c9f54e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Parts of Swiss Town'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '849a2434-1733-f035-b2ed-5b3139c9f54e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gemeindeteil'
);

--changeset system:generated-update-data-AsText-AsTemplateGroup context:any labels:c-any,o-table,ot-schema,on-AsTemplateGroup,fin-13659 runOnChange:true
--comment: Generate AsText for AsTemplateGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4d104f5a-7919-1c38-bccb-8357ed00aa36';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4d104f5a-7919-1c38-bccb-8357ed00aa36',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Template groups'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4d104f5a-7919-1c38-bccb-8357ed00aa36',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Vorlagengruppen'
);

--changeset system:generated-update-data-AsText-AsTemplateSelection context:any labels:c-any,o-table,ot-schema,on-AsTemplateSelection,fin-13659 runOnChange:true
--comment: Generate AsText for AsTemplateSelection
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='cdd4d6f5-14fb-d430-b729-87fc4c734902';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cdd4d6f5-14fb-d430-b729-87fc4c734902',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Group of SQL Queries'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cdd4d6f5-14fb-d430-b729-87fc4c734902',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'SQL Abfrage Gruppen'
);

--changeset system:generated-update-data-AsText-AsTestStatus context:any labels:c-any,o-table,ot-schema,on-AsTestStatus,fin-13659 runOnChange:true
--comment: Generate AsText for AsTestStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f38da66e-c6a1-6037-aca2-970d951828d5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f38da66e-c6a1-6037-aca2-970d951828d5',
    1,
    'MdTableDataDef',
    NULL,
    N'TestStatus',
    N'TestStatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f38da66e-c6a1-6037-aca2-970d951828d5',
    2,
    'MdTableDataDef',
    NULL,
    N'TestStatus',
    N'TestStatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f38da66e-c6a1-6037-aca2-970d951828d5',
    3,
    'MdTableDataDef',
    NULL,
    N'TestStatus',
    N'TestStatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f38da66e-c6a1-6037-aca2-970d951828d5',
    4,
    'MdTableDataDef',
    NULL,
    N'TestStatus',
    N'TestStatus'
);

--changeset system:generated-update-data-AsText-AsTransactionType context:any labels:c-any,o-table,ot-schema,on-AsTransactionType,fin-13659 runOnChange:true
--comment: Generate AsText for AsTransactionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='26b4fa4e-ff45-4236-8f97-58bba7a59f6f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '26b4fa4e-ff45-4236-8f97-58bba7a59f6f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Transaction Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '26b4fa4e-ff45-4236-8f97-58bba7a59f6f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Transaktionstyp'
);

--changeset system:generated-update-data-AsText-AsUserGroup context:any labels:c-any,o-table,ot-schema,on-AsUserGroup,fin-13659 runOnChange:true
--comment: Generate AsText for AsUserGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='17e5f14a-dbd3-6534-bc52-685d38a6efc8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '17e5f14a-dbd3-6534-bc52-685d38a6efc8',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'User Grouping'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '17e5f14a-dbd3-6534-bc52-685d38a6efc8',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Benutzergruppierung'
);

--changeset system:generated-update-data-AsText-AsUserGroupingDesc context:any labels:c-any,o-table,ot-schema,on-AsUserGroupingDesc,fin-13659 runOnChange:true
--comment: Generate AsText for AsUserGroupingDesc
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4dd8a9f4-cf34-093b-b7d9-df0e88dfa683';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4dd8a9f4-cf34-093b-b7d9-df0e88dfa683',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Group Description'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4dd8a9f4-cf34-093b-b7d9-df0e88dfa683',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Group Description'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4dd8a9f4-cf34-093b-b7d9-df0e88dfa683',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Group Description'
);

--changeset system:generated-update-data-AsText-AsUserGroupingTop context:any labels:c-any,o-table,ot-schema,on-AsUserGroupingTop,fin-13659 runOnChange:true
--comment: Generate AsText for AsUserGroupingTop
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c22b109a-7127-663c-a4f8-b131a9a323ed';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c22b109a-7127-663c-a4f8-b131a9a323ed',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'User Group top'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c22b109a-7127-663c-a4f8-b131a9a323ed',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'User Group top'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c22b109a-7127-663c-a4f8-b131a9a323ed',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'User Group top'
);

--changeset system:generated-update-data-AsText-AsValueSign context:any labels:c-any,o-table,ot-schema,on-AsValueSign,fin-13659 runOnChange:true
--comment: Generate AsText for AsValueSign
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f603b4be-d070-f331-8197-e0e920d6f249';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f603b4be-d070-f331-8197-e0e920d6f249',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Value Sign'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f603b4be-d070-f331-8197-e0e920d6f249',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Vorzeichen'
);

--changeset system:generated-update-data-AsText-AsVatCode context:any labels:c-any,o-table,ot-schema,on-AsVatCode,fin-13659 runOnChange:true
--comment: Generate AsText for AsVatCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8464fe4e-94d8-c43d-b03d-348d1fcf4f76';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8464fe4e-94d8-c43d-b03d-348d1fcf4f76',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'VAT-Code'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8464fe4e-94d8-c43d-b03d-348d1fcf4f76',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'MWst-Code'
);

--changeset system:generated-update-data-AsText-AsVatDetailPercentage context:any labels:c-any,o-table,ot-schema,on-AsVatDetailPercentage,fin-13659 runOnChange:true
--comment: Generate AsText for AsVatDetailPercentage
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='22468b69-565a-5439-a9dc-ac1e4ddf0de7';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '22468b69-565a-5439-a9dc-ac1e4ddf0de7',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'vat detail %'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '22468b69-565a-5439-a9dc-ac1e4ddf0de7',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Mwst Detailsatz'
);

--changeset system:generated-update-data-AsText-ATMUsabilityCodes context:any labels:c-any,o-table,ot-schema,on-ATMUsabilityCodes,fin-13659 runOnChange:true
--comment: Generate AsText for ATMUsabilityCodes
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0a326595-bcac-6638-9627-0e8975699571';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0a326595-bcac-6638-9627-0e8975699571',
    1,
    'MdTableDataDef',
    NULL,
    N'ATMUsabilityCodes',
    N'ATMUsabilityCodes'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0a326595-bcac-6638-9627-0e8975699571',
    2,
    'MdTableDataDef',
    NULL,
    N'ATMUsabilityCodes',
    N'ATMUsabilityCodes'
);

--changeset system:generated-update-data-AsText-AxTaxDetailATXType context:any labels:c-any,o-table,ot-schema,on-AxTaxDetailATXType,fin-13659 runOnChange:true
--comment: Generate AsText for AxTaxDetailATXType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d2535079-4ecc-d236-a0b9-91969e59afd9';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd2535079-4ecc-d236-a0b9-91969e59afd9',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Detail ATX'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd2535079-4ecc-d236-a0b9-91969e59afd9',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Detail ATX'
);

--changeset system:generated-update-data-AsText-AxTaxInputDocType context:any labels:c-any,o-table,ot-schema,on-AxTaxInputDocType,fin-13659 runOnChange:true
--comment: Generate AsText for AxTaxInputDocType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='02183b70-66d6-9f30-af20-050a14b3bb87';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '02183b70-66d6-9f30-af20-050a14b3bb87',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax country doc type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '02183b70-66d6-9f30-af20-050a14b3bb87',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Länderrep. Dok. Typ'
);

--changeset system:generated-update-data-AsText-AxTaxReportOrder context:any labels:c-any,o-table,ot-schema,on-AxTaxReportOrder,fin-13659 runOnChange:true
--comment: Generate AsText for AxTaxReportOrder
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0f6aa664-333d-b63a-a16e-f95f7a87d7b8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0f6aa664-333d-b63a-a16e-f95f7a87d7b8',
    1,
    'MdTableDataDef',
    NULL,
    N'List of ordered reports for TaxSource',
    N'List of ordered reports f'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0f6aa664-333d-b63a-a16e-f95f7a87d7b8',
    2,
    'MdTableDataDef',
    NULL,
    N'List of ordered reports for TaxSource',
    N'List of ordered reports f'
);

--changeset system:generated-update-data-AsText-AxTaxReportTariffType context:any labels:c-any,o-table,ot-schema,on-AxTaxReportTariffType,fin-13659 runOnChange:true
--comment: Generate AsText for AxTaxReportTariffType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='420111f1-12f7-9839-ac07-ded779bf5b80';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '420111f1-12f7-9839-ac07-ded779bf5b80',
    1,
    'MdTableDataDef',
    NULL,
    N'AxTaxReportTariffType',
    N'AxTaxReportTariffType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '420111f1-12f7-9839-ac07-ded779bf5b80',
    2,
    'MdTableDataDef',
    NULL,
    N'AxTaxReportTariffType',
    N'AxTaxReportTariffType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '420111f1-12f7-9839-ac07-ded779bf5b80',
    3,
    'MdTableDataDef',
    NULL,
    N'AxTaxReportTariffType',
    N'AxTaxReportTariffType'
);

--changeset system:generated-update-data-AsText-BpIntervalType context:any labels:c-any,o-table,ot-schema,on-BpIntervalType,fin-13659 runOnChange:true
--comment: Generate AsText for BpIntervalType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6ee3edc3-9606-183f-b3a3-4f9d9f2b43b4';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6ee3edc3-9606-183f-b3a3-4f9d9f2b43b4',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Interval types'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6ee3edc3-9606-183f-b3a3-4f9d9f2b43b4',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Interval types'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6ee3edc3-9606-183f-b3a3-4f9d9f2b43b4',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Interval types'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6ee3edc3-9606-183f-b3a3-4f9d9f2b43b4',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Interval types'
);

--changeset system:generated-update-data-AsText-BpJobAgent context:any labels:c-any,o-table,ot-schema,on-BpJobAgent,fin-13659 runOnChange:true
--comment: Generate AsText for BpJobAgent
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e5debb85-a6fb-1d3f-9e10-a120ed3778a2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e5debb85-a6fb-1d3f-9e10-a120ed3778a2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Job Agent'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e5debb85-a6fb-1d3f-9e10-a120ed3778a2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Job Agent'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e5debb85-a6fb-1d3f-9e10-a120ed3778a2',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Job Agent'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e5debb85-a6fb-1d3f-9e10-a120ed3778a2',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Job Agent'
);

--changeset system:generated-update-data-AsText-BpJobAgentGroup context:any labels:c-any,o-table,ot-schema,on-BpJobAgentGroup,fin-13659 runOnChange:true
--comment: Generate AsText for BpJobAgentGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='376655b7-eb0d-f237-9f2f-b1eec72444f4';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '376655b7-eb0d-f237-9f2f-b1eec72444f4',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Job Agent Group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '376655b7-eb0d-f237-9f2f-b1eec72444f4',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Job Agent Gruppe'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '376655b7-eb0d-f237-9f2f-b1eec72444f4',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Job Agent Group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '376655b7-eb0d-f237-9f2f-b1eec72444f4',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Job Agent Group'
);

--changeset system:generated-update-data-AsText-BpJobWorkItemStatus context:any labels:c-any,o-table,ot-schema,on-BpJobWorkItemStatus,fin-13659 runOnChange:true
--comment: Generate AsText for BpJobWorkItemStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7dd1e6e8-311f-ef39-8fff-12e4442bdf6e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7dd1e6e8-311f-ef39-8fff-12e4442bdf6e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS Work Item Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7dd1e6e8-311f-ef39-8fff-12e4442bdf6e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS Work Item Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7dd1e6e8-311f-ef39-8fff-12e4442bdf6e',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS Work Item Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7dd1e6e8-311f-ef39-8fff-12e4442bdf6e',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS Work Item Status'
);

--changeset system:generated-update-data-AsText-BpTaskPriority context:any labels:c-any,o-table,ot-schema,on-BpTaskPriority,fin-13659 runOnChange:true
--comment: Generate AsText for BpTaskPriority
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='85570dac-12e9-0c34-9fd9-99449f10f734';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '85570dac-12e9-0c34-9fd9-99449f10f734',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS task priority'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '85570dac-12e9-0c34-9fd9-99449f10f734',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS Task Priorität'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '85570dac-12e9-0c34-9fd9-99449f10f734',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS task priority'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '85570dac-12e9-0c34-9fd9-99449f10f734',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS task priority'
);

--changeset system:generated-update-data-AsText-BpTaskStatus context:any labels:c-any,o-table,ot-schema,on-BpTaskStatus,fin-13659 runOnChange:true
--comment: Generate AsText for BpTaskStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d2bedba3-453b-6e35-8203-2d381ff8623f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd2bedba3-453b-6e35-8203-2d381ff8623f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS task status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd2bedba3-453b-6e35-8203-2d381ff8623f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS Task Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd2bedba3-453b-6e35-8203-2d381ff8623f',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS task status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd2bedba3-453b-6e35-8203-2d381ff8623f',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS task status'
);

--changeset system:generated-update-data-AsText-BpTaskStatusDetail context:any labels:c-any,o-table,ot-schema,on-BpTaskStatusDetail,fin-13659 runOnChange:true
--comment: Generate AsText for BpTaskStatusDetail
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e2cc4289-ddf4-dc3e-96d9-d9e4d76c7381';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e2cc4289-ddf4-dc3e-96d9-d9e4d76c7381',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS detailed task status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e2cc4289-ddf4-dc3e-96d9-d9e4d76c7381',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS detailed task status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e2cc4289-ddf4-dc3e-96d9-d9e4d76c7381',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS detailed task status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e2cc4289-ddf4-dc3e-96d9-d9e4d76c7381',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS detailed task status'
);

--changeset system:generated-update-data-AsText-BpTaskStatusWaitRule context:any labels:c-any,o-table,ot-schema,on-BpTaskStatusWaitRule,fin-13659 runOnChange:true
--comment: Generate AsText for BpTaskStatusWaitRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='640192a3-b3fa-6135-8627-68f4b002d24e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '640192a3-b3fa-6135-8627-68f4b002d24e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS task status wait'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '640192a3-b3fa-6135-8627-68f4b002d24e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS Task Status Warten'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '640192a3-b3fa-6135-8627-68f4b002d24e',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS task status wait'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '640192a3-b3fa-6135-8627-68f4b002d24e',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'JCS task status wait'
);

--changeset system:generated-update-data-AsText-CoComstat context:any labels:c-any,o-table,ot-schema,on-CoComstat,fin-13659 runOnChange:true
--comment: Generate AsText for CoComstat
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='01f1541f-72ed-2330-b8c2-39afd29e5228';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '01f1541f-72ed-2330-b8c2-39afd29e5228',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'com stat after pledge exe'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '01f1541f-72ed-2330-b8c2-39afd29e5228',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Wirt. Stat. nach Ausübung'
);

--changeset system:generated-update-data-AsText-CoDivstat context:any labels:c-any,o-table,ot-schema,on-CoDivstat,fin-13659 runOnChange:true
--comment: Generate AsText for CoDivstat
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='86f99178-dc02-8335-885c-3870e8825605';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '86f99178-dc02-8335-885c-3870e8825605',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'divdend judgment'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '86f99178-dc02-8335-885c-3870e8825605',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Dividendenpot Beurteilung'
);

--changeset system:generated-update-data-AsText-CoDokBase context:any labels:c-any,o-table,ot-schema,on-CoDokBase,fin-13659 runOnChange:true
--comment: Generate AsText for CoDokBase
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3b974420-5cce-ef33-b53c-7a6e1a7f29b9';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3b974420-5cce-ef33-b53c-7a6e1a7f29b9',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'core data kredit document'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3b974420-5cce-ef33-b53c-7a6e1a7f29b9',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Stammdaten  Kreditdokumen'
);

--changeset system:generated-update-data-AsText-CoDokField context:any labels:c-any,o-table,ot-schema,on-CoDokField,fin-13659 runOnChange:true
--comment: Generate AsText for CoDokField
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ef3eaade-9d07-5138-924b-3679551f5802';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ef3eaade-9d07-5138-924b-3679551f5802',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Field data kredit documen'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ef3eaade-9d07-5138-924b-3679551f5802',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Felddaten Kreditedoukment'
);

--changeset system:generated-update-data-AsText-CoEngstat context:any labels:c-any,o-table,ot-schema,on-CoEngstat,fin-13659 runOnChange:true
--comment: Generate AsText for CoEngstat
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d0c2e9e6-41c8-623d-b450-fe11f346369b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd0c2e9e6-41c8-623d-b450-fe11f346369b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'workingstatus engagement'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd0c2e9e6-41c8-623d-b450-fe11f346369b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Status Gesamtengagement'
);

--changeset system:generated-update-data-AsText-CoFutstat context:any labels:c-any,o-table,ot-schema,on-CoFutstat,fin-13659 runOnChange:true
--comment: Generate AsText for CoFutstat
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a655cd6d-d45d-593c-ab5e-77418a5c9f7e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a655cd6d-d45d-593c-ab5e-77418a5c9f7e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'future judgment'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a655cd6d-d45d-593c-ab5e-77418a5c9f7e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zukunftsaus. Beurteilung'
);

--changeset system:generated-update-data-AsText-CoMachstat context:any labels:c-any,o-table,ot-schema,on-CoMachstat,fin-13659 runOnChange:true
--comment: Generate AsText for CoMachstat
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='751bd920-4e2f-333f-9103-07920e5f33a5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '751bd920-4e2f-333f-9103-07920e5f33a5',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'machine judgment'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '751bd920-4e2f-333f-9103-07920e5f33a5',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Produktions. Beurteilung'
);

--changeset system:generated-update-data-AsText-CoManstat context:any labels:c-any,o-table,ot-schema,on-CoManstat,fin-13659 runOnChange:true
--comment: Generate AsText for CoManstat
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='14c7cf07-faef-9c30-8c4d-d73b0d75a93e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '14c7cf07-faef-9c30-8c4d-d73b0d75a93e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'management judgment'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '14c7cf07-faef-9c30-8c4d-d73b0d75a93e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Management Beurteilung'
);

--changeset system:generated-update-data-AsText-CoMoralstat context:any labels:c-any,o-table,ot-schema,on-CoMoralstat,fin-13659 runOnChange:true
--comment: Generate AsText for CoMoralstat
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='95e9c16f-0fcc-453d-bbb4-b509b9202ee2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '95e9c16f-0fcc-453d-bbb4-b509b9202ee2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'mor stat after pledge exe'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '95e9c16f-0fcc-453d-bbb4-b509b9202ee2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Moral Stat. nach Ausübung'
);

--changeset system:generated-update-data-AsText-CoMsg context:any labels:c-any,o-table,ot-schema,on-CoMsg,fin-13659 runOnChange:true
--comment: Generate AsText for CoMsg
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c49497d7-161e-0b3d-961c-f08c46172cba';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c49497d7-161e-0b3d-961c-f08c46172cba',
    1,
    'MdTableDataDef',
    NULL,
    N'msg table',
    N'msg table'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c49497d7-161e-0b3d-961c-f08c46172cba',
    2,
    'MdTableDataDef',
    NULL,
    N'msg table',
    N'msg table'
);

--changeset system:generated-update-data-AsText-CoPremres context:any labels:c-any,o-table,ot-schema,on-CoPremres,fin-13659 runOnChange:true
--comment: Generate AsText for CoPremres
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='eaea770a-09cf-7f34-85d1-db6a5ef8e85b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'eaea770a-09cf-7f34-85d1-db6a5ef8e85b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'resulttable pledge premis'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'eaea770a-09cf-7f34-85d1-db6a5ef8e85b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Resultatstabelle Grundst.'
);

--changeset system:generated-update-data-AsText-CoPricov context:any labels:c-any,o-table,ot-schema,on-CoPricov,fin-13659 runOnChange:true
--comment: Generate AsText for CoPricov
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='cc46ff3a-7e58-803b-b191-e31fb4c5be1f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cc46ff3a-7e58-803b-b191-e31fb4c5be1f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Priority colleteral'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cc46ff3a-7e58-803b-b191-e31fb4c5be1f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Priorität Sicherheit'
);

--changeset system:generated-update-data-AsText-CoProdstat context:any labels:c-any,o-table,ot-schema,on-CoProdstat,fin-13659 runOnChange:true
--comment: Generate AsText for CoProdstat
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1455ce31-ec28-f637-8227-f1e6afd6ef5a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1455ce31-ec28-f637-8227-f1e6afd6ef5a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'product judgment'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1455ce31-ec28-f637-8227-f1e6afd6ef5a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Produkt Beurteilung'
);

--changeset system:generated-update-data-AsText-CoSubtype context:any labels:c-any,o-table,ot-schema,on-CoSubtype,fin-13659 runOnChange:true
--comment: Generate AsText for CoSubtype
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='48d2416e-5adc-6a3d-a4ea-4554aee693d2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '48d2416e-5adc-6a3d-a4ea-4554aee693d2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Colleteralsubtypes'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '48d2416e-5adc-6a3d-a4ea-4554aee693d2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Sicherheitensubtypen'
);

--changeset system:generated-update-data-AsText-CoType context:any labels:c-any,o-table,ot-schema,on-CoType,fin-13659 runOnChange:true
--comment: Generate AsText for CoType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bc85f2b3-ab63-e336-b4f9-1eecb22731b6';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bc85f2b3-ab63-e336-b4f9-1eecb22731b6',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Colleteraltypes'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bc85f2b3-ab63-e336-b4f9-1eecb22731b6',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Sicherheitentypen'
);

--changeset system:generated-update-data-AsText-CoTypecov context:any labels:c-any,o-table,ot-schema,on-CoTypecov,fin-13659 runOnChange:true
--comment: Generate AsText for CoTypecov
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='61730a57-6487-dc30-bdcc-7846c4b001a2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '61730a57-6487-dc30-bdcc-7846c4b001a2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type of coverage'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '61730a57-6487-dc30-bdcc-7846c4b001a2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Arten der Deckung'
);

--changeset system:generated-update-data-AsText-CoTypeeng context:any labels:c-any,o-table,ot-schema,on-CoTypeeng,fin-13659 runOnChange:true
--comment: Generate AsText for CoTypeeng
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='48365314-ebe7-4234-9a45-da5fb02df9e3';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '48365314-ebe7-4234-9a45-da5fb02df9e3',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'working types (account am'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '48365314-ebe7-4234-9a45-da5fb02df9e3',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Verarbungstypen  Kontobet'
);

--changeset system:generated-update-data-AsText-CoTypeField context:any labels:c-any,o-table,ot-schema,on-CoTypeField,fin-13659 runOnChange:true
--comment: Generate AsText for CoTypeField
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ce321add-2016-eb30-9ccc-af1171dee9d3';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ce321add-2016-eb30-9ccc-af1171dee9d3',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'CoTypeField'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ce321add-2016-eb30-9ccc-af1171dee9d3',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'CoTypeField'
);

--changeset system:generated-update-data-AsText-CoTypever context:any labels:c-any,o-table,ot-schema,on-CoTypever,fin-13659 runOnChange:true
--comment: Generate AsText for CoTypever
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='249ffc12-d8cd-3332-b5f2-1178683619e4';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '249ffc12-d8cd-3332-b5f2-1178683619e4',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'working types (coverage)'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '249ffc12-d8cd-3332-b5f2-1178683619e4',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Verarbungstypen  Deckung'
);

--changeset system:generated-update-data-AsText-CoVerastat context:any labels:c-any,o-table,ot-schema,on-CoVerastat,fin-13659 runOnChange:true
--comment: Generate AsText for CoVerastat
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3fbe82a5-b70f-8c3f-9c91-c3832ab48348';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3fbe82a5-b70f-8c3f-9c91-c3832ab48348',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'workingstatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3fbe82a5-b70f-8c3f-9c91-c3832ab48348',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Verarbeitungsstatus'
);

--changeset system:generated-update-data-AsText-CvDisplayLevel context:any labels:c-any,o-table,ot-schema,on-CvDisplayLevel,fin-13659 runOnChange:true
--comment: Generate AsText for CvDisplayLevel
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='62ba1292-29f2-0438-aeb4-f495564e5d97';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '62ba1292-29f2-0438-aeb4-f495564e5d97',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Cost-Value Display Level'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '62ba1292-29f2-0438-aeb4-f495564e5d97',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Einstandswert Anzeigemeng'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '62ba1292-29f2-0438-aeb4-f495564e5d97',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Prix d''acquisition Displ'
);

--changeset system:generated-update-data-AsText-CyAssetClass context:any labels:c-any,o-table,ot-schema,on-CyAssetClass,fin-13659 runOnChange:true
--comment: Generate AsText for CyAssetClass
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2012e8aa-7642-6c34-8692-fa59d1806e7f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2012e8aa-7642-6c34-8692-fa59d1806e7f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Currency Class'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2012e8aa-7642-6c34-8692-fa59d1806e7f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Währungsklasse'
);

--changeset system:generated-update-data-AsText-CyBankNoteGroup context:any labels:c-any,o-table,ot-schema,on-CyBankNoteGroup,fin-13659 runOnChange:true
--comment: Generate AsText for CyBankNoteGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6522fe90-eeec-e334-8310-8ef7b97784a5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6522fe90-eeec-e334-8310-8ef7b97784a5',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Currency groups f. report'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6522fe90-eeec-e334-8310-8ef7b97784a5',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Währungsgruppen f. Report'
);

--changeset system:generated-update-data-AsText-CyBankNoteReportGroup context:any labels:c-any,o-table,ot-schema,on-CyBankNoteReportGroup,fin-13659 runOnChange:true
--comment: Generate AsText for CyBankNoteReportGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5efb97bf-ff33-6538-8083-22dbe27475c0';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5efb97bf-ff33-6538-8083-22dbe27475c0',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'reporting group f. bankn.'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5efb97bf-ff33-6538-8083-22dbe27475c0',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Report Gruppen f. Bankno.'
);

--changeset system:generated-update-data-AsText-CyBase context:any labels:c-any,o-table,ot-schema,on-CyBase,fin-13659 runOnChange:true
--comment: Generate AsText for CyBase
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5df02b53-3f2f-2f3a-9e42-1274e74854f6';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5df02b53-3f2f-2f3a-9e42-1274e74854f6',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Currencies'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5df02b53-3f2f-2f3a-9e42-1274e74854f6',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Währungen'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5df02b53-3f2f-2f3a-9e42-1274e74854f6',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Devises'
);

--changeset system:generated-update-data-AsText-CyCategory context:any labels:c-any,o-table,ot-schema,on-CyCategory,fin-13659 runOnChange:true
--comment: Generate AsText for CyCategory
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='84798167-2765-973a-ad32-16f8dc8bf98a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '84798167-2765-973a-ad32-16f8dc8bf98a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Currency Category'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '84798167-2765-973a-ad32-16f8dc8bf98a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Währungs-Kategorien'
);

--changeset system:generated-update-data-AsText-CyCommission context:any labels:c-any,o-table,ot-schema,on-CyCommission,fin-13659 runOnChange:true
--comment: Generate AsText for CyCommission
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='80e37250-4cd4-be32-8e5f-f062fd91b819';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '80e37250-4cd4-be32-8e5f-f062fd91b819',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Commission'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '80e37250-4cd4-be32-8e5f-f062fd91b819',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kommission'
);

--changeset system:generated-update-data-AsText-CyContractInstrument context:any labels:c-any,o-table,ot-schema,on-CyContractInstrument,fin-13659 runOnChange:true
--comment: Generate AsText for CyContractInstrument
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6b7d28c3-62f2-043a-8f58-e8ab71ab0990';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6b7d28c3-62f2-043a-8f58-e8ab71ab0990',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Currency Pairs Contracts'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6b7d28c3-62f2-043a-8f58-e8ab71ab0990',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Currency Pairs Contracts'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6b7d28c3-62f2-043a-8f58-e8ab71ab0990',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Currency Pairs Contracts'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6b7d28c3-62f2-043a-8f58-e8ab71ab0990',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Currency Pairs Contracts'
);

--changeset system:generated-update-data-AsText-CyInterest context:any labels:c-any,o-table,ot-schema,on-CyInterest,fin-13659 runOnChange:true
--comment: Generate AsText for CyInterest
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f5662eae-3f9a-5e3f-b77d-8533000aac51';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f5662eae-3f9a-5e3f-b77d-8533000aac51',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Interest main table'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f5662eae-3f9a-5e3f-b77d-8533000aac51',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zinssätze haupttabelle'
);

--changeset system:generated-update-data-AsText-CyInterestCarrier context:any labels:c-any,o-table,ot-schema,on-CyInterestCarrier,fin-13659 runOnChange:true
--comment: Generate AsText for CyInterestCarrier
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4536dae4-9482-9736-a007-1953d48d2b84';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4536dae4-9482-9736-a007-1953d48d2b84',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'interest carrier'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4536dae4-9482-9736-a007-1953d48d2b84',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zins Lieferant'
);

--changeset system:generated-update-data-AsText-CyInterestType context:any labels:c-any,o-table,ot-schema,on-CyInterestType,fin-13659 runOnChange:true
--comment: Generate AsText for CyInterestType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b459ec95-8d77-523b-814d-43d5f7ae62e5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b459ec95-8d77-523b-814d-43d5f7ae62e5',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'interest type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b459ec95-8d77-523b-814d-43d5f7ae62e5',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zinstyp'
);

--changeset system:generated-update-data-AsText-CyPaymentInstrument context:any labels:c-any,o-table,ot-schema,on-CyPaymentInstrument,fin-13659 runOnChange:true
--comment: Generate AsText for CyPaymentInstrument
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='410c2d0b-ea3b-3c32-9fec-9a06e8f27d0b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '410c2d0b-ea3b-3c32-9fec-9a06e8f27d0b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Payment Instrument'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '410c2d0b-ea3b-3c32-9fec-9a06e8f27d0b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zahlungsmittel'
);

--changeset system:generated-update-data-AsText-CyRateType context:any labels:c-any,o-table,ot-schema,on-CyRateType,fin-13659 runOnChange:true
--comment: Generate AsText for CyRateType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='55dbdab3-92c2-0931-90a3-78f88b625fcf';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '55dbdab3-92c2-0931-90a3-78f88b625fcf',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Currency Rate Types'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '55dbdab3-92c2-0931-90a3-78f88b625fcf',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Währungs-Kursarten'
);

--changeset system:generated-update-data-AsText-CyTradeBook context:any labels:c-any,o-table,ot-schema,on-CyTradeBook,fin-13659 runOnChange:true
--comment: Generate AsText for CyTradeBook
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c94b9895-9dab-9f3a-886c-21b9ea00c398';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c94b9895-9dab-9f3a-886c-21b9ea00c398',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'trade book'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c94b9895-9dab-9f3a-886c-21b9ea00c398',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Händlerbücher'
);

--changeset system:generated-update-data-AsText-CyTradeStatus context:any labels:c-any,o-table,ot-schema,on-CyTradeStatus,fin-13659 runOnChange:true
--comment: Generate AsText for CyTradeStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c0f9b0ff-610a-9134-b43e-7124955380da';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c0f9b0ff-610a-9134-b43e-7124955380da',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'status of the CyTrade'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c0f9b0ff-610a-9134-b43e-7124955380da',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Status von CyTrade'
);

--changeset system:generated-update-data-AsText-DbCleanupRule context:any labels:c-any,o-table,ot-schema,on-DbCleanupRule,fin-13659 runOnChange:true
--comment: Generate AsText for DbCleanupRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4e76d263-af31-1d33-ba62-535bae6292d0';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4e76d263-af31-1d33-ba62-535bae6292d0',
    1,
    'MdTableDataDef',
    NULL,
    N'Rule definition for cleaning up a table',
    N'Cleanup Rule'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4e76d263-af31-1d33-ba62-535bae6292d0',
    2,
    'MdTableDataDef',
    NULL,
    N'Regel für das löschen einer Tabelle',
    N'Aufräum Regel'
);

--changeset system:generated-update-data-AsText-EtInstrType context:any labels:c-any,o-table,ot-schema,on-EtInstrType,fin-13659 runOnChange:true
--comment: Generate AsText for EtInstrType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e53e3238-872b-1935-865f-c7e594205464';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e53e3238-872b-1935-865f-c7e594205464',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'EasyTax Instrumenten type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e53e3238-872b-1935-865f-c7e594205464',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'EasyTax Instrumententypen'
);

--changeset system:generated-update-data-AsText-EvAmountMeth context:any labels:c-any,o-table,ot-schema,on-EvAmountMeth,fin-13659 runOnChange:true
--comment: Generate AsText for EvAmountMeth
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='af2b8719-1273-1734-abcb-8384bfe2baae';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'af2b8719-1273-1734-abcb-8384bfe2baae',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Amount method'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'af2b8719-1273-1734-abcb-8384bfe2baae',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Methode für Betrag'
);

--changeset system:generated-update-data-AsText-EvAmountQuoteType context:any labels:c-any,o-table,ot-schema,on-EvAmountQuoteType,fin-13659 runOnChange:true
--comment: Generate AsText for EvAmountQuoteType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='011366da-2201-5a39-bd61-d0283bc8b5a0';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '011366da-2201-5a39-bd61-d0283bc8b5a0',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Amount quote type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '011366da-2201-5a39-bd61-d0283bc8b5a0',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Notierungsart Betrag'
);

--changeset system:generated-update-data-AsText-EvChargeAmountType context:any labels:c-any,o-table,ot-schema,on-EvChargeAmountType,fin-13659 runOnChange:true
--comment: Generate AsText for EvChargeAmountType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b2889195-ceb6-c23a-98b2-eb1fc94b219d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b2889195-ceb6-c23a-98b2-eb1fc94b219d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Charge amount type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b2889195-ceb6-c23a-98b2-eb1fc94b219d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Spesenbetragstyp'
);

--changeset system:generated-update-data-AsText-EvCheckTaxFee context:any labels:c-any,o-table,ot-schema,on-EvCheckTaxFee,fin-13659 runOnChange:true
--comment: Generate AsText for EvCheckTaxFee
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f75f6b1f-fccb-3a3d-abd1-aa92c287b287';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f75f6b1f-fccb-3a3d-abd1-aa92c287b287',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Check tax and fee data'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f75f6b1f-fccb-3a3d-abd1-aa92c287b287',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Check Steuern/Gebühren'
);

--changeset system:generated-update-data-AsText-EvEventType context:any labels:c-any,o-table,ot-schema,on-EvEventType,fin-13659 runOnChange:true
--comment: Generate AsText for EvEventType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6fd095c3-dbce-a337-b391-8e83b050b9b2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6fd095c3-dbce-a337-b391-8e83b050b9b2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Event type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6fd095c3-dbce-a337-b391-8e83b050b9b2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ereignistyp'
);

--changeset system:generated-update-data-AsText-EvFeeCat context:any labels:c-any,o-table,ot-schema,on-EvFeeCat,fin-13659 runOnChange:true
--comment: Generate AsText for EvFeeCat
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='917dc752-16d2-a633-a30e-f4566cf28a82';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '917dc752-16d2-a633-a30e-f4566cf28a82',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fee categorie'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '917dc752-16d2-a633-a30e-f4566cf28a82',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gebührenkategorie'
);

--changeset system:generated-update-data-AsText-EvFieldCond context:any labels:c-any,o-table,ot-schema,on-EvFieldCond,fin-13659 runOnChange:true
--comment: Generate AsText for EvFieldCond
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='823e391c-4bc6-fe32-b17a-73425fe484ee';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '823e391c-4bc6-fe32-b17a-73425fe484ee',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Field condition'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '823e391c-4bc6-fe32-b17a-73425fe484ee',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Feldeingabe'
);

--changeset system:generated-update-data-AsText-EvFractionRoundType context:any labels:c-any,o-table,ot-schema,on-EvFractionRoundType,fin-13659 runOnChange:true
--comment: Generate AsText for EvFractionRoundType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='18887a2f-f88e-fc30-9a4b-341368a686a3';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '18887a2f-f88e-fc30-9a4b-341368a686a3',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Roundmethod for fractions'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '18887a2f-f88e-fc30-9a4b-341368a686a3',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rundungsmeth. Fraktionen'
);

--changeset system:generated-update-data-AsText-EvHandlingStatus context:any labels:c-any,o-table,ot-schema,on-EvHandlingStatus,fin-13659 runOnChange:true
--comment: Generate AsText for EvHandlingStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3725e736-cd2d-fd38-9c67-104b31b3b07e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3725e736-cd2d-fd38-9c67-104b31b3b07e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Handling status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3725e736-cd2d-fd38-9c67-104b31b3b07e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Abwicklungstatus'
);

--changeset system:generated-update-data-AsText-EvInfoType context:any labels:c-any,o-table,ot-schema,on-EvInfoType,fin-13659 runOnChange:true
--comment: Generate AsText for EvInfoType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0240a23e-8c5a-5832-83e4-a6a8c37eb0e2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0240a23e-8c5a-5832-83e4-a6a8c37eb0e2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Information typ'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0240a23e-8c5a-5832-83e4-a6a8c37eb0e2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Informationstyp'
);

--changeset system:generated-update-data-AsText-EvNominalAmtSource context:any labels:c-any,o-table,ot-schema,on-EvNominalAmtSource,fin-13659 runOnChange:true
--comment: Generate AsText for EvNominalAmtSource
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='740e98c3-a105-5438-b767-723f3ffe9a04';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '740e98c3-a105-5438-b767-723f3ffe9a04',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Source nominal amount'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '740e98c3-a105-5438-b767-723f3ffe9a04',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Herkunft Nominalbetrag'
);

--changeset system:generated-update-data-AsText-EvPosAmountType context:any labels:c-any,o-table,ot-schema,on-EvPosAmountType,fin-13659 runOnChange:true
--comment: Generate AsText for EvPosAmountType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c0299eab-8319-9c3c-a147-54475cb92ff1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c0299eab-8319-9c3c-a147-54475cb92ff1',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'position amount type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c0299eab-8319-9c3c-a147-54475cb92ff1',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Positionsbetragstyp'
);

--changeset system:generated-update-data-AsText-EvPosApply context:any labels:c-any,o-table,ot-schema,on-EvPosApply,fin-13659 runOnChange:true
--comment: Generate AsText for EvPosApply
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f679f524-b1a7-ab33-b03f-48fe75ce1b66';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f679f524-b1a7-ab33-b03f-48fe75ce1b66',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Event appliance'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f679f524-b1a7-ab33-b03f-48fe75ce1b66',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ereignisanwendung'
);

--changeset system:generated-update-data-AsText-EvPositionType context:any labels:c-any,o-table,ot-schema,on-EvPositionType,fin-13659 runOnChange:true
--comment: Generate AsText for EvPositionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='43c523f3-353e-a43d-bccb-b32249daf5ba';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '43c523f3-353e-a43d-bccb-b32249daf5ba',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Position type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '43c523f3-353e-a43d-bccb-b32249daf5ba',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Positionstyp'
);

--changeset system:generated-update-data-AsText-EvPosProcStatus context:any labels:c-any,o-table,ot-schema,on-EvPosProcStatus,fin-13659 runOnChange:true
--comment: Generate AsText for EvPosProcStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='cf5af77f-f44c-8234-8793-0cbd040e234f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cf5af77f-f44c-8234-8793-0cbd040e234f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Position process status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cf5af77f-f44c-8234-8793-0cbd040e234f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Positionverarb.-Status'
);

--changeset system:generated-update-data-AsText-EvQuantMeth context:any labels:c-any,o-table,ot-schema,on-EvQuantMeth,fin-13659 runOnChange:true
--comment: Generate AsText for EvQuantMeth
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9ba085e5-4b3e-a73a-8bd3-ac4634e5ffb5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9ba085e5-4b3e-a73a-8bd3-ac4634e5ffb5',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Quantity method'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9ba085e5-4b3e-a73a-8bd3-ac4634e5ffb5',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Methode für Menge'
);

--changeset system:generated-update-data-AsText-EvReclaimType context:any labels:c-any,o-table,ot-schema,on-EvReclaimType,fin-13659 runOnChange:true
--comment: Generate AsText for EvReclaimType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8f7c9491-b734-3036-a113-59b866ab76fa';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8f7c9491-b734-3036-a113-59b866ab76fa',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Reclaim type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8f7c9491-b734-3036-a113-59b866ab76fa',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rückforderungstyp'
);

--changeset system:generated-update-data-AsText-EvSelectionType context:any labels:c-any,o-table,ot-schema,on-EvSelectionType,fin-13659 runOnChange:true
--comment: Generate AsText for EvSelectionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8ead8113-f081-dd33-9493-cb6cc2549680';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8ead8113-f081-dd33-9493-cb6cc2549680',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Selection type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8ead8113-f081-dd33-9493-cb6cc2549680',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Selektionstyp'
);

--changeset system:generated-update-data-AsText-EvSpecEventRule context:any labels:c-any,o-table,ot-schema,on-EvSpecEventRule,fin-13659 runOnChange:true
--comment: Generate AsText for EvSpecEventRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='22ff0e86-adaf-1f37-8e06-56d75559dc55';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '22ff0e86-adaf-1f37-8e06-56d75559dc55',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Special event rules'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '22ff0e86-adaf-1f37-8e06-56d75559dc55',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Spezielle Ereignisregeln'
);

--changeset system:generated-update-data-AsText-EvStatus context:any labels:c-any,o-table,ot-schema,on-EvStatus,fin-13659 runOnChange:true
--comment: Generate AsText for EvStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7c23315f-8f16-7839-804d-ff32e94e9845';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7c23315f-8f16-7839-804d-ff32e94e9845',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Event status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7c23315f-8f16-7839-804d-ff32e94e9845',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ereignisstatus'
);

--changeset system:generated-update-data-AsText-EvSubTitle context:any labels:c-any,o-table,ot-schema,on-EvSubTitle,fin-13659 runOnChange:true
--comment: Generate AsText for EvSubTitle
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='77c5c21a-41fd-0731-a427-62de58820667';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '77c5c21a-41fd-0731-a427-62de58820667',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Sub title for statement'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '77c5c21a-41fd-0731-a427-62de58820667',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Untertitel Abrechnung'
);

--changeset system:generated-update-data-AsText-EvTaskType context:any labels:c-any,o-table,ot-schema,on-EvTaskType,fin-13659 runOnChange:true
--comment: Generate AsText for EvTaskType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1d7e3903-5d1b-2531-b806-d8697af43dd2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1d7e3903-5d1b-2531-b806-d8697af43dd2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Task type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1d7e3903-5d1b-2531-b806-d8697af43dd2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Verarbeitungsschritt'
);

--changeset system:generated-update-data-AsText-EvTaxNodeSecondTree context:any labels:c-any,o-table,ot-schema,on-EvTaxNodeSecondTree,fin-13659 runOnChange:true
--comment: Generate AsText for EvTaxNodeSecondTree
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4dff435f-998f-0631-9631-5f019f995bbc';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4dff435f-998f-0631-9631-5f019f995bbc',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Node for pos.-indiv. tree'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4dff435f-998f-0631-9631-5f019f995bbc',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Node für pos.-indiv. Baum'
);

--changeset system:generated-update-data-AsText-EvTaxOverrideType context:any labels:c-any,o-table,ot-schema,on-EvTaxOverrideType,fin-13659 runOnChange:true
--comment: Generate AsText for EvTaxOverrideType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f191e41f-9c39-8d3f-a23c-a368faa6a740';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f191e41f-9c39-8d3f-a23c-a368faa6a740',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax override type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f191e41f-9c39-8d3f-a23c-a368faa6a740',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Übersteuerngstyp Steuern'
);

--changeset system:generated-update-data-AsText-EvTaxReportClass context:any labels:c-any,o-table,ot-schema,on-EvTaxReportClass,fin-13659 runOnChange:true
--comment: Generate AsText for EvTaxReportClass
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a45ac468-b927-7b37-9a95-85a11eef38fb';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a45ac468-b927-7b37-9a95-85a11eef38fb',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax report class'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a45ac468-b927-7b37-9a95-85a11eef38fb',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rubrik Steuerverzeichnis'
);

--changeset system:generated-update-data-AsText-EvTaxReportRelevance context:any labels:c-any,o-table,ot-schema,on-EvTaxReportRelevance,fin-13659 runOnChange:true
--comment: Generate AsText for EvTaxReportRelevance
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='93020a07-15d8-da36-88bc-4ebd9b556344';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '93020a07-15d8-da36-88bc-4ebd9b556344',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Relevanz für Steuerverz.'
);

--changeset system:generated-update-data-AsText-EvTaxType context:any labels:c-any,o-table,ot-schema,on-EvTaxType,fin-13659 runOnChange:true
--comment: Generate AsText for EvTaxType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='94f43f53-662d-7e3f-ae7a-9c7736f1ac0e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '94f43f53-662d-7e3f-ae7a-9c7736f1ac0e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '94f43f53-662d-7e3f-ae7a-9c7736f1ac0e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuertyp'
);

--changeset system:generated-update-data-AsText-EvTemplate context:any labels:c-any,o-table,ot-schema,on-EvTemplate,fin-13659 runOnChange:true
--comment: Generate AsText for EvTemplate
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='452b11ad-08ef-bc30-a61b-08638e46b3d7';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '452b11ad-08ef-bc30-a61b-08638e46b3d7',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Event Template'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '452b11ad-08ef-bc30-a61b-08638e46b3d7',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ereignisvorlage'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '452b11ad-08ef-bc30-a61b-08638e46b3d7',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Modèle d''événement'
);

--changeset system:generated-update-data-AsText-EvTemplateAddInfo context:any labels:c-any,o-table,ot-schema,on-EvTemplateAddInfo,fin-13659 runOnChange:true
--comment: Generate AsText for EvTemplateAddInfo
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c6d25463-898e-e83c-952e-af0d0d284d50';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c6d25463-898e-e83c-952e-af0d0d284d50',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Code for additional info.'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c6d25463-898e-e83c-952e-af0d0d284d50',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Code für Zusatzinfos'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c6d25463-898e-e83c-952e-af0d0d284d50',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Code pour plus d''informat'
);

--changeset system:generated-update-data-AsText-EvTemplateGroup context:any labels:c-any,o-table,ot-schema,on-EvTemplateGroup,fin-13659 runOnChange:true
--comment: Generate AsText for EvTemplateGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b2783faa-7f78-b93f-8515-11249de071ff';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b2783faa-7f78-b93f-8515-11249de071ff',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Template group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b2783faa-7f78-b93f-8515-11249de071ff',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Templategruppe'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b2783faa-7f78-b93f-8515-11249de071ff',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Groupe de modèles'
);

--changeset system:generated-update-data-AsText-EvTemplateStatus context:any labels:c-any,o-table,ot-schema,on-EvTemplateStatus,fin-13659 runOnChange:true
--comment: Generate AsText for EvTemplateStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='30241a08-c04f-1e36-8cdc-c357204d336f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '30241a08-c04f-1e36-8cdc-c357204d336f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Template status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '30241a08-c04f-1e36-8cdc-c357204d336f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Templatestatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '30241a08-c04f-1e36-8cdc-c357204d336f',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Statut du modèle'
);

--changeset system:generated-update-data-AsText-EvText context:any labels:c-any,o-table,ot-schema,on-EvText,fin-13659 runOnChange:true
--comment: Generate AsText for EvText
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8cd33504-8cb8-d933-9182-2d6e20d11a08';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8cd33504-8cb8-d933-9182-2d6e20d11a08',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Texts for corporate act.'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8cd33504-8cb8-d933-9182-2d6e20d11a08',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Texte für Corp. Actions'
);

--changeset system:generated-update-data-AsText-EvTurnoverTaxType context:any labels:c-any,o-table,ot-schema,on-EvTurnoverTaxType,fin-13659 runOnChange:true
--comment: Generate AsText for EvTurnoverTaxType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='39473978-5406-7c3a-abcc-9a84234ea517';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '39473978-5406-7c3a-abcc-9a84234ea517',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Turnover tax code'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '39473978-5406-7c3a-abcc-9a84234ea517',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Umsatzabgabe code'
);

--changeset system:generated-update-data-AsText-FaBaseRelationType context:any labels:c-any,o-table,ot-schema,on-FaBaseRelationType,fin-13659 runOnChange:true
--comment: Generate AsText for FaBaseRelationType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7fb15e5d-ec6b-9831-ae7a-e77b887d5c13';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7fb15e5d-ec6b-9831-ae7a-e77b887d5c13',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'FaBaseRelationType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7fb15e5d-ec6b-9831-ae7a-e77b887d5c13',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'FaBaseRelationType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7fb15e5d-ec6b-9831-ae7a-e77b887d5c13',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'FaBaseRelationType'
);

--changeset system:generated-update-data-AsText-FaStatus context:any labels:c-any,o-table,ot-schema,on-FaStatus,fin-13659 runOnChange:true
--comment: Generate AsText for FaStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='849a4d14-bc75-6230-8e8e-da782eb66656';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '849a4d14-bc75-6230-8e8e-da782eb66656',
    1,
    'MdTableDataDef',
    NULL,
    N'Fatca Status',
    N'Fatca Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '849a4d14-bc75-6230-8e8e-da782eb66656',
    2,
    'MdTableDataDef',
    NULL,
    N'Fatca Status',
    N'Fatca Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '849a4d14-bc75-6230-8e8e-da782eb66656',
    3,
    'MdTableDataDef',
    NULL,
    N'Fatca Status',
    N'Fatca Status'
);

--changeset system:generated-update-data-AsText-FaUsTaxScope context:any labels:c-any,o-table,ot-schema,on-FaUsTaxScope,fin-13659 runOnChange:true
--comment: Generate AsText for FaUsTaxScope
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4bd05a39-b620-fa38-9972-5c770da71117';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4bd05a39-b620-fa38-9972-5c770da71117',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fatca Scope'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4bd05a39-b620-fa38-9972-5c770da71117',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fatca Scope'
);

--changeset system:generated-update-data-AsText-MCStateExchangeDataType context:any labels:c-any,o-table,ot-schema,on-MCStateExchangeDataType,fin-13659 runOnChange:true
--comment: Generate AsText for MCStateExchangeDataType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e1bb6fb6-041a-a23f-b1ce-1075d50e2b80';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e1bb6fb6-041a-a23f-b1ce-1075d50e2b80',
    1,
    'MdTableDataDef',
    NULL,
    N'Data Type',
    N'Data Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e1bb6fb6-041a-a23f-b1ce-1075d50e2b80',
    2,
    'MdTableDataDef',
    NULL,
    N'Datentyp',
    N'Datentyp'
);

--changeset system:generated-update-data-AsText-MCStateExchangeRecordType context:any labels:c-any,o-table,ot-schema,on-MCStateExchangeRecordType,fin-13659 runOnChange:true
--comment: Generate AsText for MCStateExchangeRecordType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4391b362-7b00-403f-8bad-fc3e77fdf83b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4391b362-7b00-403f-8bad-fc3e77fdf83b',
    1,
    'MdTableDataDef',
    NULL,
    N'CSE Record Type',
    N'CSE Record Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4391b362-7b00-403f-8bad-fc3e77fdf83b',
    2,
    'MdTableDataDef',
    NULL,
    N'CSE Record Type',
    N'CSE Record Type'
);

--changeset system:generated-update-data-AsText-MCT_Test context:any labels:c-any,o-table,ot-schema,on-MCT_Test,fin-13659 runOnChange:true
--comment: Generate AsText for MCT_Test
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2f224a72-76d0-f931-aa84-ec75e0b5a497';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2f224a72-76d0-f931-aa84-ec75e0b5a497',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'test'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2f224a72-76d0-f931-aa84-ec75e0b5a497',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'test'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2f224a72-76d0-f931-aa84-ec75e0b5a497',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'test'
);

--changeset system:generated-update-data-AsText-MdFieldData context:any labels:c-any,o-table,ot-schema,on-MdFieldData,fin-13659 runOnChange:true
--comment: Generate AsText for MdFieldData
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='77ee6b1f-42bd-d131-a299-a5a30a2a506b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '77ee6b1f-42bd-d131-a299-a5a30a2a506b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Field Definition'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '77ee6b1f-42bd-d131-a299-a5a30a2a506b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Felddefinition'
);

--changeset system:generated-update-data-AsText-MdGroup context:any labels:c-any,o-table,ot-schema,on-MdGroup,fin-13659 runOnChange:true
--comment: Generate AsText for MdGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='be6d2972-897e-d03a-860a-46c290822e4d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'be6d2972-897e-d03a-860a-46c290822e4d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Table Group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'be6d2972-897e-d03a-860a-46c290822e4d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tabellengruppe'
);

--changeset system:generated-update-data-AsText-MdStatusFlag context:any labels:c-any,o-table,ot-schema,on-MdStatusFlag,fin-13659 runOnChange:true
--comment: Generate AsText for MdStatusFlag
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='27a4f25e-8372-003c-bc00-70ab2168b7de';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '27a4f25e-8372-003c-bc00-70ab2168b7de',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Status Flag Name'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '27a4f25e-8372-003c-bc00-70ab2168b7de',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bezeichnung Statusflag'
);

--changeset system:generated-update-data-AsText-MdStatusFlagValue context:any labels:c-any,o-table,ot-schema,on-MdStatusFlagValue,fin-13659 runOnChange:true
--comment: Generate AsText for MdStatusFlagValue
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='08b49c54-4f2b-8132-a43b-8b3885b1c908';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '08b49c54-4f2b-8132-a43b-8b3885b1c908',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '08b49c54-4f2b-8132-a43b-8b3885b1c908',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Status'
);

--changeset system:generated-update-data-AsText-MdTableDataDef context:any labels:c-any,o-table,ot-schema,on-MdTableDataDef,fin-13659 runOnChange:true
--comment: Generate AsText for MdTableDataDef
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ac338bc4-f87f-bb32-8871-763e9bca5043';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ac338bc4-f87f-bb32-8871-763e9bca5043',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Table Meta Data'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ac338bc4-f87f-bb32-8871-763e9bca5043',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tabellenkontrolle'
);

--changeset system:generated-update-data-AsText-MgAccountNoConversion context:any labels:c-any,o-table,ot-schema,on-MgAccountNoConversion,fin-13659 runOnChange:true
--comment: Generate AsText for MgAccountNoConversion
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7cd1dda0-72a3-c63e-972a-c04b2512b8db';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7cd1dda0-72a3-c63e-972a-c04b2512b8db',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'CompanyAccountConversion'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7cd1dda0-72a3-c63e-972a-c04b2512b8db',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'HB Kontonummern Umsetzung'
);

--changeset system:generated-update-data-AsText-MgCoverage context:any labels:c-any,o-table,ot-schema,on-MgCoverage,fin-13659 runOnChange:true
--comment: Generate AsText for MgCoverage
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a0e5e99e-2c52-233b-b7ba-5aaf6157640f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a0e5e99e-2c52-233b-b7ba-5aaf6157640f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Coverage Records for VRX'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a0e5e99e-2c52-233b-b7ba-5aaf6157640f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Deckungsrecords für VRX'
);

--changeset system:generated-update-data-AsText-MgPilotKunde context:any labels:c-any,o-table,ot-schema,on-MgPilotKunde,fin-13659 runOnChange:true
--comment: Generate AsText for MgPilotKunde
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='02eb45bf-80ae-f939-bcc9-9c8fb041571e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '02eb45bf-80ae-f939-bcc9-9c8fb041571e',
    1,
    'MdTableDataDef',
    NULL,
    N'Pilot partner',
    N'Pilot partner'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '02eb45bf-80ae-f939-bcc9-9c8fb041571e',
    2,
    'MdTableDataDef',
    NULL,
    N'Pilot-Kunde',
    N'Pilot-Kunde'
);

--changeset system:generated-update-data-AsText-MgVRXForm context:any labels:c-any,o-table,ot-schema,on-MgVRXForm,fin-13659 runOnChange:true
--comment: Generate AsText for MgVRXForm
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8f9f7d85-3dcc-fa3b-b27e-9f4e77fe5b66';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8f9f7d85-3dcc-fa3b-b27e-9f4e77fe5b66',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'VRX Forms'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8f9f7d85-3dcc-fa3b-b27e-9f4e77fe5b66',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'VRX Bilder'
);

--changeset system:generated-update-data-AsText-MsAcknowledgeStatus context:any labels:c-any,o-table,ot-schema,on-MsAcknowledgeStatus,fin-13659 runOnChange:true
--comment: Generate AsText for MsAcknowledgeStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0745a8b4-1a36-6a34-8822-bdebd5da71b2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0745a8b4-1a36-6a34-8822-bdebd5da71b2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Acknowledge Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0745a8b4-1a36-6a34-8822-bdebd5da71b2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Acknowledge Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0745a8b4-1a36-6a34-8822-bdebd5da71b2',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Acknowledge Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0745a8b4-1a36-6a34-8822-bdebd5da71b2',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Acknowledge Status'
);

--changeset system:generated-update-data-AsText-NcSanctionTermMatchingType context:any labels:c-any,o-table,ot-schema,on-NcSanctionTermMatchingType,fin-13659 runOnChange:true
--comment: Generate AsText for NcSanctionTermMatchingType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1dc8922c-9a43-3033-b350-25333e8e7636';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1dc8922c-9a43-3033-b350-25333e8e7636',
    1,
    'MdTableDataDef',
    NULL,
    N'NcSanctionTermMatchingType',
    N'NcSanctionTermMatchingTyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1dc8922c-9a43-3033-b350-25333e8e7636',
    2,
    'MdTableDataDef',
    NULL,
    N'NcSanctionTermMatchingType',
    N'NcSanctionTermMatchingTyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1dc8922c-9a43-3033-b350-25333e8e7636',
    3,
    'MdTableDataDef',
    NULL,
    N'NcSanctionTermMatchingType',
    N'NcSanctionTermMatchingTyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1dc8922c-9a43-3033-b350-25333e8e7636',
    4,
    'MdTableDataDef',
    NULL,
    N'NcSanctionTermMatchingType',
    N'NcSanctionTermMatchingTyp'
);

--changeset system:generated-update-data-AsText-NcScanType context:any labels:c-any,o-table,ot-schema,on-NcScanType,fin-13659 runOnChange:true
--comment: Generate AsText for NcScanType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d0f2a640-64ca-2734-95ba-14bad0e4c20b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd0f2a640-64ca-2734-95ba-14bad0e4c20b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'NameMatching Scan Types'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd0f2a640-64ca-2734-95ba-14bad0e4c20b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Namematching Scan-Typen'
);

--changeset system:generated-update-data-AsText-NcStatusType context:any labels:c-any,o-table,ot-schema,on-NcStatusType,fin-13659 runOnChange:true
--comment: Generate AsText for NcStatusType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='33be8b26-4bb5-f53d-b3af-96c35522b176';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '33be8b26-4bb5-f53d-b3af-96c35522b176',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'NameMatching Proc. Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '33be8b26-4bb5-f53d-b3af-96c35522b176',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Namematching Proz.-Status'
);

--changeset system:generated-update-data-AsText-OaAgrAppConsent context:any labels:c-any,o-table,ot-schema,on-OaAgrAppConsent,fin-13659 runOnChange:true
--comment: Generate AsText for OaAgrAppConsent
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2ca3eb3c-a4b0-8134-9588-9b8594738419';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2ca3eb3c-a4b0-8134-9588-9b8594738419',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'API-App Consent Agreement'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2ca3eb3c-a4b0-8134-9588-9b8594738419',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'API-App Zustimmungsver.'
);

--changeset system:generated-update-data-AsText-OaAgrAppConsentDetail context:any labels:c-any,o-table,ot-schema,on-OaAgrAppConsentDetail,fin-13659 runOnChange:true
--comment: Generate AsText for OaAgrAppConsentDetail
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='aee7c965-55ab-bd3d-8926-b1d432cef27d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'aee7c965-55ab-bd3d-8926-b1d432cef27d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'API-App Consent Agr. Det.'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'aee7c965-55ab-bd3d-8926-b1d432cef27d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'API-App Zust. Detail'
);

--changeset system:generated-update-data-AsText-OaAgrAppConsentDetailRole context:any labels:c-any,o-table,ot-schema,on-OaAgrAppConsentDetailRole,fin-13659 runOnChange:true
--comment: Generate AsText for OaAgrAppConsentDetailRole
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ae5d0ef9-4631-6d35-a34b-9638c40a2173';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ae5d0ef9-4631-6d35-a34b-9638c40a2173',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'API-App Consent Agr. Det.'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ae5d0ef9-4631-6d35-a34b-9638c40a2173',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'API-App Zust. Detail'
);

--changeset system:generated-update-data-AsText-OaApiParameterGroupType context:any labels:c-any,o-table,ot-schema,on-OaApiParameterGroupType,fin-13659 runOnChange:true
--comment: Generate AsText for OaApiParameterGroupType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4b029691-3ff7-7231-806d-f3b02c7ef0d8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4b029691-3ff7-7231-806d-f3b02c7ef0d8',
    1,
    'MdTableDataDef',
    NULL,
    N'OaApiParameterGroupType',
    N'OaApiParameterGroupType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4b029691-3ff7-7231-806d-f3b02c7ef0d8',
    2,
    'MdTableDataDef',
    NULL,
    N'OaApiParameterGroupType',
    N'OaApiParameterGroupType'
);

--changeset system:generated-update-data-AsText-OaApp context:any labels:c-any,o-table,ot-schema,on-OaApp,fin-13659 runOnChange:true
--comment: Generate AsText for OaApp
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a55ffd18-90c6-0439-8c00-d67820607d71';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a55ffd18-90c6-0439-8c00-d67820607d71',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Open Banking Apps'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a55ffd18-90c6-0439-8c00-d67820607d71',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Open Banking Apps'
);

--changeset system:generated-update-data-AsText-OaAuthUseCase context:any labels:c-any,o-table,ot-schema,on-OaAuthUseCase,fin-13659 runOnChange:true
--comment: Generate AsText for OaAuthUseCase
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='60994364-b9ee-bd3d-b228-d88b2e9d4fb9';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '60994364-b9ee-bd3d-b228-d88b2e9d4fb9',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'2FA Auth Use Case'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '60994364-b9ee-bd3d-b228-d88b2e9d4fb9',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'2FA Auth Use Case'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '60994364-b9ee-bd3d-b228-d88b2e9d4fb9',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'2FA Auth Use Case'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '60994364-b9ee-bd3d-b228-d88b2e9d4fb9',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'2FA Auth Use Case'
);

--changeset system:generated-update-data-AsText-OaBusinessParameterType context:any labels:c-any,o-table,ot-schema,on-OaBusinessParameterType,fin-13659 runOnChange:true
--comment: Generate AsText for OaBusinessParameterType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6085e54c-460d-4f3c-85e7-367606829c9d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6085e54c-460d-4f3c-85e7-367606829c9d',
    1,
    'MdTableDataDef',
    NULL,
    N'Type and format for business parameters',
    N'OaBusinessParameterType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6085e54c-460d-4f3c-85e7-367606829c9d',
    2,
    'MdTableDataDef',
    NULL,
    N'Type and format for business parameters',
    N'OaBusinessParameterType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6085e54c-460d-4f3c-85e7-367606829c9d',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'OaBusinessParameterType'
);

--changeset system:generated-update-data-AsText-OaDefaultAccountRule context:any labels:c-any,o-table,ot-schema,on-OaDefaultAccountRule,fin-13659 runOnChange:true
--comment: Generate AsText for OaDefaultAccountRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4ac64062-0e54-0d37-835f-efb80f6434e4';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4ac64062-0e54-0d37-835f-efb80f6434e4',
    1,
    'MdTableDataDef',
    NULL,
    N'OaDefaultAccountRule',
    N'OaDefaultAccountRule'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4ac64062-0e54-0d37-835f-efb80f6434e4',
    2,
    'MdTableDataDef',
    NULL,
    N'OaDefaultAccountRule',
    N'OaDefaultAccountRule'
);

--changeset system:generated-update-data-AsText-OaDefaultPortfolioRule context:any labels:c-any,o-table,ot-schema,on-OaDefaultPortfolioRule,fin-13659 runOnChange:true
--comment: Generate AsText for OaDefaultPortfolioRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='10b93efc-9c5f-2632-8d3d-c2570e73a111';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '10b93efc-9c5f-2632-8d3d-c2570e73a111',
    1,
    'MdTableDataDef',
    NULL,
    N'OaDefaultPortfolioRule',
    N'OaDefaultPortfolioRule'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '10b93efc-9c5f-2632-8d3d-c2570e73a111',
    2,
    'MdTableDataDef',
    NULL,
    N'OaDefaultPortfolioRule',
    N'OaDefaultPortfolioRule'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '10b93efc-9c5f-2632-8d3d-c2570e73a111',
    3,
    'MdTableDataDef',
    NULL,
    N'OaDefaultPortfolioRule',
    N'OaDefaultPortfolioRule'
);

--changeset system:generated-update-data-AsText-OaIdp context:any labels:c-any,o-table,ot-schema,on-OaIdp,fin-13659 runOnChange:true
--comment: Generate AsText for OaIdp
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9677ecdb-1a44-4736-9473-a59f32ee7da0';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9677ecdb-1a44-4736-9473-a59f32ee7da0',
    1,
    'MdTableDataDef',
    NULL,
    N'The Identity Provider allows users to authenticate and access Open APIs.',
    N'Identity Provider'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9677ecdb-1a44-4736-9473-a59f32ee7da0',
    2,
    'MdTableDataDef',
    NULL,
    N'Der Identity Provider authentifiziert Open API Benutzer',
    N'Identity Provider'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9677ecdb-1a44-4736-9473-a59f32ee7da0',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Identity Provider'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9677ecdb-1a44-4736-9473-a59f32ee7da0',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Identity Provider'
);

--changeset system:generated-update-data-AsText-OaResourceRole context:any labels:c-any,o-table,ot-schema,on-OaResourceRole,fin-13659 runOnChange:true
--comment: Generate AsText for OaResourceRole
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='544b4550-3486-3733-9390-a79fb9950b34';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '544b4550-3486-3733-9390-a79fb9950b34',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Resource Roles'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '544b4550-3486-3733-9390-a79fb9950b34',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ressourcen-Rollen'
);

--changeset system:generated-update-data-AsText-OaResourceType context:any labels:c-any,o-table,ot-schema,on-OaResourceType,fin-13659 runOnChange:true
--comment: Generate AsText for OaResourceType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2e858fd7-4a05-ba36-8b86-48848251dc5a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2e858fd7-4a05-ba36-8b86-48848251dc5a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Resource Types'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2e858fd7-4a05-ba36-8b86-48848251dc5a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ressourcenarten'
);

--changeset system:generated-update-data-AsText-PmPerfDataSource context:any labels:c-any,o-table,ot-schema,on-PmPerfDataSource,fin-13659 runOnChange:true
--comment: Generate AsText for PmPerfDataSource
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6912a244-1fba-2834-a606-99bcb4cb697c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6912a244-1fba-2834-a606-99bcb4cb697c',
    1,
    'MdTableDataDef',
    NULL,
    N'Performance data source',
    N'Performance'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6912a244-1fba-2834-a606-99bcb4cb697c',
    2,
    'MdTableDataDef',
    NULL,
    N'Datenquelle Performance',
    N'Performance'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6912a244-1fba-2834-a606-99bcb4cb697c',
    3,
    'MdTableDataDef',
    NULL,
    N'Source de données sur les performances',
    N'Performance'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6912a244-1fba-2834-a606-99bcb4cb697c',
    4,
    'MdTableDataDef',
    NULL,
    N'Fonte di dati sulle prestazioni',
    N'Performance'
);

--changeset system:generated-update-data-AsText-PrAdviceControl context:any labels:c-any,o-table,ot-schema,on-PrAdviceControl,fin-13659 runOnChange:true
--comment: Generate AsText for PrAdviceControl
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e2a8e7cd-1566-6b3b-9d41-4ef11fc8308c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e2a8e7cd-1566-6b3b-9d41-4ef11fc8308c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'advice control definition'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e2a8e7cd-1566-6b3b-9d41-4ef11fc8308c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Anzeigesteuerung'
);

--changeset system:generated-update-data-AsText-PrAssetReportRule context:any labels:c-any,o-table,ot-schema,on-PrAssetReportRule,fin-13659 runOnChange:true
--comment: Generate AsText for PrAssetReportRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='966eb0dd-8a64-a433-b595-7ed769d00712';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '966eb0dd-8a64-a433-b595-7ed769d00712',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'AssetReportRules'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '966eb0dd-8a64-a433-b595-7ed769d00712',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Vermögensausweisregeln'
);

--changeset system:generated-update-data-AsText-PrAssetTypeException context:any labels:c-any,o-table,ot-schema,on-PrAssetTypeException,fin-13659 runOnChange:true
--comment: Generate AsText for PrAssetTypeException
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f592e35a-d552-8a3a-856a-bc52335f55b5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f592e35a-d552-8a3a-856a-bc52335f55b5',
    1,
    'MdTableDataDef',
    NULL,
    N'PrAssetTypeException',
    N'PrAssetTypeException'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f592e35a-d552-8a3a-856a-bc52335f55b5',
    2,
    'MdTableDataDef',
    NULL,
    N'PrAssetTypeException',
    N'PrAssetTypeException'
);

--changeset system:generated-update-data-AsText-PrBondRateIsin context:any labels:c-any,o-table,ot-schema,on-PrBondRateIsin,fin-13659 runOnChange:true
--comment: Generate AsText for PrBondRateIsin
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='88f627d1-37a5-5537-a7c5-587f7e2ca22a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '88f627d1-37a5-5537-a7c5-587f7e2ca22a',
    1,
    'MdTableDataDef',
    NULL,
    N'Bond Rate ISIN',
    N'Bond Rate ISIN'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '88f627d1-37a5-5537-a7c5-587f7e2ca22a',
    2,
    'MdTableDataDef',
    NULL,
    N'Bond Rate ISIN',
    N'Bond Rate ISIN'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '88f627d1-37a5-5537-a7c5-587f7e2ca22a',
    3,
    'MdTableDataDef',
    NULL,
    N'Bond Rate ISIN',
    N'Bond Rate ISIN'
);

--changeset system:generated-update-data-AsText-PrCollateralRateException context:any labels:c-any,o-table,ot-schema,on-PrCollateralRateException,fin-13659 runOnChange:true
--comment: Generate AsText for PrCollateralRateException
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9caa8a71-fa0d-8138-952c-ac24acac051d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9caa8a71-fa0d-8138-952c-ac24acac051d',
    1,
    'MdTableDataDef',
    NULL,
    N'PrCollateralRateException',
    N'PrCollateralRateException'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9caa8a71-fa0d-8138-952c-ac24acac051d',
    2,
    'MdTableDataDef',
    NULL,
    N'PrCollateralRateException',
    N'PrCollateralRateException'
);

--changeset system:generated-update-data-AsText-PrCommissionType context:any labels:c-any,o-table,ot-schema,on-PrCommissionType,fin-13659 runOnChange:true
--comment: Generate AsText for PrCommissionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c28d786b-3514-0b3e-868b-841c24fe71ad';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c28d786b-3514-0b3e-868b-841c24fe71ad',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Commission Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c28d786b-3514-0b3e-868b-841c24fe71ad',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kommissionsart'
);

--changeset system:generated-update-data-AsText-PrCRMDomain context:any labels:c-any,o-table,ot-schema,on-PrCRMDomain,fin-13659 runOnChange:true
--comment: Generate AsText for PrCRMDomain
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='444802ff-fca0-e036-87f5-ebae69b198ce';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '444802ff-fca0-e036-87f5-ebae69b198ce',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'CRM Product Groups'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '444802ff-fca0-e036-87f5-ebae69b198ce',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Produktegruppen für CRM'
);

--changeset system:generated-update-data-AsText-PrDurationType context:any labels:c-any,o-table,ot-schema,on-PrDurationType,fin-13659 runOnChange:true
--comment: Generate AsText for PrDurationType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4e9d0bcb-4c96-1235-805f-3e5e667131fe';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4e9d0bcb-4c96-1235-805f-3e5e667131fe',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Duration Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4e9d0bcb-4c96-1235-805f-3e5e667131fe',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Laufzeit Typ'
);

--changeset system:generated-update-data-AsText-PrEquityCapitalRule context:any labels:c-any,o-table,ot-schema,on-PrEquityCapitalRule,fin-13659 runOnChange:true
--comment: Generate AsText for PrEquityCapitalRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='fc4606f5-6f78-943f-b4d3-c750c2708217';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fc4606f5-6f78-943f-b4d3-c750c2708217',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'EquityCapital Rule'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fc4606f5-6f78-943f-b4d3-c750c2708217',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Regel EM-Hinterlegung'
);

--changeset system:generated-update-data-AsText-PrExpenseRuleset context:any labels:c-any,o-table,ot-schema,on-PrExpenseRuleset,fin-13659 runOnChange:true
--comment: Generate AsText for PrExpenseRuleset
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7d319392-0ece-f136-a6cc-ff6f60e12ca8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7d319392-0ece-f136-a6cc-ff6f60e12ca8',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Expense ruleset'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7d319392-0ece-f136-a6cc-ff6f60e12ca8',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Spesenkategorie'
);

--changeset system:generated-update-data-AsText-PrExpenseType context:any labels:c-any,o-table,ot-schema,on-PrExpenseType,fin-13659 runOnChange:true
--comment: Generate AsText for PrExpenseType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7dda127d-7a1c-f83c-8ec5-8160e8fb93d7';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7dda127d-7a1c-f83c-8ec5-8160e8fb93d7',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Expenses type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7dda127d-7a1c-f83c-8ec5-8160e8fb93d7',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Spesenart'
);

--changeset system:generated-update-data-AsText-PrivorDocument context:any labels:c-any,o-table,ot-schema,on-PrivorDocument,fin-13659 runOnChange:true
--comment: Generate AsText for PrivorDocument
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c40345fb-2277-b530-add1-0a18b405723b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c40345fb-2277-b530-add1-0a18b405723b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Privor Pension Document'
);

--changeset system:generated-update-data-AsText-PrLocGroup context:any labels:c-any,o-table,ot-schema,on-PrLocGroup,fin-13659 runOnChange:true
--comment: Generate AsText for PrLocGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3c0f906b-08af-963d-9036-ea150381fb16';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3c0f906b-08af-963d-9036-ea150381fb16',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Physical location group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3c0f906b-08af-963d-9036-ea150381fb16',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Depotstellengruppe'
);

--changeset system:generated-update-data-AsText-PrOperationType context:any labels:c-any,o-table,ot-schema,on-PrOperationType,fin-13659 runOnChange:true
--comment: Generate AsText for PrOperationType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b36a5ca9-5086-be30-bee0-8acbab589c3d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b36a5ca9-5086-be30-bee0-8acbab589c3d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'OperationType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b36a5ca9-5086-be30-bee0-8acbab589c3d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Art des Produktes'
);

--changeset system:generated-update-data-AsText-PrPrivate context:any labels:c-any,o-table,ot-schema,on-PrPrivate,fin-13659 runOnChange:true
--comment: Generate AsText for PrPrivate
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6bc235ec-2f7e-d13c-a9bd-7bb0ae5fc97f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6bc235ec-2f7e-d13c-a9bd-7bb0ae5fc97f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Private product'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6bc235ec-2f7e-d13c-a9bd-7bb0ae5fc97f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Eigenes Produkt'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6bc235ec-2f7e-d13c-a9bd-7bb0ae5fc97f',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Produit private'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6bc235ec-2f7e-d13c-a9bd-7bb0ae5fc97f',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Produtto privato'
);

--changeset system:generated-update-data-AsText-PrPrivateBonusRules context:any labels:c-any,o-table,ot-schema,on-PrPrivateBonusRules,fin-13659 runOnChange:true
--comment: Generate AsText for PrPrivateBonusRules
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='38ebcef9-b207-fe3f-8d7f-d550402a375f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '38ebcef9-b207-fe3f-8d7f-d550402a375f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bonus Rules For Product'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '38ebcef9-b207-fe3f-8d7f-d550402a375f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bonus Rules For Product'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '38ebcef9-b207-fe3f-8d7f-d550402a375f',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bonus Rules For Product'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '38ebcef9-b207-fe3f-8d7f-d550402a375f',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bonus Rules For Product'
);

--changeset system:generated-update-data-AsText-PrPrivateCharacteristic context:any labels:c-any,o-table,ot-schema,on-PrPrivateCharacteristic,fin-13659 runOnChange:true
--comment: Generate AsText for PrPrivateCharacteristic
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ac86415c-1d48-d339-9aa7-0f05d0eae6a7';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ac86415c-1d48-d339-9aa7-0f05d0eae6a7',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Product Characterisic'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ac86415c-1d48-d339-9aa7-0f05d0eae6a7',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Produktausprägung'
);

--changeset system:generated-update-data-AsText-PrPrivateCompCharacteristic context:any labels:c-any,o-table,ot-schema,on-PrPrivateCompCharacteristic,fin-13659 runOnChange:true
--comment: Generate AsText for PrPrivateCompCharacteristic
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f8359f8f-650f-e039-a1dc-da48bcecd557';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f8359f8f-650f-e039-a1dc-da48bcecd557',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Component Characterist'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f8359f8f-650f-e039-a1dc-da48bcecd557',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Komponentenausprägung'
);

--changeset system:generated-update-data-AsText-PrPrivateCompType context:any labels:c-any,o-table,ot-schema,on-PrPrivateCompType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPrivateCompType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e03d9daf-fab2-e63c-913b-0775500812b7';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e03d9daf-fab2-e63c-913b-0775500812b7',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Private Component Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e03d9daf-fab2-e63c-913b-0775500812b7',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Art der Prod..-Komponente'
);

--changeset system:generated-update-data-AsText-PrPrivateIPPermission context:any labels:c-any,o-table,ot-schema,on-PrPrivateIPPermission,fin-13659 runOnChange:true
--comment: Generate AsText for PrPrivateIPPermission
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d22628b2-8bb4-c133-96d4-c2ddf413b202';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd22628b2-8bb4-c133-96d4-c2ddf413b202',
    1,
    'MdTableDataDef',
    NULL,
    N'PrPrivateIPPermissions',
    N'PrPrivateIPPermissions'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd22628b2-8bb4-c133-96d4-c2ddf413b202',
    2,
    'MdTableDataDef',
    NULL,
    N'PrPrivateIPPermissions',
    N'PrPrivateIPPermissions'
);

--changeset system:generated-update-data-AsText-PrPrivatePayRule context:any labels:c-any,o-table,ot-schema,on-PrPrivatePayRule,fin-13659 runOnChange:true
--comment: Generate AsText for PrPrivatePayRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e8850324-926e-8433-afd8-9078b9594d08';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e8850324-926e-8433-afd8-9078b9594d08',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Private Pay Rule'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e8850324-926e-8433-afd8-9078b9594d08',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zahlungsregel'
);

--changeset system:generated-update-data-AsText-PrProtectionType context:any labels:c-any,o-table,ot-schema,on-PrProtectionType,fin-13659 runOnChange:true
--comment: Generate AsText for PrProtectionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f3d539d6-0e40-e33c-9880-1f5b8c9df68f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f3d539d6-0e40-e33c-9880-1f5b8c9df68f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Protection Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f3d539d6-0e40-e33c-9880-1f5b8c9df68f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Sicherungs-Typ'
);

--changeset system:generated-update-data-AsText-PrPublicAddDataDLTBlockchain context:any labels:c-any,o-table,ot-schema,on-PrPublicAddDataDLTBlockchain,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicAddDataDLTBlockchain
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='612bdb34-10b9-8835-9ede-4654b7c98dd0';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '612bdb34-10b9-8835-9ede-4654b7c98dd0',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Blockchain'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '612bdb34-10b9-8835-9ede-4654b7c98dd0',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Blockchain'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '612bdb34-10b9-8835-9ede-4654b7c98dd0',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Blockchain'
);

--changeset system:generated-update-data-AsText-PrPublicAddDataDLTCustodyType context:any labels:c-any,o-table,ot-schema,on-PrPublicAddDataDLTCustodyType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicAddDataDLTCustodyType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a002442e-adea-a538-9c73-aa9e5ee11268';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a002442e-adea-a538-9c73-aa9e5ee11268',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Blockchain'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a002442e-adea-a538-9c73-aa9e5ee11268',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Blockchain'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a002442e-adea-a538-9c73-aa9e5ee11268',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Blockchain'
);

--changeset system:generated-update-data-AsText-PrPublicAffidavit context:any labels:c-any,o-table,ot-schema,on-PrPublicAffidavit,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicAffidavit
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8085b178-4c94-5436-ae2f-0fa098aa0d18';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8085b178-4c94-5436-ae2f-0fa098aa0d18',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Payment validity range'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8085b178-4c94-5436-ae2f-0fa098aa0d18',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zahlunggültigkeitsbereich'
);

--changeset system:generated-update-data-AsText-PrPublicAllotmentNewInstr context:any labels:c-any,o-table,ot-schema,on-PrPublicAllotmentNewInstr,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicAllotmentNewInstr
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='702e630c-bd3d-da34-94c3-2c4a3d98d9a8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '702e630c-bd3d-da34-94c3-2c4a3d98d9a8',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Allotment new instruments'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '702e630c-bd3d-da34-94c3-2c4a3d98d9a8',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zuteilungsart neue Titel'
);

--changeset system:generated-update-data-AsText-PrPublicAllotmentType context:any labels:c-any,o-table,ot-schema,on-PrPublicAllotmentType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicAllotmentType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f50d8cef-cd00-7d35-a6ab-72bea1f30696';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f50d8cef-cd00-7d35-a6ab-72bea1f30696',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Allotment type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f50d8cef-cd00-7d35-a6ab-72bea1f30696',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Platzierungsart'
);

--changeset system:generated-update-data-AsText-PrPublicAmortizationType context:any labels:c-any,o-table,ot-schema,on-PrPublicAmortizationType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicAmortizationType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5ec4f9ef-aa10-2c32-80f4-2713dd7f7cd5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5ec4f9ef-aa10-2c32-80f4-2713dd7f7cd5',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Amortization type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5ec4f9ef-aa10-2c32-80f4-2713dd7f7cd5',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Amortisationstyp'
);

--changeset system:generated-update-data-AsText-PrPublicApplicTaxRep context:any labels:c-any,o-table,ot-schema,on-PrPublicApplicTaxRep,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicApplicTaxRep
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d609443d-9580-3931-b5fb-ccfdfceb5320';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd609443d-9580-3931-b5fb-ccfdfceb5320',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Applicability of tax/rep'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd609443d-9580-3931-b5fb-ccfdfceb5320',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Anwendbarkeit Steuer'
);

--changeset system:generated-update-data-AsText-PrPublicAssetPropCalcMeth context:any labels:c-any,o-table,ot-schema,on-PrPublicAssetPropCalcMeth,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicAssetPropCalcMeth
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8f49c04a-ec61-ab37-b428-2704370f0e0c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8f49c04a-ec61-ab37-b428-2704370f0e0c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Proportion calc. method'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8f49c04a-ec61-ab37-b428-2704370f0e0c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Anteil Berechnungsmethode'
);

--changeset system:generated-update-data-AsText-PrPublicAuthApproval context:any labels:c-any,o-table,ot-schema,on-PrPublicAuthApproval,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicAuthApproval
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='807a3f87-03f5-d634-bc2a-60d1b739869e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '807a3f87-03f5-d634-bc2a-60d1b739869e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Public authorit. approval'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '807a3f87-03f5-d634-bc2a-60d1b739869e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zustimmung Behörden'
);

--changeset system:generated-update-data-AsText-PrPublicCashFlowFunc context:any labels:c-any,o-table,ot-schema,on-PrPublicCashFlowFunc,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCashFlowFunc
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='02755284-119e-ea35-9e01-e5300dc5cdfe';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '02755284-119e-ea35-9e01-e5300dc5cdfe',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Cash flow function'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '02755284-119e-ea35-9e01-e5300dc5cdfe',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Cash Flow Funktion'
);

--changeset system:generated-update-data-AsText-PrPublicCashFlowStatus context:any labels:c-any,o-table,ot-schema,on-PrPublicCashFlowStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCashFlowStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c15fb33e-c0cb-473d-b9c7-9d9af658f6f8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c15fb33e-c0cb-473d-b9c7-9d9af658f6f8',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Cash flow status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c15fb33e-c0cb-473d-b9c7-9d9af658f6f8',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Cash Flow Status'
);

--changeset system:generated-update-data-AsText-PrPublicCertificateType context:any labels:c-any,o-table,ot-schema,on-PrPublicCertificateType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCertificateType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7e5e3a69-4eef-ea3f-a9af-198d8015585b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7e5e3a69-4eef-ea3f-a9af-198d8015585b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Certificate type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7e5e3a69-4eef-ea3f-a9af-198d8015585b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zertifikatstyp'
);

--changeset system:generated-update-data-AsText-PrPublicCfAmountType context:any labels:c-any,o-table,ot-schema,on-PrPublicCfAmountType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCfAmountType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d6c6213b-400f-4834-a2fa-5f8f06471737';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd6c6213b-400f-4834-a2fa-5f8f06471737',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Amount type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd6c6213b-400f-4834-a2fa-5f8f06471737',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Betragstyp'
);

--changeset system:generated-update-data-AsText-PrPublicCfSettlFixType context:any labels:c-any,o-table,ot-schema,on-PrPublicCfSettlFixType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCfSettlFixType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='82044507-1851-4635-a43a-e3d32366a525';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '82044507-1851-4635-a43a-e3d32366a525',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fixing condition type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '82044507-1851-4635-a43a-e3d32366a525',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fixierungsbedingungstyp'
);

--changeset system:generated-update-data-AsText-PrPublicCfUnderlType context:any labels:c-any,o-table,ot-schema,on-PrPublicCfUnderlType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCfUnderlType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b96894be-208d-0d34-89f1-3661c7255e71';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b96894be-208d-0d34-89f1-3661c7255e71',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Underlying type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b96894be-208d-0d34-89f1-3661c7255e71',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Underlying-Typ'
);

--changeset system:generated-update-data-AsText-PrPublicClearingSystem context:any labels:c-any,o-table,ot-schema,on-PrPublicClearingSystem,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicClearingSystem
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6f96749d-80e0-8238-9c8f-4c707486d1e0';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6f96749d-80e0-8238-9c8f-4c707486d1e0',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Clearing system'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6f96749d-80e0-8238-9c8f-4c707486d1e0',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Clearing System'
);

--changeset system:generated-update-data-AsText-PrPublicCombinedTransType context:any labels:c-any,o-table,ot-schema,on-PrPublicCombinedTransType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCombinedTransType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c637a00d-c9fc-4a3d-979c-f63cad6efbc3';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c637a00d-c9fc-4a3d-979c-f63cad6efbc3',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GA Kombinationsgeschäfte'
);

--changeset system:generated-update-data-AsText-PrPublicCommodityCat context:any labels:c-any,o-table,ot-schema,on-PrPublicCommodityCat,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCommodityCat
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bb71fea4-5835-b33e-8bc3-7e9ed1528579';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bb71fea4-5835-b33e-8bc3-7e9ed1528579',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Commodity-Bereich'
);

--changeset system:generated-update-data-AsText-PrPublicCommodityForm context:any labels:c-any,o-table,ot-schema,on-PrPublicCommodityForm,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCommodityForm
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='45dd82c1-8d4a-663d-9a4f-daf1e4e1b574';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '45dd82c1-8d4a-663d-9a4f-daf1e4e1b574',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Form Commodity'
);

--changeset system:generated-update-data-AsText-PrPublicCommoditySubstance context:any labels:c-any,o-table,ot-schema,on-PrPublicCommoditySubstance,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCommoditySubstance
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4c6cd3a6-3958-f437-9e1e-9b7419ed6eb1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4c6cd3a6-3958-f437-9e1e-9b7419ed6eb1',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bezeichnung Commodity'
);

--changeset system:generated-update-data-AsText-PrPublicCommodityType context:any labels:c-any,o-table,ot-schema,on-PrPublicCommodityType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCommodityType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4c5c8cab-4c43-af3b-8373-9dceee8f0a99';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4c5c8cab-4c43-af3b-8373-9dceee8f0a99',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Commodity-Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4c5c8cab-4c43-af3b-8373-9dceee8f0a99',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Commodity-Typ'
);

--changeset system:generated-update-data-AsText-PrPublicCompareOperator context:any labels:c-any,o-table,ot-schema,on-PrPublicCompareOperator,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCompareOperator
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6f823984-c16f-1138-bd4a-c609ccac875c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6f823984-c16f-1138-bd4a-c609ccac875c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Compare operator'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6f823984-c16f-1138-bd4a-c609ccac875c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Vergleichsoperator'
);

--changeset system:generated-update-data-AsText-PrPublicCompositionType context:any labels:c-any,o-table,ot-schema,on-PrPublicCompositionType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCompositionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7927dc8f-1ef9-7438-b3f8-05de55113d57';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7927dc8f-1ef9-7438-b3f8-05de55113d57',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Composition type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7927dc8f-1ef9-7438-b3f8-05de55113d57',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kompositionsart'
);

--changeset system:generated-update-data-AsText-PrPublicCompoundType context:any labels:c-any,o-table,ot-schema,on-PrPublicCompoundType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCompoundType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0e76dc1a-fb15-093b-a974-4d8a63779f68';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0e76dc1a-fb15-093b-a974-4d8a63779f68',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Compound type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0e76dc1a-fb15-093b-a974-4d8a63779f68',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zusammensetzungstyp'
);

--changeset system:generated-update-data-AsText-PrPublicCorpActStatus context:any labels:c-any,o-table,ot-schema,on-PrPublicCorpActStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCorpActStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bb135c7b-7264-9839-b577-30bad07fb851';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bb135c7b-7264-9839-b577-30bad07fb851',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Corp. action status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bb135c7b-7264-9839-b577-30bad07fb851',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Status Gesellschaftserei.'
);

--changeset system:generated-update-data-AsText-PrPublicCorpActSubInputGrade context:any labels:c-any,o-table,ot-schema,on-PrPublicCorpActSubInputGrade,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCorpActSubInputGrade
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a27b3a9b-9e09-a634-b9a7-7baebc70477d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a27b3a9b-9e09-a634-b9a7-7baebc70477d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Input grade corp. act.'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a27b3a9b-9e09-a634-b9a7-7baebc70477d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Teilereig. Erfassungsstat'
);

--changeset system:generated-update-data-AsText-PrPublicCorpActSubStatus context:any labels:c-any,o-table,ot-schema,on-PrPublicCorpActSubStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCorpActSubStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2811e3c3-1c3b-d834-9461-1f0fc5982c95';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2811e3c3-1c3b-d834-9461-1f0fc5982c95',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Status Teilereignis'
);

--changeset system:generated-update-data-AsText-PrPublicCorpActSubType context:any labels:c-any,o-table,ot-schema,on-PrPublicCorpActSubType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCorpActSubType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8f4cfe4c-5137-e332-b472-06247675d6bf';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8f4cfe4c-5137-e332-b472-06247675d6bf',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Teilereignistyp'
);

--changeset system:generated-update-data-AsText-PrPublicCorpActType context:any labels:c-any,o-table,ot-schema,on-PrPublicCorpActType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCorpActType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='44f1f9ee-65e6-de3b-bad7-2615c14ff473';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '44f1f9ee-65e6-de3b-bad7-2615c14ff473',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gesellschaftsereignistyp'
);

--changeset system:generated-update-data-AsText-PrPublicCountryTaxDefinition context:any labels:c-any,o-table,ot-schema,on-PrPublicCountryTaxDefinition,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCountryTaxDefinition
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='041c7f4b-bf04-f933-b0d5-8bcb2a690219';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '041c7f4b-bf04-f933-b0d5-8bcb2a690219',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Country spec. tax defin.'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '041c7f4b-bf04-f933-b0d5-8bcb2a690219',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Landesspez. Steuerdef.'
);

--changeset system:generated-update-data-AsText-PrPublicCustodyType context:any labels:c-any,o-table,ot-schema,on-PrPublicCustodyType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicCustodyType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7739c14c-d543-5f3d-8322-a33eb5f3cd7b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7739c14c-d543-5f3d-8322-a33eb5f3cd7b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Custody type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7739c14c-d543-5f3d-8322-a33eb5f3cd7b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Verwahrungsart'
);

--changeset system:generated-update-data-AsText-PrPublicDataCoverageType context:any labels:c-any,o-table,ot-schema,on-PrPublicDataCoverageType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicDataCoverageType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='702ab2f4-38e6-0130-aa08-76d2af764473';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '702ab2f4-38e6-0130-aa08-76d2af764473',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tradin place data covera.'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '702ab2f4-38e6-0130-aa08-76d2af764473',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Börse Datenumfangstyp'
);

--changeset system:generated-update-data-AsText-PrPublicDayCountConv context:any labels:c-any,o-table,ot-schema,on-PrPublicDayCountConv,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicDayCountConv
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='eaa3d7ab-f58f-5431-a2d2-d568b0a2e5fa';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'eaa3d7ab-f58f-5431-a2d2-d568b0a2e5fa',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Day count convention'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'eaa3d7ab-f58f-5431-a2d2-d568b0a2e5fa',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zinsusanz'
);

--changeset system:generated-update-data-AsText-PrPublicDebtorType context:any labels:c-any,o-table,ot-schema,on-PrPublicDebtorType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicDebtorType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f5012ef8-bb0d-0c3f-abfb-6eb7d323d14b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f5012ef8-bb0d-0c3f-abfb-6eb7d323d14b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Debtor type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f5012ef8-bb0d-0c3f-abfb-6eb7d323d14b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Schuldnerkategorie'
);

--changeset system:generated-update-data-AsText-PrPublicDeleteReason context:any labels:c-any,o-table,ot-schema,on-PrPublicDeleteReason,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicDeleteReason
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='05075eac-a20a-7c32-90df-cc5bc0bdb1b0';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '05075eac-a20a-7c32-90df-cc5bc0bdb1b0',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Delete reason'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '05075eac-a20a-7c32-90df-cc5bc0bdb1b0',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Löschgrund'
);

--changeset system:generated-update-data-AsText-PrPublicDeliveryCode context:any labels:c-any,o-table,ot-schema,on-PrPublicDeliveryCode,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicDeliveryCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2a2eb7ad-d990-263c-95fa-b1c85ad36c24';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2a2eb7ad-d990-263c-95fa-b1c85ad36c24',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Delivery code'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2a2eb7ad-d990-263c-95fa-b1c85ad36c24',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Lieferungscode'
);

--changeset system:generated-update-data-AsText-PrPublicDependencyType context:any labels:c-any,o-table,ot-schema,on-PrPublicDependencyType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicDependencyType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='444c114a-0e35-8f33-b0e3-1abb39e83ded';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '444c114a-0e35-8f33-b0e3-1abb39e83ded',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Dependency type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '444c114a-0e35-8f33-b0e3-1abb39e83ded',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Abhängigkeitsart'
);

--changeset system:generated-update-data-AsText-PrPublicDilutionProtection context:any labels:c-any,o-table,ot-schema,on-PrPublicDilutionProtection,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicDilutionProtection
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='77969139-b319-fd3a-aa85-c52af8bc217c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '77969139-b319-fd3a-aa85-c52af8bc217c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Dilution protection'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '77969139-b319-fd3a-aa85-c52af8bc217c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Verwässerungsschutz'
);

--changeset system:generated-update-data-AsText-PrPublicDiscountType context:any labels:c-any,o-table,ot-schema,on-PrPublicDiscountType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicDiscountType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='21911a2d-d326-4a38-a84c-b94ff1cc0f9c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '21911a2d-d326-4a38-a84c-b94ff1cc0f9c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Discount type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '21911a2d-d326-4a38-a84c-b94ff1cc0f9c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Diskonttyp'
);

--changeset system:generated-update-data-AsText-PrPublicDistribEarningType context:any labels:c-any,o-table,ot-schema,on-PrPublicDistribEarningType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicDistribEarningType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e9c9e195-319e-e635-acd3-302babb0fb70';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e9c9e195-319e-e635-acd3-302babb0fb70',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Distrib. of earnings type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e9c9e195-319e-e635-acd3-302babb0fb70',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ertragsausschüttungsart'
);

--changeset system:generated-update-data-AsText-PrPublicDistribFrequency context:any labels:c-any,o-table,ot-schema,on-PrPublicDistribFrequency,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicDistribFrequency
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='23db764c-6e81-313c-bc38-da46fa1fefbf';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '23db764c-6e81-313c-bc38-da46fa1fefbf',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Distribution frequency'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '23db764c-6e81-313c-bc38-da46fa1fefbf',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ausschüttungsfrequenz'
);

--changeset system:generated-update-data-AsText-PrPublicDividendType context:any labels:c-any,o-table,ot-schema,on-PrPublicDividendType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicDividendType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='17132169-c990-3b3e-823d-245050e703bd';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '17132169-c990-3b3e-823d-245050e703bd',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Dividend type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '17132169-c990-3b3e-823d-245050e703bd',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Dividendenart'
);

--changeset system:generated-update-data-AsText-PrPublicDivSupplyInfo context:any labels:c-any,o-table,ot-schema,on-PrPublicDivSupplyInfo,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicDivSupplyInfo
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3958d879-ebcd-533a-a093-af6688262b98';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3958d879-ebcd-533a-a093-af6688262b98',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Dividendenart-Zusatzinfo.'
);

--changeset system:generated-update-data-AsText-PrPublicDocTransactionType context:any labels:c-any,o-table,ot-schema,on-PrPublicDocTransactionType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicDocTransactionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5662e92f-0096-8a3f-b423-054442c7c044';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5662e92f-0096-8a3f-b423-054442c7c044',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Doc transaction type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5662e92f-0096-8a3f-b423-054442c7c044',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Doc Transaktionsart'
);

--changeset system:generated-update-data-AsText-PrPublicEntitledParty context:any labels:c-any,o-table,ot-schema,on-PrPublicEntitledParty,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicEntitledParty
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c971bb48-30e4-9737-b368-6db0ab2df00c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c971bb48-30e4-9737-b368-6db0ab2df00c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Entitled party'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c971bb48-30e4-9737-b368-6db0ab2df00c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Wahlpartei'
);

--changeset system:generated-update-data-AsText-PrPublicEquityType context:any labels:c-any,o-table,ot-schema,on-PrPublicEquityType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicEquityType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ae6bff0b-4085-9933-ab99-0e49d74e87a3';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ae6bff0b-4085-9933-ab99-0e49d74e87a3',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Equity tpye'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ae6bff0b-4085-9933-ab99-0e49d74e87a3',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Aktienart'
);

--changeset system:generated-update-data-AsText-PrPublicEuInterestTaxCat context:any labels:c-any,o-table,ot-schema,on-PrPublicEuInterestTaxCat,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicEuInterestTaxCat
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='72f3b905-d916-903e-9041-58182210a82e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '72f3b905-d916-903e-9041-58182210a82e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'EU interest tax categorie'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '72f3b905-d916-903e-9041-58182210a82e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'EU Zinssteuerkategorie'
);

--changeset system:generated-update-data-AsText-PrPublicEuInterestTaxScope context:any labels:c-any,o-table,ot-schema,on-PrPublicEuInterestTaxScope,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicEuInterestTaxScope
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7af8d3ea-ef43-3339-9842-5fe808b850e9';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7af8d3ea-ef43-3339-9842-5fe808b850e9',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'EU Interest tax scope'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7af8d3ea-ef43-3339-9842-5fe808b850e9',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'EU Zinssteuer Scope'
);

--changeset system:generated-update-data-AsText-PrPublicEuTaxInstrClass context:any labels:c-any,o-table,ot-schema,on-PrPublicEuTaxInstrClass,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicEuTaxInstrClass
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b906521e-9d93-bc3a-8f0f-55a0cca6ec91';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b906521e-9d93-bc3a-8f0f-55a0cca6ec91',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'class from tax view'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b906521e-9d93-bc3a-8f0f-55a0cca6ec91',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Klasse aus Steuersicht'
);

--changeset system:generated-update-data-AsText-PrPublicEuTaxProcStatus context:any labels:c-any,o-table,ot-schema,on-PrPublicEuTaxProcStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicEuTaxProcStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a135183b-45d6-bb37-a974-d653144f982a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a135183b-45d6-bb37-a974-d653144f982a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'EU interest tax status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a135183b-45d6-bb37-a974-d653144f982a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'EU Zinssteuer Status'
);

--changeset system:generated-update-data-AsText-PrPublicEventRoleType context:any labels:c-any,o-table,ot-schema,on-PrPublicEventRoleType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicEventRoleType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d89b0f44-958b-713a-9cab-da4badb392e4';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd89b0f44-958b-713a-9cab-da4badb392e4',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'event role type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd89b0f44-958b-713a-9cab-da4badb392e4',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ereignisrolle'
);

--changeset system:generated-update-data-AsText-PrPublicEventStatus context:any labels:c-any,o-table,ot-schema,on-PrPublicEventStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicEventStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='13892ffd-fc34-2e3d-aafc-fcff04ab057d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '13892ffd-fc34-2e3d-aafc-fcff04ab057d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Event status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '13892ffd-fc34-2e3d-aafc-fcff04ab057d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Eventstatus'
);

--changeset system:generated-update-data-AsText-PrPublicEventType context:any labels:c-any,o-table,ot-schema,on-PrPublicEventType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicEventType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c63c308c-fa3b-9c34-9c5c-bb25eb0d7bbf';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c63c308c-fa3b-9c34-9c5c-bb25eb0d7bbf',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Event Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c63c308c-fa3b-9c34-9c5c-bb25eb0d7bbf',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ereignisart'
);

--changeset system:generated-update-data-AsText-PrPublicFinfraGTaxApplic context:any labels:c-any,o-table,ot-schema,on-PrPublicFinfraGTaxApplic,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicFinfraGTaxApplic
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7d27eaac-be49-1b3f-a5b3-654d96dc00a7';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7d27eaac-be49-1b3f-a5b3-654d96dc00a7',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'FinfraG Report applicable'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7d27eaac-be49-1b3f-a5b3-654d96dc00a7',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'FinfraG Report Anwendung'
);

--changeset system:generated-update-data-AsText-PrPublicFinfraGTaxObject context:any labels:c-any,o-table,ot-schema,on-PrPublicFinfraGTaxObject,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicFinfraGTaxObject
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c0007072-ed09-8434-93ba-adc1ca454eac';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c0007072-ed09-8434-93ba-adc1ca454eac',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'FinfraG Report object'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c0007072-ed09-8434-93ba-adc1ca454eac',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'FinfraG Report object'
);

--changeset system:generated-update-data-AsText-PrPublicFlag context:any labels:c-any,o-table,ot-schema,on-PrPublicFlag,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicFlag
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f442c425-8d4f-da3b-9413-de208ddd4a1f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f442c425-8d4f-da3b-9413-de208ddd4a1f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Flag'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f442c425-8d4f-da3b-9413-de208ddd4a1f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Flag'
);

--changeset system:generated-update-data-AsText-PrPublicFractionType context:any labels:c-any,o-table,ot-schema,on-PrPublicFractionType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicFractionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c3eb5ffd-d4e2-4d32-9b82-231ac765565b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c3eb5ffd-d4e2-4d32-9b82-231ac765565b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fraction settlement'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c3eb5ffd-d4e2-4d32-9b82-231ac765565b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Spitzenausgleichsart'
);

--changeset system:generated-update-data-AsText-PrPublicFTTCode context:any labels:c-any,o-table,ot-schema,on-PrPublicFTTCode,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicFTTCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c41e7a19-ad7a-f336-a42d-ce26c067e3fc';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c41e7a19-ad7a-f336-a42d-ce26c067e3fc',
    1,
    'MdTableDataDef',
    NULL,
    N'FTT Code',
    N'FTT Code'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c41e7a19-ad7a-f336-a42d-ce26c067e3fc',
    2,
    'MdTableDataDef',
    NULL,
    N'FTT Code',
    N'FTT Code'
);

--changeset system:generated-update-data-AsText-PrPublicFundClass context:any labels:c-any,o-table,ot-schema,on-PrPublicFundClass,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicFundClass
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='809d170b-b8af-733a-bbef-2d78b9e1e09b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '809d170b-b8af-733a-bbef-2d78b9e1e09b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fund classification'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '809d170b-b8af-733a-bbef-2d78b9e1e09b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fondsklassifizierung'
);

--changeset system:generated-update-data-AsText-PrPublicFundGroup context:any labels:c-any,o-table,ot-schema,on-PrPublicFundGroup,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicFundGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0997ec40-2399-e338-a513-3fe0b554f3f6';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0997ec40-2399-e338-a513-3fe0b554f3f6',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fund group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0997ec40-2399-e338-a513-3fe0b554f3f6',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fondsgruppe'
);

--changeset system:generated-update-data-AsText-PrPublicFundTargetGroup context:any labels:c-any,o-table,ot-schema,on-PrPublicFundTargetGroup,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicFundTargetGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6046c7c2-a809-ef39-bbbc-40cbbdfb297f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6046c7c2-a809-ef39-bbbc-40cbbdfb297f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Investor goal group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6046c7c2-a809-ef39-bbbc-40cbbdfb297f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Anlegerzielgruppe'
);

--changeset system:generated-update-data-AsText-PrPublicFundType context:any labels:c-any,o-table,ot-schema,on-PrPublicFundType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicFundType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c10f362b-78a1-943c-80be-8ccc90b15580';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c10f362b-78a1-943c-80be-8ccc90b15580',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fund type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c10f362b-78a1-943c-80be-8ccc90b15580',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fondstyp'
);

--changeset system:generated-update-data-AsText-PrPublicGuarantyType context:any labels:c-any,o-table,ot-schema,on-PrPublicGuarantyType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicGuarantyType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ac81cf4b-48ce-4336-9689-1b70c7ca70ba';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ac81cf4b-48ce-4336-9689-1b70c7ca70ba',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Garanty type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ac81cf4b-48ce-4336-9689-1b70c7ca70ba',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Garantieart'
);

--changeset system:generated-update-data-AsText-PrPublicHistoryFlag context:any labels:c-any,o-table,ot-schema,on-PrPublicHistoryFlag,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicHistoryFlag
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='cade3736-bfca-aa30-8bd0-46ca6e817f2a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cade3736-bfca-aa30-8bd0-46ca6e817f2a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'History flag'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cade3736-bfca-aa30-8bd0-46ca6e817f2a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'History Flag'
);

--changeset system:generated-update-data-AsText-PrPublicIdentType context:any labels:c-any,o-table,ot-schema,on-PrPublicIdentType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicIdentType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e3eb5dc0-b9a7-0d38-b3bb-80285a7204f0';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e3eb5dc0-b9a7-0d38-b3bb-80285a7204f0',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Identification type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e3eb5dc0-b9a7-0d38-b3bb-80285a7204f0',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Identifikationstyp'
);

--changeset system:generated-update-data-AsText-PrPublicImportStatus context:any labels:c-any,o-table,ot-schema,on-PrPublicImportStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicImportStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='71194a6d-6789-c93b-bfcd-1d7246f3fcfb';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '71194a6d-6789-c93b-bfcd-1d7246f3fcfb',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Import status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '71194a6d-6789-c93b-bfcd-1d7246f3fcfb',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Importstatus'
);

--changeset system:generated-update-data-AsText-PrPublicInstituteRoleType context:any labels:c-any,o-table,ot-schema,on-PrPublicInstituteRoleType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicInstituteRoleType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e25eae65-240a-fa36-8472-d8d9eebdbe69';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e25eae65-240a-fa36-8472-d8d9eebdbe69',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Institute role type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e25eae65-240a-fa36-8472-d8d9eebdbe69',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Institutionsrollentyp'
);

--changeset system:generated-update-data-AsText-PrPublicInstrNoType context:any labels:c-any,o-table,ot-schema,on-PrPublicInstrNoType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicInstrNoType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='518bceb2-aa70-1833-87bb-50547ef6f28a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '518bceb2-aa70-1833-87bb-50547ef6f28a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Instrument number type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '518bceb2-aa70-1833-87bb-50547ef6f28a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Titelnummern-Typ'
);

--changeset system:generated-update-data-AsText-PrPublicInstrumentForm context:any labels:c-any,o-table,ot-schema,on-PrPublicInstrumentForm,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicInstrumentForm
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9036e255-de8e-c03a-955e-2406691a96df';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9036e255-de8e-c03a-955e-2406691a96df',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Instrument form'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9036e255-de8e-c03a-955e-2406691a96df',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Instrumentenform'
);

--changeset system:generated-update-data-AsText-PrPublicInstrumentStatus context:any labels:c-any,o-table,ot-schema,on-PrPublicInstrumentStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicInstrumentStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='88f6a30c-a395-d83e-a0d1-62536a82b14e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '88f6a30c-a395-d83e-a0d1-62536a82b14e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Instrument status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '88f6a30c-a395-d83e-a0d1-62536a82b14e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Instrumentenstatus'
);

--changeset system:generated-update-data-AsText-PrPublicInstrumentType context:any labels:c-any,o-table,ot-schema,on-PrPublicInstrumentType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicInstrumentType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='aceff618-a682-9d37-a6d6-cffedb517318';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'aceff618-a682-9d37-a6d6-cffedb517318',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Instrument type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'aceff618-a682-9d37-a6d6-cffedb517318',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Instrumententyp'
);

--changeset system:generated-update-data-AsText-PrPublicInterestType context:any labels:c-any,o-table,ot-schema,on-PrPublicInterestType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicInterestType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1554b99b-eca2-4b3f-a46b-038fda41e796';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1554b99b-eca2-4b3f-a46b-038fda41e796',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Interest type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1554b99b-eca2-4b3f-a46b-038fda41e796',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zinsart'
);

--changeset system:generated-update-data-AsText-PrPublicIntTaxAmountType context:any labels:c-any,o-table,ot-schema,on-PrPublicIntTaxAmountType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicIntTaxAmountType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5f9df5ba-a548-6c3e-84cd-2317ac2fea94';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5f9df5ba-a548-6c3e-84cd-2317ac2fea94',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Amount type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5f9df5ba-a548-6c3e-84cd-2317ac2fea94',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Betragsart'
);

--changeset system:generated-update-data-AsText-PrPublicIntTaxApplic context:any labels:c-any,o-table,ot-schema,on-PrPublicIntTaxApplic,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicIntTaxApplic
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='81a8f0c9-db30-7b33-abda-ec85cc4fe16d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '81a8f0c9-db30-7b33-abda-ec85cc4fe16d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax applicability'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '81a8f0c9-db30-7b33-abda-ec85cc4fe16d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steueranwendbarkeit'
);

--changeset system:generated-update-data-AsText-PrPublicIntTaxBase context:any labels:c-any,o-table,ot-schema,on-PrPublicIntTaxBase,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicIntTaxBase
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='525cf35b-5571-743f-9c16-0d8fda5793a6';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '525cf35b-5571-743f-9c16-0d8fda5793a6',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax base'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '525cf35b-5571-743f-9c16-0d8fda5793a6',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bemessungsgrundlage'
);

--changeset system:generated-update-data-AsText-PrPublicIntTaxIncomeType context:any labels:c-any,o-table,ot-schema,on-PrPublicIntTaxIncomeType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicIntTaxIncomeType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='99404da2-39a1-383c-9b3f-b67477311fad';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '99404da2-39a1-383c-9b3f-b67477311fad',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'AIA Income type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '99404da2-39a1-383c-9b3f-b67477311fad',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'AIA Ertragsart'
);

--changeset system:generated-update-data-AsText-PrPublicIntTaxType context:any labels:c-any,o-table,ot-schema,on-PrPublicIntTaxType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicIntTaxType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='03507ca7-091b-0134-8294-a924b1f9274d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '03507ca7-091b-0134-8294-a924b1f9274d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax type international'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '03507ca7-091b-0134-8294-a924b1f9274d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuertyp International'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '03507ca7-091b-0134-8294-a924b1f9274d',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type de taxe internationa'
);

--changeset system:generated-update-data-AsText-PrPublicInvestmentCat context:any labels:c-any,o-table,ot-schema,on-PrPublicInvestmentCat,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicInvestmentCat
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5d90830c-c9a9-e13a-917d-ac86974b1bec';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5d90830c-c9a9-e13a-917d-ac86974b1bec',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Investment category'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5d90830c-c9a9-e13a-917d-ac86974b1bec',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Anlagekategorie'
);

--changeset system:generated-update-data-AsText-PrPublicInvestmentStyle context:any labels:c-any,o-table,ot-schema,on-PrPublicInvestmentStyle,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicInvestmentStyle
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b53dbbf8-f2c5-5d3f-8215-410b8b736a91';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b53dbbf8-f2c5-5d3f-8215-410b8b736a91',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Investment style'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b53dbbf8-f2c5-5d3f-8215-410b8b736a91',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ausschüttungspolitik'
);

--changeset system:generated-update-data-AsText-PrPublicIpoTimingType context:any labels:c-any,o-table,ot-schema,on-PrPublicIpoTimingType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicIpoTimingType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d2b50fb5-e2a2-e03c-ae54-ad5a67b4ca5b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd2b50fb5-e2a2-e03c-ae54-ad5a67b4ca5b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'IPO timing type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd2b50fb5-e2a2-e03c-ae54-ad5a67b4ca5b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'IPO-Zeitpunktstyp'
);

--changeset system:generated-update-data-AsText-PrPublicIssuePaymentType context:any labels:c-any,o-table,ot-schema,on-PrPublicIssuePaymentType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicIssuePaymentType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ddb218b6-626c-e632-88ac-64f99d8c020d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ddb218b6-626c-e632-88ac-64f99d8c020d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Payment type for issue'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ddb218b6-626c-e632-88ac-64f99d8c020d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zahlungsart Liberierung'
);

--changeset system:generated-update-data-AsText-PrPublicIssueStatus context:any labels:c-any,o-table,ot-schema,on-PrPublicIssueStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicIssueStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5e994b57-a457-bb3c-ac9b-e67ccbb16e38';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5e994b57-a457-bb3c-ac9b-e67ccbb16e38',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Issue status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5e994b57-a457-bb3c-ac9b-e67ccbb16e38',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Emissionsstatus'
);

--changeset system:generated-update-data-AsText-PrPublicIupCode context:any labels:c-any,o-table,ot-schema,on-PrPublicIupCode,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicIupCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5f6d2768-d12e-9437-97b5-d008b0eef8cc';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5f6d2768-d12e-9437-97b5-d008b0eef8cc',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'IUP code'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5f6d2768-d12e-9437-97b5-d008b0eef8cc',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'IUP Code'
);

--changeset system:generated-update-data-AsText-PrPublicKeyFigureMapping context:any labels:c-any,o-table,ot-schema,on-PrPublicKeyFigureMapping,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicKeyFigureMapping
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bf5cc51f-31a4-0338-b531-378b11a64c67';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bf5cc51f-31a4-0338-b531-378b11a64c67',
    1,
    'MdTableDataDef',
    NULL,
    N'Key figure mapping',
    N'Key figure mapping'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bf5cc51f-31a4-0338-b531-378b11a64c67',
    2,
    'MdTableDataDef',
    NULL,
    N'Kennzahl Mapping',
    N'Kennzahl Mapping'
);

--changeset system:generated-update-data-AsText-PrPublicKeyFigureType context:any labels:c-any,o-table,ot-schema,on-PrPublicKeyFigureType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicKeyFigureType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c4ab4b32-77ad-0436-bc7d-81947a1f027a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c4ab4b32-77ad-0436-bc7d-81947a1f027a',
    1,
    'MdTableDataDef',
    NULL,
    N'Key figure type',
    N'Key figure type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c4ab4b32-77ad-0436-bc7d-81947a1f027a',
    2,
    'MdTableDataDef',
    NULL,
    N'Kennzahl Typ',
    N'Kennzahl Typ'
);

--changeset system:generated-update-data-AsText-PrPublicKickbackStatus context:any labels:c-any,o-table,ot-schema,on-PrPublicKickbackStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicKickbackStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='212ffac0-d1ed-8a35-b8a5-629bc3641cb5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '212ffac0-d1ed-8a35-b8a5-629bc3641cb5',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Status PrPublicKickback'
);

--changeset system:generated-update-data-AsText-PrPublicListingClass context:any labels:c-any,o-table,ot-schema,on-PrPublicListingClass,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicListingClass
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ef25a705-8993-f433-bdf9-f5d9a02d7d7f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ef25a705-8993-f433-bdf9-f5d9a02d7d7f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Listing class'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ef25a705-8993-f433-bdf9-f5d9a02d7d7f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kotierungsklassifizierung'
);

--changeset system:generated-update-data-AsText-PrPublicListingOrderStatusSx context:any labels:c-any,o-table,ot-schema,on-PrPublicListingOrderStatusSx,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicListingOrderStatusSx
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='38b08513-2700-ed3c-b910-ad0e1349abd9';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '38b08513-2700-ed3c-b910-ad0e1349abd9',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Status für Börsenauftrag'
);

--changeset system:generated-update-data-AsText-PrPublicListingStatus context:any labels:c-any,o-table,ot-schema,on-PrPublicListingStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicListingStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='50085825-b389-3131-a728-ac9b2c450db1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '50085825-b389-3131-a728-ac9b2c450db1',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Listing status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '50085825-b389-3131-a728-ac9b2c450db1',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kotierungsstatus'
);

--changeset system:generated-update-data-AsText-PrPublicMaintenanceStatus context:any labels:c-any,o-table,ot-schema,on-PrPublicMaintenanceStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicMaintenanceStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b0936499-4553-ea3b-b95c-059b51d34234';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b0936499-4553-ea3b-b95c-059b51d34234',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'VDF Plegegestatus'
);

--changeset system:generated-update-data-AsText-PrPublicMainUnderlClass context:any labels:c-any,o-table,ot-schema,on-PrPublicMainUnderlClass,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicMainUnderlClass
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='672cacea-edcf-ea33-b23b-c6c06c5ceb4e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '672cacea-edcf-ea33-b23b-c6c06c5ceb4e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Main underlying class'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '672cacea-edcf-ea33-b23b-c6c06c5ceb4e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Haupt Underlying-Klasse'
);

--changeset system:generated-update-data-AsText-PrPublicMainUnderlClassAssign context:any labels:c-any,o-table,ot-schema,on-PrPublicMainUnderlClassAssign,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicMainUnderlClassAssign
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='321fe83f-4918-d53e-b02a-a05c0c8fdafc';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '321fe83f-4918-d53e-b02a-a05c0c8fdafc',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zuteilungsart Haupt-Unde.'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '321fe83f-4918-d53e-b02a-a05c0c8fdafc',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zuteilungsart Haupt-Unde.'
);

--changeset system:generated-update-data-AsText-PrPublicMainUnderlSecLevel context:any labels:c-any,o-table,ot-schema,on-PrPublicMainUnderlSecLevel,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicMainUnderlSecLevel
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2498a7a3-820c-333b-bba1-74e106dc3fd7';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2498a7a3-820c-333b-bba1-74e106dc3fd7',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Main undrl.classe 2.level'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2498a7a3-820c-333b-bba1-74e106dc3fd7',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Haupt Underl.-Klasse 2.St'
);

--changeset system:generated-update-data-AsText-PrPublicMarketAffiliation context:any labels:c-any,o-table,ot-schema,on-PrPublicMarketAffiliation,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicMarketAffiliation
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b314507b-2f21-3233-8b37-f56cedfb6bcf';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b314507b-2f21-3233-8b37-f56cedfb6bcf',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Market affiliation'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b314507b-2f21-3233-8b37-f56cedfb6bcf',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Marktzugehörigkeit'
);

--changeset system:generated-update-data-AsText-PrPublicNonResCode context:any labels:c-any,o-table,ot-schema,on-PrPublicNonResCode,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicNonResCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7e94bc42-50e8-4230-bf47-642144199b5a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7e94bc42-50e8-4230-bf47-642144199b5a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Resident-/non resident'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7e94bc42-50e8-4230-bf47-642144199b5a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'In-/Ausländercode'
);

--changeset system:generated-update-data-AsText-PrPublicOfferStatus context:any labels:c-any,o-table,ot-schema,on-PrPublicOfferStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicOfferStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='cfd96e4e-a998-423a-9ca7-05c6f46b4599';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cfd96e4e-a998-423a-9ca7-05c6f46b4599',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Offer status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cfd96e4e-a998-423a-9ca7-05c6f46b4599',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Offertenstatus'
);

--changeset system:generated-update-data-AsText-PrPublicOpenFundType context:any labels:c-any,o-table,ot-schema,on-PrPublicOpenFundType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicOpenFundType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='26ccfb6f-52a3-d938-b6fd-40d2856626f8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '26ccfb6f-52a3-d938-b6fd-40d2856626f8',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Open fund type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '26ccfb6f-52a3-d938-b6fd-40d2856626f8',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Offener Anlagefondstyp'
);

--changeset system:generated-update-data-AsText-PrPublicOptionType context:any labels:c-any,o-table,ot-schema,on-PrPublicOptionType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicOptionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5bbdc37e-7bf4-c637-9395-20fede2efdd6';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5bbdc37e-7bf4-c637-9395-20fede2efdd6',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Option type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5bbdc37e-7bf4-c637-9395-20fede2efdd6',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Optionsart'
);

--changeset system:generated-update-data-AsText-PrPublicOrigin context:any labels:c-any,o-table,ot-schema,on-PrPublicOrigin,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicOrigin
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='096afbfb-7758-1a3e-88ba-8bedf84f371f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '096afbfb-7758-1a3e-88ba-8bedf84f371f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Origin'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '096afbfb-7758-1a3e-88ba-8bedf84f371f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Herkunft'
);

--changeset system:generated-update-data-AsText-PrPublicPartialDivType context:any labels:c-any,o-table,ot-schema,on-PrPublicPartialDivType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicPartialDivType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='45bbb9ed-69f2-c032-a057-c840dcbfd712';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '45bbb9ed-69f2-c032-a057-c840dcbfd712',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Abschlagsdividendenart'
);

--changeset system:generated-update-data-AsText-PrPublicPaymentDirection context:any labels:c-any,o-table,ot-schema,on-PrPublicPaymentDirection,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicPaymentDirection
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4da56b17-1b4f-de3a-a04a-859eb171a588';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4da56b17-1b4f-de3a-a04a-859eb171a588',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Payment direction'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4da56b17-1b4f-de3a-a04a-859eb171a588',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zahlungsrichtung'
);

--changeset system:generated-update-data-AsText-PrPublicPaymentFunc context:any labels:c-any,o-table,ot-schema,on-PrPublicPaymentFunc,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicPaymentFunc
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='42e4c134-65e9-a331-b7e3-d78541a1a8c6';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '42e4c134-65e9-a331-b7e3-d78541a1a8c6',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Payment function'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '42e4c134-65e9-a331-b7e3-d78541a1a8c6',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zahlungsfunktion'
);

--changeset system:generated-update-data-AsText-PrPublicPaymentType context:any labels:c-any,o-table,ot-schema,on-PrPublicPaymentType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicPaymentType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='793b1ce9-071f-f53e-bfae-a558c2153ece';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '793b1ce9-071f-f53e-bfae-a558c2153ece',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Payment type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '793b1ce9-071f-f53e-bfae-a558c2153ece',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zahlungstyp'
);

--changeset system:generated-update-data-AsText-PrPublicPeculiarity context:any labels:c-any,o-table,ot-schema,on-PrPublicPeculiarity,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicPeculiarity
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='65382a0c-df45-0a34-ab9c-fb332d9f0287';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '65382a0c-df45-0a34-ab9c-fb332d9f0287',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax Particularity'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '65382a0c-df45-0a34-ab9c-fb332d9f0287',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuertyp'
);

--changeset system:generated-update-data-AsText-PrPublicPhysicalUnitType context:any labels:c-any,o-table,ot-schema,on-PrPublicPhysicalUnitType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicPhysicalUnitType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='fda4684a-70c3-4e37-845d-93219e275737';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fda4684a-70c3-4e37-845d-93219e275737',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Physikalische Einheit'
);

--changeset system:generated-update-data-AsText-PrPublicPlacementType context:any labels:c-any,o-table,ot-schema,on-PrPublicPlacementType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicPlacementType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='21db3784-52f3-cc39-a429-d7b202014aec';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '21db3784-52f3-cc39-a429-d7b202014aec',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Placement type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '21db3784-52f3-cc39-a429-d7b202014aec',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Platzierungsart'
);

--changeset system:generated-update-data-AsText-PrPublicPriceCalcMeth context:any labels:c-any,o-table,ot-schema,on-PrPublicPriceCalcMeth,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicPriceCalcMeth
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2400536f-2b28-0f3e-b203-f95775eff6d0';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2400536f-2b28-0f3e-b203-f95775eff6d0',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kursberechnungsart'
);

--changeset system:generated-update-data-AsText-PrPublicPriceCategory context:any labels:c-any,o-table,ot-schema,on-PrPublicPriceCategory,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicPriceCategory
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='01995f90-0657-3f37-aabe-711bd813bec8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '01995f90-0657-3f37-aabe-711bd813bec8',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Price category'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '01995f90-0657-3f37-aabe-711bd813bec8',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kurskategorie'
);

--changeset system:generated-update-data-AsText-PrPublicPricePenalty context:any labels:c-any,o-table,ot-schema,on-PrPublicPricePenalty,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicPricePenalty
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a6fc2afb-d461-1534-b944-2dec06e47c71';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a6fc2afb-d461-1534-b944-2dec06e47c71',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Price Penalty'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a6fc2afb-d461-1534-b944-2dec06e47c71',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zeitzuschlag'
);

--changeset system:generated-update-data-AsText-PrPublicPriceQuoteType context:any labels:c-any,o-table,ot-schema,on-PrPublicPriceQuoteType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicPriceQuoteType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e1e424dc-8bea-423e-80f1-03843c879b7c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e1e424dc-8bea-423e-80f1-03843c879b7c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Price quote type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e1e424dc-8bea-423e-80f1-03843c879b7c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Notierungsart Preis'
);

--changeset system:generated-update-data-AsText-PrPublicPriceType context:any labels:c-any,o-table,ot-schema,on-PrPublicPriceType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicPriceType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3ae154e3-b227-3b37-8828-463c06cd7443';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3ae154e3-b227-3b37-8828-463c06cd7443',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Price type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3ae154e3-b227-3b37-8828-463c06cd7443',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kurstyp'
);

--changeset system:generated-update-data-AsText-PrPublicProportionClass context:any labels:c-any,o-table,ot-schema,on-PrPublicProportionClass,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicProportionClass
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f2497174-16d4-363e-a930-1d6441d4ff86';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f2497174-16d4-363e-a930-1d6441d4ff86',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Aktiven-Anteil Klassifiz.'
);

--changeset system:generated-update-data-AsText-PrPublicQualityLevel context:any labels:c-any,o-table,ot-schema,on-PrPublicQualityLevel,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicQualityLevel
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ec3f61b8-31cf-9935-8295-06d5ce93c998';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ec3f61b8-31cf-9935-8295-06d5ce93c998',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Qualtitätsgrad'
);

--changeset system:generated-update-data-AsText-PrPublicQuoteType context:any labels:c-any,o-table,ot-schema,on-PrPublicQuoteType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicQuoteType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='33fa13ea-706c-003a-979f-fac75f48ba60';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '33fa13ea-706c-003a-979f-fac75f48ba60',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Quote type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '33fa13ea-706c-003a-979f-fac75f48ba60',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Notierungsart'
);

--changeset system:generated-update-data-AsText-PrPublicRanking context:any labels:c-any,o-table,ot-schema,on-PrPublicRanking,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicRanking
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0fee2547-ded9-793b-b23f-108cab62bb82';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0fee2547-ded9-793b-b23f-108cab62bb82',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ranking'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0fee2547-ded9-793b-b23f-108cab62bb82',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rang'
);

--changeset system:generated-update-data-AsText-PrPublicRedemptionCode context:any labels:c-any,o-table,ot-schema,on-PrPublicRedemptionCode,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicRedemptionCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='02e8dff3-186b-9839-ae41-00012d347547';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '02e8dff3-186b-9839-ae41-00012d347547',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Redemption code'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '02e8dff3-186b-9839-ae41-00012d347547',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rückzahlungscode'
);

--changeset system:generated-update-data-AsText-PrPublicRedenomMethod context:any labels:c-any,o-table,ot-schema,on-PrPublicRedenomMethod,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicRedenomMethod
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='007533f7-5d27-b23a-9534-4e1b0fbc9716';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '007533f7-5d27-b23a-9534-4e1b0fbc9716',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Redenomination method'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '007533f7-5d27-b23a-9534-4e1b0fbc9716',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Redenominationsmethode'
);

--changeset system:generated-update-data-AsText-PrPublicRefPriceType context:any labels:c-any,o-table,ot-schema,on-PrPublicRefPriceType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicRefPriceType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9a387d41-e74b-1931-9c53-64a5e4539b4c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9a387d41-e74b-1931-9c53-64a5e4539b4c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'reference price type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9a387d41-e74b-1931-9c53-64a5e4539b4c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Referenzpreistyp'
);

--changeset system:generated-update-data-AsText-PrPublicRefType context:any labels:c-any,o-table,ot-schema,on-PrPublicRefType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicRefType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5b104697-1691-d832-a2c1-565336b0a6d6';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5b104697-1691-d832-a2c1-565336b0a6d6',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Reference type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5b104697-1691-d832-a2c1-565336b0a6d6',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Referenztyp'
);

--changeset system:generated-update-data-AsText-PrPublicRegionCountry context:any labels:c-any,o-table,ot-schema,on-PrPublicRegionCountry,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicRegionCountry
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7c629451-0447-f433-bf15-27e3cfa53752';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7c629451-0447-f433-bf15-27e3cfa53752',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Regionen/Länder'
);

--changeset system:generated-update-data-AsText-PrPublicRepaymentReason context:any labels:c-any,o-table,ot-schema,on-PrPublicRepaymentReason,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicRepaymentReason
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='18d5c2e5-28f2-ec3d-a7e9-6bbb6d621d57';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '18d5c2e5-28f2-ec3d-a7e9-6bbb6d621d57',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Repayment reason'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '18d5c2e5-28f2-ec3d-a7e9-6bbb6d621d57',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rückzalhlungsgrund'
);

--changeset system:generated-update-data-AsText-PrPublicRightType context:any labels:c-any,o-table,ot-schema,on-PrPublicRightType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicRightType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ecec5670-0803-df3d-8959-4d74f014ba7a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ecec5670-0803-df3d-8959-4d74f014ba7a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Right Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ecec5670-0803-df3d-8959-4d74f014ba7a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rechtsart'
);

--changeset system:generated-update-data-AsText-PrPublicSecuritySupplType context:any labels:c-any,o-table,ot-schema,on-PrPublicSecuritySupplType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicSecuritySupplType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8840d56c-c469-9d36-80c2-3262aa79fd36';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8840d56c-c469-9d36-80c2-3262aa79fd36',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Security supplement type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8840d56c-c469-9d36-80c2-3262aa79fd36',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Titelartzusatz'
);

--changeset system:generated-update-data-AsText-PrPublicSecurityType context:any labels:c-any,o-table,ot-schema,on-PrPublicSecurityType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicSecurityType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c7228a29-1177-4731-8348-40305dbb0552';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c7228a29-1177-4731-8348-40305dbb0552',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Security type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c7228a29-1177-4731-8348-40305dbb0552',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Titelart'
);

--changeset system:generated-update-data-AsText-PrPublicSecurityTypeGroup context:any labels:c-any,o-table,ot-schema,on-PrPublicSecurityTypeGroup,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicSecurityTypeGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c217c559-1425-723a-bc57-b51bcd35f2b2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c217c559-1425-723a-bc57-b51bcd35f2b2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Security type group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c217c559-1425-723a-bc57-b51bcd35f2b2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Titelartgruppe'
);

--changeset system:generated-update-data-AsText-PrPublicSettlementType context:any labels:c-any,o-table,ot-schema,on-PrPublicSettlementType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicSettlementType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='fc705ae4-f225-e138-a163-35ec6f07b82b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fc705ae4-f225-e138-a163-35ec6f07b82b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Settlement type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fc705ae4-f225-e138-a163-35ec6f07b82b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Abgeltungsform'
);

--changeset system:generated-update-data-AsText-PrPublicSim context:any labels:c-any,o-table,ot-schema,on-PrPublicSim,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicSim
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5947e2bb-1ba9-7831-a2ce-2e35e1261631';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5947e2bb-1ba9-7831-a2ce-2e35e1261631',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Public product'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5947e2bb-1ba9-7831-a2ce-2e35e1261631',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Valorenstamm'
);

--changeset system:generated-update-data-AsText-PrPublicSpecCommissionCat context:any labels:c-any,o-table,ot-schema,on-PrPublicSpecCommissionCat,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicSpecCommissionCat
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='914031a6-f46e-d937-b650-5c6374e04b44';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '914031a6-f46e-d937-b650-5c6374e04b44',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Special commissioncat.'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '914031a6-f46e-d937-b650-5c6374e04b44',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Spezielle Courtagekat.'
);

--changeset system:generated-update-data-AsText-PrPublicSpreadDirection context:any labels:c-any,o-table,ot-schema,on-PrPublicSpreadDirection,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicSpreadDirection
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7f85e19e-2669-6f3b-9af2-1cc4e36dd5f9';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7f85e19e-2669-6f3b-9af2-1cc4e36dd5f9',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Spread direction'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7f85e19e-2669-6f3b-9af2-1cc4e36dd5f9',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Spread-Richtung'
);

--changeset system:generated-update-data-AsText-PrPublicStartValueType context:any labels:c-any,o-table,ot-schema,on-PrPublicStartValueType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicStartValueType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='846325fd-e07b-d33b-99ad-e3962a918092';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '846325fd-e07b-d33b-99ad-e3962a918092',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Startwerttyp'
);

--changeset system:generated-update-data-AsText-PrPublicStatisticType context:any labels:c-any,o-table,ot-schema,on-PrPublicStatisticType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicStatisticType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='381571f6-1160-2337-8dc0-67e4e8616ebe';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '381571f6-1160-2337-8dc0-67e4e8616ebe',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Statistic type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '381571f6-1160-2337-8dc0-67e4e8616ebe',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kursart'
);

--changeset system:generated-update-data-AsText-PrPublicStopReason context:any labels:c-any,o-table,ot-schema,on-PrPublicStopReason,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicStopReason
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e6ef94f1-9c40-123a-8ac1-080017a144be';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e6ef94f1-9c40-123a-8ac1-080017a144be',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Stop reason'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e6ef94f1-9c40-123a-8ac1-080017a144be',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Oppositionsgrund'
);

--changeset system:generated-update-data-AsText-PrPublicStrikeBarrierType context:any labels:c-any,o-table,ot-schema,on-PrPublicStrikeBarrierType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicStrikeBarrierType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6438700f-b706-9135-b96d-3779980a81e6';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6438700f-b706-9135-b96d-3779980a81e6',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Strike/Barrier Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6438700f-b706-9135-b96d-3779980a81e6',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Strike/Barrier Type'
);

--changeset system:generated-update-data-AsText-PrPublicStructProdClass context:any labels:c-any,o-table,ot-schema,on-PrPublicStructProdClass,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicStructProdClass
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8f565426-53cb-e336-83fb-f1bce758082c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8f565426-53cb-e336-83fb-f1bce758082c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'd'
);

--changeset system:generated-update-data-AsText-PrPublicStructProdScheme context:any labels:c-any,o-table,ot-schema,on-PrPublicStructProdScheme,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicStructProdScheme
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b8e72c2c-bf48-5d3b-b6ec-ef9de14e1b89';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b8e72c2c-bf48-5d3b-b6ec-ef9de14e1b89',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'd'
);

--changeset system:generated-update-data-AsText-PrPublicStructRiskRating context:any labels:c-any,o-table,ot-schema,on-PrPublicStructRiskRating,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicStructRiskRating
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='fb4c57bd-3ee5-4439-bede-6df0f479f87f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fb4c57bd-3ee5-4439-bede-6df0f479f87f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'SVSP Risk Rating'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fb4c57bd-3ee5-4439-bede-6df0f479f87f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'SVSP Risk Rating'
);

--changeset system:generated-update-data-AsText-PrPublicSubscriptionType context:any labels:c-any,o-table,ot-schema,on-PrPublicSubscriptionType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicSubscriptionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='eb4f336c-dd39-ba32-bd50-18205a497fcf';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'eb4f336c-dd39-ba32-bd50-18205a497fcf',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Subscription type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'eb4f336c-dd39-ba32-bd50-18205a497fcf',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zeichungsart'
);

--changeset system:generated-update-data-AsText-PrPublicSymbolStatus context:any labels:c-any,o-table,ot-schema,on-PrPublicSymbolStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicSymbolStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3768db49-6bae-633d-85d3-56c0cbd4f621';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3768db49-6bae-633d-85d3-56c0cbd4f621',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Symbol status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3768db49-6bae-633d-85d3-56c0cbd4f621',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Symbolstatus'
);

--changeset system:generated-update-data-AsText-PrPublicTaxableObject context:any labels:c-any,o-table,ot-schema,on-PrPublicTaxableObject,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicTaxableObject
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9cca8ee9-9f3f-993a-a654-d6d3390d1742';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9cca8ee9-9f3f-993a-a654-d6d3390d1742',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Taxable Object'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9cca8ee9-9f3f-993a-a654-d6d3390d1742',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuerobjekt'
);

--changeset system:generated-update-data-AsText-PrPublicTaxAmountType context:any labels:c-any,o-table,ot-schema,on-PrPublicTaxAmountType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicTaxAmountType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c9a66b02-09a0-7c34-8266-50ae1ba8bb9b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c9a66b02-09a0-7c34-8266-50ae1ba8bb9b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax amount type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c9a66b02-09a0-7c34-8266-50ae1ba8bb9b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuerbetragstyp'
);

--changeset system:generated-update-data-AsText-PrPublicTaxCategory context:any labels:c-any,o-table,ot-schema,on-PrPublicTaxCategory,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicTaxCategory
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='299f707f-0d91-5c32-a593-a0e4fd079891';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '299f707f-0d91-5c32-a593-a0e4fd079891',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax category'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '299f707f-0d91-5c32-a593-a0e4fd079891',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuerkategorie'
);

--changeset system:generated-update-data-AsText-PrPublicTaxDateType context:any labels:c-any,o-table,ot-schema,on-PrPublicTaxDateType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicTaxDateType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='09f34e51-eb94-2933-be5b-9d196fb30212';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '09f34e51-eb94-2933-be5b-9d196fb30212',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Date type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '09f34e51-eb94-2933-be5b-9d196fb30212',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Datumstyp'
);

--changeset system:generated-update-data-AsText-PrPublicTaxName context:any labels:c-any,o-table,ot-schema,on-PrPublicTaxName,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicTaxName
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c44aa8ae-1c5c-3239-9c96-d9d74faa3c9a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c44aa8ae-1c5c-3239-9c96-d9d74faa3c9a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax / Reporting Name'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c44aa8ae-1c5c-3239-9c96-d9d74faa3c9a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuer-/Meldungsname'
);

--changeset system:generated-update-data-AsText-PrPublicTaxParticularity context:any labels:c-any,o-table,ot-schema,on-PrPublicTaxParticularity,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicTaxParticularity
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ee752661-bcee-6b30-80f8-851f45dfcb4f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ee752661-bcee-6b30-80f8-851f45dfcb4f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax Particularity'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ee752661-bcee-6b30-80f8-851f45dfcb4f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuersorgfalt'
);

--changeset system:generated-update-data-AsText-PrPublicTaxPriceAvailability context:any labels:c-any,o-table,ot-schema,on-PrPublicTaxPriceAvailability,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicTaxPriceAvailability
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='74c6a36f-d8d5-453f-88f1-9db082dd7f54';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '74c6a36f-d8d5-453f-88f1-9db082dd7f54',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Verfügbarkeit Steuerkurs'
);

--changeset system:generated-update-data-AsText-PrPublicTaxPriceValidation context:any labels:c-any,o-table,ot-schema,on-PrPublicTaxPriceValidation,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicTaxPriceValidation
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ddb62da4-eeae-623e-8699-648d604eaf32';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ddb62da4-eeae-623e-8699-648d604eaf32',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gültigkeit Steuerkurse'
);

--changeset system:generated-update-data-AsText-PrPublicTaxType context:any labels:c-any,o-table,ot-schema,on-PrPublicTaxType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicTaxType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d86a5806-ec6d-0332-9639-cbe7200b991e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd86a5806-ec6d-0332-9639-cbe7200b991e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd86a5806-ec6d-0332-9639-cbe7200b991e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuertyp'
);

--changeset system:generated-update-data-AsText-PrPublicTimeUnit context:any labels:c-any,o-table,ot-schema,on-PrPublicTimeUnit,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicTimeUnit
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1d516ab1-5306-a23e-8746-2f9e6a590aea';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1d516ab1-5306-a23e-8746-2f9e6a590aea',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Time unit'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1d516ab1-5306-a23e-8746-2f9e6a590aea',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zeiteinheit'
);

--changeset system:generated-update-data-AsText-PrPublicToffType context:any labels:c-any,o-table,ot-schema,on-PrPublicToffType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicToffType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f22f1cc0-dd89-2339-a7c8-a471a4c85fd0';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f22f1cc0-dd89-2339-a7c8-a471a4c85fd0',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'TOFF type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f22f1cc0-dd89-2339-a7c8-a471a4c85fd0',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'TOFF Typ'
);

--changeset system:generated-update-data-AsText-PrPublicTradeStatus context:any labels:c-any,o-table,ot-schema,on-PrPublicTradeStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicTradeStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9e97ca58-4471-fd3b-bdca-c7199564b587';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9e97ca58-4471-fd3b-bdca-c7199564b587',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Trade status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9e97ca58-4471-fd3b-bdca-c7199564b587',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Handelsstatus'
);

--changeset system:generated-update-data-AsText-PrPublicTradingPlaceReport context:any labels:c-any,o-table,ot-schema,on-PrPublicTradingPlaceReport,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicTradingPlaceReport
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='03628078-7340-a23a-9bd1-f37fa731d8c3';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '03628078-7340-a23a-9bd1-f37fa731d8c3',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Trading place report'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '03628078-7340-a23a-9bd1-f37fa731d8c3',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Börsenplatz Report'
);

--changeset system:generated-update-data-AsText-PrPublicTradingPlaceValueDay context:any labels:c-any,o-table,ot-schema,on-PrPublicTradingPlaceValueDay,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicTradingPlaceValueDay
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='30e89d40-f670-ec31-bfd0-205d35ec9e11';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '30e89d40-f670-ec31-bfd0-205d35ec9e11',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ValueDayType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '30e89d40-f670-ec31-bfd0-205d35ec9e11',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Valuta Frist'
);

--changeset system:generated-update-data-AsText-PrPublicTransformType context:any labels:c-any,o-table,ot-schema,on-PrPublicTransformType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicTransformType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='eaf24358-a16c-3639-adcb-f206514b0dbb';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'eaf24358-a16c-3639-adcb-f206514b0dbb',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Transformation type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'eaf24358-a16c-3639-adcb-f206514b0dbb',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Transformationstyp'
);

--changeset system:generated-update-data-AsText-PrPublicType context:any labels:c-any,o-table,ot-schema,on-PrPublicType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5f97d730-f893-f33a-b381-03d7e73f7961';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5f97d730-f893-f33a-b381-03d7e73f7961',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Public product type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5f97d730-f893-f33a-b381-03d7e73f7961',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Instrumenttyp'
);

--changeset system:generated-update-data-AsText-PrPublicUnderlSelectType context:any labels:c-any,o-table,ot-schema,on-PrPublicUnderlSelectType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicUnderlSelectType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ab806abb-47f7-7931-af39-086afcef747a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ab806abb-47f7-7931-af39-086afcef747a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Undelying Selection Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ab806abb-47f7-7931-af39-086afcef747a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Undelying Selection Type'
);

--changeset system:generated-update-data-AsText-PrPublicUnderlValuatType context:any labels:c-any,o-table,ot-schema,on-PrPublicUnderlValuatType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicUnderlValuatType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5581c040-fa21-a232-b713-e7ec18b85b48';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5581c040-fa21-a232-b713-e7ec18b85b48',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Underlying Valuation Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5581c040-fa21-a232-b713-e7ec18b85b48',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Underlying Valuation Type'
);

--changeset system:generated-update-data-AsText-PrPublicUnderlying context:any labels:c-any,o-table,ot-schema,on-PrPublicUnderlying,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicUnderlying
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a3a516c4-56bd-aa3a-92dd-478feab36a25';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a3a516c4-56bd-aa3a-92dd-478feab36a25',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Underlying'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a3a516c4-56bd-aa3a-92dd-478feab36a25',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Underlying'
);

--changeset system:generated-update-data-AsText-PrPublicUnderlyingFunc context:any labels:c-any,o-table,ot-schema,on-PrPublicUnderlyingFunc,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicUnderlyingFunc
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e6d3b1bb-1014-ec37-a570-1ffec6f511d1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e6d3b1bb-1014-ec37-a570-1ffec6f511d1',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Underlying function'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e6d3b1bb-1014-ec37-a570-1ffec6f511d1',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Underlying-Funktion'
);

--changeset system:generated-update-data-AsText-PrPublicUnderlyingRole context:any labels:c-any,o-table,ot-schema,on-PrPublicUnderlyingRole,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicUnderlyingRole
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='87edc922-22f3-9d36-b541-554136371b24';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '87edc922-22f3-9d36-b541-554136371b24',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Underlying Role'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '87edc922-22f3-9d36-b541-554136371b24',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Underlying Role'
);

--changeset system:generated-update-data-AsText-PrPublicUnderlyingType context:any labels:c-any,o-table,ot-schema,on-PrPublicUnderlyingType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicUnderlyingType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ac6c1da8-a1bb-4639-a49b-d7af8d5c6499';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ac6c1da8-a1bb-4639-a49b-d7af8d5c6499',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Underlying type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ac6c1da8-a1bb-4639-a49b-d7af8d5c6499',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Underlying-Typ'
);

--changeset system:generated-update-data-AsText-PrPublicUnit context:any labels:c-any,o-table,ot-schema,on-PrPublicUnit,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicUnit
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3e1f5ef0-14ce-843f-809e-b3c064be04a8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3e1f5ef0-14ce-843f-809e-b3c064be04a8',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Unit'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3e1f5ef0-14ce-843f-809e-b3c064be04a8',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Einheit'
);

--changeset system:generated-update-data-AsText-PrPublicUsClassification context:any labels:c-any,o-table,ot-schema,on-PrPublicUsClassification,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicUsClassification
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='11125c79-9a37-ab3e-a27e-f2b338c34f60';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '11125c79-9a37-ab3e-a27e-f2b338c34f60',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'd'
);

--changeset system:generated-update-data-AsText-PrPublicUsIrsIncomeCode context:any labels:c-any,o-table,ot-schema,on-PrPublicUsIrsIncomeCode,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicUsIrsIncomeCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a15d970c-b6a4-c637-9a0e-030308087626';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a15d970c-b6a4-c637-9a0e-030308087626',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'US IRS Income code'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a15d970c-b6a4-c637-9a0e-030308087626',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'US IRS Income Code'
);

--changeset system:generated-update-data-AsText-PrPublicUsIrsTaxCategory context:any labels:c-any,o-table,ot-schema,on-PrPublicUsIrsTaxCategory,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicUsIrsTaxCategory
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='eca88806-1a96-a738-8163-bf5950c5337e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'eca88806-1a96-a738-8163-bf5950c5337e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'US IRS Tax Category'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'eca88806-1a96-a738-8163-bf5950c5337e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'US IRS Tax Category'
);

--changeset system:generated-update-data-AsText-PrPublicValidationType context:any labels:c-any,o-table,ot-schema,on-PrPublicValidationType,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicValidationType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f3f6fb32-156f-f13f-bf9f-2139a7e1fd51';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f3f6fb32-156f-f13f-bf9f-2139a7e1fd51',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Validation type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f3f6fb32-156f-f13f-bf9f-2139a7e1fd51',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Art der Geltendmachung'
);

--changeset system:generated-update-data-AsText-PrPublicValueStyle context:any labels:c-any,o-table,ot-schema,on-PrPublicValueStyle,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicValueStyle
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='87a8a9a0-000f-f336-94f5-61d09f9f4fab';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '87a8a9a0-000f-f336-94f5-61d09f9f4fab',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Value style'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '87a8a9a0-000f-f336-94f5-61d09f9f4fab',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zusatz zu Kurstyp'
);

--changeset system:generated-update-data-AsText-PrPublicVdfDocProcStatus context:any labels:c-any,o-table,ot-schema,on-PrPublicVdfDocProcStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicVdfDocProcStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0827798e-f367-db39-a3e0-d896973b4f80';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0827798e-f367-db39-a3e0-d896973b4f80',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'VDF doc process status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0827798e-f367-db39-a3e0-d896973b4f80',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Verarbeit.-status VDFDoc'
);

--changeset system:generated-update-data-AsText-PrPublicVdfDocStatus context:any labels:c-any,o-table,ot-schema,on-PrPublicVdfDocStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicVdfDocStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5edd8b31-cc19-ed39-963d-4498210c80df';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5edd8b31-cc19-ed39-963d-4498210c80df',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'VDF doc status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5edd8b31-cc19-ed39-963d-4498210c80df',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Status VDF Doc'
);

--changeset system:generated-update-data-AsText-PrPublicVdfMetaDoc context:any labels:c-any,o-table,ot-schema,on-PrPublicVdfMetaDoc,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicVdfMetaDoc
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bdb1997b-c4b5-543c-a6cd-09c529554ff1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bdb1997b-c4b5-543c-a6cd-09c529554ff1',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'VDF Meta data doc'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bdb1997b-c4b5-543c-a6cd-09c529554ff1',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Metadaten VDF Doc'
);

--changeset system:generated-update-data-AsText-PrPublicVdfMetaSeg context:any labels:c-any,o-table,ot-schema,on-PrPublicVdfMetaSeg,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicVdfMetaSeg
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1c0bf780-f256-2739-9510-90e702e6d1b2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1c0bf780-f256-2739-9510-90e702e6d1b2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'VDF Meta data segment'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1c0bf780-f256-2739-9510-90e702e6d1b2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Metadaten VDF Segment'
);

--changeset system:generated-update-data-AsText-PrPublicVdfTextUpdate context:any labels:c-any,o-table,ot-schema,on-PrPublicVdfTextUpdate,fin-13659 runOnChange:true
--comment: Generate AsText for PrPublicVdfTextUpdate
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3ec818d4-6f44-ee30-b9d7-dd0442ee1292';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3ec818d4-6f44-ee30-b9d7-dd0442ee1292',
    1,
    'MdTableDataDef',
    NULL,
    N'VDF-Data -> PrPublicText',
    N'VDF-Data -> PrPublicText'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3ec818d4-6f44-ee30-b9d7-dd0442ee1292',
    2,
    'MdTableDataDef',
    NULL,
    N'VDF-Data -> PrPublicText',
    N'VDF-Data -> PrPublicText'
);

--changeset system:generated-update-data-AsText-PrRegion context:any labels:c-any,o-table,ot-schema,on-PrRegion,fin-13659 runOnChange:true
--comment: Generate AsText for PrRegion
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0fd1314b-3b8e-a338-a533-96aa2798e354';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0fd1314b-3b8e-a338-a533-96aa2798e354',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Region'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0fd1314b-3b8e-a338-a533-96aa2798e354',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Region'
);

--changeset system:generated-update-data-AsText-PrRoundingRule context:any labels:c-any,o-table,ot-schema,on-PrRoundingRule,fin-13659 runOnChange:true
--comment: Generate AsText for PrRoundingRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d6fd5d40-2c70-d439-8d34-3d4d70c9ffd4';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd6fd5d40-2c70-d439-8d34-3d4d70c9ffd4',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'RoundingRule'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd6fd5d40-2c70-d439-8d34-3d4d70c9ffd4',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rundungsregeln'
);

--changeset system:generated-update-data-AsText-PrRoundingType context:any labels:c-any,o-table,ot-schema,on-PrRoundingType,fin-13659 runOnChange:true
--comment: Generate AsText for PrRoundingType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='963c4dad-368e-6d38-abc7-78f17d19325a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '963c4dad-368e-6d38-abc7-78f17d19325a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rounding Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '963c4dad-368e-6d38-abc7-78f17d19325a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rundungstyp'
);

--changeset system:generated-update-data-AsText-PrSafeDepositBoxType context:any labels:c-any,o-table,ot-schema,on-PrSafeDepositBoxType,fin-13659 runOnChange:true
--comment: Generate AsText for PrSafeDepositBoxType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b25bf5ff-3772-783f-a6f4-20a0a0a37014';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b25bf5ff-3772-783f-a6f4-20a0a0a37014',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Save deposit box type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b25bf5ff-3772-783f-a6f4-20a0a0a37014',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tresorfachtyp'
);

--changeset system:generated-update-data-AsText-PrStandardPriceType context:any labels:c-any,o-table,ot-schema,on-PrStandardPriceType,fin-13659 runOnChange:true
--comment: Generate AsText for PrStandardPriceType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='82c79f84-45e2-3430-b8e0-316fad427882';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '82c79f84-45e2-3430-b8e0-316fad427882',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Standard Price Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '82c79f84-45e2-3430-b8e0-316fad427882',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Standard Preis Typ'
);

--changeset system:generated-update-data-AsText-PsAgentType context:any labels:c-any,o-table,ot-schema,on-PsAgentType,fin-13659 runOnChange:true
--comment: Generate AsText for PsAgentType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c63b0903-79d1-0634-b213-0b5a3007bb4d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c63b0903-79d1-0634-b213-0b5a3007bb4d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Printing Agent Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c63b0903-79d1-0634-b213-0b5a3007bb4d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Druckagent Typ'
);

--changeset system:generated-update-data-AsText-PsBranchLabel context:any labels:c-any,o-table,ot-schema,on-PsBranchLabel,fin-13659 runOnChange:true
--comment: Generate AsText for PsBranchLabel
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f7ec15e5-233e-0e3e-a58b-7728416b5c53';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f7ec15e5-233e-0e3e-a58b-7728416b5c53',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Branch Labels'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f7ec15e5-233e-0e3e-a58b-7728416b5c53',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Filialabhängige Texte'
);

--changeset system:generated-update-data-AsText-PsBranchLabelText context:any labels:c-any,o-table,ot-schema,on-PsBranchLabelText,fin-13659 runOnChange:true
--comment: Generate AsText for PsBranchLabelText
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='18272526-8022-793a-945c-0811f8f17cf4';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '18272526-8022-793a-945c-0811f8f17cf4',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Branch Label Text'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '18272526-8022-793a-945c-0811f8f17cf4',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Brachenabhängige Texte'
);

--changeset system:generated-update-data-AsText-PsJobStatus context:any labels:c-any,o-table,ot-schema,on-PsJobStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PsJobStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a865725a-fcea-e13a-bdda-d927cca0d98b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a865725a-fcea-e13a-bdda-d927cca0d98b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Print Job Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a865725a-fcea-e13a-bdda-d927cca0d98b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Druckauftragsstatus'
);

--changeset system:generated-update-data-AsText-PsReport context:any labels:c-any,o-table,ot-schema,on-PsReport,fin-13659 runOnChange:true
--comment: Generate AsText for PsReport
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a7f1eeb5-68ed-403b-a775-f07b28694777';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a7f1eeb5-68ed-403b-a775-f07b28694777',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Reports'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a7f1eeb5-68ed-403b-a775-f07b28694777',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Reports'
);

--changeset system:generated-update-data-AsText-PsReportGroup context:any labels:c-any,o-table,ot-schema,on-PsReportGroup,fin-13659 runOnChange:true
--comment: Generate AsText for PsReportGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c830c2c4-591f-e737-97a4-04f53a7d2e39';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c830c2c4-591f-e737-97a4-04f53a7d2e39',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Report Group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c830c2c4-591f-e737-97a4-04f53a7d2e39',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Reportgruppen'
);

--changeset system:generated-update-data-AsText-PsReportParamDataType context:any labels:c-any,o-table,ot-schema,on-PsReportParamDataType,fin-13659 runOnChange:true
--comment: Generate AsText for PsReportParamDataType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='55e876a6-18b8-f732-972e-b3f59e626405';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '55e876a6-18b8-f732-972e-b3f59e626405',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Report Param. Data Types'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '55e876a6-18b8-f732-972e-b3f59e626405',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Datentypen Reportparams'
);

--changeset system:generated-update-data-AsText-PsReportParameterType context:any labels:c-any,o-table,ot-schema,on-PsReportParameterType,fin-13659 runOnChange:true
--comment: Generate AsText for PsReportParameterType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1f9027aa-afe2-2d3d-b50f-68b1daa21e6a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1f9027aa-afe2-2d3d-b50f-68b1daa21e6a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Report parameter types'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1f9027aa-afe2-2d3d-b50f-68b1daa21e6a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Parametertypen'
);

--changeset system:generated-update-data-AsText-PsReportType context:any labels:c-any,o-table,ot-schema,on-PsReportType,fin-13659 runOnChange:true
--comment: Generate AsText for PsReportType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='31ff6616-a760-b93b-88fa-450b1c706baa';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '31ff6616-a760-b93b-88fa-450b1c706baa',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Report Types'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '31ff6616-a760-b93b-88fa-450b1c706baa',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Reportarten'
);

--changeset system:generated-update-data-AsText-PsReportUserInput context:any labels:c-any,o-table,ot-schema,on-PsReportUserInput,fin-13659 runOnChange:true
--comment: Generate AsText for PsReportUserInput
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5267040f-b474-2b35-b202-33042805a4a4';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5267040f-b474-2b35-b202-33042805a4a4',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Report User Input'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5267040f-b474-2b35-b202-33042805a4a4',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Report Benutzereingaben'
);

--changeset system:generated-update-data-AsText-PtAccountAdjustmentPosting context:any labels:c-any,o-table,ot-schema,on-PtAccountAdjustmentPosting,fin-13659 runOnChange:true
--comment: Generate AsText for PtAccountAdjustmentPosting
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='18c96581-c3f3-2037-8973-0e1c37028fac';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '18c96581-c3f3-2037-8973-0e1c37028fac',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Account adjustm. posting'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '18c96581-c3f3-2037-8973-0e1c37028fac',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ausbuchungen (Zinsen)'
);

--changeset system:generated-update-data-AsText-PtAccountClosingType context:any labels:c-any,o-table,ot-schema,on-PtAccountClosingType,fin-13659 runOnChange:true
--comment: Generate AsText for PtAccountClosingType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='282e88d0-d0b1-ce39-b72a-e304c7b5bcba';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '282e88d0-d0b1-ce39-b72a-e304c7b5bcba',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Closing type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '282e88d0-d0b1-ce39-b72a-e304c7b5bcba',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Abschluss Art'
);

--changeset system:generated-update-data-AsText-PtAccountCreditRatingDetail context:any labels:c-any,o-table,ot-schema,on-PtAccountCreditRatingDetail,fin-13659 runOnChange:true
--comment: Generate AsText for PtAccountCreditRatingDetail
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='db07048a-76db-b23c-b026-4a22c81dcc6c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'db07048a-76db-b23c-b026-4a22c81dcc6c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Credit Rating Detail'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'db07048a-76db-b23c-b026-4a22c81dcc6c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kreditrating Detail'
);

--changeset system:generated-update-data-AsText-PtAccountDebitReminderPrice context:any labels:c-any,o-table,ot-schema,on-PtAccountDebitReminderPrice,fin-13659 runOnChange:true
--comment: Generate AsText for PtAccountDebitReminderPrice
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='55e5a23b-1aca-873f-8fc9-c0c82d1aa041';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '55e5a23b-1aca-873f-8fc9-c0c82d1aa041',
    1,
    'MdTableDataDef',
    NULL,
    N'PtAccountDebitReminderPrice',
    N'PtAccountDebitReminderPri'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '55e5a23b-1aca-873f-8fc9-c0c82d1aa041',
    2,
    'MdTableDataDef',
    NULL,
    N'PtAccountDebitReminderPrice',
    N'PtAccountDebitReminderPri'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '55e5a23b-1aca-873f-8fc9-c0c82d1aa041',
    3,
    'MdTableDataDef',
    NULL,
    N'PtAccountDebitReminderPrice',
    N'PtAccountDebitReminderPri'
);

--changeset system:generated-update-data-AsText-PtAccountNoRule context:any labels:c-any,o-table,ot-schema,on-PtAccountNoRule,fin-13659 runOnChange:true
--comment: Generate AsText for PtAccountNoRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='853e71fc-f4f7-b336-be07-9f22644b7af1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '853e71fc-f4f7-b336-be07-9f22644b7af1',
    1,
    'MdTableDataDef',
    NULL,
    N'Rules for account number',
    N'Rules for account number'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '853e71fc-f4f7-b336-be07-9f22644b7af1',
    2,
    'MdTableDataDef',
    NULL,
    N'Nummerierungsregeln',
    N'Nummerierungsregeln'
);

--changeset system:generated-update-data-AsText-PtAccountPaybackStatusType context:any labels:c-any,o-table,ot-schema,on-PtAccountPaybackStatusType,fin-13659 runOnChange:true
--comment: Generate AsText for PtAccountPaybackStatusType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='57e49b2e-c4bd-b930-b5a8-d9aaf44e7775';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '57e49b2e-c4bd-b930-b5a8-d9aaf44e7775',
    1,
    'MdTableDataDef',
    NULL,
    N'Types for the amortisation progress shown in Table PtAccountPaybackStatus',
    N'Amortisation status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '57e49b2e-c4bd-b930-b5a8-d9aaf44e7775',
    2,
    'MdTableDataDef',
    NULL,
    N'Typen für den Amortisations-Fortschritt in der Tabelle PtAccountPaybackStatus (Voll, teilweise, ....',
    N'Status Amortisation'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '57e49b2e-c4bd-b930-b5a8-d9aaf44e7775',
    3,
    'MdTableDataDef',
    NULL,
    N'Types for the amortisation progress shown in Table PtAccountPaybackStatus',
    N'Status de l''amortissement'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '57e49b2e-c4bd-b930-b5a8-d9aaf44e7775',
    4,
    'MdTableDataDef',
    NULL,
    N'Types for the amortisation progress shown in Table PtAccountPaybackStatus',
    N'Stato del ammortamento'
);

--changeset system:generated-update-data-AsText-PtAccountPaybackType context:any labels:c-any,o-table,ot-schema,on-PtAccountPaybackType,fin-13659 runOnChange:true
--comment: Generate AsText for PtAccountPaybackType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='db872c3c-c3c9-bd34-a0c9-0c4cac1d7b73';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'db872c3c-c3c9-bd34-a0c9-0c4cac1d7b73',
    1,
    'MdTableDataDef',
    NULL,
    N'Type of payback (direct, indirect, etc.)',
    N'Payback Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'db872c3c-c3c9-bd34-a0c9-0c4cac1d7b73',
    2,
    'MdTableDataDef',
    NULL,
    N'Amortisationstypen (direkt, indirekt etc.)',
    N'Amortisationstypen'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'db872c3c-c3c9-bd34-a0c9-0c4cac1d7b73',
    3,
    'MdTableDataDef',
    NULL,
    N'Types d''amortisations (direct, indirect, etc.)',
    N'Types d''amortisation'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'db872c3c-c3c9-bd34-a0c9-0c4cac1d7b73',
    4,
    'MdTableDataDef',
    NULL,
    N'Typo d''ammortamento (diretto, indiretto etc.)',
    N'Typo d''ammortamento'
);

--changeset system:generated-update-data-AsText-PtAccountPriceDevType context:any labels:c-any,o-table,ot-schema,on-PtAccountPriceDevType,fin-13659 runOnChange:true
--comment: Generate AsText for PtAccountPriceDevType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d925bbb8-c9dd-7d37-b2be-971d64d85d79';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd925bbb8-c9dd-7d37-b2be-971d64d85d79',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Deviation Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd925bbb8-c9dd-7d37-b2be-971d64d85d79',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Preisabweichungsgründe'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd925bbb8-c9dd-7d37-b2be-971d64d85d79',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Raison déviation de prix'
);

--changeset system:generated-update-data-AsText-PtAccountSelectionType context:any labels:c-any,o-table,ot-schema,on-PtAccountSelectionType,fin-13659 runOnChange:true
--comment: Generate AsText for PtAccountSelectionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='169206b2-78d9-e836-bb6e-4821d793021f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '169206b2-78d9-e836-bb6e-4821d793021f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Selection-Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '169206b2-78d9-e836-bb6e-4821d793021f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Selektions-Typ'
);

--changeset system:generated-update-data-AsText-PtAccountUsagePurpose context:any labels:c-any,o-table,ot-schema,on-PtAccountUsagePurpose,fin-13659 runOnChange:true
--comment: Generate AsText for PtAccountUsagePurpose
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b5eb8439-ac71-ab3f-9ad5-429735841792';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b5eb8439-ac71-ab3f-9ad5-429735841792',
    1,
    'MdTableDataDef',
    NULL,
    N'PtAccountUsagePurpose',
    N'PtAccountUsagePurpose'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b5eb8439-ac71-ab3f-9ad5-429735841792',
    2,
    'MdTableDataDef',
    NULL,
    N'PtAccountUsagePurpose',
    N'PtAccountUsagePurpose'
);

--changeset system:generated-update-data-AsText-PtAddressSalutations context:any labels:c-any,o-table,ot-schema,on-PtAddressSalutations,fin-13659 runOnChange:true
--comment: Generate AsText for PtAddressSalutations
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3c923bc8-a6a4-2b35-858b-3c546f34d9d9';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3c923bc8-a6a4-2b35-858b-3c546f34d9d9',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Address salutations'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3c923bc8-a6a4-2b35-858b-3c546f34d9d9',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Anrede Adresse'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3c923bc8-a6a4-2b35-858b-3c546f34d9d9',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Adress salutations'
);

--changeset system:generated-update-data-AsText-PtAddressType context:any labels:c-any,o-table,ot-schema,on-PtAddressType,fin-13659 runOnChange:true
--comment: Generate AsText for PtAddressType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='78a38c1d-cb50-f132-abe6-8e83fd6d29f4';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '78a38c1d-cb50-f132-abe6-8e83fd6d29f4',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Address Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '78a38c1d-cb50-f132-abe6-8e83fd6d29f4',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Address Typ'
);

--changeset system:generated-update-data-AsText-PtAdmChargeAssetRange context:any labels:c-any,o-table,ot-schema,on-PtAdmChargeAssetRange,fin-13659 runOnChange:true
--comment: Generate AsText for PtAdmChargeAssetRange
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a42beadc-5822-dd35-8788-2a1b46f06d26';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a42beadc-5822-dd35-8788-2a1b46f06d26',
    1,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeAssetRange',
    N'PtAdmChargeAssetRange'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a42beadc-5822-dd35-8788-2a1b46f06d26',
    2,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeAssetRange',
    N'PtAdmChargeAssetRange'
);

--changeset system:generated-update-data-AsText-PtAdmChargeBase context:any labels:c-any,o-table,ot-schema,on-PtAdmChargeBase,fin-13659 runOnChange:true
--comment: Generate AsText for PtAdmChargeBase
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c0bba23b-55a2-673d-be3e-01f96e9876e7';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c0bba23b-55a2-673d-be3e-01f96e9876e7',
    1,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeBase',
    N'PtAdmChargeBase'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c0bba23b-55a2-673d-be3e-01f96e9876e7',
    2,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeBase',
    N'PtAdmChargeBase'
);

--changeset system:generated-update-data-AsText-PtAdmChargeCurrencyType context:any labels:c-any,o-table,ot-schema,on-PtAdmChargeCurrencyType,fin-13659 runOnChange:true
--comment: Generate AsText for PtAdmChargeCurrencyType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2ecf5ccd-22c9-3e3d-9e0f-9b543a77a58c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2ecf5ccd-22c9-3e3d-9e0f-9b543a77a58c',
    1,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeCurrencyType',
    N'PtAdmChargeCurrencyType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2ecf5ccd-22c9-3e3d-9e0f-9b543a77a58c',
    2,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeCurrencyType',
    N'PtAdmChargeCurrencyType'
);

--changeset system:generated-update-data-AsText-PtAdmChargeDebitAccountRule context:any labels:c-any,o-table,ot-schema,on-PtAdmChargeDebitAccountRule,fin-13659 runOnChange:true
--comment: Generate AsText for PtAdmChargeDebitAccountRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='edc21676-27cf-3835-a303-7fac84b1e48c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'edc21676-27cf-3835-a303-7fac84b1e48c',
    1,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeDebitAccountRule',
    N'PtAdmChargeDebitAccountRu'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'edc21676-27cf-3835-a303-7fac84b1e48c',
    2,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeDebitAccountRule',
    N'PtAdmChargeDebitAccountRu'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'edc21676-27cf-3835-a303-7fac84b1e48c',
    3,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeDebitAccountRule',
    N'PtAdmChargeDebitAccountRu'
);

--changeset system:generated-update-data-AsText-PtAdmChargeDPSTType context:any labels:c-any,o-table,ot-schema,on-PtAdmChargeDPSTType,fin-13659 runOnChange:true
--comment: Generate AsText for PtAdmChargeDPSTType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7773f5ba-02bc-8932-b5f7-ad60c6f7f9af';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7773f5ba-02bc-8932-b5f7-ad60c6f7f9af',
    1,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeDPSTType',
    N'PtAdmChargeDPSTType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7773f5ba-02bc-8932-b5f7-ad60c6f7f9af',
    2,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeDPSTType',
    N'PtAdmChargeDPSTType'
);

--changeset system:generated-update-data-AsText-PtAdmChargeExtraGroup context:any labels:c-any,o-table,ot-schema,on-PtAdmChargeExtraGroup,fin-13659 runOnChange:true
--comment: Generate AsText for PtAdmChargeExtraGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='84b8956a-ede2-a13d-a8ac-e0258f6f4f80';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '84b8956a-ede2-a13d-a8ac-e0258f6f4f80',
    1,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeExtraGroup',
    N'PtAdmChargeExtraGroup'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '84b8956a-ede2-a13d-a8ac-e0258f6f4f80',
    2,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeExtraGroup',
    N'PtAdmChargeExtraGroup'
);

--changeset system:generated-update-data-AsText-PtAdmChargeGroup context:any labels:c-any,o-table,ot-schema,on-PtAdmChargeGroup,fin-13659 runOnChange:true
--comment: Generate AsText for PtAdmChargeGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2c4664c6-4aca-393b-bb5e-d31cc98b67ae';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2c4664c6-4aca-393b-bb5e-d31cc98b67ae',
    1,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeGroup',
    N'PtAdmChargeGroup'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2c4664c6-4aca-393b-bb5e-d31cc98b67ae',
    2,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeGroup',
    N'PtAdmChargeGroup'
);

--changeset system:generated-update-data-AsText-PtAdmChargeMetalType context:any labels:c-any,o-table,ot-schema,on-PtAdmChargeMetalType,fin-13659 runOnChange:true
--comment: Generate AsText for PtAdmChargeMetalType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='883bcc8e-abc3-ed36-9dd2-ebb3cd198ace';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '883bcc8e-abc3-ed36-9dd2-ebb3cd198ace',
    1,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeMetalType',
    N'PtAdmChargeMetalType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '883bcc8e-abc3-ed36-9dd2-ebb3cd198ace',
    2,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeMetalType',
    N'PtAdmChargeMetalType'
);

--changeset system:generated-update-data-AsText-PtAdmChargeSubType context:any labels:c-any,o-table,ot-schema,on-PtAdmChargeSubType,fin-13659 runOnChange:true
--comment: Generate AsText for PtAdmChargeSubType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='68df27d1-2087-803c-b785-60d67ec8c4e3';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '68df27d1-2087-803c-b785-60d67ec8c4e3',
    1,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeSubType',
    N'PtAdmChargeSubType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '68df27d1-2087-803c-b785-60d67ec8c4e3',
    2,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeSubType',
    N'PtAdmChargeSubType'
);

--changeset system:generated-update-data-AsText-PtAdmChargeTaxReport context:any labels:c-any,o-table,ot-schema,on-PtAdmChargeTaxReport,fin-13659 runOnChange:true
--comment: Generate AsText for PtAdmChargeTaxReport
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9fa2e231-5c1c-863f-8e31-047adab086fa';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9fa2e231-5c1c-863f-8e31-047adab086fa',
    1,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeTaxReport',
    N'PtAdmChargeTaxReport'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9fa2e231-5c1c-863f-8e31-047adab086fa',
    2,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeTaxReport',
    N'PtAdmChargeTaxReport'
);

--changeset system:generated-update-data-AsText-PtAdmChargeTitleType context:any labels:c-any,o-table,ot-schema,on-PtAdmChargeTitleType,fin-13659 runOnChange:true
--comment: Generate AsText for PtAdmChargeTitleType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='24d98ae8-a6c6-693d-b633-deb98a0594fe';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '24d98ae8-a6c6-693d-b633-deb98a0594fe',
    1,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeTitleType',
    N'PtAdmChargeTitleType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '24d98ae8-a6c6-693d-b633-deb98a0594fe',
    2,
    'MdTableDataDef',
    NULL,
    N'PtAdmChargeTitleType',
    N'PtAdmChargeTitleType'
);

--changeset system:generated-update-data-AsText-PtAdviceType context:any labels:c-any,o-table,ot-schema,on-PtAdviceType,fin-13659 runOnChange:true
--comment: Generate AsText for PtAdviceType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b4b9e11e-aebf-b937-87f3-5d9014627a76';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b4b9e11e-aebf-b937-87f3-5d9014627a76',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'advice type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b4b9e11e-aebf-b937-87f3-5d9014627a76',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Anzeigeart'
);

--changeset system:generated-update-data-AsText-PtAgrAnnouncement context:any labels:c-any,o-table,ot-schema,on-PtAgrAnnouncement,fin-13659 runOnChange:true
--comment: Generate AsText for PtAgrAnnouncement
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0f0c8da8-5251-a83b-8082-b66cf3c5442c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0f0c8da8-5251-a83b-8082-b66cf3c5442c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'E-Banking event'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0f0c8da8-5251-a83b-8082-b66cf3c5442c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'E-Banking Ereignis'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0f0c8da8-5251-a83b-8082-b66cf3c5442c',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Événement e-banking'
);

--changeset system:generated-update-data-AsText-PtAgrCardExecutionStatus context:any labels:c-any,o-table,ot-schema,on-PtAgrCardExecutionStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtAgrCardExecutionStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='22606238-714c-7839-ad95-a6efcc52b7d2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '22606238-714c-7839-ad95-a6efcc52b7d2',
    1,
    'MdTableDataDef',
    NULL,
    N'Card Execution Status',
    N'Card Execution Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '22606238-714c-7839-ad95-a6efcc52b7d2',
    2,
    'MdTableDataDef',
    NULL,
    N'Card Execution Status',
    N'Card Execution Status'
);

--changeset system:generated-update-data-AsText-PtAgrCardExecutionType context:any labels:c-any,o-table,ot-schema,on-PtAgrCardExecutionType,fin-13659 runOnChange:true
--comment: Generate AsText for PtAgrCardExecutionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='62e52895-45f0-3232-9a84-7914b3ce1760';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '62e52895-45f0-3232-9a84-7914b3ce1760',
    1,
    'MdTableDataDef',
    NULL,
    N'Card Execution Type',
    N'Card Execution Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '62e52895-45f0-3232-9a84-7914b3ce1760',
    2,
    'MdTableDataDef',
    NULL,
    N'Card Execution Type',
    N'Card Execution Type'
);

--changeset system:generated-update-data-AsText-PtAgrGenContrIndPaybackType context:any labels:c-any,o-table,ot-schema,on-PtAgrGenContrIndPaybackType,fin-13659 runOnChange:true
--comment: Generate AsText for PtAgrGenContrIndPaybackType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3e4b8c3e-c297-5a3e-bc26-77857a0c1f09';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3e4b8c3e-c297-5a3e-bc26-77857a0c1f09',
    1,
    'MdTableDataDef',
    NULL,
    N'Payback - AutoText',
    N'Payback - AutoText'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3e4b8c3e-c297-5a3e-bc26-77857a0c1f09',
    2,
    'MdTableDataDef',
    NULL,
    N'Payback - AutoText',
    N'Payback - AutoText'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3e4b8c3e-c297-5a3e-bc26-77857a0c1f09',
    3,
    'MdTableDataDef',
    NULL,
    N'Payback - AutoText',
    N'Payback - AutoText'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3e4b8c3e-c297-5a3e-bc26-77857a0c1f09',
    4,
    'MdTableDataDef',
    NULL,
    N'Payback - AutoText',
    N'Payback - AutoText'
);

--changeset system:generated-update-data-AsText-PtAgrGeneralContrTemplNames context:any labels:c-any,o-table,ot-schema,on-PtAgrGeneralContrTemplNames,fin-13659 runOnChange:true
--comment: Generate AsText for PtAgrGeneralContrTemplNames
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f9054ed5-c6e0-1f32-9aa8-25ecf95008a5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f9054ed5-c6e0-1f32-9aa8-25ecf95008a5',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Typ of Gen.Contr.Template'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f9054ed5-c6e0-1f32-9aa8-25ecf95008a5',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Vertragsvorlagentypen'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f9054ed5-c6e0-1f32-9aa8-25ecf95008a5',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Types de modèles de contr'
);

--changeset system:generated-update-data-AsText-PtAgrGeneralContrUsageType context:any labels:c-any,o-table,ot-schema,on-PtAgrGeneralContrUsageType,fin-13659 runOnChange:true
--comment: Generate AsText for PtAgrGeneralContrUsageType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='36a2ec4e-3a6f-3838-a2a9-a2126d99826c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '36a2ec4e-3a6f-3838-a2a9-a2126d99826c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gen.Contr. Usage types'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '36a2ec4e-3a6f-3838-a2a9-a2126d99826c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Verwendungsarten'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '36a2ec4e-3a6f-3838-a2a9-a2126d99826c',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Types d''utilisation'
);

--changeset system:generated-update-data-AsText-PtAgrTaxStatus context:any labels:c-any,o-table,ot-schema,on-PtAgrTaxStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtAgrTaxStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8b74b3e8-97ab-da35-9e8f-1b900733fae8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8b74b3e8-97ab-da35-9e8f-1b900733fae8',
    1,
    'MdTableDataDef',
    NULL,
    N'Waiver Status',
    N'Waiver Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8b74b3e8-97ab-da35-9e8f-1b900733fae8',
    2,
    'MdTableDataDef',
    NULL,
    N'Waiver Status',
    N'Waiver Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8b74b3e8-97ab-da35-9e8f-1b900733fae8',
    3,
    'MdTableDataDef',
    NULL,
    N'Waiver Status',
    N'Waiver Status'
);

--changeset system:generated-update-data-AsText-PtAgrTermsAndConditions context:any labels:c-any,o-table,ot-schema,on-PtAgrTermsAndConditions,fin-13659 runOnChange:true
--comment: Generate AsText for PtAgrTermsAndConditions
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6bc78161-6521-1232-9d2d-85e3483d3cbe';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6bc78161-6521-1232-9d2d-85e3483d3cbe',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Term and condition'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6bc78161-6521-1232-9d2d-85e3483d3cbe',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Nutzungsvereinbahrung'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6bc78161-6521-1232-9d2d-85e3483d3cbe',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'conditions générales'
);

--changeset system:generated-update-data-AsText-PtAssetDepotType context:any labels:c-any,o-table,ot-schema,on-PtAssetDepotType,fin-13659 runOnChange:true
--comment: Generate AsText for PtAssetDepotType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='04ddb2f9-3626-a83a-bc9b-12650d65eb77';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '04ddb2f9-3626-a83a-bc9b-12650d65eb77',
    1,
    'MdTableDataDef',
    NULL,
    N'PtAssetDepotType',
    N'PtAssetDepotType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '04ddb2f9-3626-a83a-bc9b-12650d65eb77',
    2,
    'MdTableDataDef',
    NULL,
    N'PtAssetDepotType',
    N'PtAssetDepotType'
);

--changeset system:generated-update-data-AsText-PtAssetStrategy context:any labels:c-any,o-table,ot-schema,on-PtAssetStrategy,fin-13659 runOnChange:true
--comment: Generate AsText for PtAssetStrategy
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='74bcf60f-1a66-9d35-86f9-08f274adaecc';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '74bcf60f-1a66-9d35-86f9-08f274adaecc',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Asset Strategy'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '74bcf60f-1a66-9d35-86f9-08f274adaecc',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Anlagestrategie'
);

--changeset system:generated-update-data-AsText-PtBaaSPartnerClient context:any labels:c-any,o-table,ot-schema,on-PtBaaSPartnerClient,fin-13659 runOnChange:true
--comment: Generate AsText for PtBaaSPartnerClient
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='35c068d5-c4dc-233b-a8b1-a77c6686e212';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '35c068d5-c4dc-233b-a8b1-a77c6686e212',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'BaaS Partner Client'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '35c068d5-c4dc-233b-a8b1-a77c6686e212',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'BaaS Partner Client'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '35c068d5-c4dc-233b-a8b1-a77c6686e212',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'BaaS Partenaire Client'
);

--changeset system:generated-update-data-AsText-PtBenchmark context:any labels:c-any,o-table,ot-schema,on-PtBenchmark,fin-13659 runOnChange:true
--comment: Generate AsText for PtBenchmark
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='68d7e059-1373-5634-bfda-065ca69b30bf';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '68d7e059-1373-5634-bfda-065ca69b30bf',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Benchmark'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '68d7e059-1373-5634-bfda-065ca69b30bf',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Benchmark'
);

--changeset system:generated-update-data-AsText-PtBillConsolidator context:any labels:c-any,o-table,ot-schema,on-PtBillConsolidator,fin-13659 runOnChange:true
--comment: Generate AsText for PtBillConsolidator
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='88ec58dc-5be0-4d34-ac7b-b892eab8695d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '88ec58dc-5be0-4d34-ac7b-b892eab8695d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'EBPP Consolidator'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '88ec58dc-5be0-4d34-ac7b-b892eab8695d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'EBPP Consolidator'
);

--changeset system:generated-update-data-AsText-PtBillPresentationStatus context:any labels:c-any,o-table,ot-schema,on-PtBillPresentationStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtBillPresentationStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5e37de18-c21d-4032-90cf-b5625c056337';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5e37de18-c21d-4032-90cf-b5625c056337',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'BillPresentationStatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5e37de18-c21d-4032-90cf-b5625c056337',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rechnungsstatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5e37de18-c21d-4032-90cf-b5625c056337',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'PtBillPresentationStatus'
);

--changeset system:generated-update-data-AsText-PtBlockReason context:any labels:c-any,o-table,ot-schema,on-PtBlockReason,fin-13659 runOnChange:true
--comment: Generate AsText for PtBlockReason
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='62c78e89-1274-2530-b7b7-dce36f566420';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '62c78e89-1274-2530-b7b7-dce36f566420',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'cause of blocking'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '62c78e89-1274-2530-b7b7-dce36f566420',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Blockierungsgründe'
);

--changeset system:generated-update-data-AsText-PtBookingSide context:any labels:c-any,o-table,ot-schema,on-PtBookingSide,fin-13659 runOnChange:true
--comment: Generate AsText for PtBookingSide
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='12f11d0d-0296-7437-8ba8-7ee49882036c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '12f11d0d-0296-7437-8ba8-7ee49882036c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Booking side'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '12f11d0d-0296-7437-8ba8-7ee49882036c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Buchungsseite'
);

--changeset system:generated-update-data-AsText-PtBuildingLoanCheckGroup context:any labels:c-any,o-table,ot-schema,on-PtBuildingLoanCheckGroup,fin-13659 runOnChange:true
--comment: Generate AsText for PtBuildingLoanCheckGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ce40c9e3-fb16-5337-b911-eee0549f7704';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ce40c9e3-fb16-5337-b911-eee0549f7704',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Building Loan Costs'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ce40c9e3-fb16-5337-b911-eee0549f7704',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kostenvoranschlagsgruppen'
);

--changeset system:generated-update-data-AsText-PtBuildingLoanCheckGroupLabel context:any labels:c-any,o-table,ot-schema,on-PtBuildingLoanCheckGroupLabel,fin-13659 runOnChange:true
--comment: Generate AsText for PtBuildingLoanCheckGroupLabel
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6127a616-68ef-3b3e-9ea4-0e4d3e36c85b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6127a616-68ef-3b3e-9ea4-0e4d3e36c85b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Building Loan Label'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6127a616-68ef-3b3e-9ea4-0e4d3e36c85b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gruppe Baukreditkontrolle'
);

--changeset system:generated-update-data-AsText-PtBusinessSegment context:any labels:c-any,o-table,ot-schema,on-PtBusinessSegment,fin-13659 runOnChange:true
--comment: Generate AsText for PtBusinessSegment
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ded4b86f-7740-5b3e-bbfc-42abcc596c6f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ded4b86f-7740-5b3e-bbfc-42abcc596c6f',
    1,
    'MdTableDataDef',
    NULL,
    N'Business Segment',
    N'Business Segment'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ded4b86f-7740-5b3e-bbfc-42abcc596c6f',
    2,
    'MdTableDataDef',
    NULL,
    N'Business Segment',
    N'Business Segment'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ded4b86f-7740-5b3e-bbfc-42abcc596c6f',
    3,
    'MdTableDataDef',
    NULL,
    N'Business Segment',
    N'Business Segment'
);

--changeset system:generated-update-data-AsText-PtCardChipType context:any labels:c-any,o-table,ot-schema,on-PtCardChipType,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardChipType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2f10de16-439d-3c34-b694-9ee2f51b3321';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2f10de16-439d-3c34-b694-9ee2f51b3321',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'chip type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2f10de16-439d-3c34-b694-9ee2f51b3321',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Chiptyp'
);

--changeset system:generated-update-data-AsText-PtCardDebitOnlineResponseCode context:any labels:c-any,o-table,ot-schema,on-PtCardDebitOnlineResponseCode,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardDebitOnlineResponseCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='983f3613-5fa0-af39-8b13-51fdfee93ebd';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '983f3613-5fa0-af39-8b13-51fdfee93ebd',
    1,
    'MdTableDataDef',
    NULL,
    N'Response Code',
    N'Response Code'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '983f3613-5fa0-af39-8b13-51fdfee93ebd',
    2,
    'MdTableDataDef',
    NULL,
    N'Antwortcode',
    N'Antwortcode'
);

--changeset system:generated-update-data-AsText-PtCardEMVProfile context:any labels:c-any,o-table,ot-schema,on-PtCardEMVProfile,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardEMVProfile
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bfdbcca3-a03e-1d37-ba49-ebcd97c4379c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bfdbcca3-a03e-1d37-ba49-ebcd97c4379c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'EMV profile id'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bfdbcca3-a03e-1d37-ba49-ebcd97c4379c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'EMV Profil Id'
);

--changeset system:generated-update-data-AsText-PtCardExpress context:any labels:c-any,o-table,ot-schema,on-PtCardExpress,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardExpress
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ee75a738-a0b8-1235-bde4-9d44a742abb8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ee75a738-a0b8-1235-bde4-9d44a742abb8',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'expess code'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ee75a738-a0b8-1235-bde4-9d44a742abb8',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Expresscode'
);

--changeset system:generated-update-data-AsText-PtCardLanguage context:any labels:c-any,o-table,ot-schema,on-PtCardLanguage,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardLanguage
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d13de3c8-45e2-9f30-94ca-2686156e7a73';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd13de3c8-45e2-9f30-94ca-2686156e7a73',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'cash box langauge'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd13de3c8-45e2-9f30-94ca-2686156e7a73',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Sprache Benutzerführung'
);

--changeset system:generated-update-data-AsText-PtCardLimitType context:any labels:c-any,o-table,ot-schema,on-PtCardLimitType,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardLimitType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='52c1bdd6-dae0-ae3d-9011-613a48c17bbb';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '52c1bdd6-dae0-ae3d-9011-613a48c17bbb',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Card limit type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '52c1bdd6-dae0-ae3d-9011-613a48c17bbb',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Limitentyp Karte'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '52c1bdd6-dae0-ae3d-9011-613a48c17bbb',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type de limite de carte'
);

--changeset system:generated-update-data-AsText-PtCardLockStatus context:any labels:c-any,o-table,ot-schema,on-PtCardLockStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardLockStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5f7fa645-dc77-473e-907c-9a438b155950';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5f7fa645-dc77-473e-907c-9a438b155950',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Lock status of a card'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5f7fa645-dc77-473e-907c-9a438b155950',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Sperrcode einer Karte'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5f7fa645-dc77-473e-907c-9a438b155950',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Statut de verrouillage'
);

--changeset system:generated-update-data-AsText-PtCardMail context:any labels:c-any,o-table,ot-schema,on-PtCardMail,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardMail
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e4ea35dc-c176-f23f-a075-9967d630398c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e4ea35dc-c176-f23f-a075-9967d630398c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'mail code'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e4ea35dc-c176-f23f-a075-9967d630398c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Versandcode'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e4ea35dc-c176-f23f-a075-9967d630398c',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Code de livraison'
);

--changeset system:generated-update-data-AsText-PtCardOtrcOrderType context:any labels:c-any,o-table,ot-schema,on-PtCardOtrcOrderType,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardOtrcOrderType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a9f363f7-0cc6-1039-83e2-5dd2f1b08275';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a9f363f7-0cc6-1039-83e2-5dd2f1b08275',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Otrc Order Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a9f363f7-0cc6-1039-83e2-5dd2f1b08275',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Otrc-Auftragstyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a9f363f7-0cc6-1039-83e2-5dd2f1b08275',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Otrc type de commande'
);

--changeset system:generated-update-data-AsText-PtCardProducer context:any labels:c-any,o-table,ot-schema,on-PtCardProducer,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardProducer
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='dfa9fdab-c0ca-c739-b251-4821a02ccd82';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'dfa9fdab-c0ca-c739-b251-4821a02ccd82',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Card producer'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'dfa9fdab-c0ca-c739-b251-4821a02ccd82',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kartenproduzent'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'dfa9fdab-c0ca-c739-b251-4821a02ccd82',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Producteur de cartes'
);

--changeset system:generated-update-data-AsText-PtCardRohling context:any labels:c-any,o-table,ot-schema,on-PtCardRohling,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardRohling
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='54878b3e-a71e-ad3c-b46f-1d788faf61fc';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '54878b3e-a71e-ad3c-b46f-1d788faf61fc',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Templates for Cards'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '54878b3e-a71e-ad3c-b46f-1d788faf61fc',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rohling-Typen'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '54878b3e-a71e-ad3c-b46f-1d788faf61fc',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Types vierges'
);

--changeset system:generated-update-data-AsText-PtCardServiceScope context:any labels:c-any,o-table,ot-schema,on-PtCardServiceScope,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardServiceScope
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9213f9d3-b7a8-873d-a7eb-c2a6758b4d0f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9213f9d3-b7a8-873d-a7eb-c2a6758b4d0f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'service scope'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9213f9d3-b7a8-873d-a7eb-c2a6758b4d0f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Service Bereich'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9213f9d3-b7a8-873d-a7eb-c2a6758b4d0f',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zone de service'
);

--changeset system:generated-update-data-AsText-PtCardServiceType context:any labels:c-any,o-table,ot-schema,on-PtCardServiceType,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardServiceType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='13a3adad-9307-1036-9a91-f104262e280d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '13a3adad-9307-1036-9a91-f104262e280d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'bank specific service typ'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '13a3adad-9307-1036-9a91-f104262e280d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'bankspez. Service Typ'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '13a3adad-9307-1036-9a91-f104262e280d',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'type de service spécifiqu'
);

--changeset system:generated-update-data-AsText-PtCardStatus context:any labels:c-any,o-table,ot-schema,on-PtCardStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9de998e5-ab04-ff30-b183-7fc9f4ed028b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9de998e5-ab04-ff30-b183-7fc9f4ed028b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'card status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9de998e5-ab04-ff30-b183-7fc9f4ed028b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kartenstatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9de998e5-ab04-ff30-b183-7fc9f4ed028b',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Statut de la carte'
);

--changeset system:generated-update-data-AsText-PtCardTransactionType context:any labels:c-any,o-table,ot-schema,on-PtCardTransactionType,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardTransactionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4cc18be2-c5da-323e-a8cd-77086b341096';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4cc18be2-c5da-323e-a8cd-77086b341096',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'status card order process'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4cc18be2-c5da-323e-a8cd-77086b341096',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Status Kartenbestellung'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4cc18be2-c5da-323e-a8cd-77086b341096',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Statut de la commande'
);

--changeset system:generated-update-data-AsText-PtCardTrxAuthMessageType context:any labels:c-any,o-table,ot-schema,on-PtCardTrxAuthMessageType,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardTrxAuthMessageType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='62d7ea60-c326-e939-9e14-e4bd932545af';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '62d7ea60-c326-e939-9e14-e4bd932545af',
    1,
    'MdTableDataDef',
    NULL,
    N'Message Type',
    N'Message Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '62d7ea60-c326-e939-9e14-e4bd932545af',
    2,
    'MdTableDataDef',
    NULL,
    N'Meldungstyp',
    N'Meldungstyp'
);

--changeset system:generated-update-data-AsText-PtCardTrxAuthProcessingCode context:any labels:c-any,o-table,ot-schema,on-PtCardTrxAuthProcessingCode,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardTrxAuthProcessingCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ef315357-1e13-fc30-ae50-f8c116f95474';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ef315357-1e13-fc30-ae50-f8c116f95474',
    1,
    'MdTableDataDef',
    NULL,
    N'Processing Code',
    N'Processing Code'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ef315357-1e13-fc30-ae50-f8c116f95474',
    2,
    'MdTableDataDef',
    NULL,
    N'Processing Code',
    N'Processing Code'
);

--changeset system:generated-update-data-AsText-PtCardTrxAuthProcessingCodeTyp context:any labels:c-any,o-table,ot-schema,on-PtCardTrxAuthProcessingCodeTyp,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardTrxAuthProcessingCodeTyp
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5f4af40d-3839-2d34-88cf-95dc8e163e53';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5f4af40d-3839-2d34-88cf-95dc8e163e53',
    1,
    'MdTableDataDef',
    NULL,
    N'Processing Code Type',
    N'Processing Code Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5f4af40d-3839-2d34-88cf-95dc8e163e53',
    2,
    'MdTableDataDef',
    NULL,
    N'Processing Code Type',
    N'Processing Code Type'
);

--changeset system:generated-update-data-AsText-PtCardTrxAuthResponseCode context:any labels:c-any,o-table,ot-schema,on-PtCardTrxAuthResponseCode,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardTrxAuthResponseCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a4fd803e-fbc8-fd34-b0d1-5c844743411b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a4fd803e-fbc8-fd34-b0d1-5c844743411b',
    1,
    'MdTableDataDef',
    NULL,
    N'Response Code',
    N'Response Code'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a4fd803e-fbc8-fd34-b0d1-5c844743411b',
    2,
    'MdTableDataDef',
    NULL,
    N'Antwortcode',
    N'Antwortcode'
);

--changeset system:generated-update-data-AsText-PtCardType context:any labels:c-any,o-table,ot-schema,on-PtCardType,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='30f95e0c-b666-ce32-a0c2-cb63c8a13861';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '30f95e0c-b666-ce32-a0c2-cb63c8a13861',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Card Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '30f95e0c-b666-ce32-a0c2-cb63c8a13861',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kartentyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '30f95e0c-b666-ce32-a0c2-cb63c8a13861',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type de carte'
);

--changeset system:generated-update-data-AsText-PtCardTypeProcessorType context:any labels:c-any,o-table,ot-schema,on-PtCardTypeProcessorType,fin-13659 runOnChange:true
--comment: Generate AsText for PtCardTypeProcessorType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='df05e2da-95c3-d03a-aff1-56334771c399';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'df05e2da-95c3-d03a-aff1-56334771c399',
    1,
    'MdTableDataDef',
    NULL,
    N'Card type processor',
    N'Card type processor'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'df05e2da-95c3-d03a-aff1-56334771c399',
    2,
    'MdTableDataDef',
    NULL,
    N'Kartentyp Prozessor',
    N'Kartentyp Prozessor'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'df05e2da-95c3-d03a-aff1-56334771c399',
    3,
    'MdTableDataDef',
    NULL,
    N'Processeur de type carte',
    N'Processeur de type carte'
);

--changeset system:generated-update-data-AsText-PtCashTransListType context:any labels:c-any,o-table,ot-schema,on-PtCashTransListType,fin-13659 runOnChange:true
--comment: Generate AsText for PtCashTransListType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b90181f7-9179-953c-be74-535d244e737e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b90181f7-9179-953c-be74-535d244e737e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Cash Transtype'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b90181f7-9179-953c-be74-535d244e737e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kassageschäfte Typ'
);

--changeset system:generated-update-data-AsText-PtCheckMatchCategory context:any labels:c-any,o-table,ot-schema,on-PtCheckMatchCategory,fin-13659 runOnChange:true
--comment: Generate AsText for PtCheckMatchCategory
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f793c9fc-ffe3-ac31-bfbe-6cbcb9802203';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f793c9fc-ffe3-ac31-bfbe-6cbcb9802203',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Check Match Category'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f793c9fc-ffe3-ac31-bfbe-6cbcb9802203',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Checkergebnis-Kategorie'
);

--changeset system:generated-update-data-AsText-PtCheckVerificationType context:any labels:c-any,o-table,ot-schema,on-PtCheckVerificationType,fin-13659 runOnChange:true
--comment: Generate AsText for PtCheckVerificationType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ff3e38ef-4f8c-9835-92b6-03f35e1c83a1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ff3e38ef-4f8c-9835-92b6-03f35e1c83a1',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Check Verification Types'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ff3e38ef-4f8c-9835-92b6-03f35e1c83a1',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Prüfergebnisarten'
);

--changeset system:generated-update-data-AsText-PtCollectPartnerDataProcess context:any labels:c-any,o-table,ot-schema,on-PtCollectPartnerDataProcess,fin-13659 runOnChange:true
--comment: Generate AsText for PtCollectPartnerDataProcess
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='37f141d5-e4fb-e736-a3c7-26ff2e592e53';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '37f141d5-e4fb-e736-a3c7-26ff2e592e53',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Data collection processes'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '37f141d5-e4fb-e736-a3c7-26ff2e592e53',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Datensammlungsprozesse'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '37f141d5-e4fb-e736-a3c7-26ff2e592e53',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Proc.de collecte des donn'
);

--changeset system:generated-update-data-AsText-PtCommissionType context:any labels:c-any,o-table,ot-schema,on-PtCommissionType,fin-13659 runOnChange:true
--comment: Generate AsText for PtCommissionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d5e57fc8-49a9-f030-84c8-634ae842ce9e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd5e57fc8-49a9-f030-84c8-634ae842ce9e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Commissiontype'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd5e57fc8-49a9-f030-84c8-634ae842ce9e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Spesenart'
);

--changeset system:generated-update-data-AsText-PtConfession context:any labels:c-any,o-table,ot-schema,on-PtConfession,fin-13659 runOnChange:true
--comment: Generate AsText for PtConfession
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='39dd932b-7f3c-3734-b19e-ef71410f6765';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '39dd932b-7f3c-3734-b19e-ef71410f6765',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Confession'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '39dd932b-7f3c-3734-b19e-ef71410f6765',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Konfession'
);

--changeset system:generated-update-data-AsText-PtConsCreditForwardType context:any labels:c-any,o-table,ot-schema,on-PtConsCreditForwardType,fin-13659 runOnChange:true
--comment: Generate AsText for PtConsCreditForwardType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f8d45afa-f106-ba3f-9768-b1f940883f6b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f8d45afa-f106-ba3f-9768-b1f940883f6b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'cons credit forward type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f8d45afa-f106-ba3f-9768-b1f940883f6b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'KKG Meldungsweg'
);

--changeset system:generated-update-data-AsText-PtConsCreditType context:any labels:c-any,o-table,ot-schema,on-PtConsCreditType,fin-13659 runOnChange:true
--comment: Generate AsText for PtConsCreditType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e5589116-c042-8a3b-8ce0-8fe7c0553cdc';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e5589116-c042-8a3b-8ce0-8fe7c0553cdc',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Konsumkredittyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e5589116-c042-8a3b-8ce0-8fe7c0553cdc',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Consumer Credit Type'
);

--changeset system:generated-update-data-AsText-PtConsultantTeamRole context:any labels:c-any,o-table,ot-schema,on-PtConsultantTeamRole,fin-13659 runOnChange:true
--comment: Generate AsText for PtConsultantTeamRole
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='868266c9-28ae-863a-9104-4c524c90f663';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '868266c9-28ae-863a-9104-4c524c90f663',
    1,
    'MdTableDataDef',
    NULL,
    N'PtConsultantTeamRole',
    N'PtConsultantTeamRole'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '868266c9-28ae-863a-9104-4c524c90f663',
    2,
    'MdTableDataDef',
    NULL,
    N'PtConsultantTeamRole',
    N'PtConsultantTeamRole'
);

--changeset system:generated-update-data-AsText-PtContactPersonRole context:any labels:c-any,o-table,ot-schema,on-PtContactPersonRole,fin-13659 runOnChange:true
--comment: Generate AsText for PtContactPersonRole
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0f1962f0-260d-3630-98a8-911e3d9b3663';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0f1962f0-260d-3630-98a8-911e3d9b3663',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Contact Person Role'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0f1962f0-260d-3630-98a8-911e3d9b3663',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kontaktperson Funktion'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0f1962f0-260d-3630-98a8-911e3d9b3663',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fonction de contact'
);

--changeset system:generated-update-data-AsText-PtContactResult context:any labels:c-any,o-table,ot-schema,on-PtContactResult,fin-13659 runOnChange:true
--comment: Generate AsText for PtContactResult
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a6f466f1-f520-ba31-bbe2-1e42604e9fc2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a6f466f1-f520-ba31-bbe2-1e42604e9fc2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'achieved contact result'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a6f466f1-f520-ba31-bbe2-1e42604e9fc2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kontaktergebnis'
);

--changeset system:generated-update-data-AsText-PtContactResultReason context:any labels:c-any,o-table,ot-schema,on-PtContactResultReason,fin-13659 runOnChange:true
--comment: Generate AsText for PtContactResultReason
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='346242ca-3b3b-573d-acb9-f6bb5c13ad21';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '346242ca-3b3b-573d-acb9-f6bb5c13ad21',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Contact Result Reason'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '346242ca-3b3b-573d-acb9-f6bb5c13ad21',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kontakt Res. Begründung'
);

--changeset system:generated-update-data-AsText-PtContractLimit context:any labels:c-any,o-table,ot-schema,on-PtContractLimit,fin-13659 runOnChange:true
--comment: Generate AsText for PtContractLimit
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='90c2e2ce-e5af-5435-a8a7-9cc58abb2df3';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '90c2e2ce-e5af-5435-a8a7-9cc58abb2df3',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Contract Limit'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '90c2e2ce-e5af-5435-a8a7-9cc58abb2df3',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Contract Limit'
);

--changeset system:generated-update-data-AsText-PtContractMarketOperationType context:any labels:c-any,o-table,ot-schema,on-PtContractMarketOperationType,fin-13659 runOnChange:true
--comment: Generate AsText for PtContractMarketOperationType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='797c7ca2-6d56-1232-abb0-a01b6173e251';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '797c7ca2-6d56-1232-abb0-a01b6173e251',
    1,
    'MdTableDataDef',
    NULL,
    N'Operation Types',
    N'Operation Types'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '797c7ca2-6d56-1232-abb0-a01b6173e251',
    2,
    'MdTableDataDef',
    NULL,
    N'Operation Types',
    N'Operation Types'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '797c7ca2-6d56-1232-abb0-a01b6173e251',
    3,
    'MdTableDataDef',
    NULL,
    N'Operation Types',
    N'Operation Types'
);

--changeset system:generated-update-data-AsText-PtContractRoundingType context:any labels:c-any,o-table,ot-schema,on-PtContractRoundingType,fin-13659 runOnChange:true
--comment: Generate AsText for PtContractRoundingType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e8ac0c6e-eade-313a-90bb-f34a72397da8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e8ac0c6e-eade-313a-90bb-f34a72397da8',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Contract Rounding Types'
);

--changeset system:generated-update-data-AsText-PtContractType context:any labels:c-any,o-table,ot-schema,on-PtContractType,fin-13659 runOnChange:true
--comment: Generate AsText for PtContractType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='af9ca577-ba57-8a33-922d-a7889297d99a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'af9ca577-ba57-8a33-922d-a7889297d99a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Contract Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'af9ca577-ba57-8a33-922d-a7889297d99a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kontraktart'
);

--changeset system:generated-update-data-AsText-PtConversionStatus context:any labels:c-any,o-table,ot-schema,on-PtConversionStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtConversionStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='66f9c448-8d8a-6339-ae7c-9c15d1467766';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '66f9c448-8d8a-6339-ae7c-9c15d1467766',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Conversion status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '66f9c448-8d8a-6339-ae7c-9c15d1467766',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Umwandlungsstatus'
);

--changeset system:generated-update-data-AsText-PtCounterpartyClassType context:any labels:c-any,o-table,ot-schema,on-PtCounterpartyClassType,fin-13659 runOnChange:true
--comment: Generate AsText for PtCounterpartyClassType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b1b4e7ad-46b0-de3e-852c-e33f4ec6758a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b1b4e7ad-46b0-de3e-852c-e33f4ec6758a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Counterparty classificati'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b1b4e7ad-46b0-de3e-852c-e33f4ec6758a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gegenpartei Klassifizieru'
);

--changeset system:generated-update-data-AsText-PtCrossborderCountryRule context:any labels:c-any,o-table,ot-schema,on-PtCrossborderCountryRule,fin-13659 runOnChange:true
--comment: Generate AsText for PtCrossborderCountryRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='70c1a5ba-882c-1336-a514-a90c72714a95';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '70c1a5ba-882c-1336-a514-a90c72714a95',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Crossborder Authorisation'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '70c1a5ba-882c-1336-a514-a90c72714a95',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Cross-Border Bewilligung'
);

--changeset system:generated-update-data-AsText-PtCrossborderEbRestriction context:any labels:c-any,o-table,ot-schema,on-PtCrossborderEbRestriction,fin-13659 runOnChange:true
--comment: Generate AsText for PtCrossborderEbRestriction
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='12e8e2d4-3ec8-f935-9216-256829572d8c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '12e8e2d4-3ec8-f935-9216-256829572d8c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'CB Ebanking Restriction'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '12e8e2d4-3ec8-f935-9216-256829572d8c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'CB Ebanking Restriction'
);

--changeset system:generated-update-data-AsText-PtCurrencyStrategy context:any labels:c-any,o-table,ot-schema,on-PtCurrencyStrategy,fin-13659 runOnChange:true
--comment: Generate AsText for PtCurrencyStrategy
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bcaf7628-180a-8338-870f-6041fee1f56a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bcaf7628-180a-8338-870f-6041fee1f56a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Currency Strategy'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bcaf7628-180a-8338-870f-6041fee1f56a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Währungsstrategie'
);

--changeset system:generated-update-data-AsText-PtDebitPaymentDuePeriodType context:any labels:c-any,o-table,ot-schema,on-PtDebitPaymentDuePeriodType,fin-13659 runOnChange:true
--comment: Generate AsText for PtDebitPaymentDuePeriodType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='fd732a58-f455-743e-a6e7-008a03bca97b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fd732a58-f455-743e-a6e7-008a03bca97b',
    1,
    'MdTableDataDef',
    NULL,
    N'PtDebitPaymentDuePeriodType',
    N'PtDebitPaymentDuePeriodTy'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fd732a58-f455-743e-a6e7-008a03bca97b',
    2,
    'MdTableDataDef',
    NULL,
    N'PtDebitPaymentDuePeriodType',
    N'PtDebitPaymentDuePeriodTy'
);

--changeset system:generated-update-data-AsText-PtDebitReminderPeriodType context:any labels:c-any,o-table,ot-schema,on-PtDebitReminderPeriodType,fin-13659 runOnChange:true
--comment: Generate AsText for PtDebitReminderPeriodType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2fda5eed-2d4d-e13c-81ba-e083b2fb2878';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2fda5eed-2d4d-e13c-81ba-e083b2fb2878',
    1,
    'MdTableDataDef',
    NULL,
    N'ReminderPeriod',
    N'ReminderPeriod'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2fda5eed-2d4d-e13c-81ba-e083b2fb2878',
    2,
    'MdTableDataDef',
    NULL,
    N'ReminderPeriod',
    N'ReminderPeriod'
);

--changeset system:generated-update-data-AsText-PtDerivTransPillar context:any labels:c-any,o-table,ot-schema,on-PtDerivTransPillar,fin-13659 runOnChange:true
--comment: Generate AsText for PtDerivTransPillar
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e52bb580-4ab0-7e3d-aa47-73264adfb528';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e52bb580-4ab0-7e3d-aa47-73264adfb528',
    1,
    'MdTableDataDef',
    NULL,
    N'Used for Derivative Mgmt Tool',
    N'Derivatives Trans Pillar'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e52bb580-4ab0-7e3d-aa47-73264adfb528',
    2,
    'MdTableDataDef',
    NULL,
    N'Used for Derivative Mgmt Tool',
    N'Derivatives Trans Pillar'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e52bb580-4ab0-7e3d-aa47-73264adfb528',
    3,
    'MdTableDataDef',
    NULL,
    N'Used for Derivative Mgmt Tool',
    N'Derivatives Trans Pillar'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e52bb580-4ab0-7e3d-aa47-73264adfb528',
    4,
    'MdTableDataDef',
    NULL,
    N'Used for Derivative Mgmt Tool',
    N'Derivatives Trans Pillar'
);

--changeset system:generated-update-data-AsText-PtDerivTransPos context:any labels:c-any,o-table,ot-schema,on-PtDerivTransPos,fin-13659 runOnChange:true
--comment: Generate AsText for PtDerivTransPos
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7c93432b-c903-3f35-8941-30d084923664';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7c93432b-c903-3f35-8941-30d084923664',
    1,
    'MdTableDataDef',
    NULL,
    N'Used for Derivative Mgmt Tool',
    N'Derivatives Trans Pillar'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7c93432b-c903-3f35-8941-30d084923664',
    2,
    'MdTableDataDef',
    NULL,
    N'Used for Derivative Mgmt Tool',
    N'Derivatives Trans Pillar'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7c93432b-c903-3f35-8941-30d084923664',
    3,
    'MdTableDataDef',
    NULL,
    N'Used for Derivative Mgmt Tool',
    N'Derivatives Trans Pillar'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7c93432b-c903-3f35-8941-30d084923664',
    4,
    'MdTableDataDef',
    NULL,
    N'Used for Derivative Mgmt Tool',
    N'Derivatives Trans Pillar'
);

--changeset system:generated-update-data-AsText-PtDispoBookingStatus context:any labels:c-any,o-table,ot-schema,on-PtDispoBookingStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtDispoBookingStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='36a75318-fcde-e432-99f3-0bc97a19f4dd';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '36a75318-fcde-e432-99f3-0bc97a19f4dd',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Reservation status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '36a75318-fcde-e432-99f3-0bc97a19f4dd',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Dispo Buchung Stati'
);

--changeset system:generated-update-data-AsText-PtDisposalRight context:any labels:c-any,o-table,ot-schema,on-PtDisposalRight,fin-13659 runOnChange:true
--comment: Generate AsText for PtDisposalRight
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2f4b8ff0-2b3e-423c-aa3d-0d5685e824de';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2f4b8ff0-2b3e-423c-aa3d-0d5685e824de',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Disposal Right'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2f4b8ff0-2b3e-423c-aa3d-0d5685e824de',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Vollmacht Verfügungsrecht'
);

--changeset system:generated-update-data-AsText-PtDocDeliveryType context:any labels:c-any,o-table,ot-schema,on-PtDocDeliveryType,fin-13659 runOnChange:true
--comment: Generate AsText for PtDocDeliveryType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7016077e-2d5d-8b30-a82b-7eadafbf5ce1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7016077e-2d5d-8b30-a82b-7eadafbf5ce1',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Document Delivery Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7016077e-2d5d-8b30-a82b-7eadafbf5ce1',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Dokumentübergabeart'
);

--changeset system:generated-update-data-AsText-PtDocumentStatus context:any labels:c-any,o-table,ot-schema,on-PtDocumentStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtDocumentStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='90a561be-cb6f-6c36-b36b-a271fe818b00';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '90a561be-cb6f-6c36-b36b-a271fe818b00',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'agreement status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '90a561be-cb6f-6c36-b36b-a271fe818b00',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Vertragstatus'
);

--changeset system:generated-update-data-AsText-PtEbAssetOverviewGroupingType context:any labels:c-any,o-table,ot-schema,on-PtEbAssetOverviewGroupingType,fin-13659 runOnChange:true
--comment: Generate AsText for PtEbAssetOverviewGroupingType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a9e04e9c-ef44-293d-81ef-b1c3aad7dacf';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a9e04e9c-ef44-293d-81ef-b1c3aad7dacf',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'AssetOverview grouping'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a9e04e9c-ef44-293d-81ef-b1c3aad7dacf',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Vermögensübersicht Group'
);

--changeset system:generated-update-data-AsText-PtEbDocumentGroup context:any labels:c-any,o-table,ot-schema,on-PtEbDocumentGroup,fin-13659 runOnChange:true
--comment: Generate AsText for PtEbDocumentGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6aad6a20-15b8-f932-81bd-ef7df1e273d5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6aad6a20-15b8-f932-81bd-ef7df1e273d5',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Document group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6aad6a20-15b8-f932-81bd-ef7df1e273d5',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Dokumentengruppe'
);

--changeset system:generated-update-data-AsText-PtEbInvestIcon context:any labels:c-any,o-table,ot-schema,on-PtEbInvestIcon,fin-13659 runOnChange:true
--comment: Generate AsText for PtEbInvestIcon
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9f0ac6be-009d-6631-8b06-93a0cdebb593';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9f0ac6be-009d-6631-8b06-93a0cdebb593',
    1,
    'MdTableDataDef',
    NULL,
    N'E-Banking Invest Icon',
    N'E-Banking Invest Icon'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9f0ac6be-009d-6631-8b06-93a0cdebb593',
    2,
    'MdTableDataDef',
    NULL,
    N'E-Banking Invest Icon',
    N'E-Banking Invest Icon'
);

--changeset system:generated-update-data-AsText-PtEbInvestPresentation context:any labels:c-any,o-table,ot-schema,on-PtEbInvestPresentation,fin-13659 runOnChange:true
--comment: Generate AsText for PtEbInvestPresentation
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e9814c68-37d3-1334-a5ea-57052a3fee9d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e9814c68-37d3-1334-a5ea-57052a3fee9d',
    1,
    'MdTableDataDef',
    NULL,
    N'E-Banking Invest. Product',
    N'E-Banking Invest. Product'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e9814c68-37d3-1334-a5ea-57052a3fee9d',
    2,
    'MdTableDataDef',
    NULL,
    N'E-Banking Invest. Product',
    N'E-Banking Invest. Product'
);

--changeset system:generated-update-data-AsText-PtEbNewsletterTemplate context:any labels:c-any,o-table,ot-schema,on-PtEbNewsletterTemplate,fin-13659 runOnChange:true
--comment: Generate AsText for PtEbNewsletterTemplate
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='48e67121-b96b-353e-bbdd-205cd76adad0';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '48e67121-b96b-353e-bbdd-205cd76adad0',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Newsletter Template'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '48e67121-b96b-353e-bbdd-205cd76adad0',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Newsletter Vorlage'
);

--changeset system:generated-update-data-AsText-PtEbNewsSubscriptionTopic context:any labels:c-any,o-table,ot-schema,on-PtEbNewsSubscriptionTopic,fin-13659 runOnChange:true
--comment: Generate AsText for PtEbNewsSubscriptionTopic
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5fe5d01b-8bf8-5534-ac2d-e7ab46d1c1a5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5fe5d01b-8bf8-5534-ac2d-e7ab46d1c1a5',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'E-News subscribed topic'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5fe5d01b-8bf8-5534-ac2d-e7ab46d1c1a5',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'E-News subscribed topic'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5fe5d01b-8bf8-5534-ac2d-e7ab46d1c1a5',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'E-News subscribed topic'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5fe5d01b-8bf8-5534-ac2d-e7ab46d1c1a5',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'E-News subscribed topic'
);

--changeset system:generated-update-data-AsText-PtEbNewsTopic context:any labels:c-any,o-table,ot-schema,on-PtEbNewsTopic,fin-13659 runOnChange:true
--comment: Generate AsText for PtEbNewsTopic
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='18ee7527-0562-f334-ad78-3157a513e890';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '18ee7527-0562-f334-ad78-3157a513e890',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'E-News Topics'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '18ee7527-0562-f334-ad78-3157a513e890',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'E-News Topics'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '18ee7527-0562-f334-ad78-3157a513e890',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'E-News Topics'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '18ee7527-0562-f334-ad78-3157a513e890',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'E-News Topics'
);

--changeset system:generated-update-data-AsText-PtEbPaymentOrderPermission context:any labels:c-any,o-table,ot-schema,on-PtEbPaymentOrderPermission,fin-13659 runOnChange:true
--comment: Generate AsText for PtEbPaymentOrderPermission
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='920f008e-b4e7-293f-8ace-93426731a132';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '920f008e-b4e7-293f-8ace-93426731a132',
    1,
    'MdTableDataDef',
    NULL,
    N'E-Banking Pay. Permission',
    N'E-Banking Pay. Permission'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '920f008e-b4e7-293f-8ace-93426731a132',
    2,
    'MdTableDataDef',
    NULL,
    N'E-Banking Pay. Permission',
    N'E-Banking Pay. Permission'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '920f008e-b4e7-293f-8ace-93426731a132',
    3,
    'MdTableDataDef',
    NULL,
    N'E-Banking Pay. Permission',
    N'E-Banking Pay. Permission'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '920f008e-b4e7-293f-8ace-93426731a132',
    4,
    'MdTableDataDef',
    NULL,
    N'E-Banking Pay. Permission',
    N'E-Banking Pay. Permission'
);

--changeset system:generated-update-data-AsText-PtEbProductCategory context:any labels:c-any,o-table,ot-schema,on-PtEbProductCategory,fin-13659 runOnChange:true
--comment: Generate AsText for PtEbProductCategory
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='62b74204-b7a6-c933-9ddf-4c84ad894972';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '62b74204-b7a6-c933-9ddf-4c84ad894972',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Private product category'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '62b74204-b7a6-c933-9ddf-4c84ad894972',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Eigene Produktkategorie'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '62b74204-b7a6-c933-9ddf-4c84ad894972',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Produit privat catégorie'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '62b74204-b7a6-c933-9ddf-4c84ad894972',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Produtto privato categori'
);

--changeset system:generated-update-data-AsText-PtEducationLevel context:any labels:c-any,o-table,ot-schema,on-PtEducationLevel,fin-13659 runOnChange:true
--comment: Generate AsText for PtEducationLevel
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b1396b65-9172-5c32-bcf2-9b86003403bf';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b1396b65-9172-5c32-bcf2-9b86003403bf',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Education Level'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b1396b65-9172-5c32-bcf2-9b86003403bf',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ausbildungsniveau'
);

--changeset system:generated-update-data-AsText-PtEMailAddressType context:any labels:c-any,o-table,ot-schema,on-PtEMailAddressType,fin-13659 runOnChange:true
--comment: Generate AsText for PtEMailAddressType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='74a7f6f6-5e0c-983b-9a2f-8bceb0d2bc9f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '74a7f6f6-5e0c-983b-9a2f-8bceb0d2bc9f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'E-Mail Adresstyp'
);

--changeset system:generated-update-data-AsText-PtETaxProcessStatus context:any labels:c-any,o-table,ot-schema,on-PtETaxProcessStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtETaxProcessStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b9ce8dd4-7f5b-a735-8b2e-b63c08c7994c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b9ce8dd4-7f5b-a735-8b2e-b63c08c7994c',
    1,
    'MdTableDataDef',
    NULL,
    N'PtETaxProcessStatus',
    N'PtETaxProcessStatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b9ce8dd4-7f5b-a735-8b2e-b63c08c7994c',
    2,
    'MdTableDataDef',
    NULL,
    N'PtETaxProcessStatus',
    N'PtETaxProcessStatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b9ce8dd4-7f5b-a735-8b2e-b63c08c7994c',
    3,
    'MdTableDataDef',
    NULL,
    N'PtETaxProcessStatus',
    N'PtETaxProcessStatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b9ce8dd4-7f5b-a735-8b2e-b63c08c7994c',
    4,
    'MdTableDataDef',
    NULL,
    N'PtETaxProcessStatus',
    N'PtETaxProcessStatus'
);

--changeset system:generated-update-data-AsText-PtEUTaxation context:any labels:c-any,o-table,ot-schema,on-PtEUTaxation,fin-13659 runOnChange:true
--comment: Generate AsText for PtEUTaxation
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='82025d3e-2f68-5b3a-9eb6-9c67d19baf66';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '82025d3e-2f68-5b3a-9eb6-9c67d19baf66',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'EU taxation'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '82025d3e-2f68-5b3a-9eb6-9c67d19baf66',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'EU Besteuerung'
);

--changeset system:generated-update-data-AsText-PtEvent context:any labels:c-any,o-table,ot-schema,on-PtEvent,fin-13659 runOnChange:true
--comment: Generate AsText for PtEvent
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c731d6f0-9468-893f-ba6f-b06819a93eec';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c731d6f0-9468-893f-ba6f-b06819a93eec',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Marketing-Event'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c731d6f0-9468-893f-ba6f-b06819a93eec',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Marketing-Event'
);

--changeset system:generated-update-data-AsText-PtExportQualiCode context:any labels:c-any,o-table,ot-schema,on-PtExportQualiCode,fin-13659 runOnChange:true
--comment: Generate AsText for PtExportQualiCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='94f09b90-8a4d-bf36-bcc2-0e1b077252ae';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '94f09b90-8a4d-bf36-bcc2-0e1b077252ae',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Quali Code'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '94f09b90-8a4d-bf36-bcc2-0e1b077252ae',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Quali Code'
);

--changeset system:generated-update-data-AsText-PtFormOrderType context:any labels:c-any,o-table,ot-schema,on-PtFormOrderType,fin-13659 runOnChange:true
--comment: Generate AsText for PtFormOrderType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ba08fa6f-e81f-6f39-ab56-26d9be6b815a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ba08fa6f-e81f-6f39-ab56-26d9be6b815a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'FormType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ba08fa6f-e81f-6f39-ab56-26d9be6b815a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Formulartyp'
);

--changeset system:generated-update-data-AsText-PtFSExternalPartner context:any labels:c-any,o-table,ot-schema,on-PtFSExternalPartner,fin-13659 runOnChange:true
--comment: Generate AsText for PtFSExternalPartner
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2b197781-928e-2139-8553-137e17af70d5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2b197781-928e-2139-8553-137e17af70d5',
    1,
    'MdTableDataDef',
    NULL,
    N'PtFSExternalPartner',
    N'PtFSExternalPartner'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2b197781-928e-2139-8553-137e17af70d5',
    2,
    'MdTableDataDef',
    NULL,
    N'PtFSExternalPartner',
    N'PtFSExternalPartner'
);

--changeset system:generated-update-data-AsText-PtFSExternalPartnerRole context:any labels:c-any,o-table,ot-schema,on-PtFSExternalPartnerRole,fin-13659 runOnChange:true
--comment: Generate AsText for PtFSExternalPartnerRole
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ece86965-de66-8b37-9c75-5ddd86827038';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ece86965-de66-8b37-9c75-5ddd86827038',
    1,
    'MdTableDataDef',
    NULL,
    N'PtFSExternalPartnerRole',
    N'PtFSExternalPartnerRole'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ece86965-de66-8b37-9c75-5ddd86827038',
    2,
    'MdTableDataDef',
    NULL,
    N'PtFSExternalPartnerRole',
    N'PtFSExternalPartnerRole'
);

--changeset system:generated-update-data-AsText-PtFSExternalPartnerSetting context:any labels:c-any,o-table,ot-schema,on-PtFSExternalPartnerSetting,fin-13659 runOnChange:true
--comment: Generate AsText for PtFSExternalPartnerSetting
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0d526db4-72ce-873d-89f1-e58be266e2f1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0d526db4-72ce-873d-89f1-e58be266e2f1',
    1,
    'MdTableDataDef',
    NULL,
    N'PtFSExternalPartnerSetting',
    N'PtFSExternalPartnerSettin'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0d526db4-72ce-873d-89f1-e58be266e2f1',
    2,
    'MdTableDataDef',
    NULL,
    N'PtFSExternalPartnerSetting',
    N'PtFSExternalPartnerSettin'
);

--changeset system:generated-update-data-AsText-PtGeneralLimitType context:any labels:c-any,o-table,ot-schema,on-PtGeneralLimitType,fin-13659 runOnChange:true
--comment: Generate AsText for PtGeneralLimitType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a389ce75-3141-5a3f-9a50-d703aa0fcbf1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a389ce75-3141-5a3f-9a50-d703aa0fcbf1',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Limit Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a389ce75-3141-5a3f-9a50-d703aa0fcbf1',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Limitentyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a389ce75-3141-5a3f-9a50-d703aa0fcbf1',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Limit Type'
);

--changeset system:generated-update-data-AsText-PtHobbySubDetail context:any labels:c-any,o-table,ot-schema,on-PtHobbySubDetail,fin-13659 runOnChange:true
--comment: Generate AsText for PtHobbySubDetail
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8d9cd98f-aa42-593a-acd0-294ca88ec2a1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8d9cd98f-aa42-593a-acd0-294ca88ec2a1',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Hobby'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8d9cd98f-aa42-593a-acd0-294ca88ec2a1',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Interessen'
);

--changeset system:generated-update-data-AsText-PtHobbySubType context:any labels:c-any,o-table,ot-schema,on-PtHobbySubType,fin-13659 runOnChange:true
--comment: Generate AsText for PtHobbySubType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0ad7db2b-26b9-0431-a5d1-f6f97200a75f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0ad7db2b-26b9-0431-a5d1-f6f97200a75f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Hobby group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0ad7db2b-26b9-0431-a5d1-f6f97200a75f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Interessen Typ'
);

--changeset system:generated-update-data-AsText-PtHobbyType context:any labels:c-any,o-table,ot-schema,on-PtHobbyType,fin-13659 runOnChange:true
--comment: Generate AsText for PtHobbyType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6ce802e8-0d72-b734-a126-82348201b4f2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6ce802e8-0d72-b734-a126-82348201b4f2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Hobby Type Group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6ce802e8-0d72-b734-a126-82348201b4f2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Interessen Gruppe'
);

--changeset system:generated-update-data-AsText-PtHuntingEvent context:any labels:c-any,o-table,ot-schema,on-PtHuntingEvent,fin-13659 runOnChange:true
--comment: Generate AsText for PtHuntingEvent
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e07665b2-6d5d-cb3e-8a2b-2960db81afe1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e07665b2-6d5d-cb3e-8a2b-2960db81afe1',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'CRM Events'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e07665b2-6d5d-cb3e-8a2b-2960db81afe1',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'CRM Termine & Ereignisse'
);

--changeset system:generated-update-data-AsText-PtHuntingOpen context:any labels:c-any,o-table,ot-schema,on-PtHuntingOpen,fin-13659 runOnChange:true
--comment: Generate AsText for PtHuntingOpen
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='721b4e77-df05-7331-aab5-7b682d5b8493';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '721b4e77-df05-7331-aab5-7b682d5b8493',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Motiv to open'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '721b4e77-df05-7331-aab5-7b682d5b8493',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Eröffnungsgrund'
);

--changeset system:generated-update-data-AsText-PtHuntingResult context:any labels:c-any,o-table,ot-schema,on-PtHuntingResult,fin-13659 runOnChange:true
--comment: Generate AsText for PtHuntingResult
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='49485fba-1129-883a-954a-fb0c045b00bd';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '49485fba-1129-883a-954a-fb0c045b00bd',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Hunt result'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '49485fba-1129-883a-954a-fb0c045b00bd',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Akquisitionsresultat'
);

--changeset system:generated-update-data-AsText-PtIdentificationAddrCheckStat context:any labels:c-any,o-table,ot-schema,on-PtIdentificationAddrCheckStat,fin-13659 runOnChange:true
--comment: Generate AsText for PtIdentificationAddrCheckStat
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b7a95cf8-3f4b-533f-87fe-8ca41dbf034e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b7a95cf8-3f4b-533f-87fe-8ca41dbf034e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Identification Addr Check'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b7a95cf8-3f4b-533f-87fe-8ca41dbf034e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Identifikations Adr Check'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b7a95cf8-3f4b-533f-87fe-8ca41dbf034e',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Identification vérif.d''ad'
);

--changeset system:generated-update-data-AsText-PtIdentificationExternalType context:any labels:c-any,o-table,ot-schema,on-PtIdentificationExternalType,fin-13659 runOnChange:true
--comment: Generate AsText for PtIdentificationExternalType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b4dcd9d1-4144-ad3d-b9de-4caa1f2004a5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b4dcd9d1-4144-ad3d-b9de-4caa1f2004a5',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Identification Type exter'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b4dcd9d1-4144-ad3d-b9de-4caa1f2004a5',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Identifikation Typ extern'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b4dcd9d1-4144-ad3d-b9de-4caa1f2004a5',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'type d''identification ext'
);

--changeset system:generated-update-data-AsText-PtIdentificationMedia context:any labels:c-any,o-table,ot-schema,on-PtIdentificationMedia,fin-13659 runOnChange:true
--comment: Generate AsText for PtIdentificationMedia
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='03fd2558-c685-9530-993e-3987fdf43052';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '03fd2558-c685-9530-993e-3987fdf43052',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Identification Media'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '03fd2558-c685-9530-993e-3987fdf43052',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Identifikationsmedium'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '03fd2558-c685-9530-993e-3987fdf43052',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Moyen d''identification'
);

--changeset system:generated-update-data-AsText-PtIdentificationType context:any labels:c-any,o-table,ot-schema,on-PtIdentificationType,fin-13659 runOnChange:true
--comment: Generate AsText for PtIdentificationType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='46828c0d-5a5d-5e30-a5f7-8fdb233a0d9d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '46828c0d-5a5d-5e30-a5f7-8fdb233a0d9d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Identification Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '46828c0d-5a5d-5e30-a5f7-8fdb233a0d9d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Identifikation Typ'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '46828c0d-5a5d-5e30-a5f7-8fdb233a0d9d',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'type d''identification'
);

--changeset system:generated-update-data-AsText-PtInvestmentAdvisoryCategory context:any labels:c-any,o-table,ot-schema,on-PtInvestmentAdvisoryCategory,fin-13659 runOnChange:true
--comment: Generate AsText for PtInvestmentAdvisoryCategory
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ae015c43-39be-1e32-abcf-3a16edff79e0';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ae015c43-39be-1e32-abcf-3a16edff79e0',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Investment risk adv. cat.'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ae015c43-39be-1e32-abcf-3a16edff79e0',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Investitionsrisiko Kat.'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ae015c43-39be-1e32-abcf-3a16edff79e0',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Cat.de risque d''investiss'
);

--changeset system:generated-update-data-AsText-PtInvestmentAdvisoryCategoryOv context:any labels:c-any,o-table,ot-schema,on-PtInvestmentAdvisoryCategoryOv,fin-13659 runOnChange:true
--comment: Generate AsText for PtInvestmentAdvisoryCategoryOv
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5a668764-2268-4f3d-8ad6-cc584b9ad383';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5a668764-2268-4f3d-8ad6-cc584b9ad383',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Investment risk adv. cat.'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5a668764-2268-4f3d-8ad6-cc584b9ad383',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Investitionsrisiko Kat.'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5a668764-2268-4f3d-8ad6-cc584b9ad383',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Cat.de risque d''investiss'
);

--changeset system:generated-update-data-AsText-PtInvestmentCustomerQualMIFID context:any labels:c-any,o-table,ot-schema,on-PtInvestmentCustomerQualMIFID,fin-13659 runOnChange:true
--comment: Generate AsText for PtInvestmentCustomerQualMIFID
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2fc59bc0-eb8f-ea30-8767-695cefa9855c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2fc59bc0-eb8f-ea30-8767-695cefa9855c',
    1,
    'MdTableDataDef',
    NULL,
    N'Kundenqual MIFID SEBA',
    N'Kundenqual MIFID SEBA'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2fc59bc0-eb8f-ea30-8767-695cefa9855c',
    2,
    'MdTableDataDef',
    NULL,
    N'Kundenqual MIFID SEBA',
    N'Kundenqual MIFID SEBA'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2fc59bc0-eb8f-ea30-8767-695cefa9855c',
    3,
    'MdTableDataDef',
    NULL,
    N'Kundenqual MIFID SEBA',
    N'Kundenqual MIFID SEBA'
);

--changeset system:generated-update-data-AsText-PtInvestmentCustQualForeign context:any labels:c-any,o-table,ot-schema,on-PtInvestmentCustQualForeign,fin-13659 runOnChange:true
--comment: Generate AsText for PtInvestmentCustQualForeign
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e373d2c6-f732-3a36-8829-511dbfe86751';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e373d2c6-f732-3a36-8829-511dbfe86751',
    1,
    'MdTableDataDef',
    NULL,
    N'Qualifikation auss. CH/EU',
    N'Qualifikation auss. CH/EU'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e373d2c6-f732-3a36-8829-511dbfe86751',
    2,
    'MdTableDataDef',
    NULL,
    N'Qualifikation auss. CH/EU',
    N'Qualifikation auss. CH/EU'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e373d2c6-f732-3a36-8829-511dbfe86751',
    3,
    'MdTableDataDef',
    NULL,
    N'Qualifikation auss. CH/EU',
    N'Qualifikation auss. CH/EU'
);

--changeset system:generated-update-data-AsText-PtInvestmentFIDLEGClass context:any labels:c-any,o-table,ot-schema,on-PtInvestmentFIDLEGClass,fin-13659 runOnChange:true
--comment: Generate AsText for PtInvestmentFIDLEGClass
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0af44fac-2633-7332-93a0-abccc0741653';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0af44fac-2633-7332-93a0-abccc0741653',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'FIDLEG Classification'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0af44fac-2633-7332-93a0-abccc0741653',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'FIDLEG Klassifikation'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0af44fac-2633-7332-93a0-abccc0741653',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'FIDLEG Classification'
);

--changeset system:generated-update-data-AsText-PtInvestmentKEAssetClasses context:any labels:c-any,o-table,ot-schema,on-PtInvestmentKEAssetClasses,fin-13659 runOnChange:true
--comment: Generate AsText for PtInvestmentKEAssetClasses
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='cd7579be-a81c-4e35-ade8-f44a1c022b24';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cd7579be-a81c-4e35-ade8-f44a1c022b24',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Asset Classes'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cd7579be-a81c-4e35-ade8-f44a1c022b24',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Anlage Klassen'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cd7579be-a81c-4e35-ade8-f44a1c022b24',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Classement Actif'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cd7579be-a81c-4e35-ade8-f44a1c022b24',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Classe Risorsa'
);

--changeset system:generated-update-data-AsText-PtInvestmentKHExperience context:any labels:c-any,o-table,ot-schema,on-PtInvestmentKHExperience,fin-13659 runOnChange:true
--comment: Generate AsText for PtInvestmentKHExperience
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='518d3504-a9d7-c13f-912f-cf0ba5cd8045';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '518d3504-a9d7-c13f-912f-cf0ba5cd8045',
    1,
    'MdTableDataDef',
    NULL,
    N'KnowHow and Experience',
    N'KnowHow and Experience'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '518d3504-a9d7-c13f-912f-cf0ba5cd8045',
    2,
    'MdTableDataDef',
    NULL,
    N'KnowHow und Erfahrung',
    N'KnowHow und Erfahrung'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '518d3504-a9d7-c13f-912f-cf0ba5cd8045',
    3,
    'MdTableDataDef',
    NULL,
    N'KnowHow und Erfahrung',
    N'KnowHow und Erfahrung'
);

--changeset system:generated-update-data-AsText-PtInvestmentRiskKey context:any labels:c-any,o-table,ot-schema,on-PtInvestmentRiskKey,fin-13659 runOnChange:true
--comment: Generate AsText for PtInvestmentRiskKey
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bcf82ae9-c21f-ee34-86ed-539f3114a9ee';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bcf82ae9-c21f-ee34-86ed-539f3114a9ee',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Investment risk type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bcf82ae9-c21f-ee34-86ed-539f3114a9ee',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Art des Anlagerisikos'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bcf82ae9-c21f-ee34-86ed-539f3114a9ee',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type de risque d''investis'
);

--changeset system:generated-update-data-AsText-PtInvestmentType context:any labels:c-any,o-table,ot-schema,on-PtInvestmentType,fin-13659 runOnChange:true
--comment: Generate AsText for PtInvestmentType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='20a8f007-8fd3-d035-bea1-7e0fa9428023';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '20a8f007-8fd3-d035-bea1-7e0fa9428023',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Investment type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '20a8f007-8fd3-d035-bea1-7e0fa9428023',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Investitionstyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '20a8f007-8fd3-d035-bea1-7e0fa9428023',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type d''investissement'
);

--changeset system:generated-update-data-AsText-PtIsoGroupStatus context:any labels:c-any,o-table,ot-schema,on-PtIsoGroupStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtIsoGroupStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b2ec3305-b11d-743a-9617-7ea11e6c2834';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b2ec3305-b11d-743a-9617-7ea11e6c2834',
    1,
    'MdTableDataDef',
    NULL,
    N'PtIsoGroupStatus',
    N'PtIsoGroupStatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b2ec3305-b11d-743a-9617-7ea11e6c2834',
    2,
    'MdTableDataDef',
    NULL,
    N'PtIsoGroupStatus',
    N'PtIsoGroupStatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b2ec3305-b11d-743a-9617-7ea11e6c2834',
    3,
    'MdTableDataDef',
    NULL,
    N'PtIsoGroupStatus',
    N'PtIsoGroupStatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b2ec3305-b11d-743a-9617-7ea11e6c2834',
    4,
    'MdTableDataDef',
    NULL,
    N'PtIsoGroupStatus',
    N'PtIsoGroupStatus'
);

--changeset system:generated-update-data-AsText-PtIsoRejectionCode context:any labels:c-any,o-table,ot-schema,on-PtIsoRejectionCode,fin-13659 runOnChange:true
--comment: Generate AsText for PtIsoRejectionCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2a705168-ebdf-f637-8e54-9aaa1ad5cfc1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2a705168-ebdf-f637-8e54-9aaa1ad5cfc1',
    1,
    'MdTableDataDef',
    NULL,
    N'PtIsoRejectionCodes',
    N'PtIsoRejectionCodes'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2a705168-ebdf-f637-8e54-9aaa1ad5cfc1',
    2,
    'MdTableDataDef',
    NULL,
    N'PtIsoRejectionCodes',
    N'PtIsoRejectionCodes'
);

--changeset system:generated-update-data-AsText-PtIsoTransactionCode context:any labels:c-any,o-table,ot-schema,on-PtIsoTransactionCode,fin-13659 runOnChange:true
--comment: Generate AsText for PtIsoTransactionCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2c14bab2-461a-0130-b281-9db45729762b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2c14bab2-461a-0130-b281-9db45729762b',
    1,
    'MdTableDataDef',
    NULL,
    N'ISO bank transation codes',
    N'ISO bank transation codes'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2c14bab2-461a-0130-b281-9db45729762b',
    2,
    'MdTableDataDef',
    NULL,
    N'ISO bank transation codes',
    N'ISO bank transation codes'
);

--changeset system:generated-update-data-AsText-PtLegalDefinition context:any labels:c-any,o-table,ot-schema,on-PtLegalDefinition,fin-13659 runOnChange:true
--comment: Generate AsText for PtLegalDefinition
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e656cfc6-c49c-2430-b2b1-d71fc9989548';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e656cfc6-c49c-2430-b2b1-d71fc9989548',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Legaldefinition'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e656cfc6-c49c-2430-b2b1-d71fc9989548',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'ZGB/OR Rechtsform'
);

--changeset system:generated-update-data-AsText-PtLegalRepStatus context:any labels:c-any,o-table,ot-schema,on-PtLegalRepStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtLegalRepStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='50a5cc4f-c17f-5f38-8926-ea516a273847';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '50a5cc4f-c17f-5f38-8926-ea516a273847',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Legal Rep. Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '50a5cc4f-c17f-5f38-8926-ea516a273847',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Handlungsstatus'
);

--changeset system:generated-update-data-AsText-PtLegalStatus context:any labels:c-any,o-table,ot-schema,on-PtLegalStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtLegalStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='38bcb57a-b790-8738-923a-2d746c1f31a2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '38bcb57a-b790-8738-923a-2d746c1f31a2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Legal Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '38bcb57a-b790-8738-923a-2d746c1f31a2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rechtsform'
);

--changeset system:generated-update-data-AsText-PtLiabilityType context:any labels:c-any,o-table,ot-schema,on-PtLiabilityType,fin-13659 runOnChange:true
--comment: Generate AsText for PtLiabilityType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='56a0b937-21f1-a23f-8230-8b60db21334d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '56a0b937-21f1-a23f-8230-8b60db21334d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Liability Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '56a0b937-21f1-a23f-8230-8b60db21334d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Verpflichtungsart'
);

--changeset system:generated-update-data-AsText-PtMarriageLawType context:any labels:c-any,o-table,ot-schema,on-PtMarriageLawType,fin-13659 runOnChange:true
--comment: Generate AsText for PtMarriageLawType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7f84cc6c-bbf8-ba31-bf6e-24657058008e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7f84cc6c-bbf8-ba31-bf6e-24657058008e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Marriage Law'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7f84cc6c-bbf8-ba31-bf6e-24657058008e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Eherecht'
);

--changeset system:generated-update-data-AsText-PtMaturityInfoType context:any labels:c-any,o-table,ot-schema,on-PtMaturityInfoType,fin-13659 runOnChange:true
--comment: Generate AsText for PtMaturityInfoType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='41d15023-f2c1-b13d-accb-61c0badbde2c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '41d15023-f2c1-b13d-accb-61c0badbde2c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Maturity notification typ'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '41d15023-f2c1-b13d-accb-61c0badbde2c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Avisierungstyp Verfall'
);

--changeset system:generated-update-data-AsText-PtMLCheckLimit context:any labels:c-any,o-table,ot-schema,on-PtMLCheckLimit,fin-13659 runOnChange:true
--comment: Generate AsText for PtMLCheckLimit
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bf8a9004-1348-803c-9265-0df0bd5213d4';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bf8a9004-1348-803c-9265-0df0bd5213d4',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'PtMlCheckLimit'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bf8a9004-1348-803c-9265-0df0bd5213d4',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GwG Regel Limiten'
);

--changeset system:generated-update-data-AsText-PtMLCustomerType context:any labels:c-any,o-table,ot-schema,on-PtMLCustomerType,fin-13659 runOnChange:true
--comment: Generate AsText for PtMLCustomerType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c3d169e4-4479-1431-b6e6-9ca92978e4d2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c3d169e4-4479-1431-b6e6-9ca92978e4d2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML Customer Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c3d169e4-4479-1431-b6e6-9ca92978e4d2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GWG Kundentyp'
);

--changeset system:generated-update-data-AsText-PtMlFollowUpProcesses context:any labels:c-any,o-table,ot-schema,on-PtMlFollowUpProcesses,fin-13659 runOnChange:true
--comment: Generate AsText for PtMlFollowUpProcesses
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5425a7d6-4251-8432-9649-b7088d98b651';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5425a7d6-4251-8432-9649-b7088d98b651',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML Follow up processes'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5425a7d6-4251-8432-9649-b7088d98b651',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GWG Folgeprozesse'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5425a7d6-4251-8432-9649-b7088d98b651',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Processus de suivi ML'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5425a7d6-4251-8432-9649-b7088d98b651',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Processi di follow-up ML'
);

--changeset system:generated-update-data-AsText-PtMLPeriodicCheckChannel context:any labels:c-any,o-table,ot-schema,on-PtMLPeriodicCheckChannel,fin-13659 runOnChange:true
--comment: Generate AsText for PtMLPeriodicCheckChannel
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9c4c3f0c-d1b4-d938-8617-814934e4d34d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9c4c3f0c-d1b4-d938-8617-814934e4d34d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML Channels'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9c4c3f0c-d1b4-d938-8617-814934e4d34d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GWG Kanäle'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9c4c3f0c-d1b4-d938-8617-814934e4d34d',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Canal ML'
);

--changeset system:generated-update-data-AsText-PtMLPeriodicCheckDataState context:any labels:c-any,o-table,ot-schema,on-PtMLPeriodicCheckDataState,fin-13659 runOnChange:true
--comment: Generate AsText for PtMLPeriodicCheckDataState
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4249f0cd-590f-e133-bec0-94e5df13d8b7';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4249f0cd-590f-e133-bec0-94e5df13d8b7',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML Check Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4249f0cd-590f-e133-bec0-94e5df13d8b7',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GWG Prüfungs Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4249f0cd-590f-e133-bec0-94e5df13d8b7',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Statut de vérification ML'
);

--changeset system:generated-update-data-AsText-PtMLPeriodicCheckDetail context:any labels:c-any,o-table,ot-schema,on-PtMLPeriodicCheckDetail,fin-13659 runOnChange:true
--comment: Generate AsText for PtMLPeriodicCheckDetail
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8cab401d-c77b-ab3e-b7ed-1b55094024d2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8cab401d-c77b-ab3e-b7ed-1b55094024d2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML detail checks'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8cab401d-c77b-ab3e-b7ed-1b55094024d2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GWG Detailprüfung'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8cab401d-c77b-ab3e-b7ed-1b55094024d2',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Vérif. détaillées du ML'
);

--changeset system:generated-update-data-AsText-PtMLPeriodicCheckDetailState context:any labels:c-any,o-table,ot-schema,on-PtMLPeriodicCheckDetailState,fin-13659 runOnChange:true
--comment: Generate AsText for PtMLPeriodicCheckDetailState
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1bd5500f-a20c-fb35-898d-8fd0ecf94b66';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1bd5500f-a20c-fb35-898d-8fd0ecf94b66',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML Check Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1bd5500f-a20c-fb35-898d-8fd0ecf94b66',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GWG Status Subprüfungen'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1bd5500f-a20c-fb35-898d-8fd0ecf94b66',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Statut sous-examen ML'
);

--changeset system:generated-update-data-AsText-PtMLPeriodicCheckDetailSteps context:any labels:c-any,o-table,ot-schema,on-PtMLPeriodicCheckDetailSteps,fin-13659 runOnChange:true
--comment: Generate AsText for PtMLPeriodicCheckDetailSteps
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5d7ebf59-7b4d-053f-820e-855af5616548';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5d7ebf59-7b4d-053f-820e-855af5616548',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML steps detail checks'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5d7ebf59-7b4d-053f-820e-855af5616548',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GWG SchritteDetailprüfung'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5d7ebf59-7b4d-053f-820e-855af5616548',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Vérif détaillées étape ML'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5d7ebf59-7b4d-053f-820e-855af5616548',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML steps detail checks'
);

--changeset system:generated-update-data-AsText-PtMLPeriodicCheckOwnShipState context:any labels:c-any,o-table,ot-schema,on-PtMLPeriodicCheckOwnShipState,fin-13659 runOnChange:true
--comment: Generate AsText for PtMLPeriodicCheckOwnShipState
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3c6783c8-c312-7430-81ab-a32b58f541a2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3c6783c8-c312-7430-81ab-a32b58f541a2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML Ownership Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3c6783c8-c312-7430-81ab-a32b58f541a2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GWG Status wirtsch. Ber.'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3c6783c8-c312-7430-81ab-a32b58f541a2',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Statut de propriété de ML'
);

--changeset system:generated-update-data-AsText-PtMLPeriodicCheckProxiesState context:any labels:c-any,o-table,ot-schema,on-PtMLPeriodicCheckProxiesState,fin-13659 runOnChange:true
--comment: Generate AsText for PtMLPeriodicCheckProxiesState
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b0b3e222-d0b4-a734-963e-864625024252';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b0b3e222-d0b4-a734-963e-864625024252',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML Proxie Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b0b3e222-d0b4-a734-963e-864625024252',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GWG Vollmacht Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b0b3e222-d0b4-a734-963e-864625024252',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Statut du proxy ML'
);

--changeset system:generated-update-data-AsText-PtMLPeriodicCheckReason context:any labels:c-any,o-table,ot-schema,on-PtMLPeriodicCheckReason,fin-13659 runOnChange:true
--comment: Generate AsText for PtMLPeriodicCheckReason
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='66ce2309-8212-8a30-94a5-f2ecc0ee592b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '66ce2309-8212-8a30-94a5-f2ecc0ee592b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML types of exams'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '66ce2309-8212-8a30-94a5-f2ecc0ee592b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GWG Prüfungsarten'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '66ce2309-8212-8a30-94a5-f2ecc0ee592b',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML Types d''examens'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '66ce2309-8212-8a30-94a5-f2ecc0ee592b',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML Tipi di esami'
);

--changeset system:generated-update-data-AsText-PtMLPeriodicCheckState context:any labels:c-any,o-table,ot-schema,on-PtMLPeriodicCheckState,fin-13659 runOnChange:true
--comment: Generate AsText for PtMLPeriodicCheckState
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bb2f2551-bd6f-0c36-90f9-00d2b32d7479';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bb2f2551-bd6f-0c36-90f9-00d2b32d7479',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML Check Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bb2f2551-bd6f-0c36-90f9-00d2b32d7479',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GWG Prüfungsstatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bb2f2551-bd6f-0c36-90f9-00d2b32d7479',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Statut de vérification ML'
);

--changeset system:generated-update-data-AsText-PtMLPeriodicCheckTemplates context:any labels:c-any,o-table,ot-schema,on-PtMLPeriodicCheckTemplates,fin-13659 runOnChange:true
--comment: Generate AsText for PtMLPeriodicCheckTemplates
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6e94fa6e-7588-983c-afac-aeea213b0ee3';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6e94fa6e-7588-983c-afac-aeea213b0ee3',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML Check Templates'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6e94fa6e-7588-983c-afac-aeea213b0ee3',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GWG Prüfungsvorlagen'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6e94fa6e-7588-983c-afac-aeea213b0ee3',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Modèles vérification ML'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6e94fa6e-7588-983c-afac-aeea213b0ee3',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Modelli di controllo ML'
);

--changeset system:generated-update-data-AsText-PtMLPeriodicCheckToolTips context:any labels:c-any,o-table,ot-schema,on-PtMLPeriodicCheckToolTips,fin-13659 runOnChange:true
--comment: Generate AsText for PtMLPeriodicCheckToolTips
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='47f7a273-cd60-1533-90a7-302e7225f4c8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '47f7a273-cd60-1533-90a7-302e7225f4c8',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML Check Tool tips'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '47f7a273-cd60-1533-90a7-302e7225f4c8',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GWG Check Tool Tipp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '47f7a273-cd60-1533-90a7-302e7225f4c8',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'LBA Type infobulles'
);

--changeset system:generated-update-data-AsText-PtMLPeriodicCheckType context:any labels:c-any,o-table,ot-schema,on-PtMLPeriodicCheckType,fin-13659 runOnChange:true
--comment: Generate AsText for PtMLPeriodicCheckType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1a2d33d5-c5b4-6933-a9eb-d4f9c0825f4b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1a2d33d5-c5b4-6933-a9eb-d4f9c0825f4b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML Check Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1a2d33d5-c5b4-6933-a9eb-d4f9c0825f4b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GWG Prüfungstyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1a2d33d5-c5b4-6933-a9eb-d4f9c0825f4b',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML Type de chèque'
);

--changeset system:generated-update-data-AsText-PtMLProcessingStateNo context:any labels:c-any,o-table,ot-schema,on-PtMLProcessingStateNo,fin-13659 runOnChange:true
--comment: Generate AsText for PtMLProcessingStateNo
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='fd17e013-cc53-c03d-a8e4-6b3019838e9a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fd17e013-cc53-c03d-a8e4-6b3019838e9a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML Processing State'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fd17e013-cc53-c03d-a8e4-6b3019838e9a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GWG Prozess Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fd17e013-cc53-c03d-a8e4-6b3019838e9a',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'État de traitement ML'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fd17e013-cc53-c03d-a8e4-6b3019838e9a',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Stato di elaborazione ML'
);

--changeset system:generated-update-data-AsText-PtMLProcessingType context:any labels:c-any,o-table,ot-schema,on-PtMLProcessingType,fin-13659 runOnChange:true
--comment: Generate AsText for PtMLProcessingType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='87b2db07-b1ba-0f30-be42-18f3a6613737';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '87b2db07-b1ba-0f30-be42-18f3a6613737',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ML Processing Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '87b2db07-b1ba-0f30-be42-18f3a6613737',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GWG Prozess Typ'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '87b2db07-b1ba-0f30-be42-18f3a6613737',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type de traitement ML'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '87b2db07-b1ba-0f30-be42-18f3a6613737',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tipo di elaborazione ML'
);

--changeset system:generated-update-data-AsText-PtMLReasonType context:any labels:c-any,o-table,ot-schema,on-PtMLReasonType,fin-13659 runOnChange:true
--comment: Generate AsText for PtMLReasonType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='620de0e3-ba0b-3533-b8b7-79449741fd5a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '620de0e3-ba0b-3533-b8b7-79449741fd5a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Relation Reason'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '620de0e3-ba0b-3533-b8b7-79449741fd5a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Grund Hintergrundbericht'
);

--changeset system:generated-update-data-AsText-PtMLRules context:any labels:c-any,o-table,ot-schema,on-PtMLRules,fin-13659 runOnChange:true
--comment: Generate AsText for PtMLRules
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='505d5777-5160-7533-87ff-a4e7c7b52b1c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '505d5777-5160-7533-87ff-a4e7c7b52b1c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'AML Rules'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '505d5777-5160-7533-87ff-a4e7c7b52b1c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GwG Regeln'
);

--changeset system:generated-update-data-AsText-PtMrosPartySignificance context:any labels:c-any,o-table,ot-schema,on-PtMrosPartySignificance,fin-13659 runOnChange:true
--comment: Generate AsText for PtMrosPartySignificance
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ab3cf3d7-bb2f-4530-b8db-5198d8002305';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ab3cf3d7-bb2f-4530-b8db-5198d8002305',
    1,
    'MdTableDataDef',
    NULL,
    N'PtMrosPartySignificance',
    N'PtMrosPartySignificance'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ab3cf3d7-bb2f-4530-b8db-5198d8002305',
    2,
    'MdTableDataDef',
    NULL,
    N'PtMrosPartySignificance',
    N'PtMrosPartySignificance'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ab3cf3d7-bb2f-4530-b8db-5198d8002305',
    3,
    'MdTableDataDef',
    NULL,
    N'PtMrosPartySignificance',
    N'PtMrosPartySignificance'
);

--changeset system:generated-update-data-AsText-PtMrosReportCode context:any labels:c-any,o-table,ot-schema,on-PtMrosReportCode,fin-13659 runOnChange:true
--comment: Generate AsText for PtMrosReportCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d0bb120a-aaf8-483c-8349-a08574d67493';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd0bb120a-aaf8-483c-8349-a08574d67493',
    1,
    'MdTableDataDef',
    NULL,
    N'PtMrosReportCode',
    N'PtMrosReportCode'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd0bb120a-aaf8-483c-8349-a08574d67493',
    2,
    'MdTableDataDef',
    NULL,
    N'PtMrosReportCode',
    N'PtMrosReportCode'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd0bb120a-aaf8-483c-8349-a08574d67493',
    3,
    'MdTableDataDef',
    NULL,
    N'PtMrosReportCode',
    N'PtMrosReportCode'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd0bb120a-aaf8-483c-8349-a08574d67493',
    4,
    'MdTableDataDef',
    NULL,
    N'PtMrosReportCode',
    N'PtMrosReportCode'
);

--changeset system:generated-update-data-AsText-PtMrosReportType context:any labels:c-any,o-table,ot-schema,on-PtMrosReportType,fin-13659 runOnChange:true
--comment: Generate AsText for PtMrosReportType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='aa54ebef-7e15-5c35-a8e4-b92350ea3569';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'aa54ebef-7e15-5c35-a8e4-b92350ea3569',
    1,
    'MdTableDataDef',
    NULL,
    N'PtMrosReportType',
    N'PtMrosReportType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'aa54ebef-7e15-5c35-a8e4-b92350ea3569',
    2,
    'MdTableDataDef',
    NULL,
    N'PtMrosReportType',
    N'PtMrosReportType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'aa54ebef-7e15-5c35-a8e4-b92350ea3569',
    3,
    'MdTableDataDef',
    NULL,
    N'PtMrosReportType',
    N'PtMrosReportType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'aa54ebef-7e15-5c35-a8e4-b92350ea3569',
    4,
    'MdTableDataDef',
    NULL,
    N'PtMrosReportType',
    N'PtMrosReportType'
);

--changeset system:generated-update-data-AsText-PtNamingRule context:any labels:c-any,o-table,ot-schema,on-PtNamingRule,fin-13659 runOnChange:true
--comment: Generate AsText for PtNamingRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='12274955-04a9-b13a-b5f9-6f4a24180af4';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '12274955-04a9-b13a-b5f9-6f4a24180af4',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Naming Rule'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '12274955-04a9-b13a-b5f9-6f4a24180af4',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Namensregel'
);

--changeset system:generated-update-data-AsText-PtOfferCollateralType context:any labels:c-any,o-table,ot-schema,on-PtOfferCollateralType,fin-13659 runOnChange:true
--comment: Generate AsText for PtOfferCollateralType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='659af869-c281-bd33-9033-e3cb5d755015';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '659af869-c281-bd33-9033-e3cb5d755015',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'CollateralType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '659af869-c281-bd33-9033-e3cb5d755015',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Sicherheit'
);

--changeset system:generated-update-data-AsText-PtOfferConsequencesType context:any labels:c-any,o-table,ot-schema,on-PtOfferConsequencesType,fin-13659 runOnChange:true
--comment: Generate AsText for PtOfferConsequencesType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ba210913-0c57-b93b-ac0d-bdd06a6275b9';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ba210913-0c57-b93b-ac0d-bdd06a6275b9',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'consequences'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ba210913-0c57-b93b-ac0d-bdd06a6275b9',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Folgen'
);

--changeset system:generated-update-data-AsText-PtOfferRealEstateType context:any labels:c-any,o-table,ot-schema,on-PtOfferRealEstateType,fin-13659 runOnChange:true
--comment: Generate AsText for PtOfferRealEstateType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='51f4c895-bddd-0232-86a2-08fdee6442f2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '51f4c895-bddd-0232-86a2-08fdee6442f2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Offer Object Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '51f4c895-bddd-0232-86a2-08fdee6442f2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Offerten Objekttyp'
);

--changeset system:generated-update-data-AsText-PtOfferResultType context:any labels:c-any,o-table,ot-schema,on-PtOfferResultType,fin-13659 runOnChange:true
--comment: Generate AsText for PtOfferResultType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a01afe98-103d-6538-8cac-be13bc1525d2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a01afe98-103d-6538-8cac-be13bc1525d2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Offert ResultType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a01afe98-103d-6538-8cac-be13bc1525d2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Offertresultat'
);

--changeset system:generated-update-data-AsText-PtOfferSoftType context:any labels:c-any,o-table,ot-schema,on-PtOfferSoftType,fin-13659 runOnChange:true
--comment: Generate AsText for PtOfferSoftType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f3463a9c-e413-8930-bade-4561f9c030d7';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f3463a9c-e413-8930-bade-4561f9c030d7',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'OfferSoftTypeNo'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f3463a9c-e413-8930-bade-4561f9c030d7',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Soft Faktor Art'
);

--changeset system:generated-update-data-AsText-PtOfferSourceType context:any labels:c-any,o-table,ot-schema,on-PtOfferSourceType,fin-13659 runOnChange:true
--comment: Generate AsText for PtOfferSourceType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2bc5da1c-8869-8335-9e71-8b33ea7db60f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2bc5da1c-8869-8335-9e71-8b33ea7db60f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Source Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2bc5da1c-8869-8335-9e71-8b33ea7db60f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Herkunft'
);

--changeset system:generated-update-data-AsText-PtOfferStatus context:any labels:c-any,o-table,ot-schema,on-PtOfferStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtOfferStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='90ef3e88-37f0-0135-9bb8-26064dbe4b25';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '90ef3e88-37f0-0135-9bb8-26064dbe4b25',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Offer status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '90ef3e88-37f0-0135-9bb8-26064dbe4b25',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Offertenstatus'
);

--changeset system:generated-update-data-AsText-PtOfferType context:any labels:c-any,o-table,ot-schema,on-PtOfferType,fin-13659 runOnChange:true
--comment: Generate AsText for PtOfferType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1ce658c1-8c4a-af3e-abc6-65aaa248d3d0';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1ce658c1-8c4a-af3e-abc6-65aaa248d3d0',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Offer Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1ce658c1-8c4a-af3e-abc6-65aaa248d3d0',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Offertentyp'
);

--changeset system:generated-update-data-AsText-PtOfferVariationType context:any labels:c-any,o-table,ot-schema,on-PtOfferVariationType,fin-13659 runOnChange:true
--comment: Generate AsText for PtOfferVariationType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='063d1884-574b-af3e-b2cd-fe24d0829822';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '063d1884-574b-af3e-b2cd-fe24d0829822',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Version Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '063d1884-574b-af3e-b2cd-fe24d0829822',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Offert Modell'
);

--changeset system:generated-update-data-AsText-PtOnboardingAccountPolicy context:any labels:c-any,o-table,ot-schema,on-PtOnboardingAccountPolicy,fin-13659 runOnChange:true
--comment: Generate AsText for PtOnboardingAccountPolicy
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8fa2dabe-eca6-f13f-a553-6ea125df792f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8fa2dabe-eca6-f13f-a553-6ea125df792f',
    1,
    'MdTableDataDef',
    NULL,
    N'Baas UseCase Account',
    N'BaasUseCaseAccount'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8fa2dabe-eca6-f13f-a553-6ea125df792f',
    2,
    'MdTableDataDef',
    NULL,
    N'Baas UseCase Account',
    N'BaasUseCaseAccount'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8fa2dabe-eca6-f13f-a553-6ea125df792f',
    3,
    'MdTableDataDef',
    NULL,
    N'Baas UseCase Account',
    N'BaasUseCaseAccount'
);

--changeset system:generated-update-data-AsText-PtOnboardingCardPolicy context:any labels:c-any,o-table,ot-schema,on-PtOnboardingCardPolicy,fin-13659 runOnChange:true
--comment: Generate AsText for PtOnboardingCardPolicy
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e6641416-19b1-fb3f-91a0-d6346f47acf3';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e6641416-19b1-fb3f-91a0-d6346f47acf3',
    1,
    'MdTableDataDef',
    NULL,
    N'Baas UseCase Account Card',
    N'BaasUseCaseAccountCard'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e6641416-19b1-fb3f-91a0-d6346f47acf3',
    2,
    'MdTableDataDef',
    NULL,
    N'Baas UseCase Account Card',
    N'BaasUseCaseAccountCard'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e6641416-19b1-fb3f-91a0-d6346f47acf3',
    3,
    'MdTableDataDef',
    NULL,
    N'Baas UseCase Account Card',
    N'BaasUseCaseAccountCard'
);

--changeset system:generated-update-data-AsText-PtOnboardingDbAgrPolicy context:any labels:c-any,o-table,ot-schema,on-PtOnboardingDbAgrPolicy,fin-13659 runOnChange:true
--comment: Generate AsText for PtOnboardingDbAgrPolicy
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b8860911-6642-ee3a-a3b7-35fb878abfc5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b8860911-6642-ee3a-a3b7-35fb878abfc5',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Digital Banking Agreement'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b8860911-6642-ee3a-a3b7-35fb878abfc5',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Digital Banking Agreement'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b8860911-6642-ee3a-a3b7-35fb878abfc5',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Digital Banking Agreement'
);

--changeset system:generated-update-data-AsText-PtOnboardingDocumentPolicy context:any labels:c-any,o-table,ot-schema,on-PtOnboardingDocumentPolicy,fin-13659 runOnChange:true
--comment: Generate AsText for PtOnboardingDocumentPolicy
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d7fb880c-6df1-4d39-9612-bf864f6a637a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd7fb880c-6df1-4d39-9612-bf864f6a637a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Document'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd7fb880c-6df1-4d39-9612-bf864f6a637a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Document'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd7fb880c-6df1-4d39-9612-bf864f6a637a',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Document'
);

--changeset system:generated-update-data-AsText-PtOnboardingIdentPolicy context:any labels:c-any,o-table,ot-schema,on-PtOnboardingIdentPolicy,fin-13659 runOnChange:true
--comment: Generate AsText for PtOnboardingIdentPolicy
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1182ce01-4f0c-6936-b2ab-62076802f54c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1182ce01-4f0c-6936-b2ab-62076802f54c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Identificatican'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1182ce01-4f0c-6936-b2ab-62076802f54c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Identificatican'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1182ce01-4f0c-6936-b2ab-62076802f54c',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Identificatican'
);

--changeset system:generated-update-data-AsText-PtOnboardingPolicy context:any labels:c-any,o-table,ot-schema,on-PtOnboardingPolicy,fin-13659 runOnChange:true
--comment: Generate AsText for PtOnboardingPolicy
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='598dad28-a172-3b30-bac9-ee3fcf6ef50b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '598dad28-a172-3b30-bac9-ee3fcf6ef50b',
    1,
    'MdTableDataDef',
    NULL,
    N'Digital Onboarding UseCase',
    N'DigitalOnboarding UseCase'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '598dad28-a172-3b30-bac9-ee3fcf6ef50b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Anwendungsfall digitales'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '598dad28-a172-3b30-bac9-ee3fcf6ef50b',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Cas d’usage'
);

--changeset system:generated-update-data-AsText-PtOnboardingPolicyType context:any labels:c-any,o-table,ot-schema,on-PtOnboardingPolicyType,fin-13659 runOnChange:true
--comment: Generate AsText for PtOnboardingPolicyType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4b246daf-52f5-c33a-86d5-72e374e15edd';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4b246daf-52f5-c33a-86d5-72e374e15edd',
    1,
    'MdTableDataDef',
    NULL,
    N'Baas Usecase Type',
    N'BaasUseCaseType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4b246daf-52f5-c33a-86d5-72e374e15edd',
    2,
    'MdTableDataDef',
    NULL,
    N'Baas Usecase Type',
    N'BaasUseCaseType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4b246daf-52f5-c33a-86d5-72e374e15edd',
    3,
    'MdTableDataDef',
    NULL,
    N'Baas Usecase Type',
    N'BaasUseCaseType'
);

--changeset system:generated-update-data-AsText-PtOnboardingPortfolioPolicy context:any labels:c-any,o-table,ot-schema,on-PtOnboardingPortfolioPolicy,fin-13659 runOnChange:true
--comment: Generate AsText for PtOnboardingPortfolioPolicy
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a6a488a8-1b89-a333-a826-a2209ec1ea09';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a6a488a8-1b89-a333-a826-a2209ec1ea09',
    1,
    'MdTableDataDef',
    NULL,
    N'Baas Use Case Portfolio',
    N'BaasUseCasePortfolio'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a6a488a8-1b89-a333-a826-a2209ec1ea09',
    2,
    'MdTableDataDef',
    NULL,
    N'Baas Use Case Portfolio',
    N'BaasUseCasePortfolio'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a6a488a8-1b89-a333-a826-a2209ec1ea09',
    3,
    'MdTableDataDef',
    NULL,
    N'Baas Use Case Portfolio',
    N'BaasUseCasePortfolio'
);

--changeset system:generated-update-data-AsText-PtOpenIssueStatus context:any labels:c-any,o-table,ot-schema,on-PtOpenIssueStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtOpenIssueStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='56a2b67a-9f36-fb3f-87c5-bbaf60ff244b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '56a2b67a-9f36-fb3f-87c5-bbaf60ff244b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'status of open issues'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '56a2b67a-9f36-fb3f-87c5-bbaf60ff244b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Pendenzenstatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '56a2b67a-9f36-fb3f-87c5-bbaf60ff244b',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Point en suspens statut'
);

--changeset system:generated-update-data-AsText-PtOpenIssueType context:any labels:c-any,o-table,ot-schema,on-PtOpenIssueType,fin-13659 runOnChange:true
--comment: Generate AsText for PtOpenIssueType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f9593a1a-fdf2-4a39-bb88-4b30ee6ee248';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f9593a1a-fdf2-4a39-bb88-4b30ee6ee248',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'types of open issues'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f9593a1a-fdf2-4a39-bb88-4b30ee6ee248',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Pendenzentyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f9593a1a-fdf2-4a39-bb88-4b30ee6ee248',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Point en suspens type'
);

--changeset system:generated-update-data-AsText-PtOstaClearingMode context:any labels:c-any,o-table,ot-schema,on-PtOstaClearingMode,fin-13659 runOnChange:true
--comment: Generate AsText for PtOstaClearingMode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a411fb57-0664-0d3c-98ba-68def210d677';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a411fb57-0664-0d3c-98ba-68def210d677',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'OSTA Clearing Mode'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a411fb57-0664-0d3c-98ba-68def210d677',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'OSTA Clearing Modus'
);

--changeset system:generated-update-data-AsText-PtOstaInventoryChangeType context:any labels:c-any,o-table,ot-schema,on-PtOstaInventoryChangeType,fin-13659 runOnChange:true
--comment: Generate AsText for PtOstaInventoryChangeType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='71a43b20-6aed-7631-8e0c-83b5dca84f9e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '71a43b20-6aed-7631-8e0c-83b5dca84f9e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'OSTA Inventory Change Typ'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '71a43b20-6aed-7631-8e0c-83b5dca84f9e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'OSTA Bestandsänderungstyp'
);

--changeset system:generated-update-data-AsText-PtOstaMessageType context:any labels:c-any,o-table,ot-schema,on-PtOstaMessageType,fin-13659 runOnChange:true
--comment: Generate AsText for PtOstaMessageType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4015e7e8-6003-cd30-81bf-2ca3caa6e640';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4015e7e8-6003-cd30-81bf-2ca3caa6e640',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'OSTA Message Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4015e7e8-6003-cd30-81bf-2ca3caa6e640',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'OSTA Meldungstyp'
);

--changeset system:generated-update-data-AsText-PtOstaMoneyKind context:any labels:c-any,o-table,ot-schema,on-PtOstaMoneyKind,fin-13659 runOnChange:true
--comment: Generate AsText for PtOstaMoneyKind
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='db209b3d-7064-0c3d-a70d-dd162cf1408f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'db209b3d-7064-0c3d-a70d-dd162cf1408f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'OSTA Money Kind'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'db209b3d-7064-0c3d-a70d-dd162cf1408f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'OSTA Geldart'
);

--changeset system:generated-update-data-AsText-PtOstaServiceType context:any labels:c-any,o-table,ot-schema,on-PtOstaServiceType,fin-13659 runOnChange:true
--comment: Generate AsText for PtOstaServiceType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4f028d5c-8612-a837-a053-8a3b9b72f0a3';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4f028d5c-8612-a837-a053-8a3b9b72f0a3',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'OSTA Service Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4f028d5c-8612-a837-a053-8a3b9b72f0a3',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'OSTA Servicetyp'
);

--changeset system:generated-update-data-AsText-PtPartnerContractExclTypes context:any labels:c-any,o-table,ot-schema,on-PtPartnerContractExclTypes,fin-13659 runOnChange:true
--comment: Generate AsText for PtPartnerContractExclTypes
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1fe9d657-8d78-1436-9ca2-0e91885faee8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1fe9d657-8d78-1436-9ca2-0e91885faee8',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Contract Exclusion Types'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1fe9d657-8d78-1436-9ca2-0e91885faee8',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Vertragsausschlussarten'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1fe9d657-8d78-1436-9ca2-0e91885faee8',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Types d''exclusion contrat'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1fe9d657-8d78-1436-9ca2-0e91885faee8',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tipi esclusione contratto'
);

--changeset system:generated-update-data-AsText-PtPaymentChargeTypeCode context:any labels:c-any,o-table,ot-schema,on-PtPaymentChargeTypeCode,fin-13659 runOnChange:true
--comment: Generate AsText for PtPaymentChargeTypeCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9c462c74-0579-9c37-a8df-af6903348dae';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9c462c74-0579-9c37-a8df-af6903348dae',
    1,
    'MdTableDataDef',
    NULL,
    N'Payment Charge Type Code',
    N'Payment Charge Type Code'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9c462c74-0579-9c37-a8df-af6903348dae',
    2,
    'MdTableDataDef',
    NULL,
    N'Code der Zahlungsgebührart',
    N'Code der Zahlungsgebührar'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9c462c74-0579-9c37-a8df-af6903348dae',
    3,
    'MdTableDataDef',
    NULL,
    N'Code de type de frais de',
    N'Code de type de frais de'
);

--changeset system:generated-update-data-AsText-PtPaymentInstantExecStatus context:any labels:c-any,o-table,ot-schema,on-PtPaymentInstantExecStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtPaymentInstantExecStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b43064ce-4290-2a34-9b5b-28a79efe0415';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b43064ce-4290-2a34-9b5b-28a79efe0415',
    1,
    'MdTableDataDef',
    NULL,
    N'PtPaymentInstantExecStatus',
    N'PtPaymentInstantExecStatu'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b43064ce-4290-2a34-9b5b-28a79efe0415',
    2,
    'MdTableDataDef',
    NULL,
    N'PtPaymentInstantExecStatus',
    N'PtPaymentInstantExecStatu'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b43064ce-4290-2a34-9b5b-28a79efe0415',
    3,
    'MdTableDataDef',
    NULL,
    N'PtPaymentInstantExecStatus',
    N'PtPaymentInstantExecStatu'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b43064ce-4290-2a34-9b5b-28a79efe0415',
    4,
    'MdTableDataDef',
    NULL,
    N'PtPaymentInstantExecStatus',
    N'PtPaymentInstantExecStatu'
);

--changeset system:generated-update-data-AsText-PtPaymentInstantExternalText context:any labels:c-any,o-table,ot-schema,on-PtPaymentInstantExternalText,fin-13659 runOnChange:true
--comment: Generate AsText for PtPaymentInstantExternalText
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='35ac0643-dbc0-ac3e-ab93-54a5775d7e0c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '35ac0643-dbc0-ac3e-ab93-54a5775d7e0c',
    1,
    'MdTableDataDef',
    NULL,
    N'PtPaymentInstantExternalText',
    N'PtPaymentInstantExtText'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '35ac0643-dbc0-ac3e-ab93-54a5775d7e0c',
    2,
    'MdTableDataDef',
    NULL,
    N'PtPaymentInstantExternalText',
    N'PtPaymentInstantExtText'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '35ac0643-dbc0-ac3e-ab93-54a5775d7e0c',
    3,
    'MdTableDataDef',
    NULL,
    N'PtPaymentInstantExternalText',
    N'PtPaymentInstantExtText'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '35ac0643-dbc0-ac3e-ab93-54a5775d7e0c',
    4,
    'MdTableDataDef',
    NULL,
    N'PtPaymentInstantExternalText',
    N'PtPaymentInstantExtText'
);

--changeset system:generated-update-data-AsText-PtPaymentKTBStatus context:any labels:c-any,o-table,ot-schema,on-PtPaymentKTBStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtPaymentKTBStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0d7981fa-cb11-b73d-a736-0e22288cfd8a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0d7981fa-cb11-b73d-a736-0e22288cfd8a',
    1,
    'MdTableDataDef',
    NULL,
    N'KTB Payment Status',
    N'KTB Payment Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0d7981fa-cb11-b73d-a736-0e22288cfd8a',
    2,
    'MdTableDataDef',
    NULL,
    N'KTB Payment Status',
    N'KTB Payment Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0d7981fa-cb11-b73d-a736-0e22288cfd8a',
    3,
    'MdTableDataDef',
    NULL,
    N'KTB Payment Status',
    N'KTB Payment Status'
);

--changeset system:generated-update-data-AsText-PtPaymentOrderInternalCostUnit context:any labels:c-any,o-table,ot-schema,on-PtPaymentOrderInternalCostUnit,fin-13659 runOnChange:true
--comment: Generate AsText for PtPaymentOrderInternalCostUnit
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='fc67466d-5165-ee38-a0c4-ed0e0e4a55e8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fc67466d-5165-ee38-a0c4-ed0e0e4a55e8',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'cost unit'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fc67466d-5165-ee38-a0c4-ed0e0e4a55e8',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kostenstelle'
);

--changeset system:generated-update-data-AsText-PtPaymentOrderMsgType context:any labels:c-any,o-table,ot-schema,on-PtPaymentOrderMsgType,fin-13659 runOnChange:true
--comment: Generate AsText for PtPaymentOrderMsgType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='111b6852-d710-af3d-9ead-82b71cb42fdf';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '111b6852-d710-af3d-9ead-82b71cb42fdf',
    1,
    'MdTableDataDef',
    NULL,
    N'Payment msg types',
    N'Payment msg types'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '111b6852-d710-af3d-9ead-82b71cb42fdf',
    2,
    'MdTableDataDef',
    NULL,
    N'Payment msg types',
    N'Payment msg types'
);

--changeset system:generated-update-data-AsText-PtPaymentOrderProject context:any labels:c-any,o-table,ot-schema,on-PtPaymentOrderProject,fin-13659 runOnChange:true
--comment: Generate AsText for PtPaymentOrderProject
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1da18939-329d-7c36-9a31-f69ac37d27c6';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1da18939-329d-7c36-9a31-f69ac37d27c6',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Project'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1da18939-329d-7c36-9a31-f69ac37d27c6',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Projekt'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1da18939-329d-7c36-9a31-f69ac37d27c6',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Projet'
);

--changeset system:generated-update-data-AsText-PtPaymentOrderReport context:any labels:c-any,o-table,ot-schema,on-PtPaymentOrderReport,fin-13659 runOnChange:true
--comment: Generate AsText for PtPaymentOrderReport
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c1b07b70-02e4-6e31-8c16-281cac764ccb';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c1b07b70-02e4-6e31-8c16-281cac764ccb',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Order Reporting'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c1b07b70-02e4-6e31-8c16-281cac764ccb',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Auftrags Reporting'
);

--changeset system:generated-update-data-AsText-PtPaymentOrderStatus context:any labels:c-any,o-table,ot-schema,on-PtPaymentOrderStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtPaymentOrderStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='fe056339-ce31-6d34-9ed5-8a48dcd52608';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fe056339-ce31-6d34-9ed5-8a48dcd52608',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Payment Order Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fe056339-ce31-6d34-9ed5-8a48dcd52608',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Auftragsstatus'
);

--changeset system:generated-update-data-AsText-PtPaymentOrderType context:any labels:c-any,o-table,ot-schema,on-PtPaymentOrderType,fin-13659 runOnChange:true
--comment: Generate AsText for PtPaymentOrderType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='291874d0-3bf1-0b37-abb0-9de4277e32ee';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '291874d0-3bf1-0b37-abb0-9de4277e32ee',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'PtPaymentOrderType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '291874d0-3bf1-0b37-abb0-9de4277e32ee',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Auftragsarten'
);

--changeset system:generated-update-data-AsText-PtPaymentOrderTypeRule context:any labels:c-any,o-table,ot-schema,on-PtPaymentOrderTypeRule,fin-13659 runOnChange:true
--comment: Generate AsText for PtPaymentOrderTypeRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='cc39d7c6-b848-7e3a-96de-a0a1e67b9fe5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cc39d7c6-b848-7e3a-96de-a0a1e67b9fe5',
    1,
    'MdTableDataDef',
    NULL,
    N'Business Rule Assignment',
    N'Business Rule Assignment'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cc39d7c6-b848-7e3a-96de-a0a1e67b9fe5',
    2,
    'MdTableDataDef',
    NULL,
    N'Zuweisung von Geschäftsregeln',
    N'Geschäftsregeln Zuweisung'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cc39d7c6-b848-7e3a-96de-a0a1e67b9fe5',
    3,
    'MdTableDataDef',
    NULL,
    N'Attribution de règles métier',
    N'Attrib. de règles métier'
);

--changeset system:generated-update-data-AsText-PtPaymentRejectReason context:any labels:c-any,o-table,ot-schema,on-PtPaymentRejectReason,fin-13659 runOnChange:true
--comment: Generate AsText for PtPaymentRejectReason
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a4fbb38b-22f2-5534-8e58-338eb3fe0932';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a4fbb38b-22f2-5534-8e58-338eb3fe0932',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Payment rejection codes'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a4fbb38b-22f2-5534-8e58-338eb3fe0932',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'ZV Ablehnungscodes'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a4fbb38b-22f2-5534-8e58-338eb3fe0932',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Codes de refus de paiemen'
);

--changeset system:generated-update-data-AsText-PtPaymentRejectReturnCode context:any labels:c-any,o-table,ot-schema,on-PtPaymentRejectReturnCode,fin-13659 runOnChange:true
--comment: Generate AsText for PtPaymentRejectReturnCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='092cbe3c-5438-b136-aa60-d8296d4bfba7';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '092cbe3c-5438-b136-aa60-d8296d4bfba7',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'PtPaymentRejectReturnCode'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '092cbe3c-5438-b136-aa60-d8296d4bfba7',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'PtPaymentRejectReturnCode'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '092cbe3c-5438-b136-aa60-d8296d4bfba7',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'PtPaymentRejectReturnCode'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '092cbe3c-5438-b136-aa60-d8296d4bfba7',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'PtPaymentRejectReturnCode'
);

--changeset system:generated-update-data-AsText-PtPaymentReturnMessageText context:any labels:c-any,o-table,ot-schema,on-PtPaymentReturnMessageText,fin-13659 runOnChange:true
--comment: Generate AsText for PtPaymentReturnMessageText
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bc7f8c2e-e149-1f32-8873-67e9593f891a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bc7f8c2e-e149-1f32-8873-67e9593f891a',
    1,
    'MdTableDataDef',
    NULL,
    N'PtPaymentReturnMessageText',
    N'PtPaymentReturnMessageTex'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bc7f8c2e-e149-1f32-8873-67e9593f891a',
    2,
    'MdTableDataDef',
    NULL,
    N'PtPaymentReturnMessageText',
    N'PtPaymentReturnMessageTex'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bc7f8c2e-e149-1f32-8873-67e9593f891a',
    3,
    'MdTableDataDef',
    NULL,
    N'PtPaymentReturnMessageText',
    N'PtPaymentReturnMessageTex'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bc7f8c2e-e149-1f32-8873-67e9593f891a',
    4,
    'MdTableDataDef',
    NULL,
    N'PtPaymentReturnMessageText',
    N'PtPaymentReturnMessageTex'
);

--changeset system:generated-update-data-AsText-PtPaymentScanStatus context:any labels:c-any,o-table,ot-schema,on-PtPaymentScanStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtPaymentScanStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2f2d68cb-5c1d-e530-beff-fed88530c137';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2f2d68cb-5c1d-e530-beff-fed88530c137',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Payment Scan Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2f2d68cb-5c1d-e530-beff-fed88530c137',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zahlungsauft. Scan Status'
);

--changeset system:generated-update-data-AsText-PtPaymentType context:any labels:c-any,o-table,ot-schema,on-PtPaymentType,fin-13659 runOnChange:true
--comment: Generate AsText for PtPaymentType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ffd77f13-0ab9-7431-a90d-64ca332b7de8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ffd77f13-0ab9-7431-a90d-64ca332b7de8',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Payment Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ffd77f13-0ab9-7431-a90d-64ca332b7de8',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zahlungsart'
);

--changeset system:generated-update-data-AsText-PtPayReturnIsoCode context:any labels:c-any,o-table,ot-schema,on-PtPayReturnIsoCode,fin-13659 runOnChange:true
--comment: Generate AsText for PtPayReturnIsoCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c58516b5-b9e7-ea31-b89b-219f8fff5413';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c58516b5-b9e7-ea31-b89b-219f8fff5413',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Payment return iso codes'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c58516b5-b9e7-ea31-b89b-219f8fff5413',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Payment return iso codes'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c58516b5-b9e7-ea31-b89b-219f8fff5413',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Payment return iso codes'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c58516b5-b9e7-ea31-b89b-219f8fff5413',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Payment return iso codes'
);

--changeset system:generated-update-data-AsText-PtPhoneNumberType context:any labels:c-any,o-table,ot-schema,on-PtPhoneNumberType,fin-13659 runOnChange:true
--comment: Generate AsText for PtPhoneNumberType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='016ba36d-4d45-a431-b5b5-6c38f443dc58';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '016ba36d-4d45-a431-b5b5-6c38f443dc58',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Phone Number Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '016ba36d-4d45-a431-b5b5-6c38f443dc58',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Telefonnummertyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '016ba36d-4d45-a431-b5b5-6c38f443dc58',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Téléphone type'
);

--changeset system:generated-update-data-AsText-PtPKICarrier context:any labels:c-any,o-table,ot-schema,on-PtPKICarrier,fin-13659 runOnChange:true
--comment: Generate AsText for PtPKICarrier
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2ffd0311-07c2-7c33-83f6-5989a67bd55f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2ffd0311-07c2-7c33-83f6-5989a67bd55f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'PKI Carrier'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2ffd0311-07c2-7c33-83f6-5989a67bd55f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'PKI Träger'
);

--changeset system:generated-update-data-AsText-PtPKICarrierOrigin context:any labels:c-any,o-table,ot-schema,on-PtPKICarrierOrigin,fin-13659 runOnChange:true
--comment: Generate AsText for PtPKICarrierOrigin
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ff241b86-d806-9837-a649-9a4cc7194ca5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ff241b86-d806-9837-a649-9a4cc7194ca5',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'PKI Carrier origin'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ff241b86-d806-9837-a649-9a4cc7194ca5',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'PKI Trägerherkunft'
);

--changeset system:generated-update-data-AsText-PtPKIPriceSelection context:any labels:c-any,o-table,ot-schema,on-PtPKIPriceSelection,fin-13659 runOnChange:true
--comment: Generate AsText for PtPKIPriceSelection
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6c7ab491-71c0-8f30-a09d-3a5532f8a519';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6c7ab491-71c0-8f30-a09d-3a5532f8a519',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'PKI Price Selection'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6c7ab491-71c0-8f30-a09d-3a5532f8a519',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'PKI Preis Selektion'
);

--changeset system:generated-update-data-AsText-PtPKIReader context:any labels:c-any,o-table,ot-schema,on-PtPKIReader,fin-13659 runOnChange:true
--comment: Generate AsText for PtPKIReader
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8b62a25b-b770-ba3a-a514-82cecb7bbdee';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8b62a25b-b770-ba3a-a514-82cecb7bbdee',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'PKI Reader'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8b62a25b-b770-ba3a-a514-82cecb7bbdee',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'PKI Leser'
);

--changeset system:generated-update-data-AsText-PtPKIStatus context:any labels:c-any,o-table,ot-schema,on-PtPKIStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtPKIStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e564217b-38c1-d730-a7eb-37cd79d59980';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e564217b-38c1-d730-a7eb-37cd79d59980',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'PKI Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e564217b-38c1-d730-a7eb-37cd79d59980',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'PKI Status'
);

--changeset system:generated-update-data-AsText-PtPM1JobGroup context:any labels:c-any,o-table,ot-schema,on-PtPM1JobGroup,fin-13659 runOnChange:true
--comment: Generate AsText for PtPM1JobGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9fdaaaf6-dfb1-f73a-9ad0-ce93ee22aa71';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9fdaaaf6-dfb1-f73a-9ad0-ce93ee22aa71',
    1,
    'MdTableDataDef',
    NULL,
    N'PM1 Job Groups',
    N'PM1 Job Groups'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9fdaaaf6-dfb1-f73a-9ad0-ce93ee22aa71',
    2,
    'MdTableDataDef',
    NULL,
    N'PM1 Job Groups',
    N'PM1 Job Groups'
);

--changeset system:generated-update-data-AsText-PtPM1TransMapping context:any labels:c-any,o-table,ot-schema,on-PtPM1TransMapping,fin-13659 runOnChange:true
--comment: Generate AsText for PtPM1TransMapping
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ccad075a-ba4b-a13f-8115-b77d888fc2e8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ccad075a-ba4b-a13f-8115-b77d888fc2e8',
    1,
    'MdTableDataDef',
    NULL,
    N'PM1 Transaction Mapping',
    N'PM1 Transaction Mapping'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ccad075a-ba4b-a13f-8115-b77d888fc2e8',
    2,
    'MdTableDataDef',
    NULL,
    N'PM1 Transaction Mapping',
    N'PM1 Transaction Mapping'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ccad075a-ba4b-a13f-8115-b77d888fc2e8',
    3,
    'MdTableDataDef',
    NULL,
    N'PM1 Transaction Mapping',
    N'PM1 Transaction Mapping'
);

--changeset system:generated-update-data-AsText-PtPMSAssetType context:any labels:c-any,o-table,ot-schema,on-PtPMSAssetType,fin-13659 runOnChange:true
--comment: Generate AsText for PtPMSAssetType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6760279b-f4a2-9731-b2de-66ec2325984a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6760279b-f4a2-9731-b2de-66ec2325984a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'PMS Asset Types'
);

--changeset system:generated-update-data-AsText-PtPortfolioExpense context:any labels:c-any,o-table,ot-schema,on-PtPortfolioExpense,fin-13659 runOnChange:true
--comment: Generate AsText for PtPortfolioExpense
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6d657383-be8c-e83f-83ce-0f12a3ae6921';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6d657383-be8c-e83f-83ce-0f12a3ae6921',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Expenses'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6d657383-be8c-e83f-83ce-0f12a3ae6921',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Spesen'
);

--changeset system:generated-update-data-AsText-PtPortfolioExpenseExeption context:any labels:c-any,o-table,ot-schema,on-PtPortfolioExpenseExeption,fin-13659 runOnChange:true
--comment: Generate AsText for PtPortfolioExpenseExeption
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8690f575-7a0e-9634-9338-2ca6e193e88c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8690f575-7a0e-9634-9338-2ca6e193e88c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'individual expenses'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8690f575-7a0e-9634-9338-2ca6e193e88c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Individuelle Spesen'
);

--changeset system:generated-update-data-AsText-PtPortfolioNostroType context:any labels:c-any,o-table,ot-schema,on-PtPortfolioNostroType,fin-13659 runOnChange:true
--comment: Generate AsText for PtPortfolioNostroType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='267e3a03-4771-9334-8b04-907d7cd47e34';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '267e3a03-4771-9334-8b04-907d7cd47e34',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Nostrotype'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '267e3a03-4771-9334-8b04-907d7cd47e34',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Nostrotyp'
);

--changeset system:generated-update-data-AsText-PtPortfolioPricingModel context:any labels:c-any,o-table,ot-schema,on-PtPortfolioPricingModel,fin-13659 runOnChange:true
--comment: Generate AsText for PtPortfolioPricingModel
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ea103ad8-984f-ac3a-bc70-5924e1d6adbd';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ea103ad8-984f-ac3a-bc70-5924e1d6adbd',
    1,
    'MdTableDataDef',
    NULL,
    N'Portfolio Pricing Model',
    N'Portfolio Pricing Model'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ea103ad8-984f-ac3a-bc70-5924e1d6adbd',
    2,
    'MdTableDataDef',
    NULL,
    N'Portfolio Preis Model',
    N'Portfolio Preis Model'
);

--changeset system:generated-update-data-AsText-PtPortfolioSxTariff context:any labels:c-any,o-table,ot-schema,on-PtPortfolioSxTariff,fin-13659 runOnChange:true
--comment: Generate AsText for PtPortfolioSxTariff
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='33800355-473c-2439-9b12-03beee677a12';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '33800355-473c-2439-9b12-03beee677a12',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Portfolio Tariff'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '33800355-473c-2439-9b12-03beee677a12',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Portfolio-Tarif'
);

--changeset system:generated-update-data-AsText-PtPortfolioTaxRegulation context:any labels:c-any,o-table,ot-schema,on-PtPortfolioTaxRegulation,fin-13659 runOnChange:true
--comment: Generate AsText for PtPortfolioTaxRegulation
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f5001662-14e7-9e37-ade8-ce05f6c90ece';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f5001662-14e7-9e37-ade8-ce05f6c90ece',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'QITax Codes Portfolio'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f5001662-14e7-9e37-ade8-ce05f6c90ece',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'QI Steuercodes Portfolio'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f5001662-14e7-9e37-ade8-ce05f6c90ece',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'QITax Codes Portfolio'
);

--changeset system:generated-update-data-AsText-PtPortfolioType context:any labels:c-any,o-table,ot-schema,on-PtPortfolioType,fin-13659 runOnChange:true
--comment: Generate AsText for PtPortfolioType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='343112d8-c0fb-7f39-84b4-60867cf6fb22';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '343112d8-c0fb-7f39-84b4-60867cf6fb22',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Portfolio Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '343112d8-c0fb-7f39-84b4-60867cf6fb22',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Portfolio Typ'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '343112d8-c0fb-7f39-84b4-60867cf6fb22',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type de portefeuille'
);

--changeset system:generated-update-data-AsText-PtPortfolioTypeProductNoRestr context:any labels:c-any,o-table,ot-schema,on-PtPortfolioTypeProductNoRestr,fin-13659 runOnChange:true
--comment: Generate AsText for PtPortfolioTypeProductNoRestr
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1ae51c1c-e96c-5437-a88e-65832b2c27aa';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1ae51c1c-e96c-5437-a88e-65832b2c27aa',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Portfoliotype restriction'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1ae51c1c-e96c-5437-a88e-65832b2c27aa',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'PortfolioType Restriktion'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1ae51c1c-e96c-5437-a88e-65832b2c27aa',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Restriction portfoliotype'
);

--changeset system:generated-update-data-AsText-PtPortfolioTypeRestriction context:any labels:c-any,o-table,ot-schema,on-PtPortfolioTypeRestriction,fin-13659 runOnChange:true
--comment: Generate AsText for PtPortfolioTypeRestriction
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8725dae0-44ee-813e-a818-e72aada87afc';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8725dae0-44ee-813e-a818-e72aada87afc',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Portfoliotype restriction'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8725dae0-44ee-813e-a818-e72aada87afc',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'PortfolioType Restriktion'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8725dae0-44ee-813e-a818-e72aada87afc',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Restriction portfoliotype'
);

--changeset system:generated-update-data-AsText-PtPositionClassificationType context:any labels:c-any,o-table,ot-schema,on-PtPositionClassificationType,fin-13659 runOnChange:true
--comment: Generate AsText for PtPositionClassificationType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='cd98863d-3ee0-2135-a2e4-8ba9cb77be1f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cd98863d-3ee0-2135-a2e4-8ba9cb77be1f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Position Classification'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cd98863d-3ee0-2135-a2e4-8ba9cb77be1f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Positionseinteilungstyp'
);

--changeset system:generated-update-data-AsText-PtPositionDetailStatus context:any labels:c-any,o-table,ot-schema,on-PtPositionDetailStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtPositionDetailStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6366c9c9-959a-253f-999d-04ef140ad006';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6366c9c9-959a-253f-999d-04ef140ad006',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Position detail status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6366c9c9-959a-253f-999d-04ef140ad006',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bearbeit.Stat Pos.Detail'
);

--changeset system:generated-update-data-AsText-PtPrintPaymentAdviceDayStatus context:any labels:c-any,o-table,ot-schema,on-PtPrintPaymentAdviceDayStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtPrintPaymentAdviceDayStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b19acef3-d85e-fc36-b35e-0be555490568';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b19acef3-d85e-fc36-b35e-0be555490568',
    1,
    'MdTableDataDef',
    NULL,
    N'payment advice day status',
    N'payment advice day status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b19acef3-d85e-fc36-b35e-0be555490568',
    2,
    'MdTableDataDef',
    NULL,
    N'ZV Avis Status',
    N'ZV Avis Status'
);

--changeset system:generated-update-data-AsText-PtProfession context:any labels:c-any,o-table,ot-schema,on-PtProfession,fin-13659 runOnChange:true
--comment: Generate AsText for PtProfession
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='46da69c5-5be3-ca36-a6ef-0928d937e297';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '46da69c5-5be3-ca36-a6ef-0928d937e297',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Professions'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '46da69c5-5be3-ca36-a6ef-0928d937e297',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Berufe'
);

--changeset system:generated-update-data-AsText-PtProfileCertificationType context:any labels:c-any,o-table,ot-schema,on-PtProfileCertificationType,fin-13659 runOnChange:true
--comment: Generate AsText for PtProfileCertificationType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='968f7657-1924-b832-a9f5-205f933d8d08';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '968f7657-1924-b832-a9f5-205f933d8d08',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'CertificationType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '968f7657-1924-b832-a9f5-205f933d8d08',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zertifizierungsart'
);

--changeset system:generated-update-data-AsText-PtProfileCompanyStatus context:any labels:c-any,o-table,ot-schema,on-PtProfileCompanyStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtProfileCompanyStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3064aaa7-d7e9-9538-bf60-78bbf3d0953e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3064aaa7-d7e9-9538-bf60-78bbf3d0953e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'CompanyStatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3064aaa7-d7e9-9538-bf60-78bbf3d0953e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Status HR Eintrag'
);

--changeset system:generated-update-data-AsText-PtProfileInvestmentStrategy context:any labels:c-any,o-table,ot-schema,on-PtProfileInvestmentStrategy,fin-13659 runOnChange:true
--comment: Generate AsText for PtProfileInvestmentStrategy
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='384ea259-0a4c-8739-b45c-3c30882914e3';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '384ea259-0a4c-8739-b45c-3c30882914e3',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Investment strategy'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '384ea259-0a4c-8739-b45c-3c30882914e3',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Anlagestrategie'
);

--changeset system:generated-update-data-AsText-PtProfileMoneyLaunderSuspect context:any labels:c-any,o-table,ot-schema,on-PtProfileMoneyLaunderSuspect,fin-13659 runOnChange:true
--comment: Generate AsText for PtProfileMoneyLaunderSuspect
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='efdd726e-4076-033a-8d99-5dbf0cb6708f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'efdd726e-4076-033a-8d99-5dbf0cb6708f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Money Launder Suspect'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'efdd726e-4076-033a-8d99-5dbf0cb6708f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Geldwäscherei Verdacht'
);

--changeset system:generated-update-data-AsText-PtProfilePEPType context:any labels:c-any,o-table,ot-schema,on-PtProfilePEPType,fin-13659 runOnChange:true
--comment: Generate AsText for PtProfilePEPType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5a490f3c-bfdd-ba30-8b31-0135751c37f1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5a490f3c-bfdd-ba30-8b31-0135751c37f1',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Political exposed person'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5a490f3c-bfdd-ba30-8b31-0135751c37f1',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Politisch exponierte Pers'
);

--changeset system:generated-update-data-AsText-PtProfilePurposeType context:any labels:c-any,o-table,ot-schema,on-PtProfilePurposeType,fin-13659 runOnChange:true
--comment: Generate AsText for PtProfilePurposeType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1425863c-59e2-8d31-8077-8914778be6a6';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1425863c-59e2-8d31-8077-8914778be6a6',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Purpose of Business Rela'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1425863c-59e2-8d31-8077-8914778be6a6',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zweck der Geschäftsbez.'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1425863c-59e2-8d31-8077-8914778be6a6',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Objet relation d''affaires'
);

--changeset system:generated-update-data-AsText-PtProfileRelRoot context:any labels:c-any,o-table,ot-schema,on-PtProfileRelRoot,fin-13659 runOnChange:true
--comment: Generate AsText for PtProfileRelRoot
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='616876ff-0d67-c33a-bd38-42248ce4f1e5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '616876ff-0d67-c33a-bd38-42248ce4f1e5',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Relation Root Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '616876ff-0d67-c33a-bd38-42248ce4f1e5',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Beziehung zur Region'
);

--changeset system:generated-update-data-AsText-PtProfileRiskAbility context:any labels:c-any,o-table,ot-schema,on-PtProfileRiskAbility,fin-13659 runOnChange:true
--comment: Generate AsText for PtProfileRiskAbility
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e5b9b5b9-4f55-833b-bcce-3dced9dc1cf1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e5b9b5b9-4f55-833b-bcce-3dced9dc1cf1',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Risk Ability'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e5b9b5b9-4f55-833b-bcce-3dced9dc1cf1',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Risikofähigkeit'
);

--changeset system:generated-update-data-AsText-PtProfileRiskReadiness context:any labels:c-any,o-table,ot-schema,on-PtProfileRiskReadiness,fin-13659 runOnChange:true
--comment: Generate AsText for PtProfileRiskReadiness
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5ead665a-d765-0b36-9e57-55c7a6a3c87d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5ead665a-d765-0b36-9e57-55c7a6a3c87d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Risk readiness'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5ead665a-d765-0b36-9e57-55c7a6a3c87d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Risikobereitschaft'
);

--changeset system:generated-update-data-AsText-PtProfileSuspectCategory context:any labels:c-any,o-table,ot-schema,on-PtProfileSuspectCategory,fin-13659 runOnChange:true
--comment: Generate AsText for PtProfileSuspectCategory
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2c03163f-45b1-be36-bdc2-1de705b156ac';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2c03163f-45b1-be36-bdc2-1de705b156ac',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Suspect category'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2c03163f-45b1-be36-bdc2-1de705b156ac',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Verdächtigungsart'
);

--changeset system:generated-update-data-AsText-PtProsecutionType context:any labels:c-any,o-table,ot-schema,on-PtProsecutionType,fin-13659 runOnChange:true
--comment: Generate AsText for PtProsecutionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4445d357-2431-ca34-b4b4-c206fd64775f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4445d357-2431-ca34-b4b4-c206fd64775f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ProsecutionTypeNo'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4445d357-2431-ca34-b4b4-c206fd64775f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Betreibungssituation'
);

--changeset system:generated-update-data-AsText-PtProtectionAmountObjectType context:any labels:c-any,o-table,ot-schema,on-PtProtectionAmountObjectType,fin-13659 runOnChange:true
--comment: Generate AsText for PtProtectionAmountObjectType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2303d5fe-6541-7535-aa80-91c4cf858338';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2303d5fe-6541-7535-aa80-91c4cf858338',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Object types'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2303d5fe-6541-7535-aa80-91c4cf858338',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Objektarten'
);

--changeset system:generated-update-data-AsText-PtProxyRight context:any labels:c-any,o-table,ot-schema,on-PtProxyRight,fin-13659 runOnChange:true
--comment: Generate AsText for PtProxyRight
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='90af226c-10f3-b131-bb5a-aeea5614160b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '90af226c-10f3-b131-bb5a-aeea5614160b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Proxy Right'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '90af226c-10f3-b131-bb5a-aeea5614160b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Vollmachtsberechtigung'
);

--changeset system:generated-update-data-AsText-PtRatingConsType context:any labels:c-any,o-table,ot-schema,on-PtRatingConsType,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingConsType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7490b01c-40bb-9532-8ef8-e32b34c0318e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7490b01c-40bb-9532-8ef8-e32b34c0318e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rating Typ'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7490b01c-40bb-9532-8ef8-e32b34c0318e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rating Typ'
);

--changeset system:generated-update-data-AsText-PtRatingFinAcceptability context:any labels:c-any,o-table,ot-schema,on-PtRatingFinAcceptability,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingFinAcceptability
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6074891c-9a13-7135-bff2-12d77a81039a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6074891c-9a13-7135-bff2-12d77a81039a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fin Acceptability'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6074891c-9a13-7135-bff2-12d77a81039a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tragbarkeits-Beurteilung'
);

--changeset system:generated-update-data-AsText-PtRatingFinAudit context:any labels:c-any,o-table,ot-schema,on-PtRatingFinAudit,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingFinAudit
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9d630355-9e4a-943b-b324-95757b294ee7';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9d630355-9e4a-943b-b324-95757b294ee7',
    1,
    'MdTableDataDef',
    NULL,
    N'PtRatingFinAudit',
    N'PtRatingFinAudit'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9d630355-9e4a-943b-b324-95757b294ee7',
    2,
    'MdTableDataDef',
    NULL,
    N'PtRatingFinAudit',
    N'PtRatingFinAudit'
);

--changeset system:generated-update-data-AsText-PtRatingFinCFAvg context:any labels:c-any,o-table,ot-schema,on-PtRatingFinCFAvg,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingFinCFAvg
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5c4e74c8-cf53-393c-ae02-b693cd78ff43';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5c4e74c8-cf53-393c-ae02-b693cd78ff43',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'CFAvgNo'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5c4e74c8-cf53-393c-ae02-b693cd78ff43',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'FinCFAvgNo'
);

--changeset system:generated-update-data-AsText-PtRatingFinCFPlanned context:any labels:c-any,o-table,ot-schema,on-PtRatingFinCFPlanned,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingFinCFPlanned
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='992c4c82-2c1b-6f33-9bc2-7841d867d8e1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '992c4c82-2c1b-6f33-9bc2-7841d867d8e1',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'FinCFPlannedNo'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '992c4c82-2c1b-6f33-9bc2-7841d867d8e1',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'FinCFPlannedNo'
);

--changeset system:generated-update-data-AsText-PtRatingFinDeptFactor context:any labels:c-any,o-table,ot-schema,on-PtRatingFinDeptFactor,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingFinDeptFactor
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9c5d572d-e712-b031-b073-58cacef5ca23';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9c5d572d-e712-b031-b073-58cacef5ca23',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fin DeptFactor'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9c5d572d-e712-b031-b073-58cacef5ca23',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Verschuldungsfaktor'
);

--changeset system:generated-update-data-AsText-PtRatingFinNPL context:any labels:c-any,o-table,ot-schema,on-PtRatingFinNPL,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingFinNPL
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2c776ea4-0540-7331-9a1d-804b72fc4d1a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2c776ea4-0540-7331-9a1d-804b72fc4d1a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fin NPL'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2c776ea4-0540-7331-9a1d-804b72fc4d1a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fin NPL'
);

--changeset system:generated-update-data-AsText-PtRatingFinQuickRatio context:any labels:c-any,o-table,ot-schema,on-PtRatingFinQuickRatio,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingFinQuickRatio
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ff62304a-9608-093b-ad0b-64924436a9de';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ff62304a-9608-093b-ad0b-64924436a9de',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fin QuickRatio'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ff62304a-9608-093b-ad0b-64924436a9de',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Quick Ratio'
);

--changeset system:generated-update-data-AsText-PtRatingFinROE context:any labels:c-any,o-table,ot-schema,on-PtRatingFinROE,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingFinROE
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='afea863a-0c75-c030-9e4a-87f32056bdbe';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'afea863a-0c75-c030-9e4a-87f32056bdbe',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fin ROE'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'afea863a-0c75-c030-9e4a-87f32056bdbe',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'ROE'
);

--changeset system:generated-update-data-AsText-PtRatingFinSelfFinancing context:any labels:c-any,o-table,ot-schema,on-PtRatingFinSelfFinancing,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingFinSelfFinancing
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ed3067e6-5d42-4632-88b7-f5a718b23f31';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ed3067e6-5d42-4632-88b7-f5a718b23f31',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Fin SelfFinancing'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ed3067e6-5d42-4632-88b7-f5a718b23f31',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Eigenfinanzierungsgrad'
);

--changeset system:generated-update-data-AsText-PtRatingNatAccept context:any labels:c-any,o-table,ot-schema,on-PtRatingNatAccept,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingNatAccept
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d91ed5e6-3d01-0d3f-a618-18c33deb8426';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd91ed5e6-3d01-0d3f-a618-18c33deb8426',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Acepptability'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd91ed5e6-3d01-0d3f-a618-18c33deb8426',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tragbarkeitsbeurteilung'
);

--changeset system:generated-update-data-AsText-PtRatingNatChar context:any labels:c-any,o-table,ot-schema,on-PtRatingNatChar,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingNatChar
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='46c07761-ce7b-1c32-bf9d-071169af042a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '46c07761-ce7b-1c32-bf9d-071169af042a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Character'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '46c07761-ce7b-1c32-bf9d-071169af042a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Character'
);

--changeset system:generated-update-data-AsText-PtRatingNatFin context:any labels:c-any,o-table,ot-schema,on-PtRatingNatFin,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingNatFin
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='34cf53ed-5e3d-fe30-bc9e-1a06fd597797';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '34cf53ed-5e3d-fe30-bc9e-1a06fd597797',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'other financials'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '34cf53ed-5e3d-fe30-bc9e-1a06fd597797',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'finanz. Verhältnisse'
);

--changeset system:generated-update-data-AsText-PtRatingNatFut context:any labels:c-any,o-table,ot-schema,on-PtRatingNatFut,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingNatFut
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6d746a21-e0d6-643e-92b0-90b34e716fab';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6d746a21-e0d6-643e-92b0-90b34e716fab',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Future'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6d746a21-e0d6-643e-92b0-90b34e716fab',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zukunftsaussichten'
);

--changeset system:generated-update-data-AsText-PtRatingNatLifeStand context:any labels:c-any,o-table,ot-schema,on-PtRatingNatLifeStand,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingNatLifeStand
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0c3063e9-b155-c532-b0ea-adb7dd8f1b02';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0c3063e9-b155-c532-b0ea-adb7dd8f1b02',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Life Standard'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0c3063e9-b155-c532-b0ea-adb7dd8f1b02',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Lebensstandard'
);

--changeset system:generated-update-data-AsText-PtRatingNatNPL context:any labels:c-any,o-table,ot-schema,on-PtRatingNatNPL,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingNatNPL
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3a1bc536-d90d-d533-a5aa-641a6a9f3bbb';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3a1bc536-d90d-d533-a5aa-641a6a9f3bbb',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Non Perf Loan'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3a1bc536-d90d-d533-a5aa-641a6a9f3bbb',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Non Perf Loan'
);

--changeset system:generated-update-data-AsText-PtRatingNatRep context:any labels:c-any,o-table,ot-schema,on-PtRatingNatRep,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingNatRep
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e168f4af-967f-743d-b322-2ed9d087843c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e168f4af-967f-743d-b322-2ed9d087843c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Representation'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e168f4af-967f-743d-b322-2ed9d087843c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Auftreten'
);

--changeset system:generated-update-data-AsText-PtRatingSoftBudget context:any labels:c-any,o-table,ot-schema,on-PtRatingSoftBudget,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingSoftBudget
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='64cabbae-6196-633d-ab35-433561081e3d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '64cabbae-6196-633d-ab35-433561081e3d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Budget'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '64cabbae-6196-633d-ab35-433561081e3d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Budget Erreichung'
);

--changeset system:generated-update-data-AsText-PtRatingSoftChar context:any labels:c-any,o-table,ot-schema,on-PtRatingSoftChar,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingSoftChar
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='30f1f7f9-44d9-9037-9d47-12ad9955e142';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '30f1f7f9-44d9-9037-9d47-12ad9955e142',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Character'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '30f1f7f9-44d9-9037-9d47-12ad9955e142',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ruf / Charakter'
);

--changeset system:generated-update-data-AsText-PtRatingSoftClientRelation context:any labels:c-any,o-table,ot-schema,on-PtRatingSoftClientRelation,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingSoftClientRelation
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d2c5c405-c365-d633-8cc5-589653905f40';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd2c5c405-c365-d633-8cc5-589653905f40',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ClientRelation'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd2c5c405-c365-d633-8cc5-589653905f40',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kundenpotential/-bindung'
);

--changeset system:generated-update-data-AsText-PtRatingSoftEarning context:any labels:c-any,o-table,ot-schema,on-PtRatingSoftEarning,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingSoftEarning
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2569ee7d-b700-a93d-8774-6ded0b2df880';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2569ee7d-b700-a93d-8774-6ded0b2df880',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Earnings'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2569ee7d-b700-a93d-8774-6ded0b2df880',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Div.Politik / Privatbezug'
);

--changeset system:generated-update-data-AsText-PtRatingSoftFuture context:any labels:c-any,o-table,ot-schema,on-PtRatingSoftFuture,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingSoftFuture
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2c675564-eec6-ee36-b757-130be5f98d99';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2c675564-eec6-ee36-b757-130be5f98d99',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Future'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2c675564-eec6-ee36-b757-130be5f98d99',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zukunftsaussichten'
);

--changeset system:generated-update-data-AsText-PtRatingSoftLocation context:any labels:c-any,o-table,ot-schema,on-PtRatingSoftLocation,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingSoftLocation
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='608aa2e6-eea5-a638-853b-36e63d9cdaad';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '608aa2e6-eea5-a638-853b-36e63d9cdaad',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Location'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '608aa2e6-eea5-a638-853b-36e63d9cdaad',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Standort-Eignung'
);

--changeset system:generated-update-data-AsText-PtRatingSoftManEdu context:any labels:c-any,o-table,ot-schema,on-PtRatingSoftManEdu,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingSoftManEdu
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1174fc03-cfcb-9c3d-a4a3-08a35d0cf400';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1174fc03-cfcb-9c3d-a4a3-08a35d0cf400',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Management Education'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1174fc03-cfcb-9c3d-a4a3-08a35d0cf400',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Management Ausbildung'
);

--changeset system:generated-update-data-AsText-PtRatingSoftManGoal context:any labels:c-any,o-table,ot-schema,on-PtRatingSoftManGoal,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingSoftManGoal
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1d11b4fa-283d-a735-905e-12e019280810';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1d11b4fa-283d-a735-905e-12e019280810',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Management Goal'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1d11b4fa-283d-a735-905e-12e019280810',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Management Erfolgnachweis'
);

--changeset system:generated-update-data-AsText-PtRatingSoftNext context:any labels:c-any,o-table,ot-schema,on-PtRatingSoftNext,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingSoftNext
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4d69a5fd-f55b-2638-b7ce-13122aa591f6';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4d69a5fd-f55b-2638-b7ce-13122aa591f6',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Managment Next'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4d69a5fd-f55b-2638-b7ce-13122aa591f6',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Nachfolge Regelung'
);

--changeset system:generated-update-data-AsText-PtRatingSoftProduct context:any labels:c-any,o-table,ot-schema,on-PtRatingSoftProduct,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingSoftProduct
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7676cca1-e143-a434-80fc-7dbd59929288';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7676cca1-e143-a434-80fc-7dbd59929288',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Products'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7676cca1-e143-a434-80fc-7dbd59929288',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Produkte/DL/Märkte'
);

--changeset system:generated-update-data-AsText-PtRatingSoftProduction context:any labels:c-any,o-table,ot-schema,on-PtRatingSoftProduction,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingSoftProduction
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='55b6ef0c-40af-ad3d-8f87-ba75bd6eb5f3';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '55b6ef0c-40af-ad3d-8f87-ba75bd6eb5f3',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'SoftProduction'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '55b6ef0c-40af-ad3d-8f87-ba75bd6eb5f3',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Produktionsmittel'
);

--changeset system:generated-update-data-AsText-PtRatingSoftRep context:any labels:c-any,o-table,ot-schema,on-PtRatingSoftRep,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingSoftRep
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3ceb214d-6eab-c83e-86f9-adb1d6777f5a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3ceb214d-6eab-c83e-86f9-adb1d6777f5a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Representation No'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3ceb214d-6eab-c83e-86f9-adb1d6777f5a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Auftreten'
);

--changeset system:generated-update-data-AsText-PtRatingSoftRisk context:any labels:c-any,o-table,ot-schema,on-PtRatingSoftRisk,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingSoftRisk
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='479ccda2-b922-6c36-9686-52f40a6fe7e6';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '479ccda2-b922-6c36-9686-52f40a6fe7e6',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Risk'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '479ccda2-b922-6c36-9686-52f40a6fe7e6',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'ext.Einflüsse / Risiken'
);

--changeset system:generated-update-data-AsText-PtRatingStandardOvr context:any labels:c-any,o-table,ot-schema,on-PtRatingStandardOvr,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingStandardOvr
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f74e5d02-852a-8b3f-b326-4229d42e9878';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f74e5d02-852a-8b3f-b326-4229d42e9878',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Credit override'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f74e5d02-852a-8b3f-b326-4229d42e9878',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bonitätsübersteuerung'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f74e5d02-852a-8b3f-b326-4229d42e9878',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Remplacement de crédit'
);

--changeset system:generated-update-data-AsText-PtRatingStatus context:any labels:c-any,o-table,ot-schema,on-PtRatingStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtRatingStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7f8b08c4-41b8-c139-ad74-55bfc941e09f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7f8b08c4-41b8-c139-ad74-55bfc941e09f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Statuses of the ratings'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7f8b08c4-41b8-c139-ad74-55bfc941e09f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rating Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7f8b08c4-41b8-c139-ad74-55bfc941e09f',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Statuts des notations'
);

--changeset system:generated-update-data-AsText-PtRecognitionType context:any labels:c-any,o-table,ot-schema,on-PtRecognitionType,fin-13659 runOnChange:true
--comment: Generate AsText for PtRecognitionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e9677aa6-55e4-1637-8269-71fb3ff03307';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e9677aa6-55e4-1637-8269-71fb3ff03307',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Recognition Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e9677aa6-55e4-1637-8269-71fb3ff03307',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Erkennungstyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e9677aa6-55e4-1637-8269-71fb3ff03307',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Reconnaissance type'
);

--changeset system:generated-update-data-AsText-PtRelationRole context:any labels:c-any,o-table,ot-schema,on-PtRelationRole,fin-13659 runOnChange:true
--comment: Generate AsText for PtRelationRole
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='08987ba7-cea4-2439-81ff-81b01c63c084';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '08987ba7-cea4-2439-81ff-81b01c63c084',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Role in Relation'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '08987ba7-cea4-2439-81ff-81b01c63c084',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rolle innerhalb Beziehung'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '08987ba7-cea4-2439-81ff-81b01c63c084',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Role in Relation'
);

--changeset system:generated-update-data-AsText-PtRelationSlaveCloseRelType context:any labels:c-any,o-table,ot-schema,on-PtRelationSlaveCloseRelType,fin-13659 runOnChange:true
--comment: Generate AsText for PtRelationSlaveCloseRelType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5879e764-cd11-0330-9c4d-41e76b21a7b4';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5879e764-cd11-0330-9c4d-41e76b21a7b4',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Close Relation'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5879e764-cd11-0330-9c4d-41e76b21a7b4',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Nähere Verbindung Partner'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5879e764-cd11-0330-9c4d-41e76b21a7b4',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Relation proche'
);

--changeset system:generated-update-data-AsText-PtRelationType context:any labels:c-any,o-table,ot-schema,on-PtRelationType,fin-13659 runOnChange:true
--comment: Generate AsText for PtRelationType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2841cd9d-55d7-0631-b896-637f6483b7bb';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2841cd9d-55d7-0631-b896-637f6483b7bb',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Relation Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2841cd9d-55d7-0631-b896-637f6483b7bb',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Art der Beziehung'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2841cd9d-55d7-0631-b896-637f6483b7bb',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type de relation'
);

--changeset system:generated-update-data-AsText-PtReleaseReason context:any labels:c-any,o-table,ot-schema,on-PtReleaseReason,fin-13659 runOnChange:true
--comment: Generate AsText for PtReleaseReason
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='479ae896-2b21-5e3e-8a6c-4f3f7fef36ce';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '479ae896-2b21-5e3e-8a6c-4f3f7fef36ce',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'cause of release'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '479ae896-2b21-5e3e-8a6c-4f3f7fef36ce',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Grund der Freigabe'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '479ae896-2b21-5e3e-8a6c-4f3f7fef36ce',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'cause of release'
);

--changeset system:generated-update-data-AsText-PtSegment context:any labels:c-any,o-table,ot-schema,on-PtSegment,fin-13659 runOnChange:true
--comment: Generate AsText for PtSegment
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bf66b195-0733-e43d-9a16-b66936ac59ba';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bf66b195-0733-e43d-9a16-b66936ac59ba',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Segment'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bf66b195-0733-e43d-9a16-b66936ac59ba',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Segment'
);

--changeset system:generated-update-data-AsText-PtServiceLevel context:any labels:c-any,o-table,ot-schema,on-PtServiceLevel,fin-13659 runOnChange:true
--comment: Generate AsText for PtServiceLevel
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8aa34d0c-956b-e633-b099-ba7aa8b12f27';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8aa34d0c-956b-e633-b099-ba7aa8b12f27',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Service Level'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8aa34d0c-956b-e633-b099-ba7aa8b12f27',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Partnerprofil'
);

--changeset system:generated-update-data-AsText-PtServiceNameList context:any labels:c-any,o-table,ot-schema,on-PtServiceNameList,fin-13659 runOnChange:true
--comment: Generate AsText for PtServiceNameList
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='285b075e-5108-203d-8fd5-2017c659bf59';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '285b075e-5108-203d-8fd5-2017c659bf59',
    1,
    'MdTableDataDef',
    NULL,
    N'PtServiceNameList',
    N'PtServiceNameList'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '285b075e-5108-203d-8fd5-2017c659bf59',
    2,
    'MdTableDataDef',
    NULL,
    N'PtServiceNameList',
    N'PtServiceNameList'
);

--changeset system:generated-update-data-AsText-PtSexStatus context:any labels:c-any,o-table,ot-schema,on-PtSexStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtSexStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='96d7d9e1-e1cc-8b36-b30f-fb6f9b3d3c1c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '96d7d9e1-e1cc-8b36-b30f-fb6f9b3d3c1c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Sex Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '96d7d9e1-e1cc-8b36-b30f-fb6f9b3d3c1c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Geschlecht'
);

--changeset system:generated-update-data-AsText-PtShadowAccountStatus context:any labels:c-any,o-table,ot-schema,on-PtShadowAccountStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtShadowAccountStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='531eec5f-2690-183a-8910-d4e8bf0fe77a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '531eec5f-2690-183a-8910-d4e8bf0fe77a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Pension Accounts states'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '531eec5f-2690-183a-8910-d4e8bf0fe77a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Stati Vorsorgekonten'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '531eec5f-2690-183a-8910-d4e8bf0fe77a',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Statut comptes prévoyance'
);

--changeset system:generated-update-data-AsText-PtShadowContractStatus context:any labels:c-any,o-table,ot-schema,on-PtShadowContractStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtShadowContractStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b3463778-0266-4735-b5d2-500e87699e41';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b3463778-0266-4735-b5d2-500e87699e41',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Contract Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b3463778-0266-4735-b5d2-500e87699e41',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Status Treuhandvertrag'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b3463778-0266-4735-b5d2-500e87699e41',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Statut du contract'
);

--changeset system:generated-update-data-AsText-PtShadowProduct context:any labels:c-any,o-table,ot-schema,on-PtShadowProduct,fin-13659 runOnChange:true
--comment: Generate AsText for PtShadowProduct
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ea7a0559-0136-d033-b467-93f3e256875f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ea7a0559-0136-d033-b467-93f3e256875f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Shadow Product'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ea7a0559-0136-d033-b467-93f3e256875f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Produkt für Schattenkonto'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ea7a0559-0136-d033-b467-93f3e256875f',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Produit compte prévoyance'
);

--changeset system:generated-update-data-AsText-PtShareholderMTType context:any labels:c-any,o-table,ot-schema,on-PtShareholderMTType,fin-13659 runOnChange:true
--comment: Generate AsText for PtShareholderMTType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='13b118d7-7804-093f-8a70-2c774e3152b3';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '13b118d7-7804-093f-8a70-2c774e3152b3',
    1,
    'MdTableDataDef',
    NULL,
    N'Management Trans Type',
    N'Management Trans Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '13b118d7-7804-093f-8a70-2c774e3152b3',
    2,
    'MdTableDataDef',
    NULL,
    N'Management Trans Type',
    N'Management Trans Typ'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '13b118d7-7804-093f-8a70-2c774e3152b3',
    3,
    'MdTableDataDef',
    NULL,
    N'Management Trans Type',
    N'Management Trans Type'
);

--changeset system:generated-update-data-AsText-PtStandingOrderPreDefType context:any labels:c-any,o-table,ot-schema,on-PtStandingOrderPreDefType,fin-13659 runOnChange:true
--comment: Generate AsText for PtStandingOrderPreDefType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6f6a61a0-212d-983f-941d-123ceea09a81';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6f6a61a0-212d-983f-941d-123ceea09a81',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'default amount st.order'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6f6a61a0-212d-983f-941d-123ceea09a81',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Defaultbetrag D''auftrag'
);

--changeset system:generated-update-data-AsText-PtStandingOrderStyle context:any labels:c-any,o-table,ot-schema,on-PtStandingOrderStyle,fin-13659 runOnChange:true
--comment: Generate AsText for PtStandingOrderStyle
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2776cebd-286f-8838-bbea-479423f32786';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2776cebd-286f-8838-bbea-479423f32786',
    1,
    'MdTableDataDef',
    NULL,
    N'PtStandingOrderStyle',
    N'PtStandingOrderStyle'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2776cebd-286f-8838-bbea-479423f32786',
    2,
    'MdTableDataDef',
    NULL,
    N'PtStandingOrderStyle',
    N'PtStandingOrderStyle'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2776cebd-286f-8838-bbea-479423f32786',
    3,
    'MdTableDataDef',
    NULL,
    N'PtStandingOrderStyle',
    N'PtStandingOrderStyle'
);

--changeset system:generated-update-data-AsText-PtStandingOrderUsage context:any labels:c-any,o-table,ot-schema,on-PtStandingOrderUsage,fin-13659 runOnChange:true
--comment: Generate AsText for PtStandingOrderUsage
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='78ae28c8-5083-533b-9ab9-c15a25b272fd';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '78ae28c8-5083-533b-9ab9-c15a25b272fd',
    1,
    'MdTableDataDef',
    NULL,
    N'PtStandingOrderUsage',
    N'PtStandingOrderUsage'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '78ae28c8-5083-533b-9ab9-c15a25b272fd',
    2,
    'MdTableDataDef',
    NULL,
    N'PtStandingOrderUsage',
    N'PtStandingOrderUsage'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '78ae28c8-5083-533b-9ab9-c15a25b272fd',
    3,
    'MdTableDataDef',
    NULL,
    N'PtStandingOrderUsage',
    N'PtStandingOrderUsage'
);

--changeset system:generated-update-data-AsText-PtSubmissionAuthority context:any labels:c-any,o-table,ot-schema,on-PtSubmissionAuthority,fin-13659 runOnChange:true
--comment: Generate AsText for PtSubmissionAuthority
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='88227ef9-2bf2-1e3f-bdee-d0448a8f616d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '88227ef9-2bf2-1e3f-bdee-d0448a8f616d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'PtSubmissionAuthority'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '88227ef9-2bf2-1e3f-bdee-d0448a8f616d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Vorlagekompetenz'
);

--changeset system:generated-update-data-AsText-PtSubmissionStatus context:any labels:c-any,o-table,ot-schema,on-PtSubmissionStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtSubmissionStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7d184563-9061-fd32-a582-ed1168a21be9';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7d184563-9061-fd32-a582-ed1168a21be9',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Submission Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7d184563-9061-fd32-a582-ed1168a21be9',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Vorlagestatus'
);

--changeset system:generated-update-data-AsText-PtSubmissionValdidation context:any labels:c-any,o-table,ot-schema,on-PtSubmissionValdidation,fin-13659 runOnChange:true
--comment: Generate AsText for PtSubmissionValdidation
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c94cbb59-e25f-703a-8832-b38af4b27138';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c94cbb59-e25f-703a-8832-b38af4b27138',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Submission validation'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c94cbb59-e25f-703a-8832-b38af4b27138',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Vorlageprüfung'
);

--changeset system:generated-update-data-AsText-PtSWIFTTradeChargeType context:any labels:c-any,o-table,ot-schema,on-PtSWIFTTradeChargeType,fin-13659 runOnChange:true
--comment: Generate AsText for PtSWIFTTradeChargeType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f3642d16-70c5-3730-bd4c-374c925e9102';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f3642d16-70c5-3730-bd4c-374c925e9102',
    1,
    'MdTableDataDef',
    NULL,
    N'PtSWIFTTradeChargeType',
    N'PtSWIFTTradeChargeType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f3642d16-70c5-3730-bd4c-374c925e9102',
    2,
    'MdTableDataDef',
    NULL,
    N'PtSWIFTTradeChargeType',
    N'PtSWIFTTradeChargeType'
);

--changeset system:generated-update-data-AsText-PtTabuType context:any labels:c-any,o-table,ot-schema,on-PtTabuType,fin-13659 runOnChange:true
--comment: Generate AsText for PtTabuType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c42af2c2-336e-0e3f-a0ba-0e970e5ae50c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c42af2c2-336e-0e3f-a0ba-0e970e5ae50c',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tabu type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c42af2c2-336e-0e3f-a0ba-0e970e5ae50c',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tabutyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c42af2c2-336e-0e3f-a0ba-0e970e5ae50c',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tabou type'
);

--changeset system:generated-update-data-AsText-PtTaxJurisdiction context:any labels:c-any,o-table,ot-schema,on-PtTaxJurisdiction,fin-13659 runOnChange:true
--comment: Generate AsText for PtTaxJurisdiction
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='61684e71-84d1-0c38-8d0f-b25fe850ee12';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '61684e71-84d1-0c38-8d0f-b25fe850ee12',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tax Jurisiction'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '61684e71-84d1-0c38-8d0f-b25fe850ee12',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Steuerhoheit'
);

--changeset system:generated-update-data-AsText-PtTaxReportEarningMode context:any labels:c-any,o-table,ot-schema,on-PtTaxReportEarningMode,fin-13659 runOnChange:true
--comment: Generate AsText for PtTaxReportEarningMode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5380fb80-c4b1-c137-ac40-054e01e34222';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5380fb80-c4b1-c137-ac40-054e01e34222',
    1,
    'MdTableDataDef',
    NULL,
    N'PtTaxReportEarningMode',
    N'PtTaxReportEarningMode'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5380fb80-c4b1-c137-ac40-054e01e34222',
    2,
    'MdTableDataDef',
    NULL,
    N'PtTaxReportEarningMode',
    N'PtTaxReportEarningMode'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5380fb80-c4b1-c137-ac40-054e01e34222',
    3,
    'MdTableDataDef',
    NULL,
    N'PtTaxReportEarningMode',
    N'PtTaxReportEarningMode'
);

--changeset system:generated-update-data-AsText-PtTaxReportMinMaxMode context:any labels:c-any,o-table,ot-schema,on-PtTaxReportMinMaxMode,fin-13659 runOnChange:true
--comment: Generate AsText for PtTaxReportMinMaxMode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3b3e6013-3615-363c-b837-8eaae5eac5a1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3b3e6013-3615-363c-b837-8eaae5eac5a1',
    1,
    'MdTableDataDef',
    NULL,
    N'PtTaxReportMinMaxMode',
    N'PtTaxReportMinMaxMode'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3b3e6013-3615-363c-b837-8eaae5eac5a1',
    2,
    'MdTableDataDef',
    NULL,
    N'PtTaxReportMinMaxMode',
    N'PtTaxReportMinMaxMode'
);

--changeset system:generated-update-data-AsText-PtTelekursBranchRule context:any labels:c-any,o-table,ot-schema,on-PtTelekursBranchRule,fin-13659 runOnChange:true
--comment: Generate AsText for PtTelekursBranchRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3b884245-d9ed-ea3e-9346-403d64057fad';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3b884245-d9ed-ea3e-9346-403d64057fad',
    1,
    'MdTableDataDef',
    NULL,
    N'PtTelekursBranchRule',
    N'PtTelekursBranchRule'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3b884245-d9ed-ea3e-9346-403d64057fad',
    2,
    'MdTableDataDef',
    NULL,
    N'PtTelekursBranchRule',
    N'PtTelekursBranchRule'
);

--changeset system:generated-update-data-AsText-PtTradingSystem context:any labels:c-any,o-table,ot-schema,on-PtTradingSystem,fin-13659 runOnChange:true
--comment: Generate AsText for PtTradingSystem
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='04a7bbcc-6c81-7f35-8764-4947bfa2ab37';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '04a7bbcc-6c81-7f35-8764-4947bfa2ab37',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Trading system'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '04a7bbcc-6c81-7f35-8764-4947bfa2ab37',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Handelssystem'
);

--changeset system:generated-update-data-AsText-PtTradingSystemGroup context:any labels:c-any,o-table,ot-schema,on-PtTradingSystemGroup,fin-13659 runOnChange:true
--comment: Generate AsText for PtTradingSystemGroup
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8b561633-e27d-033a-81c4-755b416a1263';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8b561633-e27d-033a-81c4-755b416a1263',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Trading system group'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8b561633-e27d-033a-81c4-755b416a1263',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Handelssystemgruppe'
);

--changeset system:generated-update-data-AsText-PtTransChargeType context:any labels:c-any,o-table,ot-schema,on-PtTransChargeType,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransChargeType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f3bc1762-54c6-1a39-9fff-9e925d54edf1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f3bc1762-54c6-1a39-9fff-9e925d54edf1',
    1,
    'MdTableDataDef',
    NULL,
    N'Charge types',
    N'Charge types'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f3bc1762-54c6-1a39-9fff-9e925d54edf1',
    2,
    'MdTableDataDef',
    NULL,
    N'Spesenarten',
    N'Spesenarten'
);

--changeset system:generated-update-data-AsText-PtTransCvAmountType context:any labels:c-any,o-table,ot-schema,on-PtTransCvAmountType,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransCvAmountType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d8da7894-62a5-d632-9057-616583042e68';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd8da7894-62a5-d632-9057-616583042e68',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Cost value amount type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd8da7894-62a5-d632-9057-616583042e68',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Betragstyp EK-Rechnung'
);

--changeset system:generated-update-data-AsText-PtTransItemRight context:any labels:c-any,o-table,ot-schema,on-PtTransItemRight,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransItemRight
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1fdb00a9-d214-c837-a92a-73fe76fa77a7';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1fdb00a9-d214-c837-a92a-73fe76fa77a7',
    1,
    'MdTableDataDef',
    NULL,
    N'PtTransItemRight',
    N'PtTransItemRight'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1fdb00a9-d214-c837-a92a-73fe76fa77a7',
    2,
    'MdTableDataDef',
    NULL,
    N'PtTransItemRight',
    N'PtTransItemRight'
);

--changeset system:generated-update-data-AsText-PtTransItemText context:any labels:c-any,o-table,ot-schema,on-PtTransItemText,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransItemText
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0146e8eb-b67e-9432-aeba-ba9240db18f9';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0146e8eb-b67e-9432-aeba-ba9240db18f9',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'TransItemText'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0146e8eb-b67e-9432-aeba-ba9240db18f9',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Buchungstext'
);

--changeset system:generated-update-data-AsText-PtTransMsgFlow context:any labels:c-any,o-table,ot-schema,on-PtTransMsgFlow,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransMsgFlow
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c5cd9559-820d-d93b-aacf-4fcb7b2ca67f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c5cd9559-820d-d93b-aacf-4fcb7b2ca67f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'payee chain'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c5cd9559-820d-d93b-aacf-4fcb7b2ca67f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zahlungsempfänger Kette'
);

--changeset system:generated-update-data-AsText-PtTransMsgStatus context:any labels:c-any,o-table,ot-schema,on-PtTransMsgStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransMsgStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='fba342a7-92c7-5235-809f-d0d931b59d7f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fba342a7-92c7-5235-809f-d0d931b59d7f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Transaction status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fba342a7-92c7-5235-809f-d0d931b59d7f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Abwicklungsstatus'
);

--changeset system:generated-update-data-AsText-PtTransOrderMedia context:any labels:c-any,o-table,ot-schema,on-PtTransOrderMedia,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransOrderMedia
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4e177ceb-b4de-c539-9ede-e276d91531b5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4e177ceb-b4de-c539-9ede-e276d91531b5',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Order media'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4e177ceb-b4de-c539-9ede-e276d91531b5',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Auftragsart'
);

--changeset system:generated-update-data-AsText-PtTransSxGoiApp context:any labels:c-any,o-table,ot-schema,on-PtTransSxGoiApp,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransSxGoiApp
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='91a6540f-32a3-a232-85a4-895f7d04d700';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '91a6540f-32a3-a232-85a4-895f7d04d700',
    1,
    'MdTableDataDef',
    NULL,
    N'Source Application for GOI',
    N'Source Application GOI'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '91a6540f-32a3-a232-85a4-895f7d04d700',
    2,
    'MdTableDataDef',
    NULL,
    N'Source Applikation für GOI',
    N'Source Applikation GOI'
);

--changeset system:generated-update-data-AsText-PtTransSxGoiChannel context:any labels:c-any,o-table,ot-schema,on-PtTransSxGoiChannel,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransSxGoiChannel
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b91b4457-02f9-a73c-834a-894b2c47e490';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b91b4457-02f9-a73c-834a-894b2c47e490',
    1,
    'MdTableDataDef',
    NULL,
    N'Channel for GOI',
    N'Channel for GOI'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b91b4457-02f9-a73c-834a-894b2c47e490',
    2,
    'MdTableDataDef',
    NULL,
    N'Kanal für GOI',
    N'Kanal für GOI'
);

--changeset system:generated-update-data-AsText-PtTransSxGoiCheckLevel context:any labels:c-any,o-table,ot-schema,on-PtTransSxGoiCheckLevel,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransSxGoiCheckLevel
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='73064f3b-4fe8-0f34-a667-4a7a67c80c34';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '73064f3b-4fe8-0f34-a667-4a7a67c80c34',
    1,
    'MdTableDataDef',
    NULL,
    N'GOI Check Level',
    N'GOI Check Level'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '73064f3b-4fe8-0f34-a667-4a7a67c80c34',
    2,
    'MdTableDataDef',
    NULL,
    N'GOI Check Level',
    N'GOI Check Level'
);

--changeset system:generated-update-data-AsText-PtTransSxGoiConfig context:any labels:c-any,o-table,ot-schema,on-PtTransSxGoiConfig,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransSxGoiConfig
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='12ed232f-a2cf-a139-a156-6b991c1fe2b2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '12ed232f-a2cf-a139-a156-6b991c1fe2b2',
    1,
    'MdTableDataDef',
    NULL,
    N'Configuration GOI',
    N'Configuration GOI'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '12ed232f-a2cf-a139-a156-6b991c1fe2b2',
    2,
    'MdTableDataDef',
    NULL,
    N'Konfiguration GOI',
    N'Konfiguration GOI'
);

--changeset system:generated-update-data-AsText-PtTransSxGoiOrderStatus context:any labels:c-any,o-table,ot-schema,on-PtTransSxGoiOrderStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransSxGoiOrderStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bf1578d9-521d-353d-9457-ba838c5904cf';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bf1578d9-521d-353d-9457-ba838c5904cf',
    1,
    'MdTableDataDef',
    NULL,
    N'GOI Order Status',
    N'GOI Order Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bf1578d9-521d-353d-9457-ba838c5904cf',
    2,
    'MdTableDataDef',
    NULL,
    N'GOI Order Status',
    N'GOI Order Status'
);

--changeset system:generated-update-data-AsText-PtTransSxListOrderTextNo context:any labels:c-any,o-table,ot-schema,on-PtTransSxListOrderTextNo,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransSxListOrderTextNo
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6fc79ee2-89de-1f35-9346-36ce9c12c42c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6fc79ee2-89de-1f35-9346-36ce9c12c42c',
    1,
    'MdTableDataDef',
    NULL,
    N'Translation table for listingorder TextNo from SxOrderRestriction',
    N'ListingOrder TextNo'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6fc79ee2-89de-1f35-9346-36ce9c12c42c',
    2,
    'MdTableDataDef',
    NULL,
    N'Übersetzungs-Tabelle für Listenaufträge TextNo von SxOrderRestriction',
    N'ListingOrder TextNo'
);

--changeset system:generated-update-data-AsText-PtTransSxOrderAdvisory context:any labels:c-any,o-table,ot-schema,on-PtTransSxOrderAdvisory,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransSxOrderAdvisory
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='dd48274b-2065-6136-8c58-5a37cb7fdc69';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'dd48274b-2065-6136-8c58-5a37cb7fdc69',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Order advisory type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'dd48274b-2065-6136-8c58-5a37cb7fdc69',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Auftrags Beratungsart'
);

--changeset system:generated-update-data-AsText-PtTransSxOrderStatus context:any labels:c-any,o-table,ot-schema,on-PtTransSxOrderStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransSxOrderStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='319f64ad-d9b7-d839-980f-3fd0f7305a1b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '319f64ad-d9b7-d839-980f-3fd0f7305a1b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Order status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '319f64ad-d9b7-d839-980f-3fd0f7305a1b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Auftrags-Status'
);

--changeset system:generated-update-data-AsText-PtTransSxRebate context:any labels:c-any,o-table,ot-schema,on-PtTransSxRebate,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransSxRebate
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0cb4ee72-bd10-503a-b65f-b9086375ca9b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0cb4ee72-bd10-503a-b65f-b9086375ca9b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rebate Table'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0cb4ee72-bd10-503a-b65f-b9086375ca9b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rabattstaffel'
);

--changeset system:generated-update-data-AsText-PtTransSxRebateCat context:any labels:c-any,o-table,ot-schema,on-PtTransSxRebateCat,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransSxRebateCat
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='383578de-227c-b63a-bfec-f899abc69493';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '383578de-227c-b63a-bfec-f899abc69493',
    1,
    'MdTableDataDef',
    NULL,
    N'rebate category',
    N'rebate category'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '383578de-227c-b63a-bfec-f899abc69493',
    2,
    'MdTableDataDef',
    NULL,
    N'Rabatt-Kategorie',
    N'Rabatt-Kategorie'
);

--changeset system:generated-update-data-AsText-PtTransSxTariff context:any labels:c-any,o-table,ot-schema,on-PtTransSxTariff,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransSxTariff
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='815b7389-f290-d033-aead-3cbabf54592d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '815b7389-f290-d033-aead-3cbabf54592d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Stock Exchange Tariff'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '815b7389-f290-d033-aead-3cbabf54592d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Börsentarif Basis'
);

--changeset system:generated-update-data-AsText-PtTransSxTariffAccess context:any labels:c-any,o-table,ot-schema,on-PtTransSxTariffAccess,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransSxTariffAccess
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c88afc49-1813-983b-826c-9304fa3522fa';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c88afc49-1813-983b-826c-9304fa3522fa',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tariff Access'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c88afc49-1813-983b-826c-9304fa3522fa',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zugriffsbasis'
);

--changeset system:generated-update-data-AsText-PtTransSxTestStatusNo context:any labels:c-any,o-table,ot-schema,on-PtTransSxTestStatusNo,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransSxTestStatusNo
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='213ca761-6cdb-5834-932c-800becb8c9d2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '213ca761-6cdb-5834-932c-800becb8c9d2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Test Status No'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '213ca761-6cdb-5834-932c-800becb8c9d2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Teststatus-Nummer'
);

--changeset system:generated-update-data-AsText-PtTransType context:any labels:c-any,o-table,ot-schema,on-PtTransType,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d48af3fd-e5bb-b131-9e3a-f06c62bf8dea';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd48af3fd-e5bb-b131-9e3a-f06c62bf8dea',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'transaction type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd48af3fd-e5bb-b131-9e3a-f06c62bf8dea',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Transaktionstyp'
);

--changeset system:generated-update-data-AsText-PtTransTypeOrig context:any labels:c-any,o-table,ot-schema,on-PtTransTypeOrig,fin-13659 runOnChange:true
--comment: Generate AsText for PtTransTypeOrig
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='442b0788-0825-003d-901c-bb660ca331b0';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '442b0788-0825-003d-901c-bb660ca331b0',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Original payment type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '442b0788-0825-003d-901c-bb660ca331b0',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Original Zahlungsart'
);

--changeset system:generated-update-data-AsText-PtUSBasket context:any labels:c-any,o-table,ot-schema,on-PtUSBasket,fin-13659 runOnChange:true
--comment: Generate AsText for PtUSBasket
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='de34c7d2-01b5-4932-a78a-c0a9bb5b17c8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'de34c7d2-01b5-4932-a78a-c0a9bb5b17c8',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Basket'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'de34c7d2-01b5-4932-a78a-c0a9bb5b17c8',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'US Basket'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'de34c7d2-01b5-4932-a78a-c0a9bb5b17c8',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'US Basket'
);

--changeset system:generated-update-data-AsText-PtUserTimeActivity context:any labels:c-any,o-table,ot-schema,on-PtUserTimeActivity,fin-13659 runOnChange:true
--comment: Generate AsText for PtUserTimeActivity
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='da36b2a0-a51f-363d-ac36-a72ab1c30035';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'da36b2a0-a51f-363d-ac36-a72ab1c30035',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Time Activity'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'da36b2a0-a51f-363d-ac36-a72ab1c30035',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rapportart'
);

--changeset system:generated-update-data-AsText-PtUserTimeCutRule context:any labels:c-any,o-table,ot-schema,on-PtUserTimeCutRule,fin-13659 runOnChange:true
--comment: Generate AsText for PtUserTimeCutRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='34a1f070-bfbd-0037-ae29-8bb2a91806b6';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '34a1f070-bfbd-0037-ae29-8bb2a91806b6',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Time Cut Rule'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '34a1f070-bfbd-0037-ae29-8bb2a91806b6',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Überzeitregelart'
);

--changeset system:generated-update-data-AsText-PtUserTimeRank context:any labels:c-any,o-table,ot-schema,on-PtUserTimeRank,fin-13659 runOnChange:true
--comment: Generate AsText for PtUserTimeRank
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2aad391c-42a8-4c33-8ebe-6af8c2a6177a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2aad391c-42a8-4c33-8ebe-6af8c2a6177a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Users Rank'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2aad391c-42a8-4c33-8ebe-6af8c2a6177a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Mitarbeiter Rang'
);

--changeset system:generated-update-data-AsText-PtUserTimeSchedule context:any labels:c-any,o-table,ot-schema,on-PtUserTimeSchedule,fin-13659 runOnChange:true
--comment: Generate AsText for PtUserTimeSchedule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='937d4dd0-ee60-3931-b1c3-a8481c09c228';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '937d4dd0-ee60-3931-b1c3-a8481c09c228',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Time Schedule'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '937d4dd0-ee60-3931-b1c3-a8481c09c228',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zeiterfassung Zonen'
);

--changeset system:generated-update-data-AsText-PtUserTimeStatus context:any labels:c-any,o-table,ot-schema,on-PtUserTimeStatus,fin-13659 runOnChange:true
--comment: Generate AsText for PtUserTimeStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c90d1b6b-8c6f-8a3c-b02d-52b8d46a15d2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c90d1b6b-8c6f-8a3c-b02d-52b8d46a15d2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Time Visum Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c90d1b6b-8c6f-8a3c-b02d-52b8d46a15d2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rapportvisum Status'
);

--changeset system:generated-update-data-AsText-PtUserTimeVacationRule context:any labels:c-any,o-table,ot-schema,on-PtUserTimeVacationRule,fin-13659 runOnChange:true
--comment: Generate AsText for PtUserTimeVacationRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='012ac6de-cfda-cf3d-a5f0-ca0a24fdb875';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '012ac6de-cfda-cf3d-a5f0-ca0a24fdb875',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Time Vacation Rule'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '012ac6de-cfda-cf3d-a5f0-ca0a24fdb875',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ferienregelart'
);

--changeset system:generated-update-data-AsText-PtVisecaCardLimitType context:any labels:c-any,o-table,ot-schema,on-PtVisecaCardLimitType,fin-13659 runOnChange:true
--comment: Generate AsText for PtVisecaCardLimitType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b552aae4-e555-3d34-b335-1335c51f2917';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b552aae4-e555-3d34-b335-1335c51f2917',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Viseca Card Limit Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b552aae4-e555-3d34-b335-1335c51f2917',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Viseca Karten Limittypen'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b552aae4-e555-3d34-b335-1335c51f2917',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Types de limite de carte'
);

--changeset system:generated-update-data-AsText-PtVisecaCardType context:any labels:c-any,o-table,ot-schema,on-PtVisecaCardType,fin-13659 runOnChange:true
--comment: Generate AsText for PtVisecaCardType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='71a3606c-35e8-7035-94f2-1806f6d5a4ea';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '71a3606c-35e8-7035-94f2-1806f6d5a4ea',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Viseca Card Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '71a3606c-35e8-7035-94f2-1806f6d5a4ea',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Viseca Kartentypen'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '71a3606c-35e8-7035-94f2-1806f6d5a4ea',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type de carte Viseca'
);

--changeset system:generated-update-data-AsText-ReBaseType context:any labels:c-any,o-table,ot-schema,on-ReBaseType,fin-13659 runOnChange:true
--comment: Generate AsText for ReBaseType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='984dfe6b-0efb-8138-976c-6965b23686c2';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '984dfe6b-0efb-8138-976c-6965b23686c2',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Real estate type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '984dfe6b-0efb-8138-976c-6965b23686c2',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Liegenschaftstyp'
);

--changeset system:generated-update-data-AsText-ReBaseVisitMode context:any labels:c-any,o-table,ot-schema,on-ReBaseVisitMode,fin-13659 runOnChange:true
--comment: Generate AsText for ReBaseVisitMode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='949b004e-a135-8436-a3c6-80fab4ef0351';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '949b004e-a135-8436-a3c6-80fab4ef0351',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Visit mode'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '949b004e-a135-8436-a3c6-80fab4ef0351',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Besichtigungsart'
);

--changeset system:generated-update-data-AsText-ReBelongType context:any labels:c-any,o-table,ot-schema,on-ReBelongType,fin-13659 runOnChange:true
--comment: Generate AsText for ReBelongType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='71a728e3-e730-df3a-9395-5163c06e5ec3';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '71a728e3-e730-df3a-9395-5163c06e5ec3',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'BelongType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '71a728e3-e730-df3a-9395-5163c06e5ec3',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zugehörtyp'
);

--changeset system:generated-update-data-AsText-ReBuildingAddType context:any labels:c-any,o-table,ot-schema,on-ReBuildingAddType,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingAddType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5318bb85-f203-7b36-b0f2-d17cdb7c7704';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5318bb85-f203-7b36-b0f2-d17cdb7c7704',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'BuildingAddType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5318bb85-f203-7b36-b0f2-d17cdb7c7704',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gebäudezuschlagstyp'
);

--changeset system:generated-update-data-AsText-ReBuildingAmountType context:any labels:c-any,o-table,ot-schema,on-ReBuildingAmountType,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingAmountType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='fb3b1261-01ab-bf30-a89e-db6ef736b5af';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fb3b1261-01ab-bf30-a89e-db6ef736b5af',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Amounttype'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fb3b1261-01ab-bf30-a89e-db6ef736b5af',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Betragsart'
);

--changeset system:generated-update-data-AsText-ReBuildingConceptType context:any labels:c-any,o-table,ot-schema,on-ReBuildingConceptType,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingConceptType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1702e65e-efc3-7638-a32a-45298df3eace';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1702e65e-efc3-7638-a32a-45298df3eace',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ConceptType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1702e65e-efc3-7638-a32a-45298df3eace',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gebäude Konzept'
);

--changeset system:generated-update-data-AsText-ReBuildingConditionChoiceType context:any labels:c-any,o-table,ot-schema,on-ReBuildingConditionChoiceType,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingConditionChoiceType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='fa4a4437-d789-a834-adf0-e1df41812d6b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fa4a4437-d789-a834-adf0-e1df41812d6b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Building Condition Choice'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fa4a4437-d789-a834-adf0-e1df41812d6b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'GebäudezustandAuswahllist'
);

--changeset system:generated-update-data-AsText-ReBuildingConditionDetailType context:any labels:c-any,o-table,ot-schema,on-ReBuildingConditionDetailType,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingConditionDetailType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='221402ee-0747-bd30-97e8-f38812240c62';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '221402ee-0747-bd30-97e8-f38812240c62',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Condition Detail Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '221402ee-0747-bd30-97e8-f38812240c62',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gebäudezustand Detail'
);

--changeset system:generated-update-data-AsText-ReBuildingConditionType context:any labels:c-any,o-table,ot-schema,on-ReBuildingConditionType,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingConditionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='10b8bdc5-6a56-ff39-b65b-b8297e4f3a0d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '10b8bdc5-6a56-ff39-b65b-b8297e4f3a0d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ConditionType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '10b8bdc5-6a56-ff39-b65b-b8297e4f3a0d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gebäudezustand'
);

--changeset system:generated-update-data-AsText-ReBuildingCostIndex context:any labels:c-any,o-table,ot-schema,on-ReBuildingCostIndex,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingCostIndex
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5cb2b4ba-e508-e23c-b470-cb18aed0f8e9';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5cb2b4ba-e508-e23c-b470-cb18aed0f8e9',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Building Cost Index'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5cb2b4ba-e508-e23c-b470-cb18aed0f8e9',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Baukosten Index'
);

--changeset system:generated-update-data-AsText-ReBuildingFloorType context:any labels:c-any,o-table,ot-schema,on-ReBuildingFloorType,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingFloorType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4d6bb835-c1e8-7434-8a62-6d5852ee7b2b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4d6bb835-c1e8-7434-8a62-6d5852ee7b2b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Floor Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4d6bb835-c1e8-7434-8a62-6d5852ee7b2b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Etagentyp'
);

--changeset system:generated-update-data-AsText-ReBuildingInsuranceType context:any labels:c-any,o-table,ot-schema,on-ReBuildingInsuranceType,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingInsuranceType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7b9f7a94-82f9-fe30-b3e2-bedffd4d0b59';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7b9f7a94-82f9-fe30-b3e2-bedffd4d0b59',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Insurance Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7b9f7a94-82f9-fe30-b3e2-bedffd4d0b59',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Versicherungsart'
);

--changeset system:generated-update-data-AsText-ReBuildingProjectPhase context:any labels:c-any,o-table,ot-schema,on-ReBuildingProjectPhase,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingProjectPhase
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='173812e6-229c-5f3e-927c-4b8073b48493';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '173812e6-229c-5f3e-927c-4b8073b48493',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Project Phase'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '173812e6-229c-5f3e-927c-4b8073b48493',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gebäudeprojekt Phase'
);

--changeset system:generated-update-data-AsText-ReBuildingPtRelType context:any labels:c-any,o-table,ot-schema,on-ReBuildingPtRelType,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingPtRelType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0fc5acf3-6aa2-e933-bd1c-4596b737d005';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0fc5acf3-6aa2-e933-bd1c-4596b737d005',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Building Partner Rel'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0fc5acf3-6aa2-e933-bd1c-4596b737d005',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gebäude Partner Verb.'
);

--changeset system:generated-update-data-AsText-ReBuildingQuality context:any labels:c-any,o-table,ot-schema,on-ReBuildingQuality,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingQuality
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='67af8c36-759c-ec3b-aa8e-09201320defa';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '67af8c36-759c-ec3b-aa8e-09201320defa',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Developing Quality'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '67af8c36-759c-ec3b-aa8e-09201320defa',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bauqualität, -standard'
);

--changeset system:generated-update-data-AsText-ReBuildingQualityChoiceType context:any labels:c-any,o-table,ot-schema,on-ReBuildingQualityChoiceType,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingQualityChoiceType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='cd486fd4-0f6e-0038-924d-f7dccd26d4ea';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cd486fd4-0f6e-0038-924d-f7dccd26d4ea',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'BuildingQualityChoiceType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cd486fd4-0f6e-0038-924d-f7dccd26d4ea',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bauqalitat Auswahlliste'
);

--changeset system:generated-update-data-AsText-ReBuildingQualityDetailType context:any labels:c-any,o-table,ot-schema,on-ReBuildingQualityDetailType,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingQualityDetailType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3c3ff177-8ac8-9134-9a72-05ab35add126';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3c3ff177-8ac8-9134-9a72-05ab35add126',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'BuildingQualityDetail'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3c3ff177-8ac8-9134-9a72-05ab35add126',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bauqualitat Detail'
);

--changeset system:generated-update-data-AsText-ReBuildingSit context:any labels:c-any,o-table,ot-schema,on-ReBuildingSit,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingSit
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='59835414-1bba-7638-bf1c-ed3c0f9fc93b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '59835414-1bba-7638-bf1c-ed3c0f9fc93b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Situation Within Building'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '59835414-1bba-7638-bf1c-ed3c0f9fc93b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Situierung in Gebäude'
);

--changeset system:generated-update-data-AsText-ReBuildingStyle context:any labels:c-any,o-table,ot-schema,on-ReBuildingStyle,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingStyle
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d5f6fe29-7dca-4730-810f-cf819558cb97';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd5f6fe29-7dca-4730-810f-cf819558cb97',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Building Style'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd5f6fe29-7dca-4730-810f-cf819558cb97',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gebäudeart'
);

--changeset system:generated-update-data-AsText-ReBuildingStyleHoRe context:any labels:c-any,o-table,ot-schema,on-ReBuildingStyleHoRe,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingStyleHoRe
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7db25b99-2b22-b632-b782-5fde3be7ca88';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7db25b99-2b22-b632-b782-5fde3be7ca88',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Building Style Hotel Rest'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7db25b99-2b22-b632-b782-5fde3be7ca88',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Hotel/Restaurant Typ'
);

--changeset system:generated-update-data-AsText-ReBuildingStyleOthers context:any labels:c-any,o-table,ot-schema,on-ReBuildingStyleOthers,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingStyleOthers
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5be36582-b439-6835-998f-3bd857fa2c67';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5be36582-b439-6835-998f-3bd857fa2c67',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Building Style Other'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5be36582-b439-6835-998f-3bd857fa2c67',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'übrige Gebäudeart'
);

--changeset system:generated-update-data-AsText-ReBuildingStyleSTWE context:any labels:c-any,o-table,ot-schema,on-ReBuildingStyleSTWE,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingStyleSTWE
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a9a75d9f-514d-0e30-bfa0-961c8abded78';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a9a75d9f-514d-0e30-bfa0-961c8abded78',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Building style STWE'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a9a75d9f-514d-0e30-bfa0-961c8abded78',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'STWE Typ'
);

--changeset system:generated-update-data-AsText-ReBuildingSubType context:any labels:c-any,o-table,ot-schema,on-ReBuildingSubType,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingSubType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='cf9a8d97-9aa5-2a3a-933f-9e7b099db12e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cf9a8d97-9aa5-2a3a-933f-9e7b099db12e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Building sub type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cf9a8d97-9aa5-2a3a-933f-9e7b099db12e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gebäudeuntertypen'
);

--changeset system:generated-update-data-AsText-ReBuildingTenantsMix context:any labels:c-any,o-table,ot-schema,on-ReBuildingTenantsMix,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingTenantsMix
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='fc382cbb-de44-013b-bb4f-db593bf5f508';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fc382cbb-de44-013b-bb4f-db593bf5f508',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'TenantsMix'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fc382cbb-de44-013b-bb4f-db593bf5f508',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Mietermix'
);

--changeset system:generated-update-data-AsText-ReBuildingType context:any labels:c-any,o-table,ot-schema,on-ReBuildingType,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3ced9b57-e2ed-693c-a221-5147bc6d9e78';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3ced9b57-e2ed-693c-a221-5147bc6d9e78',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Building Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3ced9b57-e2ed-693c-a221-5147bc6d9e78',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gebäudetyp'
);

--changeset system:generated-update-data-AsText-ReBuildingVolumeType context:any labels:c-any,o-table,ot-schema,on-ReBuildingVolumeType,fin-13659 runOnChange:true
--comment: Generate AsText for ReBuildingVolumeType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9d887c43-18cb-ab38-b19d-25fb6ee0abe6';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9d887c43-18cb-ab38-b19d-25fb6ee0abe6',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Volumetype'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9d887c43-18cb-ab38-b19d-25fb6ee0abe6',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Raumnorm'
);

--changeset system:generated-update-data-AsText-ReBusinessType context:any labels:c-any,o-table,ot-schema,on-ReBusinessType,fin-13659 runOnChange:true
--comment: Generate AsText for ReBusinessType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='36a8db2a-21ef-1b35-8679-fe1404e8c433';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '36a8db2a-21ef-1b35-8679-fe1404e8c433',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Business Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '36a8db2a-21ef-1b35-8679-fe1404e8c433',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Geschäftsart'
);

--changeset system:generated-update-data-AsText-ReChoiceType context:any labels:c-any,o-table,ot-schema,on-ReChoiceType,fin-13659 runOnChange:true
--comment: Generate AsText for ReChoiceType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c0526488-9329-513b-814c-5d988b44b975';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c0526488-9329-513b-814c-5d988b44b975',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Choice Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c0526488-9329-513b-814c-5d988b44b975',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Auswahlart'
);

--changeset system:generated-update-data-AsText-ReConstructionDetail context:any labels:c-any,o-table,ot-schema,on-ReConstructionDetail,fin-13659 runOnChange:true
--comment: Generate AsText for ReConstructionDetail
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2cb942ca-42fb-6c3a-825b-07cbfe71e9cf';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2cb942ca-42fb-6c3a-825b-07cbfe71e9cf',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Construction Detail'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2cb942ca-42fb-6c3a-825b-07cbfe71e9cf',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Konstruktionsbeschrieb'
);

--changeset system:generated-update-data-AsText-ReConstructionType context:any labels:c-any,o-table,ot-schema,on-ReConstructionType,fin-13659 runOnChange:true
--comment: Generate AsText for ReConstructionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bcf47ab2-220d-ac34-a66b-154f42ba0aa5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bcf47ab2-220d-ac34-a66b-154f42ba0aa5',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Construction Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bcf47ab2-220d-ac34-a66b-154f42ba0aa5',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gebäudekonstruktion'
);

--changeset system:generated-update-data-AsText-ReConstructionZone context:any labels:c-any,o-table,ot-schema,on-ReConstructionZone,fin-13659 runOnChange:true
--comment: Generate AsText for ReConstructionZone
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='cd6e21d9-477a-a035-8521-a54ecb499a14';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cd6e21d9-477a-a035-8521-a54ecb499a14',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Construction Zone'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cd6e21d9-477a-a035-8521-a54ecb499a14',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Bauzone'
);

--changeset system:generated-update-data-AsText-ReCoUnitType context:any labels:c-any,o-table,ot-schema,on-ReCoUnitType,fin-13659 runOnChange:true
--comment: Generate AsText for ReCoUnitType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='442e0851-84ae-ee3f-9c96-75c2442a435b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '442e0851-84ae-ee3f-9c96-75c2442a435b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Co Unit Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '442e0851-84ae-ee3f-9c96-75c2442a435b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Einheit Mit.Eig.Anteil'
);

--changeset system:generated-update-data-AsText-ReDevDetail context:any labels:c-any,o-table,ot-schema,on-ReDevDetail,fin-13659 runOnChange:true
--comment: Generate AsText for ReDevDetail
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='de175f13-7fd7-d031-82c3-a469fd0f32f0';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'de175f13-7fd7-d031-82c3-a469fd0f32f0',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Dev Detail'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'de175f13-7fd7-d031-82c3-a469fd0f32f0',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ausprägung'
);

--changeset system:generated-update-data-AsText-ReDevDetailChoiceType context:any labels:c-any,o-table,ot-schema,on-ReDevDetailChoiceType,fin-13659 runOnChange:true
--comment: Generate AsText for ReDevDetailChoiceType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='099f5a30-28dc-0733-a7f8-000763ccd18b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '099f5a30-28dc-0733-a7f8-000763ccd18b',
    1,
    'MdTableDataDef',
    NULL,
    N'Development ChoiceType',
    N'Development ChoiceType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '099f5a30-28dc-0733-a7f8-000763ccd18b',
    2,
    'MdTableDataDef',
    NULL,
    N'Ausbauart Auswahlliste',
    N'Ausbauart Auswahlliste'
);

--changeset system:generated-update-data-AsText-ReDevelopmentDetType context:any labels:c-any,o-table,ot-schema,on-ReDevelopmentDetType,fin-13659 runOnChange:true
--comment: Generate AsText for ReDevelopmentDetType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='05198eb3-6427-7e37-be1e-ece32abe29c9';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '05198eb3-6427-7e37-be1e-ece32abe29c9',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Dev.Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '05198eb3-6427-7e37-be1e-ece32abe29c9',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Erschliessungskriterien'
);

--changeset system:generated-update-data-AsText-ReDevelopmentRate context:any labels:c-any,o-table,ot-schema,on-ReDevelopmentRate,fin-13659 runOnChange:true
--comment: Generate AsText for ReDevelopmentRate
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c6d3e00d-6734-0139-a1ce-4504e7c5e2f4';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c6d3e00d-6734-0139-a1ce-4504e7c5e2f4',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rate of Development'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c6d3e00d-6734-0139-a1ce-4504e7c5e2f4',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Erschliessungsgrad'
);

--changeset system:generated-update-data-AsText-ReDevType context:any labels:c-any,o-table,ot-schema,on-ReDevType,fin-13659 runOnChange:true
--comment: Generate AsText for ReDevType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a37d0fa3-f7d4-d53f-9460-7fd464cb77fc';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a37d0fa3-f7d4-d53f-9460-7fd464cb77fc',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Development Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a37d0fa3-f7d4-d53f-9460-7fd464cb77fc',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ausbauart'
);

--changeset system:generated-update-data-AsText-ReDwellingType context:any labels:c-any,o-table,ot-schema,on-ReDwellingType,fin-13659 runOnChange:true
--comment: Generate AsText for ReDwellingType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f724fa92-feff-ca3b-bfa2-f9d15a6cd414';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f724fa92-feff-ca3b-bfa2-f9d15a6cd414',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Dwelling Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f724fa92-feff-ca3b-bfa2-f9d15a6cd414',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Wohnungstyp'
);

--changeset system:generated-update-data-AsText-ReEnvironmentAddType context:any labels:c-any,o-table,ot-schema,on-ReEnvironmentAddType,fin-13659 runOnChange:true
--comment: Generate AsText for ReEnvironmentAddType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='b482182b-770d-6d3d-a557-fb139aa761ee';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b482182b-770d-6d3d-a557-fb139aa761ee',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'EnvironmentAddType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b482182b-770d-6d3d-a557-fb139aa761ee',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Umgebungszuschlagstyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b482182b-770d-6d3d-a557-fb139aa761ee',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type de supplément d''envi'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'b482182b-770d-6d3d-a557-fb139aa761ee',
    4,
    'MdTableDataDef',
    NULL,
    N'',
    N'Tipo di supplemento ambie'
);

--changeset system:generated-update-data-AsText-ReEnvironmentAddValuation context:any labels:c-any,o-table,ot-schema,on-ReEnvironmentAddValuation,fin-13659 runOnChange:true
--comment: Generate AsText for ReEnvironmentAddValuation
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='37f6264f-6747-6235-a751-0eee7e3eeb10';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '37f6264f-6747-6235-a751-0eee7e3eeb10',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ReEnvironmentAddValutaion'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '37f6264f-6747-6235-a751-0eee7e3eeb10',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Schätzungsrel.Zuschlag'
);

--changeset system:generated-update-data-AsText-ReGBRegisterType context:any labels:c-any,o-table,ot-schema,on-ReGBRegisterType,fin-13659 runOnChange:true
--comment: Generate AsText for ReGBRegisterType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='fbc94b01-18a5-a334-a405-a6f00038f1fd';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fbc94b01-18a5-a334-a405-a6f00038f1fd',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Registertype'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fbc94b01-18a5-a334-a405-a6f00038f1fd',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Grundbuchtyp'
);

--changeset system:generated-update-data-AsText-ReIaziCategoryType context:any labels:c-any,o-table,ot-schema,on-ReIaziCategoryType,fin-13659 runOnChange:true
--comment: Generate AsText for ReIaziCategoryType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5d4a6c07-7baa-683a-822f-c2090376362f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5d4a6c07-7baa-683a-822f-c2090376362f',
    1,
    'MdTableDataDef',
    NULL,
    N'Iazi Category Type',
    N'Iazi Category Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5d4a6c07-7baa-683a-822f-c2090376362f',
    2,
    'MdTableDataDef',
    NULL,
    N'Iazi Category Type',
    N'Iazi Category Type'
);

--changeset system:generated-update-data-AsText-ReIaziEAPList context:any labels:c-any,o-table,ot-schema,on-ReIaziEAPList,fin-13659 runOnChange:true
--comment: Generate AsText for ReIaziEAPList
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='960cf0b7-46b1-0a3c-ab32-f0afdba2b38c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '960cf0b7-46b1-0a3c-ab32-f0afdba2b38c',
    1,
    'MdTableDataDef',
    NULL,
    N'ReIaziEAPList',
    N'ReIaziEAPList'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '960cf0b7-46b1-0a3c-ab32-f0afdba2b38c',
    2,
    'MdTableDataDef',
    NULL,
    N'ReIaziEAPList',
    N'ReIaziEAPList'
);

--changeset system:generated-update-data-AsText-ReIaziEAPXMLSchema context:any labels:c-any,o-table,ot-schema,on-ReIaziEAPXMLSchema,fin-13659 runOnChange:true
--comment: Generate AsText for ReIaziEAPXMLSchema
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6d4e0918-b6fe-523a-8235-6fda3e5cf29e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6d4e0918-b6fe-523a-8235-6fda3e5cf29e',
    1,
    'MdTableDataDef',
    NULL,
    N'ReIaziEAPXMLSchema',
    N'ReIaziEAPXMLSchema'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6d4e0918-b6fe-523a-8235-6fda3e5cf29e',
    2,
    'MdTableDataDef',
    NULL,
    N'ReIaziEAPXMLSchema',
    N'ReIaziEAPXMLSchema'
);

--changeset system:generated-update-data-AsText-ReIaziProcessType context:any labels:c-any,o-table,ot-schema,on-ReIaziProcessType,fin-13659 runOnChange:true
--comment: Generate AsText for ReIaziProcessType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7533bfce-8699-733f-bf23-6b4279167cf3';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7533bfce-8699-733f-bf23-6b4279167cf3',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Iazi Process Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7533bfce-8699-733f-bf23-6b4279167cf3',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Iazi Process Type'
);

--changeset system:generated-update-data-AsText-ReIaziQualityCode context:any labels:c-any,o-table,ot-schema,on-ReIaziQualityCode,fin-13659 runOnChange:true
--comment: Generate AsText for ReIaziQualityCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9005a796-53e9-dd3a-8ed0-5f9e2fcd6b3a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9005a796-53e9-dd3a-8ed0-5f9e2fcd6b3a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Iazi Quality Code'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9005a796-53e9-dd3a-8ed0-5f9e2fcd6b3a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Iazi Quality Code'
);

--changeset system:generated-update-data-AsText-ReIaziTransactionType context:any labels:c-any,o-table,ot-schema,on-ReIaziTransactionType,fin-13659 runOnChange:true
--comment: Generate AsText for ReIaziTransactionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d17d69e2-a0c5-663b-a306-aaab1cd32980';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd17d69e2-a0c5-663b-a306-aaab1cd32980',
    1,
    'MdTableDataDef',
    NULL,
    N'Iazi Transaction Type',
    N'Iazi Transaction Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd17d69e2-a0c5-663b-a306-aaab1cd32980',
    2,
    'MdTableDataDef',
    NULL,
    N'Iazi Transaction Typ',
    N'Iazi Transaction Typ'
);

--changeset system:generated-update-data-AsText-ReIaziWSEvalDeliveryType context:any labels:c-any,o-table,ot-schema,on-ReIaziWSEvalDeliveryType,fin-13659 runOnChange:true
--comment: Generate AsText for ReIaziWSEvalDeliveryType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c0bf4484-b027-9130-9fa8-1022e8db01bb';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c0bf4484-b027-9130-9fa8-1022e8db01bb',
    1,
    'MdTableDataDef',
    NULL,
    N'ReIaziWSEvalDeliveryType',
    N'ReIaziWSEvalDeliveryType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c0bf4484-b027-9130-9fa8-1022e8db01bb',
    2,
    'MdTableDataDef',
    NULL,
    N'ReIaziWSEvalDeliveryType',
    N'ReIaziWSEvalDeliveryType'
);

--changeset system:generated-update-data-AsText-ReIaziWSEvalParamQuality context:any labels:c-any,o-table,ot-schema,on-ReIaziWSEvalParamQuality,fin-13659 runOnChange:true
--comment: Generate AsText for ReIaziWSEvalParamQuality
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5a576709-8c79-1431-84ce-0e5aa5f70983';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5a576709-8c79-1431-84ce-0e5aa5f70983',
    1,
    'MdTableDataDef',
    NULL,
    N'ReIaziWSEvalParamQuality',
    N'ReIaziWSEvalParamQuality'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5a576709-8c79-1431-84ce-0e5aa5f70983',
    2,
    'MdTableDataDef',
    NULL,
    N'ReIaziWSEvalParamQuality',
    N'ReIaziWSEvalParamQuality'
);

--changeset system:generated-update-data-AsText-ReIaziWSEvalQuality context:any labels:c-any,o-table,ot-schema,on-ReIaziWSEvalQuality,fin-13659 runOnChange:true
--comment: Generate AsText for ReIaziWSEvalQuality
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5b98d6f3-6264-9a34-988f-fed2f6125d0f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5b98d6f3-6264-9a34-988f-fed2f6125d0f',
    1,
    'MdTableDataDef',
    NULL,
    N'ReIaziWSEvalQuality',
    N'ReIaziWSEvalQuality'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5b98d6f3-6264-9a34-988f-fed2f6125d0f',
    2,
    'MdTableDataDef',
    NULL,
    N'ReIaziWSEvalQuality',
    N'ReIaziWSEvalQuality'
);

--changeset system:generated-update-data-AsText-ReIaziWSEvalStatus context:any labels:c-any,o-table,ot-schema,on-ReIaziWSEvalStatus,fin-13659 runOnChange:true
--comment: Generate AsText for ReIaziWSEvalStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6b837ef5-91f1-cd31-9f0b-f5b7cbbc656c';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6b837ef5-91f1-cd31-9f0b-f5b7cbbc656c',
    1,
    'MdTableDataDef',
    NULL,
    N'ReIaziWSEvalStatus',
    N'ReIaziWSEvalStatus'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6b837ef5-91f1-cd31-9f0b-f5b7cbbc656c',
    2,
    'MdTableDataDef',
    NULL,
    N'ReIaziWSEvalStatus',
    N'ReIaziWSEvalStatus'
);

--changeset system:generated-update-data-AsText-ReImmissionIntensity context:any labels:c-any,o-table,ot-schema,on-ReImmissionIntensity,fin-13659 runOnChange:true
--comment: Generate AsText for ReImmissionIntensity
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0403fd88-1d02-2938-9fc8-5255aa755693';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0403fd88-1d02-2938-9fc8-5255aa755693',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Intensity'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0403fd88-1d02-2938-9fc8-5255aa755693',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Intensität'
);

--changeset system:generated-update-data-AsText-ReImmissionSourceType context:any labels:c-any,o-table,ot-schema,on-ReImmissionSourceType,fin-13659 runOnChange:true
--comment: Generate AsText for ReImmissionSourceType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ad5e6efa-8b83-063c-a6d8-d99a3e9fef9e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ad5e6efa-8b83-063c-a6d8-d99a3e9fef9e',
    1,
    'MdTableDataDef',
    NULL,
    N'Immission Source',
    N'Immission Source'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ad5e6efa-8b83-063c-a6d8-d99a3e9fef9e',
    2,
    'MdTableDataDef',
    NULL,
    N'Verursacher',
    N'Verursacher'
);

--changeset system:generated-update-data-AsText-ReImmissionType context:any labels:c-any,o-table,ot-schema,on-ReImmissionType,fin-13659 runOnChange:true
--comment: Generate AsText for ReImmissionType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1a7b73ee-313a-8a3c-8839-12aaecab4edf';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1a7b73ee-313a-8a3c-8839-12aaecab4edf',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Immission Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1a7b73ee-313a-8a3c-8839-12aaecab4edf',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Immissionsart'
);

--changeset system:generated-update-data-AsText-ReIndexType context:any labels:c-any,o-table,ot-schema,on-ReIndexType,fin-13659 runOnChange:true
--comment: Generate AsText for ReIndexType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='9ef6dcce-4d6e-9335-9067-29e26378a52e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9ef6dcce-4d6e-9335-9067-29e26378a52e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Index'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '9ef6dcce-4d6e-9335-9067-29e26378a52e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Index'
);

--changeset system:generated-update-data-AsText-ReInfrastructure context:any labels:c-any,o-table,ot-schema,on-ReInfrastructure,fin-13659 runOnChange:true
--comment: Generate AsText for ReInfrastructure
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='6ea8a559-afac-a43b-b9da-8a21937a9b26';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6ea8a559-afac-a43b-b9da-8a21937a9b26',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'infrastructure'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '6ea8a559-afac-a43b-b9da-8a21937a9b26',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Infrastruktur'
);

--changeset system:generated-update-data-AsText-ReInterestType context:any labels:c-any,o-table,ot-schema,on-ReInterestType,fin-13659 runOnChange:true
--comment: Generate AsText for ReInterestType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='807c9cf9-b21f-9c33-b2fb-b13a35300ced';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '807c9cf9-b21f-9c33-b2fb-b13a35300ced',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Interestrate Basis'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '807c9cf9-b21f-9c33-b2fb-b13a35300ced',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Zinssatzbasis'
);

--changeset system:generated-update-data-AsText-ReInvestmentStyle context:any labels:c-any,o-table,ot-schema,on-ReInvestmentStyle,fin-13659 runOnChange:true
--comment: Generate AsText for ReInvestmentStyle
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='805d6dcb-1af6-ee34-8f97-3a78a995214e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '805d6dcb-1af6-ee34-8f97-3a78a995214e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Investment sytle'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '805d6dcb-1af6-ee34-8f97-3a78a995214e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Investitionsart'
);

--changeset system:generated-update-data-AsText-ReInvestmentType context:any labels:c-any,o-table,ot-schema,on-ReInvestmentType,fin-13659 runOnChange:true
--comment: Generate AsText for ReInvestmentType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='42429067-9340-d936-81b2-65a0dd6e004a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '42429067-9340-d936-81b2-65a0dd6e004a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Investment type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '42429067-9340-d936-81b2-65a0dd6e004a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Investitionstyp'
);

--changeset system:generated-update-data-AsText-ReLandType context:any labels:c-any,o-table,ot-schema,on-ReLandType,fin-13659 runOnChange:true
--comment: Generate AsText for ReLandType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8868c576-b104-1b35-bbba-bcb053f8bb42';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8868c576-b104-1b35-bbba-bcb053f8bb42',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Country Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8868c576-b104-1b35-bbba-bcb053f8bb42',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Landtyp'
);

--changeset system:generated-update-data-AsText-ReLegalLienType context:any labels:c-any,o-table,ot-schema,on-ReLegalLienType,fin-13659 runOnChange:true
--comment: Generate AsText for ReLegalLienType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0a195668-0bb9-8838-a382-5128d28d228b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0a195668-0bb9-8838-a382-5128d28d228b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'LegalLienType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0a195668-0bb9-8838-a382-5128d28d228b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Art gesetzl. Pfandrecht'
);

--changeset system:generated-update-data-AsText-ReLegalTrans context:any labels:c-any,o-table,ot-schema,on-ReLegalTrans,fin-13659 runOnChange:true
--comment: Generate AsText for ReLegalTrans
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='67f0b78e-d9b6-8b39-a9ca-991acc6a2bda';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '67f0b78e-d9b6-8b39-a9ca-991acc6a2bda',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Legal Transaction Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '67f0b78e-d9b6-8b39-a9ca-991acc6a2bda',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rechtsgeschäftsart'
);

--changeset system:generated-update-data-AsText-ReMinergieStandardType context:any labels:c-any,o-table,ot-schema,on-ReMinergieStandardType,fin-13659 runOnChange:true
--comment: Generate AsText for ReMinergieStandardType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1868a2b1-720b-853e-9453-2651f829a3ab';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1868a2b1-720b-853e-9453-2651f829a3ab',
    1,
    'MdTableDataDef',
    NULL,
    N'Minergie Standard',
    N'Minergie Standard'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1868a2b1-720b-853e-9453-2651f829a3ab',
    2,
    'MdTableDataDef',
    NULL,
    N'Minergie Standard',
    N'Minergie Standard'
);

--changeset system:generated-update-data-AsText-ReNegotiability context:any labels:c-any,o-table,ot-schema,on-ReNegotiability,fin-13659 runOnChange:true
--comment: Generate AsText for ReNegotiability
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='e0ceada1-c043-1d32-b445-45385b7cc9b8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e0ceada1-c043-1d32-b445-45385b7cc9b8',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Negotiability'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'e0ceada1-c043-1d32-b445-45385b7cc9b8',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Verkäuflichkeit'
);

--changeset system:generated-update-data-AsText-ReNoteAdd context:any labels:c-any,o-table,ot-schema,on-ReNoteAdd,fin-13659 runOnChange:true
--comment: Generate AsText for ReNoteAdd
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a52de233-e9b7-ba3b-a951-b33136b32f79';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a52de233-e9b7-ba3b-a951-b33136b32f79',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Note Addition'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a52de233-e9b7-ba3b-a951-b33136b32f79',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Miteigentumsanteil'
);

--changeset system:generated-update-data-AsText-ReNoteType context:any labels:c-any,o-table,ot-schema,on-ReNoteType,fin-13659 runOnChange:true
--comment: Generate AsText for ReNoteType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4cb16d36-192f-ef32-873d-2a53a408ad7f';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4cb16d36-192f-ef32-873d-2a53a408ad7f',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Notetype'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4cb16d36-192f-ef32-873d-2a53a408ad7f',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Anmerkungsart'
);

--changeset system:generated-update-data-AsText-ReObligLienCreation context:any labels:c-any,o-table,ot-schema,on-ReObligLienCreation,fin-13659 runOnChange:true
--comment: Generate AsText for ReObligLienCreation
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d8c54b17-adeb-5d3c-9ba4-ab7c85fef071';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd8c54b17-adeb-5d3c-9ba4-ab7c85fef071',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Lien Creation'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd8c54b17-adeb-5d3c-9ba4-ab7c85fef071',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Pfandrecht Verarbeitung'
);

--changeset system:generated-update-data-AsText-ReObligLienStatus context:any labels:c-any,o-table,ot-schema,on-ReObligLienStatus,fin-13659 runOnChange:true
--comment: Generate AsText for ReObligLienStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='19318511-28e2-b13d-b53d-41c242f73128';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '19318511-28e2-b13d-b53d-41c242f73128',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Lien Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '19318511-28e2-b13d-b53d-41c242f73128',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Pfandrecht Status'
);

--changeset system:generated-update-data-AsText-ReObligObligeeRight context:any labels:c-any,o-table,ot-schema,on-ReObligObligeeRight,fin-13659 runOnChange:true
--comment: Generate AsText for ReObligObligeeRight
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bfec823c-9b7c-4d38-b08d-4f5961153a32';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bfec823c-9b7c-4d38-b08d-4f5961153a32',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Obligee Right'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bfec823c-9b7c-4d38-b08d-4f5961153a32',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gläubigerrecht'
);

--changeset system:generated-update-data-AsText-ReObligObligeeStatus context:any labels:c-any,o-table,ot-schema,on-ReObligObligeeStatus,fin-13659 runOnChange:true
--comment: Generate AsText for ReObligObligeeStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3e15b43b-9b95-513f-8407-2f56424413ec';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3e15b43b-9b95-513f-8407-2f56424413ec',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Obligee Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3e15b43b-9b95-513f-8407-2f56424413ec',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gläubigerstatus'
);

--changeset system:generated-update-data-AsText-ReObligObligeeType context:any labels:c-any,o-table,ot-schema,on-ReObligObligeeType,fin-13659 runOnChange:true
--comment: Generate AsText for ReObligObligeeType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a57e9fde-173c-c43e-950f-5f1b529bb45d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a57e9fde-173c-c43e-950f-5f1b529bb45d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Obligee Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a57e9fde-173c-c43e-950f-5f1b529bb45d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gläubiger Typ'
);

--changeset system:generated-update-data-AsText-ReObligType context:any labels:c-any,o-table,ot-schema,on-ReObligType,fin-13659 runOnChange:true
--comment: Generate AsText for ReObligType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c6be97c2-faa1-5739-a0f5-d81d10f393fd';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c6be97c2-faa1-5739-a0f5-d81d10f393fd',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Obligationtype'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c6be97c2-faa1-5739-a0f5-d81d10f393fd',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Schuldbrief Art'
);

--changeset system:generated-update-data-AsText-ReParkingType context:any labels:c-any,o-table,ot-schema,on-ReParkingType,fin-13659 runOnChange:true
--comment: Generate AsText for ReParkingType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='db7e47cb-6bbc-ba3c-9b1a-706e70d53f57';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'db7e47cb-6bbc-ba3c-9b1a-706e70d53f57',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ParkingType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'db7e47cb-6bbc-ba3c-9b1a-706e70d53f57',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Parkiermöglichkeitstyp'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'db7e47cb-6bbc-ba3c-9b1a-706e70d53f57',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'parking type'
);

--changeset system:generated-update-data-AsText-RePfBMessageType context:any labels:c-any,o-table,ot-schema,on-RePfBMessageType,fin-13659 runOnChange:true
--comment: Generate AsText for RePfBMessageType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='c0a91d97-8d52-b731-ad63-667ca2b2e9bd';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c0a91d97-8d52-b731-ad63-667ca2b2e9bd',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Pledge MessageType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'c0a91d97-8d52-b731-ad63-667ca2b2e9bd',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Pfandregister Meldungstyp'
);

--changeset system:generated-update-data-AsText-RePfBRelBC context:any labels:c-any,o-table,ot-schema,on-RePfBRelBC,fin-13659 runOnChange:true
--comment: Generate AsText for RePfBRelBC
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1ac8a542-10b5-033a-89fb-51acee0f719b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1ac8a542-10b5-033a-89fb-51acee0f719b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'PfB No'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1ac8a542-10b5-033a-89fb-51acee0f719b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Mitgliedno PfB'
);

--changeset system:generated-update-data-AsText-RePledgeRegisterAccAmortPeriod context:any labels:c-any,o-table,ot-schema,on-RePledgeRegisterAccAmortPeriod,fin-13659 runOnChange:true
--comment: Generate AsText for RePledgeRegisterAccAmortPeriod
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2385caa5-0613-9b30-bc44-a65beae96f87';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2385caa5-0613-9b30-bc44-a65beae96f87',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Amort Periode'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2385caa5-0613-9b30-bc44-a65beae96f87',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Amortisationsperiode'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2385caa5-0613-9b30-bc44-a65beae96f87',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Periode d''amortissement'
);

--changeset system:generated-update-data-AsText-RePledgeRegisterExtCode context:any labels:c-any,o-table,ot-schema,on-RePledgeRegisterExtCode,fin-13659 runOnChange:true
--comment: Generate AsText for RePledgeRegisterExtCode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7490b7f7-5e81-af3e-91f6-be13666b2412';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7490b7f7-5e81-af3e-91f6-be13666b2412',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'external Text Code'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7490b7f7-5e81-af3e-91f6-be13666b2412',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'ext.Text Grund'
);

--changeset system:generated-update-data-AsText-RePledgeRegisterIssueStatus context:any labels:c-any,o-table,ot-schema,on-RePledgeRegisterIssueStatus,fin-13659 runOnChange:true
--comment: Generate AsText for RePledgeRegisterIssueStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='8659a449-c318-6931-b048-94c43108e6c4';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8659a449-c318-6931-b048-94c43108e6c4',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '8659a449-c318-6931-b048-94c43108e6c4',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Status'
);

--changeset system:generated-update-data-AsText-RePledgeRegisterIssueType context:any labels:c-any,o-table,ot-schema,on-RePledgeRegisterIssueType,fin-13659 runOnChange:true
--comment: Generate AsText for RePledgeRegisterIssueType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='5bfb4b42-9917-ff3f-829c-6bba22ae7654';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5bfb4b42-9917-ff3f-829c-6bba22ae7654',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Issue Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '5bfb4b42-9917-ff3f-829c-6bba22ae7654',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Pendenzentyp'
);

--changeset system:generated-update-data-AsText-RePledgeRegisterStatus context:any labels:c-any,o-table,ot-schema,on-RePledgeRegisterStatus,fin-13659 runOnChange:true
--comment: Generate AsText for RePledgeRegisterStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='7b54be50-5841-ab3b-844b-1b8665e41ecd';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7b54be50-5841-ab3b-844b-1b8665e41ecd',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '7b54be50-5841-ab3b-844b-1b8665e41ecd',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Pfandregisterstatus'
);

--changeset system:generated-update-data-AsText-RePledgeTransType context:any labels:c-any,o-table,ot-schema,on-RePledgeTransType,fin-13659 runOnChange:true
--comment: Generate AsText for RePledgeTransType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='40b4d147-02b9-a63a-939b-8a65b387bc50';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '40b4d147-02b9-a63a-939b-8a65b387bc50',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Pledge Transtype'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '40b4d147-02b9-a63a-939b-8a65b387bc50',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Pfandregister Transtyp'
);

--changeset system:generated-update-data-AsText-RePledgeType context:any labels:c-any,o-table,ot-schema,on-RePledgeType,fin-13659 runOnChange:true
--comment: Generate AsText for RePledgeType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0bb945a9-41c5-0c3b-b30c-01c35109cc6b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0bb945a9-41c5-0c3b-b30c-01c35109cc6b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Pledge Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0bb945a9-41c5-0c3b-b30c-01c35109cc6b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Pfandobjektart'
);

--changeset system:generated-update-data-AsText-RePollutionCause context:any labels:c-any,o-table,ot-schema,on-RePollutionCause,fin-13659 runOnChange:true
--comment: Generate AsText for RePollutionCause
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='91843474-1cc6-b93c-8646-e59d195fdc73';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '91843474-1cc6-b93c-8646-e59d195fdc73',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'pollution cause'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '91843474-1cc6-b93c-8646-e59d195fdc73',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ursachen für Altlasten'
);

--changeset system:generated-update-data-AsText-RePremisesPtRelType context:any labels:c-any,o-table,ot-schema,on-RePremisesPtRelType,fin-13659 runOnChange:true
--comment: Generate AsText for RePremisesPtRelType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='67b2f5ff-a141-223f-975a-25022e39721a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '67b2f5ff-a141-223f-975a-25022e39721a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'PremisesPtRelType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '67b2f5ff-a141-223f-975a-25022e39721a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Grundst.Partner Verb.Typ'
);

--changeset system:generated-update-data-AsText-RePremisesRelAccountRule context:any labels:c-any,o-table,ot-schema,on-RePremisesRelAccountRule,fin-13659 runOnChange:true
--comment: Generate AsText for RePremisesRelAccountRule
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='977d2a0b-74f1-2630-8eda-aa1ca0aedbb5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '977d2a0b-74f1-2630-8eda-aa1ca0aedbb5',
    1,
    'MdTableDataDef',
    NULL,
    N'RePremisesRelAccountRule',
    N'RePremisesRelAccountRule'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '977d2a0b-74f1-2630-8eda-aa1ca0aedbb5',
    2,
    'MdTableDataDef',
    NULL,
    N'RePremisesRelAccountRule',
    N'RePremisesRelAccountRule'
);

--changeset system:generated-update-data-AsText-RePremisesRelObligType context:any labels:c-any,o-table,ot-schema,on-RePremisesRelObligType,fin-13659 runOnChange:true
--comment: Generate AsText for RePremisesRelObligType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0e7a2e8e-c3d5-293b-9da9-770cf9f067e8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0e7a2e8e-c3d5-293b-9da9-770cf9f067e8',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'RelObligType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0e7a2e8e-c3d5-293b-9da9-770cf9f067e8',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Pflichten'
);

--changeset system:generated-update-data-AsText-RePremisesRelRightType context:any labels:c-any,o-table,ot-schema,on-RePremisesRelRightType,fin-13659 runOnChange:true
--comment: Generate AsText for RePremisesRelRightType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d1061131-9dae-143b-8f3e-dab03055a41e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd1061131-9dae-143b-8f3e-dab03055a41e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'RelRightType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd1061131-9dae-143b-8f3e-dab03055a41e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Rechte'
);

--changeset system:generated-update-data-AsText-RePremisesRelSTWEType context:any labels:c-any,o-table,ot-schema,on-RePremisesRelSTWEType,fin-13659 runOnChange:true
--comment: Generate AsText for RePremisesRelSTWEType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a8ca175c-7c1c-8831-aa8e-97fbc428b52a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a8ca175c-7c1c-8831-aa8e-97fbc428b52a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Relation STWE'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a8ca175c-7c1c-8831-aa8e-97fbc428b52a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'STWE Verbindung'
);

--changeset system:generated-update-data-AsText-RePremisesType context:any labels:c-any,o-table,ot-schema,on-RePremisesType,fin-13659 runOnChange:true
--comment: Generate AsText for RePremisesType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='fe815dc4-1665-e73c-bd9a-7bb5f1cf793e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fe815dc4-1665-e73c-bd9a-7bb5f1cf793e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Premises Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'fe815dc4-1665-e73c-bd9a-7bb5f1cf793e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Grundstuecktyp'
);

--changeset system:generated-update-data-AsText-RePropertyType context:any labels:c-any,o-table,ot-schema,on-RePropertyType,fin-13659 runOnChange:true
--comment: Generate AsText for RePropertyType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a5804462-9d92-3930-b7d0-ed46845ac9bd';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a5804462-9d92-3930-b7d0-ed46845ac9bd',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Property Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a5804462-9d92-3930-b7d0-ed46845ac9bd',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Eigentumsart'
);

--changeset system:generated-update-data-AsText-ReResType context:any labels:c-any,o-table,ot-schema,on-ReResType,fin-13659 runOnChange:true
--comment: Generate AsText for ReResType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4b18ea38-cdd3-b03e-932c-75836ba59288';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4b18ea38-cdd3-b03e-932c-75836ba59288',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Reservation Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4b18ea38-cdd3-b03e-932c-75836ba59288',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Vormerkungstyp'
);

--changeset system:generated-update-data-AsText-ReRoomCountingMethod context:any labels:c-any,o-table,ot-schema,on-ReRoomCountingMethod,fin-13659 runOnChange:true
--comment: Generate AsText for ReRoomCountingMethod
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2c1c9f27-e3e6-cc3f-ba11-0e0fc352fdfd';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2c1c9f27-e3e6-cc3f-ba11-0e0fc352fdfd',
    1,
    'MdTableDataDef',
    NULL,
    N'ReRoomCountingMethod',
    N'ReRoomCountingMethod'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2c1c9f27-e3e6-cc3f-ba11-0e0fc352fdfd',
    2,
    'MdTableDataDef',
    NULL,
    N'ReRoomCountingMethod',
    N'ReRoomCountingMethod'
);

--changeset system:generated-update-data-AsText-ReRoomType context:any labels:c-any,o-table,ot-schema,on-ReRoomType,fin-13659 runOnChange:true
--comment: Generate AsText for ReRoomType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='27239a32-31c4-4f3b-b1c0-5bbb7dcee9f1';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '27239a32-31c4-4f3b-b1c0-5bbb7dcee9f1',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'room type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '27239a32-31c4-4f3b-b1c0-5bbb7dcee9f1',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Raumtyp'
);

--changeset system:generated-update-data-AsText-ReRoomTypeCategory context:any labels:c-any,o-table,ot-schema,on-ReRoomTypeCategory,fin-13659 runOnChange:true
--comment: Generate AsText for ReRoomTypeCategory
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='43a76d58-334a-1639-8ad2-555701841061';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '43a76d58-334a-1639-8ad2-555701841061',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Room Type Category'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '43a76d58-334a-1639-8ad2-555701841061',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Raumkategorie'
);

--changeset system:generated-update-data-AsText-ReSituationAllocation context:any labels:c-any,o-table,ot-schema,on-ReSituationAllocation,fin-13659 runOnChange:true
--comment: Generate AsText for ReSituationAllocation
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='cbef336b-ed81-cb34-b8b5-f4fcec48f20d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cbef336b-ed81-cb34-b8b5-f4fcec48f20d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Situation Allocation'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cbef336b-ed81-cb34-b8b5-f4fcec48f20d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Lagezuordnung'
);

--changeset system:generated-update-data-AsText-ReSituationDistanceType context:any labels:c-any,o-table,ot-schema,on-ReSituationDistanceType,fin-13659 runOnChange:true
--comment: Generate AsText for ReSituationDistanceType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='87376223-f37d-9a3b-82fc-bac9f2c41b1d';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '87376223-f37d-9a3b-82fc-bac9f2c41b1d',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Situation Distance'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '87376223-f37d-9a3b-82fc-bac9f2c41b1d',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Infrastruktur Distanz'
);

--changeset system:generated-update-data-AsText-ReSituationType context:any labels:c-any,o-table,ot-schema,on-ReSituationType,fin-13659 runOnChange:true
--comment: Generate AsText for ReSituationType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='bb4296c3-6de4-363f-8cca-652ff0d98234';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bb4296c3-6de4-363f-8cca-652ff0d98234',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Situation Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'bb4296c3-6de4-363f-8cca-652ff0d98234',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'det. Lagebeurteilung'
);

--changeset system:generated-update-data-AsText-ReTownCategory context:any labels:c-any,o-table,ot-schema,on-ReTownCategory,fin-13659 runOnChange:true
--comment: Generate AsText for ReTownCategory
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='0c14037b-340f-923e-8ad6-b5e9032ee598';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0c14037b-340f-923e-8ad6-b5e9032ee598',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Town Category'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '0c14037b-340f-923e-8ad6-b5e9032ee598',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ortskategorie'
);

--changeset system:generated-update-data-AsText-ReTownType context:any labels:c-any,o-table,ot-schema,on-ReTownType,fin-13659 runOnChange:true
--comment: Generate AsText for ReTownType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2f592150-0c63-4037-86b2-dfbd3b73da7e';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2f592150-0c63-4037-86b2-dfbd3b73da7e',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Town Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2f592150-0c63-4037-86b2-dfbd3b73da7e',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Ortstyp'
);

--changeset system:generated-update-data-AsText-ReUseType context:any labels:c-any,o-table,ot-schema,on-ReUseType,fin-13659 runOnChange:true
--comment: Generate AsText for ReUseType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='37015c79-1c45-7231-97f9-12e887207877';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '37015c79-1c45-7231-97f9-12e887207877',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Type of use'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '37015c79-1c45-7231-97f9-12e887207877',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Nutzungsart'
);

--changeset system:generated-update-data-AsText-ReValuationExtType context:any labels:c-any,o-table,ot-schema,on-ReValuationExtType,fin-13659 runOnChange:true
--comment: Generate AsText for ReValuationExtType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1d855e8a-2af3-813e-8ca6-098419873922';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1d855e8a-2af3-813e-8ca6-098419873922',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ext valuation type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1d855e8a-2af3-813e-8ca6-098419873922',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'ext. Schätzungsart'
);

--changeset system:generated-update-data-AsText-ReValuationReasonType context:any labels:c-any,o-table,ot-schema,on-ReValuationReasonType,fin-13659 runOnChange:true
--comment: Generate AsText for ReValuationReasonType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='07345d03-7503-ff36-ad6e-6954a0b78e5b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '07345d03-7503-ff36-ad6e-6954a0b78e5b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'ReasonType'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '07345d03-7503-ff36-ad6e-6954a0b78e5b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Schätzungsgrund'
);

--changeset system:generated-update-data-AsText-ReValuationStatus context:any labels:c-any,o-table,ot-schema,on-ReValuationStatus,fin-13659 runOnChange:true
--comment: Generate AsText for ReValuationStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4d95133d-1034-db37-acaa-06b4252fc507';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4d95133d-1034-db37-acaa-06b4252fc507',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'valuation status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4d95133d-1034-db37-acaa-06b4252fc507',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Schätzungsstatus'
);

--changeset system:generated-update-data-AsText-ReValueCalcMethode context:any labels:c-any,o-table,ot-schema,on-ReValueCalcMethode,fin-13659 runOnChange:true
--comment: Generate AsText for ReValueCalcMethode
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='d20b8ec4-1726-4538-8751-87aca591af33';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd20b8ec4-1726-4538-8751-87aca591af33',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'calculation methode'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'd20b8ec4-1726-4538-8751-87aca591af33',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Kalkulationsart'
);

--changeset system:generated-update-data-AsText-ReValueType context:any labels:c-any,o-table,ot-schema,on-ReValueType,fin-13659 runOnChange:true
--comment: Generate AsText for ReValueType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='36d3c1d2-4707-7232-a941-f8efc10fb6db';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '36d3c1d2-4707-7232-a941-f8efc10fb6db',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Value Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '36d3c1d2-4707-7232-a941-f8efc10fb6db',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Werttyp'
);

--changeset system:generated-update-data-AsText-ReVolumeUsability context:any labels:c-any,o-table,ot-schema,on-ReVolumeUsability,fin-13659 runOnChange:true
--comment: Generate AsText for ReVolumeUsability
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='2f7fd119-6f04-933a-b392-016c002a2d21';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2f7fd119-6f04-933a-b392-016c002a2d21',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'volume usability'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '2f7fd119-6f04-933a-b392-016c002a2d21',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Nutzungsbeurt. Gbde-Vol.'
);

--changeset system:generated-update-data-AsText-SwBankOperation context:any labels:c-any,o-table,ot-schema,on-SwBankOperation,fin-13659 runOnChange:true
--comment: Generate AsText for SwBankOperation
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1ff68297-7f1c-9c31-ab8f-c85b9520eecc';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1ff68297-7f1c-9c31-ab8f-c85b9520eecc',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Swift Bank Operation Code'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1ff68297-7f1c-9c31-ab8f-c85b9520eecc',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Swift Bank Operation Code'
);

--changeset system:generated-update-data-AsText-SwMT565MsgType context:any labels:c-any,o-table,ot-schema,on-SwMT565MsgType,fin-13659 runOnChange:true
--comment: Generate AsText for SwMT565MsgType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='cca3d215-d32b-5337-b34a-fc1bfe1f0d36';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cca3d215-d32b-5337-b34a-fc1bfe1f0d36',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Mt565 Msg Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cca3d215-d32b-5337-b34a-fc1bfe1f0d36',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Mt565 Msg Typ'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'cca3d215-d32b-5337-b34a-fc1bfe1f0d36',
    3,
    'MdTableDataDef',
    NULL,
    N'',
    N'Mt565 Msg Type'
);

--changeset system:generated-update-data-AsText-SwTransType context:any labels:c-any,o-table,ot-schema,on-SwTransType,fin-13659 runOnChange:true
--comment: Generate AsText for SwTransType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1147de05-a975-013b-bc55-ce34c1205b83';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1147de05-a975-013b-bc55-ce34c1205b83',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'SwiftTransTypeCode'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1147de05-a975-013b-bc55-ce34c1205b83',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Swift Trans Type Code'
);

--changeset system:generated-update-data-AsText-Test context:any labels:c-any,o-table,ot-schema,on-Test,fin-13659 runOnChange:true
--comment: Generate AsText for Test
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='1166bc0c-54f5-d03b-809a-388dc95a615b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1166bc0c-54f5-d03b-809a-388dc95a615b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Test'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '1166bc0c-54f5-d03b-809a-388dc95a615b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Test'
);

--changeset system:generated-update-data-AsText-TrMessageStandardType context:any labels:c-any,o-table,ot-schema,on-TrMessageStandardType,fin-13659 runOnChange:true
--comment: Generate AsText for TrMessageStandardType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f4a7bd4a-3318-1333-9242-87393a192f50';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f4a7bd4a-3318-1333-9242-87393a192f50',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Message Standard'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f4a7bd4a-3318-1333-9242-87393a192f50',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Message Standard'
);

--changeset system:generated-update-data-AsText-TrPlace context:any labels:c-any,o-table,ot-schema,on-TrPlace,fin-13659 runOnChange:true
--comment: Generate AsText for TrPlace
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='81f72532-001f-6133-a4a4-767843ad0a94';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '81f72532-001f-6133-a4a4-767843ad0a94',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Trading Place'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '81f72532-001f-6133-a4a4-767843ad0a94',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Handelplatz'
);

--changeset system:generated-update-data-AsText-WfNotificationStatus context:any labels:c-any,o-table,ot-schema,on-WfNotificationStatus,fin-13659 runOnChange:true
--comment: Generate AsText for WfNotificationStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a7c6a4f9-c0af-613e-bf1a-b51991b5730b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a7c6a4f9-c0af-613e-bf1a-b51991b5730b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Notification Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a7c6a4f9-c0af-613e-bf1a-b51991b5730b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Mitteilungsstatus'
);

--changeset system:generated-update-data-AsText-WfNotificationType context:any labels:c-any,o-table,ot-schema,on-WfNotificationType,fin-13659 runOnChange:true
--comment: Generate AsText for WfNotificationType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='42312819-ebbd-da37-8e8b-9f63ef62691a';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '42312819-ebbd-da37-8e8b-9f63ef62691a',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Notification Type'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '42312819-ebbd-da37-8e8b-9f63ef62691a',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Benachrichtigunstyp'
);

--changeset system:generated-update-data-AsText-WfStepStatus context:any labels:c-any,o-table,ot-schema,on-WfStepStatus,fin-13659 runOnChange:true
--comment: Generate AsText for WfStepStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='3e748e1f-65b5-5237-ab7d-4243910e6f5b';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3e748e1f-65b5-5237-ab7d-4243910e6f5b',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Workflow Step Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '3e748e1f-65b5-5237-ab7d-4243910e6f5b',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Workflow Stepstatus'
);

--changeset system:generated-update-data-AsText-WfStepType context:any labels:c-any,o-table,ot-schema,on-WfStepType,fin-13659 runOnChange:true
--comment: Generate AsText for WfStepType
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='a182f1d0-b088-a939-a8ef-06fa80dd08f8';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a182f1d0-b088-a939-a8ef-06fa80dd08f8',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Workflow Steptypes'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'a182f1d0-b088-a939-a8ef-06fa80dd08f8',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Workflow Steptyp'
);

--changeset system:generated-update-data-AsText-WfTaskStatus context:any labels:c-any,o-table,ot-schema,on-WfTaskStatus,fin-13659 runOnChange:true
--comment: Generate AsText for WfTaskStatus
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='4487db53-9c8a-df35-9d5b-46b0c60b5824';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4487db53-9c8a-df35-9d5b-46b0c60b5824',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Workflow Task Status'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '4487db53-9c8a-df35-9d5b-46b0c60b5824',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Workflow Aufgabenstatus'
);

--changeset system:generated-update-data-AsText-WtActivity context:any labels:c-any,o-table,ot-schema,on-WtActivity,fin-13659 runOnChange:true
--comment: Generate AsText for WtActivity
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='ef0fc889-db43-1032-a4b2-fb0ec590d971';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ef0fc889-db43-1032-a4b2-fb0ec590d971',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Activity'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'ef0fc889-db43-1032-a4b2-fb0ec590d971',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Aktivität'
);

--changeset system:generated-update-data-AsText-WtArea context:any labels:c-any,o-table,ot-schema,on-WtArea,fin-13659 runOnChange:true
--comment: Generate AsText for WtArea
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='f53f16bb-edfb-d83f-b8e9-9bd87f967292';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f53f16bb-edfb-d83f-b8e9-9bd87f967292',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Area'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    'f53f16bb-edfb-d83f-b8e9-9bd87f967292',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Gebiet'
);

--changeset system:generated-update-data-AsText-WtProject context:any labels:c-any,o-table,ot-schema,on-WtProject,fin-13659 runOnChange:true
--comment: Generate AsText for WtProject
DELETE FROM [dbo].[AsText] WHERE MasterTableName='MdTableDataDef' AND MasterId='503f7b84-3129-1b34-9096-a95b0b3790c5';
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '503f7b84-3129-1b34-9096-a95b0b3790c5',
    1,
    'MdTableDataDef',
    NULL,
    N'',
    N'Project'
);
INSERT INTO [dbo].[AsText] (
    Id,
    MasterId,
    LanguageNo,
    MasterTableName,
    SourceFlag,
    TextLong,
    TextShort
)
VALUES (
    newid(),
    '503f7b84-3129-1b34-9096-a95b0b3790c5',
    2,
    'MdTableDataDef',
    NULL,
    N'',
    N'Projekt'
);