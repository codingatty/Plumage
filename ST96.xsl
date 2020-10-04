<?xml version="1.0" encoding="utf-8"?>

<!-- 

   Plumage: XSLT to transform USPTO TSDR XML to CSV format
   https://github.com/codingatty/Plumage
   
   ST96.xsl - ST.96 transform
   Version 1.2.0 (pre-release), 2018-09-25
   Copyright 2014-2018 Terry Carroll
   carroll@tjc.com

   This program is licensed under Apache License, version 2.0 (January 2004),
   http://www.apache.org/licenses/LICENSE-2.0

   SPX-License-Identifier: Apache-2.0

   Anyone who makes use of, or who modifies, this code is encouraged
   (but not required) to notify the author.

-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns1="http://www.wipo.int/standards/XMLSchema/ST96/Common" xmlns:ns2="http://www.wipo.int/standards/XMLSchema/ST96/Trademark" xmlns:ns3="urn:us:gov:doc:uspto:trademark">
<xsl:output method="text" encoding="utf-8" />
<xsl:variable name='NL'><xsl:text>&#10;</xsl:text></xsl:variable><!-- NL = newline character X'0A' -->

<xsl:template match="ns2:TrademarkTransaction">
<xsl:apply-templates select=".//ns2:TrademarkBag/ns2:Trademark"/>
<xsl:text/>MetaInfoXSLTName,"Plumage"
MetaInfoXSLTVersion,"1.4.0-pre"
MetaInfoXSLTDate,"2020-09-02"
MetaInfoXSLTAuthor,"Terry Carroll"
MetaInfoXSLTURL,"https://github.com/codingatty/Plumage"
MetaInfoXSLTCopyright,"Copyright 2014-2020 Terry Carroll"
MetaInfoXSLTLicense,"Apache License, version 2.0 (January 2004)"
MetaInfoXSLTSPDXLicenseIdentifier,"Apache-2.0"
MetaInfoXSLTLicenseURL,"http://www.apache.org/licenses/LICENSE-2.0"
MetaInfoLibraryName,"$IMPLEMENTATIONNAME$"
MetaInfoLibraryVersion,"$IMPLEMENTATIONVERSION$"
MetaInfoLibraryDate,"$IMPLEMENTATIONDATE$"
MetaInfoLibraryAuthor,"$IMPLEMENTATIONAUTHOR$"
MetaInfoLibraryURL,"$IMPLEMENTATIONURL$"
MetaInfoLibraryCopyright,"$IMPLEMENTATIONCOPYRIGHT$"
MetaInfoLibraryLicense,"$IMPLEMENTATIONLICENSE$"
MetaInfoLibrarySPDXLicenseIdentifier,"$IMPLEMENTATIONSPDXLID$"
MetaInfoLibraryLicenseURL,"$IMPLEMENTATIONLICENSEURL$"
MetaInfoExecXSLTFilename,"$XSLTFILENAME$"
MetaInfoExecXSLTLocation,"$XSLTLOCATION$"
MetaInfoExecXSLTFormat,"ST.96"
MetaInfoExecExecutionDateTime,"$EXECUTIONDATETIME$"
MetaInfoExecTSDRStartTimestamp,"$TSDRSTARTDATETIME$"
MetaInfoExecTSDRCompleteTimestamp,"$TSDRSCOMPLETEDATETIME$"
MetaInfoExecXMLSource,"$XMLSOURCE$"
MetaInfoExecXSLProcessorVersion,"<xsl:value-of select="system-property('xsl:version')"/>"
MetaInfoExecXSLProcessorVendor,"<xsl:value-of select="system-property('xsl:vendor')"/>"
MetaInfoExecXSLProcessorVendorURL,"<xsl:value-of select="system-property('xsl:vendor-url')"/>"
</xsl:template>

