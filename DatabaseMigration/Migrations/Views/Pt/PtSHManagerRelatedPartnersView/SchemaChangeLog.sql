--liquibase formatted sql

--changeset system:create-alter-view-PtSHManagerRelatedPartnersView context:any labels:c-any,o-view,ot-schema,on-PtSHManagerRelatedPartnersView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtSHManagerRelatedPartnersView
CREATE OR ALTER VIEW dbo.PtSHManagerRelatedPartnersView AS
Select PartnerID, RankNo, 
	Null As RelatedPartnerID, 
	Null As RelationRoleNo 
From PtUserBase 
Where RankNo In (20, 22, 30, 32, 34) And HdVersionNo<999999999

Union

Select U.PartnerID, U.RankNo, 
	S.PartnerID As RelatedPartnerID, 
	S.RelationRoleNo 
From PtUserBase U Inner Join PtRelationMaster M On U.PartnerID=M.PartnerID And M.RelationTypeNo In (10, 40, 90)
		And U.HdVersionNo<999999999 And M.HdVersionNo<999999999 
	Inner Join PtRelationSlave S On S.MasterID=M.ID And S.HdVersionNo<999999999 
		And (S.ValidTo Is Null Or S.ValidTo>getDate()) And S.RelationRoleNo In (6, 7,10,11, 13)
Where U.RankNo In (20, 22, 30, 32, 34)

Union

Select U.PartnerID, U.RankNo, 
	S.PartnerID As RelatedPartnerID, 
	S.RelationRoleNo 
From PtUserBase U Inner Join PtRelationMaster M On U.PartnerID=M.PartnerID And M.RelationTypeNo In (40)
		And U.HdVersionNo<999999999 And M.HdVersionNo<999999999 
	Inner Join PtRelationSlave S On S.MasterID=M.ID And S.HdVersionNo<999999999 
		And (S.ValidTo Is Null Or S.ValidTo>getDate()) And S.RelationRoleNo In (6, 75, 76)
Where U.RankNo In (20, 22, 30, 32, 34)
