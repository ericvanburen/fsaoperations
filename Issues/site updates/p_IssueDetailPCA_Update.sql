USE [Issues]

GO

/****** Object:  StoredProcedure [dbo].[p_IssueDetail_Update]    Script Date: 09/05/2014 13:08:29 ******/

SET ANSI_NULLS ON

GO

SET QUOTED_IDENTIFIER ON

GO

-- =============================================

-- Author:    Van Buren, Eric

-- Create date: 2014/09/05

-- Description: Update single PCA issue

-- =============================================

CREATE PROCEDURE [dbo].[p_IssueDetailPCA_Update]
     @IssueID int = NULL
    ,@DateReceived smalldatetime = NULL
    ,@EnteredBy varchar(50) = NULL
    ,@FollowupDate smalldatetime = NULL
    ,@CategoryID int = NULL
    ,@SubCategoryID int = NULL
    ,@IssueStatus varchar(50) = NULL
    ,@SourceOrgID int = NULL
    ,@UserID varchar(50) = NULL
    ,@BorrowerNumber varchar(50) = NULL
    ,@BorrowerName varchar(50) = NULL      
    ,@ReceivedBy varchar(50) = NULL
    ,@SourceOrgType varchar(50) = NULL
    ,@RootCause varchar(50) = NULL
    ,@WrittenVerbal varchar(50) = NULL
    ,@ComplaintTypeA bit = NULL
    ,@ComplaintTypeB bit = NULL
    ,@ComplaintTypeC bit = NULL
    ,@ComplaintTypeD bit = NULL
    ,@ComplaintTypeE bit = NULL
    ,@ComplaintTypeF bit = NULL
    ,@ComplaintTypeG bit = NULL
    ,@ComplaintTypeH bit = NULL
    ,@ComplaintTypeI bit = NULL
    ,@ComplaintTypeJ bit = NULL
    ,@ComplaintTypeK bit = NULL
    ,@ComplaintTypeL bit = NULL
    ,@ComplaintTypeM bit = NULL
    ,@ComplaintTypeN bit = NULL
    ,@ComplaintTypeO bit = NULL
    ,@ComplaintTypeP bit = NULL
    ,@ComplaintTypeQ bit = NULL
    ,@ComplaintTypeR bit = NULL
    ,@ComplaintTypeS bit = NULL
    ,@ComplaintTypeT bit = NULL
    ,@ComplaintTypeU bit = NULL
    ,@ComplaintTypeV bit = NULL
    ,@ComplaintTypeW bit = NULL
    ,@ComplaintTypeX bit = NULL
    ,@ComplaintTypeY bit = NULL
    ,@ComplaintTypeZ bit = NULL
    ,@ComplaintTypeZZ bit = NULL
    ,@ComplaintTypeA_Validity varchar(50) = NULL
    ,@ComplaintTypeB_Validity varchar(50) = NULL
    ,@ComplaintTypeC_Validity varchar(50) = NULL
    ,@ComplaintTypeD_Validity varchar(50) = NULL
    ,@ComplaintTypeE_Validity varchar(50) = NULL
    ,@ComplaintTypeF_Validity varchar(50) = NULL
    ,@ComplaintTypeG_Validity varchar(50) = NULL
    ,@ComplaintTypeH_Validity varchar(50) = NULL
    ,@ComplaintTypeI_Validity varchar(50) = NULL
    ,@ComplaintTypeJ_Validity varchar(50) = NULL
    ,@ComplaintTypeK_Validity varchar(50) = NULL
    ,@ComplaintTypeL_Validity varchar(50) = NULL
    ,@ComplaintTypeM_Validity varchar(50) = NULL
    ,@ComplaintTypeN_Validity varchar(50) = NULL
    ,@ComplaintTypeO_Validity varchar(50) = NULL
    ,@ComplaintTypeP_Validity varchar(50) = NULL
    ,@ComplaintTypeQ_Validity varchar(50) = NULL
    ,@ComplaintTypeR_Validity varchar(50) = NULL
    ,@ComplaintTypeS_Validity varchar(50) = NULL
    ,@ComplaintTypeT_Validity varchar(50) = NULL
    ,@ComplaintTypeU_Validity varchar(50) = NULL
    ,@ComplaintTypeV_Validity varchar(50) = NULL
    ,@ComplaintTypeW_Validity varchar(50) = NULL
    ,@ComplaintTypeX_Validity varchar(50) = NULL
    ,@ComplaintTypeY_Validity varchar(50) = NULL
    ,@ComplaintTypeZ_Validity varchar(50) = NULL
    ,@ComplaintTypeZZ_Validity varchar(50) = NULL
    ,@Severity varchar(50) = NULL
    ,@CollectorFirstName varchar(50) = NULL
    ,@CollectorLastName varchar(50) = NULL
    ,@DateResolved smalldatetime = NULL
    ,@IssueDescription varchar(max) = NULL
    ,@Comments varchar(max) = NULL
    ,@Resolution varchar(max) = NULL
    ,@DueDate smalldatetime = NULL
    ,@Attachment1 varchar(150) = NULL
    ,@Attachment2 varchar(150) = NULL
    ,@Attachment3 varchar(50) = NULL
    ,@AffectedOrgID int = NULL
      
AS

