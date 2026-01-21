--liquibase formatted sql

--changeset system:generated-update-data-MdGroup-AsText context:any labels:c-any,o-table,ot-data,on-AsText,fin-13659 runOnChange:true
--comment: Update data in AsText for table MdGroup
DELETE FROM AsText WHERE MasterTableName = 'MdGroup';

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'a4926754-03be-263a-b388-211179174a82', '55cf3376-ad4b-4c80-836a-4b8403901d1a', 1, 'MdGroup', NULL, NULL, N'Accountancy Reporting'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'c8709594-2f69-ab39-ba54-87d3048ee8d4', '55cf3376-ad4b-4c80-836a-4b8403901d1a', 2, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '6d17ae26-730a-e23c-8638-a7b292c6d9df', '55cf3376-ad4b-4c80-836a-4b8403901d1a', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'b2900957-eabe-e835-81f5-1aad9a0c495a', '55cf3376-ad4b-4c80-836a-4b8403901d1a', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'cfdb0232-f6a4-1531-a01c-7e5024452bb7', '6343cc8c-363d-4cce-968c-fe33e28066e0', 1, 'MdGroup', NULL, NULL, N'Aeoi'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '56ffd6bc-6ea8-f931-a26f-28b1e17add7e', '6343cc8c-363d-4cce-968c-fe33e28066e0', 2, 'MdGroup', NULL, N'Automatischer Informationsaustausch', N'Aeoi'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '4916578c-f50d-5a30-abdd-d5af7b0b4d17', '6343cc8c-363d-4cce-968c-fe33e28066e0', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '41b90d51-7c75-233b-a630-9dd16dd058a5', '6343cc8c-363d-4cce-968c-fe33e28066e0', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '2c4bd7b5-cd2d-603b-a9ef-4470030b5b8d', '1913daa1-53ed-41c4-a39e-d6e93a2e67d3', 1, 'MdGroup', NULL, NULL, N'Application System'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '3e89f54a-d56a-853c-8ffb-ae45aaea0ac0', '1913daa1-53ed-41c4-a39e-d6e93a2e67d3', 2, 'MdGroup', NULL, NULL, N'Applikationssystem'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '0ef051ab-446a-703e-bad5-469870df99b5', '1913daa1-53ed-41c4-a39e-d6e93a2e67d3', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'f933fd71-68f9-b731-b2ad-843fe297b764', '1913daa1-53ed-41c4-a39e-d6e93a2e67d3', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'f0e6259a-9b6d-fd38-b77b-1a45601ed5d9', '78cc5ca3-d241-48ac-9c89-b1583300cd2b', 1, 'MdGroup', NULL, NULL, N'Batch Processor'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '1565ddfd-9114-5d37-88ee-239cd19ed072', '78cc5ca3-d241-48ac-9c89-b1583300cd2b', 2, 'MdGroup', NULL, NULL, N'Batch Processor'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '5f6da9e5-7393-f038-a8c4-c96a11c8bd99', '78cc5ca3-d241-48ac-9c89-b1583300cd2b', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '71992a6c-8a74-6337-89be-dd5473e4ccc8', '78cc5ca3-d241-48ac-9c89-b1583300cd2b', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '3fe3a415-769a-a839-8d8a-9d970ca3bbea', 'c8abdfd0-d645-4dd5-8162-b50d7fe587cb', 1, 'MdGroup', NULL, NULL, N'Communication'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '2ee53f41-7387-573e-82f1-4ed5318e0c86', 'c8abdfd0-d645-4dd5-8162-b50d7fe587cb', 2, 'MdGroup', NULL, NULL, N'Kommunikation'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'f65ec1bd-9b47-043c-903b-3b511257d832', 'c8abdfd0-d645-4dd5-8162-b50d7fe587cb', 3, 'MdGroup', NULL, NULL, N'Communication'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '4d12ca8c-5296-6133-bd05-5f9175afdb4a', 'c8abdfd0-d645-4dd5-8162-b50d7fe587cb', 4, 'MdGroup', NULL, NULL, N'Communicazione'
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'efad253b-6a04-f733-ad0a-d10f4c7c0412', '39e36615-106e-4bd9-b32f-7d3294315ab3', 1, 'MdGroup', NULL, NULL, N'Currency'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '5e938149-08ab-c23b-a565-bf4b056cb8f3', '39e36615-106e-4bd9-b32f-7d3294315ab3', 2, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'e430d8c2-116e-be32-abaf-4db634f613e4', '39e36615-106e-4bd9-b32f-7d3294315ab3', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'ba47833a-fae7-7731-815f-a69b2a549e98', '39e36615-106e-4bd9-b32f-7d3294315ab3', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '5f7930d7-b4ac-403c-8548-b897addd7faa', '75acefc4-0a56-4966-97a8-53e8b891ec08', 1, 'MdGroup', NULL, NULL, N'Data Navigation'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'a5910777-ac12-313f-8efb-5a82a5eb448f', '75acefc4-0a56-4966-97a8-53e8b891ec08', 2, 'MdGroup', NULL, NULL, N'Datennavigation'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '74b95b61-69fe-d331-86f1-4ee8cfeb1b21', '75acefc4-0a56-4966-97a8-53e8b891ec08', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '51610ea9-56ca-ff3e-b381-430feaf359ce', '75acefc4-0a56-4966-97a8-53e8b891ec08', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '8a47d023-6ed4-4a31-a03c-d2c7983f13c6', 'cdfbe352-fbd8-46a5-aad6-6f893f64f551', 1, 'MdGroup', NULL, N'Data Store', N'DataStore'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'a121a29d-5344-9f35-8c4c-5dd51bb6fae3', 'cdfbe352-fbd8-46a5-aad6-6f893f64f551', 2, 'MdGroup', NULL, N'DataStore', N'DataStore'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'a314bc76-f1bb-db39-a15d-a4c4d466999f', 'cdfbe352-fbd8-46a5-aad6-6f893f64f551', 3, 'MdGroup', NULL, N'DataStore', N'DataStore'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '46f1858a-8968-a43c-9773-506fd025b272', 'cdfbe352-fbd8-46a5-aad6-6f893f64f551', 4, 'MdGroup', NULL, N'DataStore', N'DataStore'
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '375cdde0-a1ca-0b38-9bc8-d195fb0d7f87', '6b91ae05-a1a4-4f29-9a23-3235f80f4066', 1, 'MdGroup', NULL, NULL, N'Database Checks'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '63fa8707-1842-ee30-ba3d-89707d5d3dc6', '6b91ae05-a1a4-4f29-9a23-3235f80f4066', 2, 'MdGroup', NULL, NULL, N'Datenbankprüfungen'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '45cb78c5-bec8-3733-b2bd-b05606a85e17', '6b91ae05-a1a4-4f29-9a23-3235f80f4066', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'c93a18d6-87c9-e733-bb15-0a0b6c11aa7a', '6b91ae05-a1a4-4f29-9a23-3235f80f4066', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '9887cdc7-993b-a731-894e-16fbbf490497', '94c2d033-c482-4cd0-842b-8498330b12a6', 1, 'MdGroup', NULL, NULL, N'Development'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '7c7e5a99-83ea-8a39-8483-5abda2eec831', '94c2d033-c482-4cd0-842b-8498330b12a6', 2, 'MdGroup', NULL, NULL, N'Entwicklung'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'c51d4e49-5765-b63f-a865-acdfde25d10d', '94c2d033-c482-4cd0-842b-8498330b12a6', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '1f251a77-6d06-4539-890e-dfd8244517b4', '94c2d033-c482-4cd0-842b-8498330b12a6', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'e7a358f7-ea5d-b135-9de6-69c08c303f83', '50c8cf24-0d64-438a-8e98-cf3f5d8300f4', 1, 'MdGroup', NULL, NULL, N'EBanking'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '8011d003-9ed9-d13a-962b-d37fa63c1a83', '50c8cf24-0d64-438a-8e98-cf3f5d8300f4', 2, 'MdGroup', NULL, NULL, N'EBanking'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'e9f4a2e3-0dfe-bf35-aa57-17dbd7bfd0df', '50c8cf24-0d64-438a-8e98-cf3f5d8300f4', 3, 'MdGroup', NULL, NULL, N'EBanking'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '7d00dc7b-cadd-a73e-92f3-e707f04df7d1', '50c8cf24-0d64-438a-8e98-cf3f5d8300f4', 4, 'MdGroup', NULL, NULL, N'EBanking'
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '0b475b05-7bc7-e530-8234-799188dc83f5', '2ff0c162-5e66-40c2-b2f7-6f3afd0c03bb', 1, 'MdGroup', NULL, N'Tables used for EasyTax interface.', N'EasyTax'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '043242ab-3c5b-4a3f-bb3f-e63d17f9d22f', '2ff0c162-5e66-40c2-b2f7-6f3afd0c03bb', 2, 'MdGroup', NULL, N'Tabellen für die EasyTax Schnittstelle.', N'EasyTax'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '8c68b022-50af-0333-bc83-e2f3daa90f20', '2ff0c162-5e66-40c2-b2f7-6f3afd0c03bb', 3, 'MdGroup', NULL, NULL, N'EasyTax'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'd13b5368-b356-6e3c-95df-c31cd564ee04', '2ff0c162-5e66-40c2-b2f7-6f3afd0c03bb', 4, 'MdGroup', NULL, NULL, N'EasyTax'
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '0a26299b-ceb7-3b30-a296-1e1f952b8dca', '93dd25c4-d1d7-4060-b575-fdb05f708086', 1, 'MdGroup', NULL, NULL, N'Event'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'c9a133cc-be5c-6633-a393-47e6e3b6075c', '93dd25c4-d1d7-4060-b575-fdb05f708086', 2, 'MdGroup', NULL, NULL, N'Event'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'bb8482ca-d6c7-bf3c-a67a-59a9c414f9f7', '93dd25c4-d1d7-4060-b575-fdb05f708086', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '44a4f82a-5d0c-c637-9ac0-6296c6a141be', '93dd25c4-d1d7-4060-b575-fdb05f708086', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '10237161-db9d-dd38-94a3-fe3ad4f5dee2', 'e5916290-2b38-446a-9502-236b10cb37f3', 1, 'MdGroup', NULL, NULL, N'Fatca'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'a0aae94c-7f1d-4936-80d5-08ed32445294', 'e5916290-2b38-446a-9502-236b10cb37f3', 2, 'MdGroup', NULL, NULL, N'Fatca'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'c02db54a-2f1f-2d3d-8163-0ca1524a1e08', 'e5916290-2b38-446a-9502-236b10cb37f3', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'e6807534-a154-2f3c-a04e-3fbb365e91bf', 'e5916290-2b38-446a-9502-236b10cb37f3', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'e75713a5-72b1-6a31-8836-a149023a8401', '492eb932-11a5-4c01-acd4-498e5cb33327', 1, 'MdGroup', NULL, NULL, N'FIDLEG'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '48660f58-4702-5233-affc-9a554a793cf3', '492eb932-11a5-4c01-acd4-498e5cb33327', 2, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '58de9146-1fd4-673d-a4c5-bb775972edbb', '492eb932-11a5-4c01-acd4-498e5cb33327', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'ce2a03da-b9d2-6e3c-8dd7-2495720926ca', '492eb932-11a5-4c01-acd4-498e5cb33327', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '312d4e9b-ddf0-8034-8429-3b4a20ff8cda', '395d9f23-8cc3-4aa0-8c1f-045a593f1eeb', 1, 'MdGroup', NULL, NULL, N'Header Tables'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'c506f773-e025-953b-bad0-7e86df6d3b55', '395d9f23-8cc3-4aa0-8c1f-045a593f1eeb', 2, 'MdGroup', NULL, NULL, N'Vorsatztabellen'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '7c2dd20f-551b-6234-a418-bc07b3b500e3', '395d9f23-8cc3-4aa0-8c1f-045a593f1eeb', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'd76649ef-2bf8-4535-b48a-e09c8705c577', '395d9f23-8cc3-4aa0-8c1f-045a593f1eeb', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '7c5282b7-1e2f-863f-b181-5405ae538d28', 'ad1522a5-0089-4328-b6d3-7d873ca13f19', 1, 'MdGroup', NULL, NULL, N'Instrument'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'e47f976a-4ad5-2530-be3e-bbd21f15c2c2', 'ad1522a5-0089-4328-b6d3-7d873ca13f19', 2, 'MdGroup', NULL, NULL, N'Instrument'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'adb1f4fa-7986-8135-b037-6ecb0ec36e75', 'ad1522a5-0089-4328-b6d3-7d873ca13f19', 3, 'MdGroup', NULL, NULL, N'Instrument'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '24d3a846-ea1b-713b-b5bd-7e0e86ef546e', 'ad1522a5-0089-4328-b6d3-7d873ca13f19', 4, 'MdGroup', NULL, NULL, N'Instrument'
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '79e896a0-6ff5-523d-863b-de13814da2a3', '7dfee250-9877-4fdc-9d97-41e6028999f6', 1, 'MdGroup', NULL, NULL, N'Interface'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '0168e0f1-edfe-8d3b-9701-1c23d9b68074', '7dfee250-9877-4fdc-9d97-41e6028999f6', 2, 'MdGroup', NULL, NULL, N'Schnittstelle'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '52f345fd-c308-0035-a191-42609af54a6e', '7dfee250-9877-4fdc-9d97-41e6028999f6', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '268098c2-2ba1-f632-9b3b-c1dc28386bb8', '7dfee250-9877-4fdc-9d97-41e6028999f6', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'c9c2b72a-176a-b53f-8c28-1c057070347d', '0aa7953a-9813-4f76-9e53-78df724f757a', 1, 'MdGroup', NULL, NULL, N'Loan'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'c8e65400-c904-8b38-a8ef-4f2b0a8d9616', '0aa7953a-9813-4f76-9e53-78df724f757a', 2, 'MdGroup', NULL, NULL, N'Kredite'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '45629953-001c-ba37-9f5d-acade478a918', '0aa7953a-9813-4f76-9e53-78df724f757a', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'ee30b6c8-05d9-c531-a8cf-273b38f5d2ca', '0aa7953a-9813-4f76-9e53-78df724f757a', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '31de941f-6bcd-4531-8264-268859ddedd7', 'c1a52d85-2b4e-4419-b86a-2be5c47bad9d', 1, 'MdGroup', NULL, NULL, N'Mail System'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '43e5ebcb-6ddf-ae37-8737-32127534a085', 'c1a52d85-2b4e-4419-b86a-2be5c47bad9d', 2, 'MdGroup', NULL, NULL, N'Mail System'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '675205af-83e6-cb3f-b432-10346131a426', 'c1a52d85-2b4e-4419-b86a-2be5c47bad9d', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'a8defbad-777a-103b-9ce9-5308d475129e', 'c1a52d85-2b4e-4419-b86a-2be5c47bad9d', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'fe624e5d-1b13-d33c-91ac-717bc09395b6', '1b7f657d-bf02-4f66-b37b-cee0cfa5299b', 1, 'MdGroup', NULL, NULL, N'Marktdaten'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '93c82b53-513c-7a31-9514-81c7778500e0', '1b7f657d-bf02-4f66-b37b-cee0cfa5299b', 2, 'MdGroup', NULL, NULL, N'MarketData'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'cece24b8-1b46-3e36-a733-0cfdc35ea1f1', '1b7f657d-bf02-4f66-b37b-cee0cfa5299b', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'afe57e62-ff1f-ac33-9530-1d7951eeb7a3', '1b7f657d-bf02-4f66-b37b-cee0cfa5299b', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '57b5456f-9777-6b33-b173-17dc54464461', '47a738e9-4dcb-41bc-8fcc-bb1699c6b097', 1, 'MdGroup', NULL, NULL, N'Message Store'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '81fbb0f1-2d09-2334-9b62-549710e08a47', '47a738e9-4dcb-41bc-8fcc-bb1699c6b097', 2, 'MdGroup', NULL, NULL, N'Message Store'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '4e90be4b-9fbe-1030-ac8d-7e3d7e490346', '47a738e9-4dcb-41bc-8fcc-bb1699c6b097', 3, 'MdGroup', NULL, NULL, N'Message Store'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '74d1d281-a2cd-7139-8816-b75ebc48ca9a', '47a738e9-4dcb-41bc-8fcc-bb1699c6b097', 4, 'MdGroup', NULL, NULL, N'Message Store'
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '1385ce5e-d00b-fa3b-92f4-0b32623651d9', 'd18c2bae-7838-4b83-a18e-29041114c63e', 1, 'MdGroup', NULL, NULL, N'Meta Data'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'ef9b4791-4d3a-9c33-a1ce-4533f22f8853', 'd18c2bae-7838-4b83-a18e-29041114c63e', 2, 'MdGroup', NULL, NULL, N'Metadaten'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'a8dddc08-8583-4536-b6f7-f2846b711e73', 'd18c2bae-7838-4b83-a18e-29041114c63e', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'df5aed62-a91c-6530-8a36-f39b6bac6942', 'd18c2bae-7838-4b83-a18e-29041114c63e', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'caee4741-664e-c833-9a8b-a6c05693e05e', 'f6a6cd91-488e-4742-a2e4-68a2be5a10a7', 1, 'MdGroup', NULL, NULL, N'Migration'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'bf442bb9-1e40-6232-ba5f-9a754988e81e', 'f6a6cd91-488e-4742-a2e4-68a2be5a10a7', 2, 'MdGroup', NULL, NULL, N'Migration'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '7807ec17-8216-6a3e-a842-070b74463623', 'f6a6cd91-488e-4742-a2e4-68a2be5a10a7', 3, 'MdGroup', NULL, NULL, N'Migration'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'c4cb3083-fee2-1b33-8cc3-c4b82463e93c', 'f6a6cd91-488e-4742-a2e4-68a2be5a10a7', 4, 'MdGroup', NULL, NULL, N'Migrazione'
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'c31a1d41-5a8b-5e35-a2a9-b0437bfad247', '0ebe92b4-009e-4d5f-b882-c8d9daf72042', 1, 'MdGroup', NULL, NULL, N'Name Check'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '2965139c-6198-463a-82ee-f4a5d6dba232', '0ebe92b4-009e-4d5f-b882-c8d9daf72042', 2, 'MdGroup', NULL, NULL, N'Name Check'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '6d6a262a-11fa-1d30-9791-6af1e03f71ee', '0ebe92b4-009e-4d5f-b882-c8d9daf72042', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '8076667b-5de5-3833-9f2d-5358327055b4', '0ebe92b4-009e-4d5f-b882-c8d9daf72042', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '24cc7114-045e-5634-b302-678fe230fcdc', 'a4112bd6-f727-4177-a33e-e8cac9f81144', 1, 'MdGroup', NULL, NULL, N'OpenApi'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '147d3f8e-e6d9-ac3d-a6a2-bc007d84b01e', 'a4112bd6-f727-4177-a33e-e8cac9f81144', 2, 'MdGroup', NULL, NULL, N'OpenApi'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '63a4cb83-bdbb-c239-bf26-ca8a0d27547d', 'a4112bd6-f727-4177-a33e-e8cac9f81144', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'def16609-b514-9233-97c5-1c0dd0ea0784', 'a4112bd6-f727-4177-a33e-e8cac9f81144', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '77f0d4e0-1eca-cb32-acee-7c17483bac70', '4de0d3b7-95d8-473e-be4c-1d37a958d353', 1, 'MdGroup', NULL, NULL, N'OpenBanking'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '698af76c-9e52-e635-877c-f7336ec1b086', '4de0d3b7-95d8-473e-be4c-1d37a958d353', 2, 'MdGroup', NULL, NULL, N'OpenBanking'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '3924d24a-8294-3b3d-abdd-70158c42790e', '4de0d3b7-95d8-473e-be4c-1d37a958d353', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'b5a5fb38-ed86-ac34-93d1-ab83f7028e0b', '4de0d3b7-95d8-473e-be4c-1d37a958d353', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '237aacf3-ed5c-3030-96b5-c86b14b22b3f', 'b76a4fbd-6160-4021-9b0c-245c7b4371c2', 1, 'MdGroup', NULL, NULL, N'Order Management'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '0a517356-1453-3d38-9895-9db9f7efaba2', 'b76a4fbd-6160-4021-9b0c-245c7b4371c2', 2, 'MdGroup', NULL, NULL, N'Auftragsbearbeitung'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '839eeb9a-24a2-5135-b46c-eb766f7f2769', 'b76a4fbd-6160-4021-9b0c-245c7b4371c2', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '2e47dfcf-d91a-8c30-87a2-b9e2777e94d4', 'b76a4fbd-6160-4021-9b0c-245c7b4371c2', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '9538c82a-94b2-a53e-9d57-f4643ce652b8', '9dc441d9-52c0-4cec-8a7f-e57b0ead1674', 1, 'MdGroup', NULL, NULL, N'Partner'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '7faa89ea-99f7-2c3d-ae92-ebc53c3f73ea', '9dc441d9-52c0-4cec-8a7f-e57b0ead1674', 2, 'MdGroup', NULL, NULL, N'Partner'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '293a2037-6fff-1535-8a6c-22f7ce700549', '9dc441d9-52c0-4cec-8a7f-e57b0ead1674', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'c57c537c-2e89-1b3d-9eb2-34a5393e5562', '9dc441d9-52c0-4cec-8a7f-e57b0ead1674', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'ae2dec85-84ca-663e-a369-59d344118542', '81a3a910-e114-4a8b-892c-bbbaa4bd60c8', 1, 'MdGroup', NULL, NULL, N'Payment System'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'fca4bf86-10cf-0534-bd11-d7ffb25793be', '81a3a910-e114-4a8b-892c-bbbaa4bd60c8', 2, 'MdGroup', NULL, NULL, N'Zahlungssystem'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'c738241a-2d51-dc39-aafc-cc0167f6f07c', '81a3a910-e114-4a8b-892c-bbbaa4bd60c8', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '0c4c0407-1f3d-de34-b181-b0fe60b67001', '81a3a910-e114-4a8b-892c-bbbaa4bd60c8', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'e9853349-1a0e-4a3a-9453-32eec2d31db2', 'a457c69a-1aff-4501-93c1-65635c1471d4', 1, 'MdGroup', NULL, NULL, N'Pension Data Exchange'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '4a4b6cf5-04bc-323d-bad3-15f660a2fe52', 'a457c69a-1aff-4501-93c1-65635c1471d4', 2, 'MdGroup', NULL, NULL, N'Vorsorge-Datenaustausch'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '07515495-c049-3b34-a679-de0c69d35a1b', 'a457c69a-1aff-4501-93c1-65635c1471d4', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '7082498c-e3c1-3f38-9de2-e01cedade09e', 'a457c69a-1aff-4501-93c1-65635c1471d4', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '9c27d20d-eb11-653e-8176-19938e4d53c3', '5041baf0-4b1e-42de-bc90-23121d0dddd6', 1, 'MdGroup', NULL, NULL, N'Portfolio Management Sys'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'd2b93e5c-3f24-833e-8968-7967711bb473', '5041baf0-4b1e-42de-bc90-23121d0dddd6', 2, 'MdGroup', NULL, NULL, N'Portfolio Management Sys'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '0bf046e8-efc9-1938-b11c-48281ae44144', '5041baf0-4b1e-42de-bc90-23121d0dddd6', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '2f2854b8-8e41-6e32-9910-44213ff97e3d', '5041baf0-4b1e-42de-bc90-23121d0dddd6', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'a9f8f5c5-04d5-2937-acf6-5222b70fd4e4', 'dfa425a0-fc5e-41ba-a1d2-22b8f44f2a95', 1, 'MdGroup', NULL, NULL, N'Printing System'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '8d4819fa-f7ff-c930-99a5-898961f927d1', 'dfa425a0-fc5e-41ba-a1d2-22b8f44f2a95', 2, 'MdGroup', NULL, NULL, N'Printing System'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'b3eb466d-a517-e236-b49f-6bf53f9ad37c', 'dfa425a0-fc5e-41ba-a1d2-22b8f44f2a95', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '8d2f9687-aca5-0137-8b88-8c0aa984c49d', 'dfa425a0-fc5e-41ba-a1d2-22b8f44f2a95', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'cade752b-6841-fb34-9762-fd0cdaf9216a', '20cc6fa2-8ebc-4afe-a0af-709583029d4c', 1, 'MdGroup', NULL, NULL, N'Product'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '5acc8459-ff61-2832-bf0d-7be4f8200847', '20cc6fa2-8ebc-4afe-a0af-709583029d4c', 2, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '707e8527-9642-d13c-a7c3-467421186e31', '20cc6fa2-8ebc-4afe-a0af-709583029d4c', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '067d321c-0feb-4231-b951-934b39d0c7b3', '20cc6fa2-8ebc-4afe-a0af-709583029d4c', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '2d77e8c5-91db-9031-9810-9a643b345470', '617e9b96-2fc1-4dbb-b666-17533607e005', 1, 'MdGroup', NULL, NULL, N'Real Estate'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '1684fc0e-1c77-0230-a233-7547c0509372', '617e9b96-2fc1-4dbb-b666-17533607e005', 2, 'MdGroup', NULL, NULL, N'Grundstück'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '79648424-d63a-5b3e-9f47-3289a27ab452', '617e9b96-2fc1-4dbb-b666-17533607e005', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'a753242c-caa7-8133-a026-88cdae654b20', '617e9b96-2fc1-4dbb-b666-17533607e005', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'a28478a6-aa4a-6732-b984-52f9e435e37e', 'c1378147-e089-4f5e-aba8-c2f0e293c21a', 1, 'MdGroup', NULL, N'SIS', N'SIS'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'ed010f49-a82b-1635-b3ae-4610ebe75fbf', 'c1378147-e089-4f5e-aba8-c2f0e293c21a', 2, 'MdGroup', NULL, N'SIS', N'SIS'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '8e4d7d01-a237-5639-8127-8afbb3c89d25', 'c1378147-e089-4f5e-aba8-c2f0e293c21a', 3, 'MdGroup', NULL, N'SIS', N'SIS'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '1e0e8f5a-35ce-5537-b038-ea841ec59d77', 'c1378147-e089-4f5e-aba8-c2f0e293c21a', 4, 'MdGroup', NULL, N'SIS', N'SIS'
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '25becdb9-5980-d136-9773-1cdd5a6af1e4', '4acbe022-2230-43ff-8ee9-38f7f0e7a595', 1, 'MdGroup', NULL, NULL, N'Soft Logic'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '0a929fb4-2589-843b-a51f-07f96daa578a', '4acbe022-2230-43ff-8ee9-38f7f0e7a595', 2, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '8e11a134-7257-dc3f-ab95-531bd085fc2a', '4acbe022-2230-43ff-8ee9-38f7f0e7a595', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '1ae68079-402a-2636-b650-73a48475434b', '4acbe022-2230-43ff-8ee9-38f7f0e7a595', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '6fcf2962-72e9-bb30-ab29-82252b880b9e', '83458b04-5fa9-42c9-a46e-a39780ca3259', 1, 'MdGroup', NULL, N'TaxData', N'TaxData'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '36a8ed03-df7b-0e31-aa08-5854f62a6286', '83458b04-5fa9-42c9-a46e-a39780ca3259', 2, 'MdGroup', NULL, N'TaxData', N'TaxData'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'f064f7f4-3cfe-9932-ad46-5cc1ddd0b9e3', '83458b04-5fa9-42c9-a46e-a39780ca3259', 3, 'MdGroup', NULL, N'TaxData', N'TaxData'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '7b8ad072-63d0-2630-8694-5d646373ba9c', '83458b04-5fa9-42c9-a46e-a39780ca3259', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '6a742817-b424-6236-b42e-642944a5f6bc', '8c7c7fe8-904e-449d-8b00-69c67c6a21d8', 1, 'MdGroup', NULL, N'Archive Tables for Test Application', N'Test Archive'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'ed856074-05f7-8336-9bf5-dcda34c54c06', '8c7c7fe8-904e-449d-8b00-69c67c6a21d8', 2, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '706584ac-38a1-3e34-820b-dbb7e530f858', '8c7c7fe8-904e-449d-8b00-69c67c6a21d8', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'a8cee12c-29d3-6830-b635-fb0fc893c1dc', '8c7c7fe8-904e-449d-8b00-69c67c6a21d8', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'e8b9259c-c5d7-e631-a66f-8024a26e1b47', 'ed24bd87-1b5f-4231-b64b-f2cc5ca68d5d', 1, 'MdGroup', NULL, N'Special Testcase oriented Tables for Test Application', N'Test Tables'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '35c632e2-359d-ca32-b58e-9675c1904ed0', 'ed24bd87-1b5f-4231-b64b-f2cc5ca68d5d', 2, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '6232c35e-3b2d-9f36-b895-bd477d5a0806', 'ed24bd87-1b5f-4231-b64b-f2cc5ca68d5d', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '91396a5b-a905-8631-8032-7413035e326d', 'ed24bd87-1b5f-4231-b64b-f2cc5ca68d5d', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'a84544b9-7e4a-c138-9c17-caa5eaca3dd7', '39fefc5c-772a-4ec8-ba9e-e396da7b80bb', 1, 'MdGroup', NULL, NULL, N'Trans Messages'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'c5a3761c-38a7-d43c-ba8e-4c19090f05f4', '39fefc5c-772a-4ec8-ba9e-e396da7b80bb', 2, 'MdGroup', NULL, NULL, N'Externe Meldungen'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '8bc5ed82-793a-7537-b95d-943aba151fc3', '39fefc5c-772a-4ec8-ba9e-e396da7b80bb', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'c692bd32-d459-5935-b5a6-9d10c956444b', '39fefc5c-772a-4ec8-ba9e-e396da7b80bb', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'd4c88816-9e98-343d-bb05-63a0aa80e286', 'bad6dd0b-5ed3-4cee-b419-0b3faf9ddacc', 1, 'MdGroup', NULL, NULL, N'TWINT'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '60beffad-0adc-723f-906c-160a4d2ffe26', 'bad6dd0b-5ed3-4cee-b419-0b3faf9ddacc', 2, 'MdGroup', NULL, NULL, N'TWINT'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'e65df168-bb03-9a30-bc8c-f36e77db853c', 'bad6dd0b-5ed3-4cee-b419-0b3faf9ddacc', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '2138fed2-cad6-b131-aae3-4e8cc7a85cc6', 'bad6dd0b-5ed3-4cee-b419-0b3faf9ddacc', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'e8276eaf-dba6-b838-882f-a1d4434a319a', '65ffe932-c171-41f2-94bd-8d53bb5e922a', 1, 'MdGroup', NULL, NULL, N'WorkFlow'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'a74fd874-adee-5934-b914-d7b4bc948484', '65ffe932-c171-41f2-94bd-8d53bb5e922a', 2, 'MdGroup', NULL, NULL, N'WorkFlow'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'b7634637-3e70-b731-9518-fc20c9ec9d5e', '65ffe932-c171-41f2-94bd-8d53bb5e922a', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '1abdcb43-74e6-8a30-b35e-37e083eee194', '65ffe932-c171-41f2-94bd-8d53bb5e922a', 4, 'MdGroup', NULL, NULL, NULL
);

INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '9d7ae812-65df-bc32-b76a-f328731d2d90', 'b4ef08a8-5ddd-4342-8dd4-9468bd7539de', 1, 'MdGroup', NULL, NULL, N'WorkTime'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'a2b6d289-d379-fa35-9238-747a5b0253c1', 'b4ef08a8-5ddd-4342-8dd4-9468bd7539de', 2, 'MdGroup', NULL, NULL, N'Arbeitszeit'
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  '4dec8f89-f2b9-f738-a292-876d3a081479', 'b4ef08a8-5ddd-4342-8dd4-9468bd7539de', 3, 'MdGroup', NULL, NULL, NULL
);
INSERT INTO AsText (
  Id, MasterId, LanguageNo, MasterTableName, SourceFlag, TextLong, TextShort
) VALUES (
  'dff40293-31a2-6f31-9d85-b1f25fddba89', 'b4ef08a8-5ddd-4342-8dd4-9468bd7539de', 4, 'MdGroup', NULL, NULL, NULL
);