<xsl:template match="ns2:Trademark">
<xsl:text/>MarkCurrentStatusDate,"<xsl:value-of select="ns2:MarkCurrentStatusDate"/>"
MarkCurrentStatusDateTruncated,"<xsl:value-of select="substring(ns2:MarkCurrentStatusDate,1,10)"/>"
ApplicationNumber,"<xsl:value-of select="ns1:ApplicationNumber/ns1:ApplicationNumberText"/>"
ApplicationDate,"<xsl:value-of select="ns2:ApplicationDate"/>"
ApplicationDateTruncated,"<xsl:value-of select="substring(ns2:ApplicationDate,1,10)"/>"
RegistrationNumber,"<xsl:value-of select="ns1:RegistrationNumber"/>"
RegistrationDate,"<xsl:value-of select="ns1:RegistrationDate"/>"
RegistrationDateTruncated,"<xsl:value-of select="substring(ns1:RegistrationDate,1,10)"/>"
<xsl:apply-templates select="ns2:MarkRepresentation/ns2:MarkReproduction/ns2:WordMarkSpecification"/>
<xsl:apply-templates select="ns2:NationalTrademarkInformation"/>
<xsl:apply-templates select="ns2:AssociatedMarkBag/ns2:AssociatedMark"/>
<xsl:apply-templates select="ns2:GoodsServicesBag/ns2:GoodsServices/ns2:ClassDescriptionBag/ns2:ClassDescription"/>
<xsl:apply-templates select="ns2:GoodsServicesBag/ns2:GoodsServices/ns2:GoodsServicesClassificationBag/ns2:GoodsServicesClassification"/>
<xsl:apply-templates select="ns2:GoodsServicesBag/ns2:GoodsServices/ns2:NationalFilingBasis"/>
<xsl:apply-templates select="ns2:PublicationBag/ns2:Publication"/>
<xsl:apply-templates select="ns2:NationalCorrespondent/ns1:Contact"/>
<xsl:apply-templates select="ns1:StaffBag/ns1:Staff"/>
<xsl:apply-templates select="ns2:ApplicantBag/ns2:Applicant"/>
<xsl:apply-templates select="ns2:MarkEventBag/ns2:MarkEvent"/>
<xsl:apply-templates select="ns2:AssignmentBag/ns2:Assignment"/>
</xsl:template>

<xsl:template match="ns2:MarkRepresentation/ns2:MarkReproduction/ns2:WordMarkSpecification">
<xsl:text/>MarkVerbalElementText,"<xsl:value-of select="ns2:MarkVerbalElementText"/>"
</xsl:template>

<xsl:template match="ns2:NationalTrademarkInformation">
<xsl:text/>MarkCurrentStatusExternalDescriptionText,"<xsl:value-of select="ns2:MarkCurrentStatusExternalDescriptionText"/>"
<!-- kludge: ST.96 format uses "Primary" instead of "Principal" for the Principal Register -->
<xsl:choose>
	<xsl:when test="ns2:RegisterCategory = 'Primary'">
<xsl:text/>RegisterCategory,"Principal"<xsl:text/>
	</xsl:when>
	<xsl:otherwise>
<xsl:text/>RegisterCategory,"<xsl:value-of select="ns2:RegisterCategory"/>"<xsl:text/>
	</xsl:otherwise>
</xsl:choose>
RenewalDate,"<xsl:value-of select="ns2:RenewalDate"/>"
RenewalDateTruncated,"<xsl:value-of select="substring(ns2:RenewalDate,1,10)"/>"
<xsl:apply-templates select="ns2:NationalCaseLocation"/>
</xsl:template>

<xsl:template match="ns2:NationalCaseLocation">
<xsl:text/>LawOfficeAssignedText,"<xsl:value-of select="ns2:LawOfficeAssignedText"/>"
CurrentLocationCode,"<xsl:value-of select="ns2:CurrentLocationCode"/>"
CurrentLocationText,"<xsl:value-of select="ns2:CurrentLocationText"/>"
CurrentLocationDate,"<xsl:value-of select="ns2:CurrentLocationDate"/>"
CurrentLocationDateTruncated,"<xsl:value-of select="substring(ns2:CurrentLocationDate,1,10)"/>"
</xsl:template>

<!-- This is odd, but, yes, the *registration* number is stored under "InternationalApplicationNumber". 
     This is a change from ST96 1_D3 to ST96 2.2.1 -->