BEGIN

  SET NOCOUNT ON;

  UPDATE 
     Issues
  SET

       [IssueType] = @IssueType
      ,[DateEntered] = @DateEntered
      ,[DateReceived] = @DateReceived
      ,[EnteredBy] = @EnteredBy
      ,[FollowupDate] = @FollowupDate
      ,[CategoryID] = @CategoryID
      ,[SubCategoryID] = @SubCategoryID
      ,[IssueStatus] = @IssueStatus
      ,[SourceOrgID] = @SourceOrgID
      ,[UserID] = @UserID
      ,[BorrowerNumber] = @BorrowerNumber
      ,[BorrowerName] = @BorrowerName      
      ,[ReceivedBy] = @ReceivedBy
      ,[SourceOrgType] = @SourceOrgType
      ,[RootCause] = @RootCause
      ,[WrittenVerbal] = @WrittenVerbal
      ,ComplaintTypeA = @ComplaintTypeA
      ,ComplaintTypeB = @ComplaintTypeB
      ,ComplaintTypeC = @ComplaintTypeC
      ,ComplaintTypeD = @ComplaintTypeD
      ,ComplaintTypeE = @ComplaintTypeE
      ,ComplaintTypeF = @ComplaintTypeF
      ,ComplaintTypeG = @ComplaintTypeG
      ,ComplaintTypeH = @ComplaintTypeH
      ,ComplaintTypeI = @ComplaintTypeI
      ,ComplaintTypeJ = @ComplaintTypeJ
      ,ComplaintTypeK = @ComplaintTypeK
      ,ComplaintTypeL = @ComplaintTypeL
      ,ComplaintTypeM = @ComplaintTypeM
      ,ComplaintTypeN = @ComplaintTypeN
      ,ComplaintTypeO = @ComplaintTypeO
      ,ComplaintTypeP = @ComplaintTypeP
      ,ComplaintTypeQ = @ComplaintTypeQ
      ,ComplaintTypeR = @ComplaintTypeR
      ,ComplaintTypeS = @ComplaintTypeS
      ,ComplaintTypeT = @ComplaintTypeT
      ,ComplaintTypeU = @ComplaintTypeU
      ,ComplaintTypeV = @ComplaintTypeV
      ,ComplaintTypeW = @ComplaintTypeW
      ,ComplaintTypeX = @ComplaintTypeX
      ,ComplaintTypeY = @ComplaintTypeY
      ,ComplaintTypeZ = @ComplaintTypeZ
      ,ComplaintTypeZZ = @ComplaintTypeZZ
      ,ComplaintTypeA_Validity = @ComplaintTypeA_Validity
      ,ComplaintTypeB_Validity = @ComplaintTypeB_Validity
      ,ComplaintTypeC_Validity = @ComplaintTypeC_Validity
      ,ComplaintTypeD_Validity = @ComplaintTypeD_Validity
      ,ComplaintTypeE_Validity = @ComplaintTypeE_Validity
      ,ComplaintTypeF_Validity = @ComplaintTypeF_Validity
      ,ComplaintTypeG_Validity = @ComplaintTypeG_Validity
      ,ComplaintTypeH_Validity = @ComplaintTypeH_Validity
      ,ComplaintTypeI_Validity = @ComplaintTypeI_Validity
      ,ComplaintTypeJ_Validity = @ComplaintTypeJ_Validity
      ,ComplaintTypeK_Validity = @ComplaintTypeK_Validity
      ,ComplaintTypeL_Validity = @ComplaintTypeL_Validity
      ,ComplaintTypeM_Validity = @ComplaintTypeM_Validity
      ,ComplaintTypeN_Validity = @ComplaintTypeN_Validity
      ,ComplaintTypeO_Validity = @ComplaintTypeO_Validity
      ,ComplaintTypeP_Validity = @ComplaintTypeP_Validity
      ,ComplaintTypeQ_Validity = @ComplaintTypeQ_Validity
      ,ComplaintTypeR_Validity = @ComplaintTypeR_Validity
      ,ComplaintTypeS_Validity = @ComplaintTypeS_Validity
      ,ComplaintTypeT_Validity = @ComplaintTypeT_Validity
      ,ComplaintTypeU_Validity = @ComplaintTypeU_Validity
      ,ComplaintTypeV_Validity = @ComplaintTypeV_Validity
      ,ComplaintTypeW_Validity = @ComplaintTypeW_Validity
      ,ComplaintTypeX_Validity = @ComplaintTypeX_Validity
      ,ComplaintTypeY_Validity = @ComplaintTypeY_Validity
      ,ComplaintTypeZ_Validity = @ComplaintTypeZ_Validity
      ,ComplaintTypeZZ_Validity = @ComplaintTypeZZ_Validity
      ,[Severity] = @Severity
      ,[CollectorFirstName] = @CollectorFirstName
      ,[CollectorLastName] = @CollectorLastName 
      ,[DateResolved] = @DateResolved
      ,[IssueDescription] = @IssueDescription
      ,[Comments] = @Comments
      ,[Resolution] = @Resolution
      ,[DueDate] = @DueDate
      ,[Attachment1] = @Attachment1
      ,[Attachment2] = @Attachment2
      ,[Attachment3] = @Attachment3
      ,[AffectedOrgID] = @AffectedOrgID      
      WHERE 
    IssueID = @IssueID

END
