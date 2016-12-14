<?xml version="1.0" encoding="utf-8"?>

<!-- 

   Plumage: XSLT to transform USPTO TSDR XML to CSV format
   https://github.com/codingatty/Plumage
   
   ST96.xsl - ST.96 transform
   Version 1.1.0, 2016-05-21
   Copyright 2014-2016 Terry Carroll
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
</xsl:template>

<xsl:template match="ns2:Trademark">
<xsl:text/>DiagnosticInfoXSLTFilename,"$XSLTFILENAME$"<xsl:text/>
DiagnosticInfoXSLTLocation,"$XSLTLOCATION$"<xsl:text/>
DiagnosticInfoXSLTVersion,"1.1.0"<xsl:text/>
DiagnosticInfoXSLTDate,"2016-05-21"<xsl:text/>
DiagnosticInfoXSLTFormat,"ST.96"<xsl:text/>
DiagnosticInfoXSLTAuthor,"Terry Carroll"<xsl:text/>
DiagnosticInfoXSLTURL,"https://github.com/codingatty"<xsl:text/>
DiagnosticInfoXSLTCopyright,"Copyright 2014-2016 Terry Carroll"<xsl:text/>
DiagnosticInfoXSLTLicense,"Apache License, version 2.0 (January 2004)"<xsl:text/>
DiagnosticInfoXSLTSPDXLicenseIdentifier,"Apache-2.0"<xsl:text/>
DiagnosticInfoXSLTLicenseURL,"http://www.apache.org/licenses/LICENSE-2.0"<xsl:text/>
DiagnosticInfoImplementationName,"$IMPLEMENTATIONNAME$"<xsl:text/>
DiagnosticInfoImplementationVersion,"$IMPLEMENTATIONVERSION$"<xsl:text/>
DiagnosticInfoImplementationDate,"$IMPLEMENTATIONDATE$"<xsl:text/>
DiagnosticInfoImplementationAuthor,"$IMPLEMENTATIONAUTHOR$"<xsl:text/>
DiagnosticInfoImplementationURL,"$IMPLEMENTATIONURL$"<xsl:text/>
DiagnosticInfoImplementationCopyright,"$IMPLEMENTATIONCOPYRIGHT$"<xsl:text/>
DiagnosticInfoImplementationSPDXLicenseIdentifier,"$IMPLEMENTATIONSPDXLID$"<xsl:text/>
DiagnosticInfoImplementationLicense,"$IMPLEMENTATIONLICENSE$"<xsl:text/>
DiagnosticInfoImplementationLicenseURL,"$IMPLEMENTATIONLICENSEURL$"<xsl:text/>
DiagnosticInfoExecutionDateTime,"$EXECUTIONDATETIME$"<xsl:text/>
DiagnosticInfoXMLSource,"$XMLSOURCE$"<xsl:text/>
DiagnosticInfoXSLProcessorVersion,"<xsl:value-of select="system-property('xsl:version')"/>"<xsl:text/>
DiagnosticInfoXSLProcessorVendor,"<xsl:value-of select="system-property('xsl:vendor')"/>"<xsl:text/>
DiagnosticInfoXSLProcessorVendorURL,"<xsl:value-of select="system-property('xsl:vendor-url')"/>"<xsl:text/>
MarkCurrentStatusDate,"<xsl:value-of select="ns2:MarkCurrentStatusDate"/>"<xsl:text/>
MarkCurrentStatusDateTruncated,"<xsl:value-of select="substring(ns2:MarkCurrentStatusDate,1,10)"/>"<xsl:text/>
ApplicationNumber,"<xsl:value-of select="ns1:ApplicationNumber/ns1:ApplicationNumberText"/>"<xsl:text/>
ApplicationDate,"<xsl:value-of select="ns2:ApplicationDate"/>"<xsl:text/>
ApplicationDateTruncated,"<xsl:value-of select="substring(ns2:ApplicationDate,1,10)"/>"<xsl:text/>
RegistrationNumber,"<xsl:value-of select="ns1:RegistrationNumber"/>"<xsl:text/>
RegistrationDate,"<xsl:value-of select="ns1:RegistrationDate"/>"<xsl:text/>
RegistrationDateTruncated,"<xsl:value-of select="substring(ns1:RegistrationDate,1,10)"/>"<xsl:text/>
<xsl:apply-templates select="ns2:MarkRepresentation/ns2:MarkReproduction/ns2:WordMarkSpecification"/>
<xsl:apply-templates select="ns2:NationalTrademarkInformation"/>
<xsl:apply-templates select="ns2:AssociatedMarkBag/ns2:AssociatedMark"/>
<xsl:apply-templates select="ns2:PublicationBag/ns2:Publication"/>
<xsl:apply-templates select="ns2:NationalCorrespondent/ns1:Contact"/>
<xsl:apply-templates select="ns2:ApplicantBag/ns2:Applicant"/>
<xsl:apply-templates select="ns1:StaffBag/ns1:Staff"/>
<xsl:apply-templates select="ns2:MarkEventBag/ns2:MarkEvent"/>
<xsl:apply-templates select="ns2:AssignmentBag/ns2:Assignment"/>
</xsl:template>