<xsl:template match="ns2:AssociatedMarkBag/ns2:AssociatedMark">
<xsl:if test="ns2:AssociationCategory = 'International application or registration'">
<xsl:text/>InternationalApplicationNumber,"<xsl:value-of select="ns1:ApplicationNumber/ns1:ApplicationNumberText"/>"
InternationalRegistrationNumber,"<xsl:value-of select="ns2:InternationalApplicationNumber/ns1:ApplicationNumberText"/>"
</xsl:if>
</xsl:template>

<!-- ST96 has two types of ClassDescription nodes; one with the class number and description; and one with a NationalStatusBag node. We process only the first type. -->
<xsl:template match="ns2:GoodsServicesBag/ns2:GoodsServices/ns2:ClassDescriptionBag/ns2:ClassDescription">
<xsl:if test="ns2:ClassNumber != ''">
<xsl:text/>BeginRepeatedField,"InternationalClassDescription"
InternationalClassNumber,"<xsl:value-of select="ns2:ClassNumber"/>"
GoodsServicesDescription,"<xsl:value-of select="ns2:GoodsServicesDescriptionText"/>"
EndRepeatedField,"InternationalClassDescription"
</xsl:if>
</xsl:template>

<xsl:template match="ns2:GoodsServicesBag/ns2:GoodsServices/ns2:GoodsServicesClassificationBag/ns2:GoodsServicesClassification">
<xsl:if test="ns2:ClassificationKindCode = 'Domestic'">
<xsl:text/>BeginRepeatedField,"DomesticClassDescription"
<xsl:for-each select="../ns2:GoodsServicesClassification">
<xsl:if test="ns2:ClassificationKindCode = 'Primary'">
<xsl:text/>PrimaryClassNumber,"<xsl:value-of select="ns2:ClassNumber"/>"
</xsl:if>
<xsl:if test="ns2:ClassificationKindCode = 'Nice'">
<xsl:text/>NiceClassNumber,"<xsl:value-of select="ns2:ClassNumber"/>"
</xsl:if>
</xsl:for-each>
<xsl:text/>ClassificationKindCode,"<xsl:value-of select="ns2:ClassificationKindCode"/>"
NationalClassNumber,"<xsl:value-of select="ns2:NationalClassNumber"/>"
<xsl:text/>EndRepeatedField,"DomesticClassDescription"
</xsl:if>
</xsl:template>

<xsl:template match="ns2:GoodsServicesBag/ns2:GoodsServices/ns2:NationalFilingBasis">
<xsl:text/>BeginRepeatedField,"FirstUseDates"
<xsl:for-each select="../ns2:GoodsServicesClassificationBag/ns2:GoodsServicesClassification">
<xsl:if test="ns2:ClassificationKindCode = 'Primary'">
<xsl:text/>PrimaryClassNumber,"<xsl:value-of select="ns2:ClassNumber"/>"
</xsl:if>
<xsl:if test="ns2:ClassificationKindCode = 'Nice'">
<xsl:text/>NiceClassNumber,"<xsl:value-of select="ns2:ClassNumber"/>"
</xsl:if>
</xsl:for-each>
<xsl:text/>FirstUseDateNumber,"<xsl:value-of select="ns2:FirstUsedDate"/>"
FirstUseInCommerceDate,"<xsl:value-of select="ns2:FirstUsedCommerceDate"/>"
<xsl:text/>EndRepeatedField,"FirstUseDates"
</xsl:template>

<xsl:template match="ns2:PublicationBag/ns2:Publication">
<xsl:text/>PublicationDate,"<xsl:value-of select="ns1:PublicationDate"/>"
PublicationDateTruncated,"<xsl:value-of select="substring(ns1:PublicationDate,1,10)"/>"
</xsl:template>

