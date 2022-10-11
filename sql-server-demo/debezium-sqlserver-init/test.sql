-- CREATE DATABASE [ARAOS]
-- GO

USE testDB
GO

CREATE TABLE [dbo].[TBOrderReview](
	[TBOrderReview_ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[TBInvoiceMaster_ID] [nvarchar](10) NOT NULL,
	[TBVendor_ID] [nvarchar](3) NULL,
	[TBCustomer_ID] [nvarchar](8) NOT NULL,
	[comment] [nvarchar](1000) NULL,
	[total_score] [tinyint] NOT NULL,
	[product_quality] [tinyint] NOT NULL,
	[shipping_time] [tinyint] NOT NULL,
	[handling_shipping_fee] [tinyint] NOT NULL,
	[communication] [tinyint] NOT NULL,
	[is_active] [bit] NOT NULL,
	[created_date] [datetime] NOT NULL,
	[is_reviewed] [bit] NOT NULL,
	[reply] [nvarchar](1000) NULL,
	[reply_date] [datetime] NULL,
	[comment_void_reason] [nvarchar](500) NULL,
	[comment_void_date] [datetime] NULL,
	[comment_void_staff] [int] NULL,
	[reply_void_reason] [nvarchar](500) NULL,
	[reply_void_date] [datetime] NULL,
	[reply_void_staff] [int] NULL
);

GO


CREATE VIEW [dbo].[vw_AvgOrderReview]
AS
  SELECT REV.TBVendor_ID
  , (100 * SUM(CASE REV.[total_score] WHEN 5 THEN 1 ELSE 0 END) / COUNT(REV.[TBOrderReview_ID])) [pct_5_stars]
  , (100 * SUM(CASE REV.[total_score] WHEN 4 THEN 1 ELSE 0 END) / COUNT(REV.[TBOrderReview_ID])) [pct_4_stars]
  , (100 * SUM(CASE REV.[total_score] WHEN 3 THEN 1 ELSE 0 END) / COUNT(REV.[TBOrderReview_ID])) [pct_3_stars]
  , (100 * SUM(CASE REV.[total_score] WHEN 2 THEN 1 ELSE 0 END) / COUNT(REV.[TBOrderReview_ID])) [pct_2_stars]
  , (100 * SUM(CASE REV.[total_score] WHEN 1 THEN 1 ELSE 0 END) / COUNT(REV.[TBOrderReview_ID])) [pct_1_stars]
  , (20.0 * SUM(REV.[total_score]) / COUNT(REV.[TBOrderReview_ID])) [avg_total_score]
  , (20.0 * SUM(REV.[product_quality]) / COUNT(REV.[TBOrderReview_ID])) [avg_product_quality]
  , (20.0 * SUM(REV.[shipping_time]) / COUNT(REV.[TBOrderReview_ID])) [avg_shipping_time]
  , (20.0 * SUM(REV.[handling_shipping_fee]) / COUNT(REV.[TBOrderReview_ID])) [avg_handling_shipping_fee]
  , (20.0 * SUM(REV.[communication]) / COUNT(REV.[TBOrderReview_ID])) [avg_communication]
  , COUNT(REV.TBVendor_ID) [count_review]
  FROM [ARAOS].[dbo].[TBOrderReview] [REV]
  WHERE REV.comment_void_date is NULL
  GROUP BY REV.TBVendor_ID;

GO


CREATE TABLE [dbo].[TBSizeChart](
	[TBSizeChart_ID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL PRIMARY KEY,
	[dSizeName] [nvarchar](50) NOT NULL,
	[dSizeDescription] [nvarchar](100) NULL,
	[d01S] [nvarchar](10) NULL,
	[d02S] [nvarchar](10) NULL,
	[d03S] [nvarchar](10) NULL,
	[d04S] [nvarchar](10) NULL,
	[d05S] [nvarchar](10) NULL,
	[d06S] [nvarchar](10) NULL,
	[d07S] [nvarchar](10) NULL,
	[d08S] [nvarchar](10) NULL,
	[d09S] [nvarchar](10) NULL,
	[d010S] [nvarchar](10) NULL,
	[d011S] [nvarchar](10) NULL,
	[d012S] [nvarchar](10) NULL,
	[d013S] [nvarchar](10) NULL,
	[SizeAndPack] [nvarchar](50) NULL
);


GO
CREATE TABLE [dbo].[TBPackNo](
	[TBPackNo_ID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL PRIMARY KEY,
	[dPackNoName] [nvarchar](50) NOT NULL,
	[dPackNoDescription] [nvarchar](50) NULL,
	[d01P] [nvarchar](10) NULL,
	[d02P] [nvarchar](10) NULL,
	[d03P] [nvarchar](10) NULL,
	[d04P] [nvarchar](10) NULL,
	[d05P] [nvarchar](10) NULL,
	[d06P] [nvarchar](10) NULL,
	[d07P] [nvarchar](10) NULL,
	[d08P] [nvarchar](10) NULL,
	[d09P] [nvarchar](10) NULL,
	[d010P] [nvarchar](10) NULL,
	[d011P] [nvarchar](10) NULL,
	[d012P] [nvarchar](10) NULL,
	[d013P] [nvarchar](10) NULL,
	[SizeAndPack] [nvarchar](50) NULL
);

GO

CREATE TABLE [dbo].[TBStyleNo_Popular](
	[TBItem_ID] [nvarchar](8) NOT NULL PRIMARY KEY,
	[popular_point_7] [int] NULL,
	[popular_point_14] [int] NULL,
	[popular_point_30] [int] NULL,
	[popular_point_60] [int] NULL
);

GO


CREATE TABLE [dbo].[TBVendor](
	[TBVendor_SQL_ID] [bigint] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[TBVendor_ID] [nvarchar](3) NOT NULL,
	[TBBrandVendor_ID] [nvarchar](3) NULL,
	[TBMajorMarket_ID] [nvarchar](50) NULL,
	[AfricanAmerican] [char](1) NULL,
	[AsianEthnicities] [char](1) NULL,
	[Caucasian] [char](1) NULL,
	[LatinAmerican] [char](1) NULL,
	[MiddleEasternEthnicity] [char](1) NULL,
	[NativeAmerican] [char](1) NULL,
	[PacificIslandEthnicity] [char](1) NULL,
	[TBSizeChart_ID] [bigint] NULL,
	[TBPackNo_ID] [bigint] NULL,
	[VDName] [nvarchar](50) NOT NULL,
	[VDWebName] [nvarchar](50) NULL,
	[VDName2] [nvarchar](50) NULL,
	[VDAddress] [nvarchar](200) NULL,
	[VDAddress2] [nvarchar](200) NULL,
	[VDCity] [nvarchar](50) NULL,
	[VDState] [nvarchar](15) NULL,
	[VDZip] [nvarchar](12) NULL,
	[VDPhone] [nvarchar](30) NULL,
	[VDFax] [nvarchar](30) NULL,
	[VDEMail] [nvarchar](50) NULL,
	[VDContact] [nvarchar](30) NULL,
	[VDContTitle] [nvarchar](15) NULL,
	[fTerm] [nvarchar](10) NULL,
	[VDActive] [char](1) NOT NULL,
	[VDOSVendor] [char](1) NULL,
	[VDRate1] [float] NULL,
	[VDRate2] [float] NULL,
	[VDRate3] [float] NULL,
	[VDCRate1] [float] NULL,
	[VDCRate2] [float] NULL,
	[VDCRate3] [float] NULL,
	[VDImageFrontMain] [nvarchar](200) NULL,
	[VDImageVendorMain] [nvarchar](200) NULL,
	[VDLogoImage] [nvarchar](200) NULL,
	[VDFrontImage] [nvarchar](200) NULL,
	[VDIntroduction] [varchar](1000) NULL,
	[VDFrontDescription] [varchar](2000) NULL,
	[VDRegisterDate] [smalldatetime] NULL,
	[VDWebUsing] [char](1) NULL,
	[VDAdminUsing] [char](1) NULL,
	[VDWebUsingDomain] [char](1) NULL,
	[VDOwnDomain] [char](1) NULL,
	[TSalesCounting] [int] NULL,
	[TNewArrivalCounting1] [int] NULL,
	[TNewArrivalCounting2] [int] NULL,
	[TNewArrivalCounting3] [int] NULL,
	[TNewArrivalCounting4] [int] NULL,
	[TBVendor_Domain] [nvarchar](100) NULL,
	[TBOwnWebSiteManage] [char](1) NULL,
	[VDPrivacyPolicy] [varchar](4000) NULL,
	[VDReturnPolicy] [varchar](4000) NULL,
	[VDTermsOfUse] [varchar](max) NULL,
	[VDContactUs] [varchar](2000) NULL,
	[VDVendorEmail] [nvarchar](50) NULL,
	[VDVendorURL] [nvarchar](100) NULL,
	[VDYoutubeUsing] [varchar](50) NULL,
	[VDYoutubeURL] [varchar](300) NULL,
	[VDABLogoOn] [varchar](1) NULL,
	[VDMinimumOrderAmount] [money] NULL,
	[VDWatermarkPositionx] [nvarchar](50) NULL,
	[VDWatermarkPositiony] [nvarchar](50) NULL,
	[VDWatermarkText] [nvarchar](50) NULL,
	[VDWatermarkImage] [nvarchar](50) NULL,
	[VDWatermarkFont] [nvarchar](50) NULL,
	[VDWatermarkSelect] [nvarchar](50) NULL,
	[nDownload] [nvarchar](1) NULL,
	[OnisCustomer] [nvarchar](1) NULL,
	[VDRegisterEmailTitle] [nvarchar](200) NULL,
	[VDRegisterEmailContent] [varchar](max) NULL,
	[VDForgotEmailTitle] [nvarchar](200) NULL,
	[VDForgotEmailContent] [varchar](2000) NULL,
	[VDPurchaseEmailTitle] [nvarchar](200) NULL,
	[VDPurchaseEmailContent] [varchar](2000) NULL,
	[VDShipoutEmailTitle] [nvarchar](200) NULL,
	[VDShipoutEmailContent] [varchar](2000) NULL,
	[VDApprovedEmailTitle] [nvarchar](200) NULL,
	[VDApprovedEmailContent] [varchar](max) NULL,
	[nAllowSendOSEmail] [nvarchar](1) NULL,
	[VDOwnManageOrder] [nvarchar](1) NULL,
	[TUpdate] [nvarchar](1) NULL,
	[VDClass] [nvarchar](1) NOT NULL,
	[AuthLoginName] [nvarchar](20) NULL,
	[AuthTransactionKey] [nvarchar](30) NULL,
	[nHomePageLayout] [nvarchar](1) NULL,
	[HeadBannerImageA_1] [nvarchar](100) NULL,
	[HeadBannerImageA_2] [nvarchar](100) NULL,
	[HeadBannerImageA_3] [nvarchar](100) NULL,
	[HeadBannerImageA_4] [nvarchar](100) NULL,
	[BannerA_Image1] [nvarchar](100) NULL,
	[BannerA_Image2] [nvarchar](100) NULL,
	[BannerA_Image3] [nvarchar](100) NULL,
	[BannerB_Image1] [nvarchar](100) NULL,
	[BannerB_Image2] [nvarchar](100) NULL,
	[nColorScheme] [nvarchar](1) NULL,
	[HeadBannerImageC_1] [nvarchar](100) NULL,
	[CCVerifyCode] [nvarchar](50) NULL,
	[BannerImg1] [varchar](1000) NULL,
	[BannerImg2] [varchar](1000) NULL,
	[BannerImg3] [varchar](1000) NULL,
	[BannerImg4] [varchar](1000) NULL,
	[BannerImg5] [varchar](1000) NULL,
	[BannerImg6] [varchar](1000) NULL,
	[BannerImg7] [varchar](1000) NULL,
	[ShippedFrom] [nvarchar](50) NULL,
	[OSminOrderAMT] [money] NULL,
	[EnableDownloadPicture] [char](1) NOT NULL,
	[FeaturedBrand] [char](1) NOT NULL,
	[VDCategory] [nvarchar](50) NULL,
	[copyprevention] [bit] NOT NULL,
	[OSDescription] [nvarchar](max) NULL,
	[VDPriceLevel] [int] NULL,
	[VDMadeIn] [nvarchar](50) NULL,
	[TBStyleNo_OS_Collection_ID] [bigint] NULL,
	[VDContactPreference] [nvarchar](50) NULL,
	[VDPaidDetail] [char](1) NULL,
	[UPSAcct] [nvarchar](50) NULL,
	[VDH1Tag] [nvarchar](300) NULL,
	[VDWhoShipping] [nvarchar](50) NULL,
	[VDFSB] [nvarchar](1) NULL,
	[VDOrderEmail] [nvarchar](1) NULL,
	[PictureFee] [money] NULL,
	[ColorSwatchFee] [money] NULL,
	[VDPreOrderActive] [nvarchar](1) NULL,
	[VDDiscountFee] [float] NULL,
	[SignUpType] [varchar](1) NOT NULL,
	[VDStoreCredit] [money] NOT NULL,
	[VDUseUPS] [bit] NOT NULL,
	[VDOwnWebMonthlyFee] [money] NULL,
	[VDMonthlyFee] [money] NULL,
	[VDInvoiceMemo] [nvarchar](1000) NULL,
	[VDMemo] [nvarchar](1000) NULL,
	[VDUseOnlySale] [bit] NOT NULL,
	[Brand_Rep_Image] [nvarchar](max) NULL,
	[VDMerchantFee] [float] NOT NULL,
	[VDPreAuth] [bit] NULL,
	[VDPremiumCommission] [bit] NOT NULL,
	[BuyerStaff] [int] NULL,
	[BuyerStaffTemp] [int] NULL,
	[Site] [nvarchar](10) NOT NULL,
	[VDActiveDate] [smalldatetime] NULL,
	[AssignedStaff] [int] NULL,
	[SEOTitle] [nvarchar](300) NULL,
	[SEODescription] [nvarchar](max) NULL,
	[VDStorePolicy] [nvarchar](4000) NOT NULL,
	[BrandRewardRate] [float] NOT NULL,
	[owner_info] [nvarchar](1000) NULL,
	[VendorCollection] [nvarchar](50) NULL,
	[Ein_number] [nvarchar](50) NULL,
	[CorporateName] [nvarchar](100) NULL,
	[internationalShipping] [bit] NULL,
	[VDInactiveDate] [datetime] NULL,
	[VDReactiveDate] [datetime] NULL,
	[api_login_id] [nvarchar](50) NULL,
	[api_transaction_key] [nvarchar](250) NULL
);
GO

CREATE TABLE [dbo].[TBColorSelect](
	[TBColorSelect_ID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL PRIMARY KEY,
	[TBItem_ID] [nvarchar](8) NOT NULL,
	[TBColor_ID] [nvarchar](10) NOT NULL,
	[Active] [char](1) NULL,
	[nAdd] [char](1) NULL,
	[nUpdate] [char](1) NULL,
	[nDelete] [char](1) NULL,
	[nUpdatedDate] [smalldatetime] NULL,
	[nTransferedToVendor] [nvarchar](1) NULL,
	[ImageLink] [nvarchar](max) NULL,
	[BrandActive] [varchar](1) NOT NULL
);
GO

CREATE TABLE [dbo].[TBStyleNo](
	[TBItem_ID] [nvarchar](8) NOT NULL,
	[TBVendorOwnCategory_ID] [bigint] NULL,
	[TBStyleNoCategory1_ID] [bigint] NULL,
	[TBStyleNoCategory2_ID] [bigint] NULL,
	[TBVendorCollection_ID] [bigint] NULL,
	[TBVendor_ID] [nvarchar](3) NOT NULL,
	[TBRealVendor_ID] [nvarchar](3) NULL,
	[nVendorBarItem] [nvarchar](12) NULL,
	[nVendorStyleNo] [nvarchar](30) NULL,
	[nOurStyleNo] [nvarchar](30) NULL,
	[nOurStyleNo2] [nvarchar](30) NULL,
	[nItemDescription] [varchar](4000) NULL,
	[TBSizeChart_ID] [bigint] NOT NULL,
	[nReportYesOrNo] [nvarchar](3) NULL,
	[TBPackNo_ID] [bigint] NOT NULL,
	[nActive] [char](1) NULL,
	[nVendorActive] [char](1) NULL,
	[nPrepare] [nvarchar](1) NULL,
	[nPurchasePrice] [money] NULL,
	[nPurchaseDiscountPrice] [money] NULL,
	[nMSRP] [money] NULL,
	[nPrice1] [money] NULL,
	[nPrice2] [money] NULL,
	[nPrice3] [money] NULL,
	[nOnSale] [char](1) NULL,
	[nSalePrice] [money] NULL,
	[nSalePrice1] [money] NULL,
	[nSalePrice2] [money] NULL,
	[nSalePrice3] [money] NULL,
	[nAvgPrice] [money] NULL,
	[nFirstPDate] [smalldatetime] NULL,
	[nLastPDate] [smalldatetime] NULL,
	[nFirstSDate] [smalldatetime] NULL,
	[nLastSDate] [smalldatetime] NULL,
	[nFirstPPrice] [money] NULL,
	[nLastPPrice] [money] NULL,
	[nFirstSalePrice] [money] NULL,
	[nLastSalePrice] [money] NULL,
	[nAvgCost] [money] NULL,
	[nDate] [smalldatetime] NULL,
	[nDISC] [nvarchar](5) NULL,
	[nBDiscountYesOrNo] [bit] NULL,
	[nFirstSalePrice1] [money] NULL,
	[nFirstSalePrice2] [money] NULL,
	[nFirstSalePrice3] [money] NULL,
	[nWeight] [float] NULL,
	[nCustomerReadCount] [int] NULL,
	[nIsAllPack] [char](1) NULL,
	[nModifyDate] [smalldatetime] NULL,
	[nSoldOutUpdateDate] [smalldatetime] NULL,
	[nSaleDate] [smalldatetime] NULL,
	[nSoldOut] [char](1) NULL,
	[nVendorSalePrice] [money] NULL,
	[nHotItem100_1] [char](1) NULL,
	[nHotItem20_1] [char](1) NULL,
	[nHotItem100_2] [char](1) NULL,
	[nHotItem20_2] [char](1) NULL,
	[nHotItem100_3] [char](1) NULL,
	[nHotItem20_3] [char](1) NULL,
	[nHotItem100_4] [char](1) NULL,
	[nHotItem20_4] [char](1) NULL,
	[nHotItem100_2M] [char](1) NULL,
	[nHotItem20_2M] [char](1) NULL,
	[nHotItem100_1Sorting] [int] NULL,
	[nHotItem20_1Sorting] [int] NULL,
	[nHotItem100_2Sorting] [int] NULL,
	[nHotItem20_2Sorting] [int] NULL,
	[nHotItem100_3Sorting] [int] NULL,
	[nHotItem20_3Sorting] [int] NULL,
	[nHotItem100_4Sorting] [int] NULL,
	[nHotItem20_4Sorting] [int] NULL,
	[nHotItem100_2MSorting] [int] NULL,
	[nHotItem20_2MSorting] [int] NULL,
	[PictureS1] [nvarchar](100) NULL,
	[PictureS2] [nvarchar](100) NULL,
	[PictureS3] [nvarchar](100) NULL,
	[PictureS4] [nvarchar](100) NULL,
	[PictureS5] [nvarchar](100) NULL,
	[PictureS6] [nvarchar](100) NULL,
	[PictureS7] [nvarchar](100) NULL,
	[PictureS8] [nvarchar](100) NULL,
	[PictureS9] [nvarchar](100) NULL,
	[PictureR1] [nvarchar](100) NULL,
	[PictureR2] [nvarchar](100) NULL,
	[PictureR3] [nvarchar](100) NULL,
	[PictureR4] [nvarchar](100) NULL,
	[PictureR5] [nvarchar](100) NULL,
	[PictureR6] [nvarchar](100) NULL,
	[PictureR7] [nvarchar](100) NULL,
	[PictureR8] [nvarchar](100) NULL,
	[PictureR9] [nvarchar](100) NULL,
	[Picture1] [nvarchar](100) NULL,
	[Picture2] [nvarchar](100) NULL,
	[Picture3] [nvarchar](100) NULL,
	[Picture4] [nvarchar](100) NULL,
	[Picture5] [nvarchar](100) NULL,
	[Picture6] [nvarchar](100) NULL,
	[Picture7] [nvarchar](100) NULL,
	[Picture8] [nvarchar](100) NULL,
	[Picture9] [nvarchar](100) NULL,
	[PColorID1] [nvarchar](2) NULL,
	[PColorID2] [nvarchar](2) NULL,
	[PColorID3] [nvarchar](2) NULL,
	[PColorID4] [nvarchar](2) NULL,
	[PColorID5] [nvarchar](2) NULL,
	[PColorID6] [nvarchar](2) NULL,
	[PColorID7] [nvarchar](2) NULL,
	[PColorID8] [nvarchar](2) NULL,
	[PColorID9] [nvarchar](2) NULL,
	[PictureS1Temp] [nvarchar](100) NULL,
	[PictureS2Temp] [nvarchar](100) NULL,
	[PictureS3Temp] [nvarchar](100) NULL,
	[PictureS4Temp] [nvarchar](100) NULL,
	[PictureS5Temp] [nvarchar](100) NULL,
	[PictureS6Temp] [nvarchar](100) NULL,
	[PictureS7Temp] [nvarchar](100) NULL,
	[PictureS8Temp] [nvarchar](100) NULL,
	[PictureS9Temp] [nvarchar](100) NULL,
	[PictureR1Temp] [nvarchar](100) NULL,
	[PictureR2Temp] [nvarchar](100) NULL,
	[PictureR3Temp] [nvarchar](100) NULL,
	[PictureR4Temp] [nvarchar](100) NULL,
	[PictureR5Temp] [nvarchar](100) NULL,
	[PictureR6Temp] [nvarchar](100) NULL,
	[PictureR7Temp] [nvarchar](100) NULL,
	[PictureR8Temp] [nvarchar](100) NULL,
	[PictureR9Temp] [nvarchar](100) NULL,
	[Picture1Temp] [nvarchar](100) NULL,
	[Picture2Temp] [nvarchar](100) NULL,
	[Picture3Temp] [nvarchar](100) NULL,
	[Picture4Temp] [nvarchar](100) NULL,
	[Picture5Temp] [nvarchar](100) NULL,
	[Picture6Temp] [nvarchar](100) NULL,
	[Picture7Temp] [nvarchar](100) NULL,
	[Picture8Temp] [nvarchar](100) NULL,
	[Picture9Temp] [nvarchar](100) NULL,
	[nMatched] [char](1) NULL,
	[nUpdate] [char](1) NULL,
	[nVendorBestSeller] [char](1) NULL,
	[nVendorBestSellerManual] [char](1) NULL,
	[nABSChoice] [char](1) NULL,
	[nAdd] [char](1) NULL,
	[nSelfAdd] [char](1) NULL,
	[TBStyleNo_OS_Category_Master_ID] [bigint] NULL,
	[TBStyleNo_OS_Category_Sub_ID] [bigint] NULL,
	[TBStyleNo_Category_Master_ID] [bigint] NULL,
	[TBStyleNo_Category_Sub_ID] [bigint] NULL,
	[TBStyleNo_Color_ID] [bigint] NULL,
	[TBStyleNo_PatternDetail_ID] [nvarchar](140) NULL,
	[TBStyleNo_Style_ID] [nvarchar](10) NULL,
	[TBStyleNo_Department_ID] [int] NULL,
	[nSortingNO] [int] NULL,
	[onGroupBy_Active] [nvarchar](1) NULL,
	[onGroupBy_MaxPack] [int] NULL,
	[onGroupBy_ChoosePackQTY] [int] NULL,
	[OnisCustomer] [nvarchar](1) NULL,
	[PictureZ1] [nvarchar](100) NULL,
	[PictureZ2] [nvarchar](100) NULL,
	[PictureZ3] [nvarchar](100) NULL,
	[PictureZ4] [nvarchar](100) NULL,
	[PictureZ5] [nvarchar](100) NULL,
	[PictureZ6] [nvarchar](100) NULL,
	[PictureZ7] [nvarchar](100) NULL,
	[PictureZ8] [nvarchar](100) NULL,
	[PictureZ9] [nvarchar](100) NULL,
	[PictureZ1Temp] [nvarchar](100) NULL,
	[PictureZ2Temp] [nvarchar](100) NULL,
	[PictureZ3Temp] [nvarchar](100) NULL,
	[PictureZ4Temp] [nvarchar](100) NULL,
	[PictureZ5Temp] [nvarchar](100) NULL,
	[PictureZ6Temp] [nvarchar](100) NULL,
	[PictureZ7Temp] [nvarchar](100) NULL,
	[PictureZ8Temp] [nvarchar](100) NULL,
	[PictureZ9Temp] [nvarchar](100) NULL,
	[PictureFullLocation] [nvarchar](1000) NULL,
	[PictureV1] [nvarchar](100) NULL,
	[PictureV2] [nvarchar](100) NULL,
	[PictureV3] [nvarchar](100) NULL,
	[PictureV4] [nvarchar](100) NULL,
	[PictureV5] [nvarchar](100) NULL,
	[PictureV6] [nvarchar](100) NULL,
	[PictureV7] [nvarchar](100) NULL,
	[PictureV8] [nvarchar](100) NULL,
	[PictureV9] [nvarchar](100) NULL,
	[PictureV1Temp] [nvarchar](100) NULL,
	[PictureV2Temp] [nvarchar](100) NULL,
	[PictureV3Temp] [nvarchar](100) NULL,
	[PictureV4Temp] [nvarchar](100) NULL,
	[PictureV5Temp] [nvarchar](100) NULL,
	[PictureV6Temp] [nvarchar](100) NULL,
	[PictureV7Temp] [nvarchar](100) NULL,
	[PictureV8Temp] [nvarchar](100) NULL,
	[PictureV9Temp] [nvarchar](100) NULL,
	[PictureELocation] [nvarchar](200) NULL,
	[PictureLLocation] [nvarchar](200) NULL,
	[PictureVLocation] [nvarchar](200) NULL,
	[PictureZLocation] [nvarchar](200) NULL,
	[PictureTestR1] [nvarchar](100) NULL,
	[GroupBuySeries] [char](1) NULL,
	[nPreOrder] [nvarchar](1) NOT NULL,
	[nPreOrderAvailableDate] [smalldatetime] NULL,
	[TBGroupBuyStyleNo_ID] [bigint] NULL,
	[GroupNO_ID] [nvarchar](50) NULL,
	[nStyleName] [nvarchar](40) NULL,
	[nStyleNameUpdated] [nvarchar](1) NULL,
	[TBStyleNo_OS_Collection_ID] [bigint] NULL,
	[SearchField] [nvarchar](max) NULL,
	[PageIDX] [bigint] NULL,
	[nHidden] [char](1) NULL,
	[nReStock] [nvarchar](1) NULL,
	[nReStockDate] [smalldatetime] NULL,
	[is_brand_only] [bit] NOT NULL,
	[is_brand_only_active] [bit] NOT NULL,
	[view_point] [smallint] NULL,
	[cart_point] [int] NULL,
	[sales_point] [smallint] NULL,
	[popular_point] [smallint] NULL,
	[WaitCallback] [bit] NOT NULL,
	[OriginDate] [datetime] NOT NULL,
	[PublishDate] [smalldatetime] NULL,
	[is_broken_pack] [bit] NOT NULL,
	[min_broken_pack_order_qty] [smallint] NOT NULL,
	[TBStyleNo_OS_Shape_ID] [int] NULL,
	[TBStyleNo_OS_Length_ID] [int] NULL,
	[TBStyleNo_OS_Sleeve_ID] [int] NULL,
	[made_in] [nvarchar](3) NULL,
	[is_failed] [bit] NULL,
	[is_checked] [bit] NOT NULL
);
GO



CREATE TABLE [dbo].[TBStyleNo_OS_Category_Master](
	[TBStyleNo_OS_Category_Master_ID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CategoryMasterName] [nvarchar](50) NULL,
	[Description] [nvarchar](4000) NULL,
	[Active] [bit] NULL,
	[mainTopCategory] [smallint] NOT NULL,
	[DisplayGroup] [nvarchar](50) NULL,
	[DisplayOrder] [int] NULL,
	[DisplayGroupOrder] [int] NULL,
	[url] [nvarchar](50) NULL,
	[Description50] [nvarchar](4000) NULL,
	[seo_title] [nvarchar](500) NULL,
	[seo_description] [nvarchar](max) NULL,
	[Description_tmpl] [nvarchar](2000) NULL,
	[h1_tag] [nvarchar](500) NULL
);


GO
CREATE TABLE [dbo].[TBStyleNo_OS_Category_Sub](
	[TBStyleNo_OS_Category_Sub_ID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TBStyleNo_OS_Category_Master_ID] [bigint] NULL,
	[CategorySubName] [nvarchar](50) NULL,
	[Description] [nvarchar](2000) NULL,
	[Active] [bit] NULL,
	[url] [nvarchar](50) NULL,
	[Description50] [nvarchar](2000) NULL,
	[seo_title] [nvarchar](500) NULL,
	[seo_description] [nvarchar](max) NULL,
	[Description_tmpl] [nvarchar](2000) NULL,
	[h1_tag] [nvarchar](500) NULL
);
GO


CREATE TABLE [dbo].[TBVendorShoeSize](
	[TBVendorShoeSize_ID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ShoeSizeName] [nvarchar](50) NULL,
	[Description] [nvarchar](50) NULL,
	[TBVendor_ID] [nvarchar](3) NULL,
	[S5] [nvarchar](2) NULL,
	[S5h] [nvarchar](2) NULL,
	[S6] [nvarchar](2) NULL,
	[S6h] [nvarchar](2) NULL,
	[S7] [nvarchar](2) NULL,
	[S7h] [nvarchar](2) NULL,
	[S8] [nvarchar](2) NULL,
	[S8h] [nvarchar](2) NULL,
	[S9] [nvarchar](2) NULL,
	[S9h] [nvarchar](2) NULL,
	[S10] [nvarchar](2) NULL,
	[S10h] [nvarchar](2) NULL,
	[S11] [nvarchar](2) NULL,
	[S11h] [nvarchar](2) NULL,
	[S12] [nvarchar](2) NULL,
	[S12h] [nvarchar](2) NULL,
	[is_favorite] [bit] NULL,
	[sn1] [varchar](15) NULL,
	[sn2] [varchar](15) NULL,
	[sn3] [varchar](15) NULL,
	[sn4] [varchar](15) NULL,
	[sn5] [varchar](15) NULL,
	[sn6] [varchar](15) NULL,
	[sn7] [varchar](15) NULL,
	[sn8] [varchar](15) NULL,
	[sn9] [varchar](15) NULL,
	[sn10] [varchar](15) NULL,
	[sn11] [varchar](15) NULL,
	[sn12] [varchar](15) NULL,
	[sn13] [varchar](15) NULL,
	[sn14] [varchar](15) NULL,
	[sn15] [varchar](15) NULL,
	[sn16] [varchar](15) NULL
);


CREATE TABLE [dbo].[TBColor](
	[TBColor_ID] [nvarchar](10) NOT NULL,
	[cColorName] [nvarchar](30) NOT NULL,
	[cColorDescription] [nvarchar](50) NULL,
	[cActive] [bit] NULL,
	[TBVendor_ID] [nvarchar](3) NULL,
	[cAdd] [nvarchar](1) NULL,
	[cDelete] [nvarchar](1) NULL
);

GO
CREATE TABLE [dbo].[TBStyleNo_OS_Pattern](
	[TBStyleNo_OS_Pattern_ID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[PatternName] [nvarchar](50) NULL,
	[Description] [nvarchar](50) NULL,
	[Active] [bit] NULL
);
GO

CREATE TABLE [dbo].[TBStyleNo_OS_StyleSelect](
	[TBStyleNo_OS_StyleSelect_ID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TBItem_ID] [nvarchar](8) NULL,
	[TBStyleNo_OS_Style_ID] [bigint] NULL,
	[nAdd] [nvarchar](1) NULL,
	[nDelete] [nvarchar](1) NULL
);


GO
CREATE TABLE [dbo].[TBVendorShoeSizeSelect](
	[TBVendorShoeSizeSelect_ID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TBItem_ID] [nvarchar](10) NULL,
	[TBVendorShoeSize_ID] [bigint] NULL
);

GO

CREATE TABLE [dbo].[TBStyleNo_OS_PatternSelect](
	[TBStyleNo_OS_PatternSelect_ID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TBItem_ID] [nvarchar](8) NULL,
	[TBStyleNo_OS_Pattern_ID] [bigint] NULL,
	[nAdd] [nvarchar](1) NULL,
	[nDelete] [nvarchar](1) NULL
);

GO
CREATE TABLE [dbo].[TBStyleNo_OS_SleeveSelect](
	[TBStyleNo_OS_SleeveSelect_ID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TBItem_ID] [nvarchar](8) NULL,
	[TBStyleNo_OS_Sleeve_ID] [bigint] NULL,
	[nAdd] [nvarchar](1) NULL,
	[nDelete] [nvarchar](1) NULL
);

GO
CREATE TABLE [dbo].[TBStyleNo_OS_Sleeve](
	[TBStyleNo_OS_Sleeve_ID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SleeveName] [nvarchar](50) NULL,
	[Description] [nvarchar](50) NULL,
	[Active] [bit] NULL
);

GO

CREATE TABLE [dbo].[TBStyleNo_OS_Style](
	[TBStyleNo_OS_Style_ID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[StyleName] [nvarchar](50) NULL,
	[Description] [nvarchar](50) NULL,
	[Active] [bit] NULL
);

GO

GO
	create view [dbo].[vTBStyleSearch] as
	SELECT

	TBSNO.TBItem_ID as product_id,
	TBOCM.DisplayGroupOrder as group_id,
	TBSNO.nStyleName as style_name,
	TBSNO.nVendorStyleNo as style_number,
	TBOCM.DisplayGroup as group_name,
	TBOCM.CategoryMasterName as category,
	TBOCM.is_plus_size as is_plus_size,
	TBOCM.TBStyleNo_OS_Category_Master_ID as category_id,
	TBOCS.CategorySubName as sub_category,

	TBOCS.TBStyleNo_OS_Category_Sub_ID as sub_category_id,
	TBSNO.nItemDescription as description,
	TBCST.TBColor_ID as color_id,


	TBCLR.cColorName as color_name,
	TBCST.Active as is_color_active,
	TBSNO.Picture1 as default_picture,
	CASE WHEN  (TBCST.ImageLink='' or TBCST.ImageLink is null)  THEN  TBSNO.Picture1 ELSE  concat('https://dc964uidi8qge.cloudfront.net/OSFile/OS/ColorSwatch/', ImageLink) END as color_image,

	TBSNO.TBVendor_ID as brand_id,
	TBVD.VDName as brand_name,
	TBVD.VDWebName as brand_web_name,
	TBVD.ShippedFrom as fulfillment,
	TBVD.VDVendorURL as brand_url,
	TBVD.copyprevention as is_prevention ,

	RTBSNOPT.patterns as patterns,
	RTBSOSST.sleeves as sleeves,
	RTBSNOS.styles as styles,

	TBSNO.nActive as is_active,
	TBSNO.is_broken_pack as is_broken,
	TBSNO.nOnSale as is_sale,
	TBSNO.nPreOrder as is_preorder,
	TBSNO.nPreOrderAvailableDate as available_date,
	TBSNO.nReStock as is_restock,
	TBSNO.nSoldOut as is_sold_out,

	TBPKNO.dPackNoName as pack_name,
	TBSZCT.dSizeDescription as item_sizes,
	TBVDSSS.shoe_sizes as shoe_sizes,

	TBSNPLR.popular_point_7 as popular_point_7,
	TBSNPLR.popular_point_14 as popular_point_14,
	TBSNPLR.popular_point_30 as popular_point_30,
	TBSNPLR.popular_point_60 as popular_point_60,
	VAOR.pct_1_stars as pct_1_stars,
	VAOR.pct_2_stars as pct_2_stars,
	VAOR.pct_3_stars as pct_3_stars,
	VAOR.pct_4_stars as pct_4_stars,
	VAOR.pct_5_stars as pct_5_stars,

	TBSNO.nPrice2 as regular_price,
	case when  TBSNO.nSalePrice2<>''  then TBSNO.nSalePrice2 else TBSNO.nPrice2  end as price,
	TBSNO.nSalePrice2 as sale_price,

	TBSNO.nDate as created_date,
	TBSNO.nModifyDate as updated_date,
	(SELECT    		string_agg(TBCLR.cColorName,',')
					FROM TBColorSelect TBCST
	LEFT JOIN (SELECT
					TBColor_ID,
					cColorName
					FROM TBColor) TBCLR
	ON TBCST.TBColor_ID = TBCLR.TBColor_ID
	WHERE TBSNO.TBItem_ID = TBCST.TBItem_ID ) as color_list

	FROM (SELECT
			TBItem_ID,
			nVendorBarItem,
			nStyleName,
			nVendorStyleNo,
			TBStyleNo_OS_Category_Master_ID,
			TBStyleNo_OS_Category_Sub_ID,
			nItemDescription,
			TBPackNo_ID,
			TBSizeChart_ID,
			TBVendor_ID,
			nActive,
			is_broken_pack,
			nOnSale,
			nPreOrder,
			nReStock,
			nSoldOut,
			nPrice2,
			nSalePrice2,
			concat('https://media.orangeshine.com/OSFile/OS/Pictures/', Picture1) as Picture1,
			nDate,
			nModifyDate,
			nPreOrderAvailableDate
			FROM TBStyleNo where Picture1 <> '') TBSNO

	LEFT JOIN (SELECT
					STYLE_TBSNO.TBItem_ID,
					string_agg(TBSNOS.StyleName,',') as styles
					FROM (SELECT TBItem_ID
							FROM TBStyleNo) STYLE_TBSNO
					LEFT JOIN TBStyleNo_OS_StyleSelect TBSNOST
					ON STYLE_TBSNO.TBItem_ID = TBSNOST.TBItem_ID
					LEFT JOIN TBStyleNo_OS_Style TBSNOS
					ON TBSNOST.TBStyleNo_OS_Style_ID = TBSNOS.TBStyleNo_OS_Style_ID
					GROUP BY STYLE_TBSNO.TBItem_ID) RTBSNOS
	ON TBSNO.TBItem_ID = RTBSNOS.TBItem_ID

	LEFT JOIN (SELECT
					SLEEVE_TBSNO.TBItem_ID,
					string_agg(TBSOSS.SleeveName,',') as sleeves
					FROM (SELECT TBItem_ID
					  FROM TBStyleNo) SLEEVE_TBSNO
					LEFT JOIN TBStyleNo_OS_SleeveSelect TBSOSST
					ON SLEEVE_TBSNO.TBItem_ID = TBSOSST.TBItem_ID
					LEFT JOIN TBStyleNo_OS_Sleeve TBSOSS
					ON TBSOSST.TBStyleNo_OS_Sleeve_ID = TBSOSST.TBStyleNo_OS_Sleeve_ID
					GROUP BY SLEEVE_TBSNO.TBItem_ID) RTBSOSST
	ON TBSNO.TBItem_ID = RTBSOSST.TBItem_ID

	LEFT JOIN (SELECT
					Pattern_TBSNO.TBItem_ID,
					string_agg(TBSNOP.PatternName,',') as patterns
					FROM (SELECT TBItem_ID
							FROM TBStyleNo) Pattern_TBSNO
					LEFT JOIN TBStyleNo_OS_PatternSelect TBSNOPT
					ON Pattern_TBSNO.TBItem_ID = TBSNOPT.TBItem_ID
					LEFT JOIN TBStyleNo_OS_Pattern TBSNOP
					ON TBSNOPT.TBStyleNo_OS_Pattern_ID = TBSNOP.TBStyleNo_OS_Pattern_ID
					GROUP BY Pattern_TBSNO.TBItem_ID) RTBSNOPT
	ON TBSNO.TBItem_ID = RTBSNOPT.TBItem_ID

	INNER JOIN (SELECT
					TBVendor_ID,
					VDName,
					VDWebName,
					VDVendorURL,
					copyprevention,
					ShippedFrom
					FROM TBVendor) TBVD
	ON TBSNO.TBVendor_ID = TBVD.TBVendor_ID
	INNER JOIN (SELECT
					TBStyleNo_OS_Category_Master_ID,
					DisplayGroup,
					CategoryMasterName,
					DisplayGroupOrder,
	case when TBStyleNo_OS_Category_Master_ID=9 then  1 else  0 end as is_plus_size
					FROM TBStyleNo_OS_Category_Master) TBOCM
	ON TBSNO.TBStyleNo_OS_Category_Master_ID = TBOCM.TBStyleNo_OS_Category_Master_ID
	LEFT JOIN (SELECT
					TBStyleNo_OS_Category_Sub_ID,
					CategorySubName
	FROM TBStyleNo_OS_Category_Sub) TBOCS
	ON TBSNO.TBStyleNo_OS_Category_Sub_ID = TBOCS.TBStyleNo_OS_Category_Sub_ID

	LEFT JOIN (SELECT
					TBItem_ID,
					TBColor_ID,
					ImageLink,
	Active
					FROM TBColorSelect) TBCST
	ON TBSNO.TBItem_ID = TBCST.TBItem_ID
	LEFT JOIN (SELECT
					TBColor_ID,
					cColorName
					FROM TBColor) TBCLR
	ON TBCST.TBColor_ID = TBCLR.TBColor_ID
	LEFT JOIN (SELECT
					TBItem_ID,
					popular_point_7,
					popular_point_14,
					popular_point_30,
					popular_point_60
					FROM TBStyleNo_Popular) TBSNPLR
	ON TBSNO.TBItem_ID = TBSNPLR.TBItem_ID
	LEFT JOIN (SELECT
					TBVendor_ID,
					pct_1_stars,
					pct_2_stars,
					pct_3_stars,
					pct_4_stars,
					pct_5_stars
					FROM vw_AvgOrderReview) VAOR
	ON TBVD.TBVendor_ID = VAOR.TBVendor_ID
	INNER JOIN (SELECT
					TBPackNo_ID,
					dPackNoName
	FROM TBPackNo) TBPKNO
	ON TBSNO.TBPackNo_ID = TBPKNO.TBPackNo_ID
	LEFT JOIN (SELECT
					TBSizeChart_ID,
					dSizeDescription
	FROM TBSizeChart) TBSZCT
	ON TBSNO.TBSizeChart_ID = TBSZCT.TBSizeChart_ID
	LEFT JOIN (SELECT
					TBItem_ID,
	TBVendorShoeSize_ID
	FROM TBVendorShoeSizeSelect) TBVDSSST
	ON TBSNO.TBItem_ID = TBVDSSST.TBItem_ID
	LEFT JOIN (SELECT
				TBVendorShoeSize_ID,
				CONCAT(sn1,',',
						sn2,',',
						sn3, ',',
						sn4, ',',
						sn5, ',',
						sn6, ',',
						sn7, ',',
						sn8, ',',
						sn9, ',',
						sn10, ',',
						sn11, ',',
						sn12, ',',
						sn13, ',',
						sn14, ',',
						sn15, ',',
						sn16) as shoe_sizes
	FROM
						TBVendorShoeSize) TBVDSSS
	ON TBVDSSST.TBVendorShoeSize_ID = TBVDSSS.TBVendorShoeSize_ID;
GO