<xsl:template match="ns2:MarkRepresentation/ns2:MarkReproduction/ns2:WordMarkSpecification">
MarkVerbalElementText,"<xsl:value-of select="ns2:MarkVerbalElementText"/>"<xsl:text/>
</xsl:template>

<xsl:template match="ns2:NationalTrademarkInformation">
MarkCurrentStatusExternalDescriptionText,"<xsl:value-of select="ns2:MarkCurrentStatusExternalDescriptionText"/>"<xsl:text/>
<!-- kludge: ST.96 format uses "Primary" instead of "Principal" for the Principal Register -->
<xsl:choose>
	<xsl:when test="ns2:RegisterCategory = 'Primary'">
RegisterCategory,"Principal"<xsl:text/>
	</xsl:when>
	<xsl:otherwise>
RegisterCategory,"<xsl:value-of select="ns2:RegisterCategory"/>"<xsl:text/>
	</xsl:otherwise>
</xsl:choose>
RenewalDate,"<xsl:value-of select="ns2:RenewalDate"/>"<xsl:text/>
RenewalDateTruncated,"<xsl:value-of select="substring(ns2:RenewalDate,1,10)"/>"<xsl:text/>
<xsl:apply-templates select="ns2:NationalCaseLocation"/>
</xsl:template>

<xsl:template match="ns2:NationalCaseLocation">
LawOfficeAssignedText,"<xsl:value-of select="ns2:LawOfficeAssignedText"/>"<xsl:text/>
CurrentLocationCode,"<xsl:value-of select="ns2:CurrentLocationCode"/>"<xsl:text/>
CurrentLocationText,"<xsl:value-of select="ns2:CurrentLocationText"/>"<xsl:text/>
CurrentLocationDate,"<xsl:value-of select="ns2:CurrentLocationDate"/>"<xsl:text/>
CurrentLocationDateTruncated,"<xsl:value-of select="substring(ns2:CurrentLocationDate,1,10)"/>"<xsl:text/>
</xsl:template>

<xsl:template match="ns2:AssociatedMarkBag/ns2:AssociatedMark">
<xsl:if test="ns2:AssociationCategory = 'International application or registration'">
InternationalApplicationNumber,"<xsl:value-of select="ns1:ApplicationNumber/ns1:ApplicationNumberText"/>"<xsl:text/>
<!-- This is odd, but, yes, the *registration* number is stored under "InternationalApplicationNumber". 
     This is a change from ST96 1_D3 to ST96 2.2.1 -->
InternationalRegistrationNumber,"<xsl:value-of select="ns2:InternationalApplicationNumber/ns1:ApplicationNumberText"/>"<xsl:text/>
</xsl:if>
</xsl:template>

<xsl:template match="ns2:PublicationBag/ns2:Publication">
PublicationDate,"<xsl:value-of select="ns1:PublicationDate"/>"<xsl:text/>
PublicationDateTruncated,"<xsl:value-of select="substring(ns1:PublicationDate,1,10)"/>"<xsl:text/>
</xsl:template>

<xsl:template match="ns2:NationalCorrespondent/ns1:Contact">
CorrespondentName,"<xsl:value-of select="ns1:Name/ns1:PersonName/ns1:PersonFullName"/>"<xsl:text/>
CorrespondentOrganization,"<xsl:value-of select="ns1:Name/ns1:OrganizationName/ns1:OrganizationStandardName"/>"<xsl:text/>
<xsl:apply-templates select="ns1:PostalAddressBag/ns1:PostalAddress/ns1:PostalStructuredAddress" mode="CorrespondentAddress"/>
CorrespondentPhoneNumber,"<xsl:value-of select="ns1:PhoneNumberBag/ns1:PhoneNumber"/>"<xsl:text/>
CorrespondentFaxNumber,"<xsl:value-of select="ns1:FaxNumberBag/ns1:FaxNumber"/>"<xsl:text/>
CorrespondentEmailAddress,"<xsl:value-of select="ns1:EmailAddressBag/ns1:EmailAddressText"/>"<xsl:text/>
</xsl:template>