<xsl:template match="ns2:NationalCorrespondent/ns1:Contact">
<xsl:text/>CorrespondentName,"<xsl:value-of select="ns1:Name/ns1:PersonName/ns1:PersonFullName"/>"
CorrespondentOrganization,"<xsl:value-of select="ns1:Name/ns1:OrganizationName/ns1:OrganizationStandardName"/>"
<xsl:apply-templates select="ns1:PostalAddressBag/ns1:PostalAddress/ns1:PostalStructuredAddress" mode="CorrespondentAddress"/>
CorrespondentPhoneNumber,"<xsl:value-of select="ns1:PhoneNumberBag/ns1:PhoneNumber"/>"
CorrespondentFaxNumber,"<xsl:value-of select="ns1:FaxNumberBag/ns1:FaxNumber"/>"
CorrespondentEmailAddress,"<xsl:value-of select="ns1:EmailAddressBag/ns1:EmailAddressText"/>"
</xsl:template>

<xsl:template match="ns1:PostalAddressBag/ns1:PostalAddress/ns1:PostalStructuredAddress" mode="CorrespondentAddress">
<xsl:text/>CorrespondentAddressLine01,"<xsl:value-of select="ns1:AddressLineText[@ns1:sequenceNumber='1']"/>"
CorrespondentAddressLine02,"<xsl:value-of select="ns1:AddressLineText[@ns1:sequenceNumber='2']"/>"
CorrespondentAddressCity,"<xsl:value-of select="ns1:CityName"/>"
CorrespondentAddressGeoRegion,"<xsl:value-of select="ns1:GeographicRegionName"/>"
CorrespondentPostalCode,"<xsl:value-of select="ns1:PostalCode"/>"
CorrespondentCountryCode,"<xsl:value-of select="ns1:CountryCode"/>"<xsl:text/>
<xsl:value-of select="concat($NL, 'CorrespondentCombinedAddress,&quot;', 
	ns1:AddressLineText[@ns1:sequenceNumber='1'], '/',
	ns1:AddressLineText[@ns1:sequenceNumber='2'], '/',
	ns1:CityName, '/',
	ns1:GeographicRegionName, '/',
	ns1:PostalCode, '/',
	ns1:CountryCode, '&quot;'
 	)"/>
</xsl:template>

<xsl:template match="ns2:ApplicantBag/ns2:Applicant">
<xsl:text/>BeginRepeatedField,"Applicant"<xsl:text/>
<xsl:choose>
	<xsl:when test="ns1:Contact/ns1:Name/ns1:EntityName != ''">
ApplicantName,"<xsl:value-of select="ns1:Contact/ns1:Name/ns1:EntityName"/>"<xsl:text/>
	</xsl:when>
	<xsl:otherwise>
ApplicantName,"<xsl:value-of select="ns1:Contact/ns1:Name/ns1:OrganizationName/ns1:OrganizationStandardName"/>"<xsl:text/>
	</xsl:otherwise>
</xsl:choose>
<xsl:choose>
	<xsl:when test="ns1:Version/ns1:CommentText != ''">
ApplicantDescription,"<xsl:value-of select="ns1:Version/ns1:CommentText"/>"<xsl:text/>
	</xsl:when>
	<xsl:otherwise>
ApplicantDescription,"<xsl:value-of select="ns1:CommentText"/>"<xsl:text/>
	</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="ns1:Contact/ns1:PostalAddressBag/ns1:PostalAddress/ns1:PostalStructuredAddress" mode="ApplicantAddress"/>
EndRepeatedField,"Applicant"
</xsl:template>

<xsl:template match="ns1:Contact/ns1:PostalAddressBag/ns1:PostalAddress/ns1:PostalStructuredAddress" mode="ApplicantAddress">
ApplicantAddressLine01,"<xsl:value-of select="ns1:AddressLineText[@ns1:sequenceNumber='1']"/>"
ApplicantAddressLine02,"<xsl:value-of select="ns1:AddressLineText[@ns1:sequenceNumber='2']"/>"
ApplicantAddressCity,"<xsl:value-of select="ns1:CityName"/>"
ApplicantAddressGeoRegion,"<xsl:value-of select="ns1:GeographicRegionName"/>"
ApplicantPostalCode,"<xsl:value-of select="ns1:PostalCode"/>"
ApplicantCountryCode,"<xsl:value-of select="ns1:CountryCode"/>"<xsl:text/>
<xsl:value-of select="concat($NL, 'ApplicantCombinedAddress,&quot;', 
	ns1:AddressLineText[@ns1:sequenceNumber='1'], '/',
	ns1:AddressLineText[@ns1:sequenceNumber='2'], '/',
	ns1:CityName, '/',
	ns1:GeographicRegionName, '/',
	ns1:PostalCode, '/',
	ns1:CountryCode, '&quot;'
 	)"/>
</xsl:template>

<xsl:template match="ns1:StaffBag/ns1:Staff">
<xsl:text/>StaffName,"<xsl:value-of select="ns1:StaffName"/>"
StaffOfficialTitle,"<xsl:value-of select="ns1:OfficialTitleText"/>"
</xsl:template>

<xsl:template match="ns2:MarkEventBag/ns2:MarkEvent">
<xsl:text/>BeginRepeatedField,"MarkEvent"
MarkEventDate,"<xsl:value-of select="ns2:MarkEventDate"/>"
MarkEventDateTruncated,"<xsl:value-of select="substring(ns2:MarkEventDate,1,10)"/>"
MarkEventDescription,"<xsl:value-of select="ns2:NationalMarkEvent/ns2:MarkEventDescriptionText"/>"
MarkEventEntryNumber,"<xsl:value-of select="ns2:NationalMarkEvent/ns2:MarkEventEntryNumber"/>"
EndRepeatedField,"MarkEvent"
</xsl:template>

<xsl:template match="ns2:AssignmentBag/ns2:Assignment">
<xsl:text/>BeginRepeatedField,"Assignment"
AssignmentIdentifier,"<xsl:value-of select="ns2:AssignmentIdentifier"/>"
AssignmentConveyanceCategory,"<xsl:value-of select="ns2:AssignmentConveyanceCategory"/>"
AssignmentGroupCategory,"<xsl:value-of select="ns2:AssignmentGroupCategory"/>"
AssignmentRecordedDate,"<xsl:value-of select="ns2:AssignmentRecordedDate"/>"
AssignmentRecordedDateTruncated,"<xsl:value-of select="substring(ns2:AssignmentRecordedDate,1,10)"/>"
AssignmentExecutedDate,"<xsl:value-of select="ns2:AssignmentExecutedDate"/>"
AssignmentExecutedDateTruncated,"<xsl:value-of select="substring(ns2:AssignmentExecutedDate,1,10)"/>"<xsl:text/>
<xsl:choose>
	<xsl:when test="ns2:AssignorBag/ns2:Assignor/ns1:Contact/ns1:Name/ns1:EntityName != ''">
AssignorEntityName,"<xsl:value-of select="ns2:AssignorBag/ns2:Assignor/ns1:Contact/ns1:Name/ns1:EntityName"/>"<xsl:text/>
	</xsl:when>
	<xsl:otherwise>
AssignorEntityName,"<xsl:value-of select="ns2:AssignorBag/ns2:Assignor/ns1:Contact/ns1:Name/ns1:OrganizationName/ns1:OrganizationStandardName"/>"<xsl:text/>
	</xsl:otherwise>
</xsl:choose>
<xsl:choose>
	<xsl:when test="ns2:AssigneeBag/ns2:Assignee/ns1:Contact/ns1:Name/ns1:EntityName != ''">
AssigneeEntityName,"<xsl:value-of select="ns2:AssigneeBag/ns2:Assignee/ns1:Contact/ns1:Name/ns1:EntityName"/>"<xsl:text/>
	</xsl:when>
	<xsl:otherwise>
AssigneeEntityName,"<xsl:value-of select="ns2:AssigneeBag/ns2:Assignee/ns1:Contact/ns1:Name/ns1:OrganizationName/ns1:OrganizationStandardName"/>"<xsl:text/>
	</xsl:otherwise>
</xsl:choose>
AssignmentDocumentURL,"<xsl:value-of select="ns2:AssignmentDocumentBag/ns2:TrademarkDocument/ns1:DocumentIdentifier"/>"
EndRepeatedField,"Assignment"
</xsl:template>
</xsl:stylesheet>