<xsl:template match="ns1:PostalAddressBag/ns1:PostalAddress/ns1:PostalStructuredAddress" mode="CorrespondentAddress">
CorrespondentAddressLine01,"<xsl:value-of select="ns1:AddressLineText[@ns1:sequenceNumber='1']"/>"<xsl:text/>
CorrespondentAddressLine02,"<xsl:value-of select="ns1:AddressLineText[@ns1:sequenceNumber='2']"/>"<xsl:text/>
CorrespondentAddressCity,"<xsl:value-of select="ns1:CityName"/>"<xsl:text/>
CorrespondentAddressGeoRegion,"<xsl:value-of select="ns1:GeographicRegionName"/>"<xsl:text/>
CorrespondentPostalCode,"<xsl:value-of select="ns1:PostalCode"/>"<xsl:text/>
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
BeginRepeatedField,"Applicant"<xsl:text/>
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
EndRepeatedField,"Applicant"<xsl:text/>
</xsl:template>

<xsl:template match="ns1:Contact/ns1:PostalAddressBag/ns1:PostalAddress/ns1:PostalStructuredAddress" mode="ApplicantAddress">
ApplicantAddressLine01,"<xsl:value-of select="ns1:AddressLineText[@ns1:sequenceNumber='1']"/>"<xsl:text/>
ApplicantAddressLine02,"<xsl:value-of select="ns1:AddressLineText[@ns1:sequenceNumber='2']"/>"<xsl:text/>
ApplicantAddressCity,"<xsl:value-of select="ns1:CityName"/>"<xsl:text/>
ApplicantAddressGeoRegion,"<xsl:value-of select="ns1:GeographicRegionName"/>"<xsl:text/>
ApplicantPostalCode,"<xsl:value-of select="ns1:PostalCode"/>"<xsl:text/>
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
StaffName,"<xsl:value-of select="ns1:StaffName"/>"<xsl:text/>
StaffOfficialTitle,"<xsl:value-of select="ns1:OfficialTitleText"/>"<xsl:text/><xsl:text/>
</xsl:template>

<xsl:template match="ns2:MarkEventBag/ns2:MarkEvent">
BeginRepeatedField,"MarkEvent"<xsl:text/>
MarkEventDate,"<xsl:value-of select="ns2:MarkEventDate"/>"<xsl:text/>
MarkEventDateTruncated,"<xsl:value-of select="substring(ns2:MarkEventDate,1,10)"/>"<xsl:text/>
MarkEventDescription,"<xsl:value-of select="ns2:NationalMarkEvent/ns2:MarkEventDescriptionText"/>"<xsl:text/>
MarkEventEntryNumber,"<xsl:value-of select="ns2:NationalMarkEvent/ns2:MarkEventEntryNumber"/>"<xsl:text/>
EndRepeatedField,"MarkEvent"<xsl:text/>
</xsl:template>

<xsl:template match="ns2:AssignmentBag/ns2:Assignment">
BeginRepeatedField,"Assignment"<xsl:text/>
AssignmentIdentifier,"<xsl:value-of select="ns2:AssignmentIdentifier"/>"<xsl:text/>
AssignmentConveyanceCategory,"<xsl:value-of select="ns2:AssignmentConveyanceCategory"/>"<xsl:text/>
AssignmentGroupCategory,"<xsl:value-of select="ns2:AssignmentGroupCategory"/>"<xsl:text/>
AssignmentRecordedDate,"<xsl:value-of select="ns2:AssignmentRecordedDate"/>"<xsl:text/>
AssignmentRecordedDateTruncated,"<xsl:value-of select="substring(ns2:AssignmentRecordedDate,1,10)"/>"<xsl:text/>
AssignmentExecutedDate,"<xsl:value-of select="ns2:AssignmentExecutedDate"/>"<xsl:text/>
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
AssignmentDocumentURL,"<xsl:value-of select="ns2:AssignmentDocumentBag/ns2:TrademarkDocument/ns1:DocumentIdentifier"/>"<xsl:text/>
EndRepeatedField,"Assignment"<xsl:text/>
</xsl:template>
</xsl:stylesheet>