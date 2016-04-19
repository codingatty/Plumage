<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:com="http://www.wipo.int/standards/XMLSchema/Common/1" xmlns:tmk="http://www.wipo.int/standards/XMLSchema/Trademark/1">
<xsl:output method="text" encoding="utf-8" />
<xsl:variable name='NL'><xsl:text>&#10;</xsl:text></xsl:variable><!-- NL = newline character X'0A' -->
<xsl:template match="tmk:Transaction">
<xsl:apply-templates select=".//tmk:TrademarkBag/tmk:Trademark"/>
</xsl:template>

<xsl:template match="tmk:Trademark">
<xsl:text/>DiagnosticInfoXSLTFilename,"$XSLTFILENAME$"<xsl:text/>
DiagnosticInfoXSLTLocation,"$XSLTLOCATION$"<xsl:text/>
DiagnosticInfoXSLTVersion,"0.9.3"<xsl:text/>
DiagnosticInfoXSLTDate,"2014-07-31"<xsl:text/>
DiagnosticInfoXSLTFormat,"ST.96"<xsl:text/>
DiagnosticInfoXSLTAuthor,"Terry Carroll"<xsl:text/>
DiagnosticInfoXSLTURL,"https://github.com/codingatty"<xsl:text/>
DiagnosticInfoXSLTCopyright,"Copyright 2014 Terry Carroll"<xsl:text/>
DiagnosticInfoXSLTLicense,"Apache License, version 2.0 (January 2004)"<xsl:text/>
DiagnosticInfoXSLTLicenseURL,"http://www.apache.org/licenses/LICENSE-2.0"<xsl:text/>
DiagnosticInfoImplementationName,"$IMPLEMENTATIONNAME$"<xsl:text/>
DiagnosticInfoImplementationVersion,"$IMPLEMENTATIONVERSION$"<xsl:text/>
DiagnosticInfoImplementationDate,"$IMPLEMENTATIONDATE$"<xsl:text/>
DiagnosticInfoImplementationAuthor,"$IMPLEMENTATIONAUTHOR$"<xsl:text/>
DiagnosticInfoImplementationURL,"$IMPLEMENTATIONURL$"<xsl:text/>
DiagnosticInfoImplementationCopyright,"$IMPLEMENTATIONCOPYRIGHT$"<xsl:text/>
DiagnosticInfoImplementationLicense,"$IMPLEMENTATIONLICENSE$"<xsl:text/>
DiagnosticInfoImplementationLicenseURL,"$IMPLEMENTATIONLICENSEURL$"<xsl:text/>
DiagnosticInfoExecutionDateTime,"$EXECUTIONDATETIME$"<xsl:text/>
DiagnosticInfoXMLSource,"$XMLSOURCE$"<xsl:text/>
DiagnosticInfoXSLProcessorVersion,"<xsl:value-of select="system-property('xsl:version')"/>"<xsl:text/>
DiagnosticInfoXSLProcessorVendor,"<xsl:value-of select="system-property('xsl:vendor')"/>"<xsl:text/>
DiagnosticInfoXSLProcessorVendorURL,"<xsl:value-of select="system-property('xsl:vendor-url')"/>"<xsl:text/>
MarkCurrentStatusDate,"<xsl:value-of select="tmk:MarkCurrentStatusDate"/>"<xsl:text/>
MarkCurrentStatusDateTruncated,"<xsl:value-of select="substring(tmk:MarkCurrentStatusDate,1,10)"/>"<xsl:text/>
ApplicationNumber,"<xsl:value-of select="com:ApplicationNumber/com:ApplicationNumberText"/>"<xsl:text/>
ApplicationDate,"<xsl:value-of select="tmk:ApplicationDate"/>"<xsl:text/>
ApplicationDateTruncated,"<xsl:value-of select="substring(tmk:ApplicationDate,1,10)"/>"<xsl:text/>
RegistrationNumber,"<xsl:value-of select="com:RegistrationNumber"/>"<xsl:text/>
RegistrationDate,"<xsl:value-of select="com:RegistrationDate"/>"<xsl:text/>
RegistrationDateTruncated,"<xsl:value-of select="substring(com:RegistrationDate,1,10)"/>"<xsl:text/>
<xsl:apply-templates select="tmk:MarkRepresentation/tmk:MarkReproduction/tmk:WordMarkSpecification"/>
<xsl:apply-templates select="tmk:NationalTrademarkInformation"/>
<xsl:apply-templates select="tmk:AssociatedMarkBag/tmk:AssociatedMark"/>
<xsl:apply-templates select="tmk:PublicationBag/tmk:Publication"/>
<xsl:apply-templates select="tmk:NationalCorrespondent/com:Contact"/>
<xsl:apply-templates select="tmk:ApplicantBag/tmk:Applicant"/>
<xsl:apply-templates select="com:StaffBag/com:Staff"/>
<xsl:apply-templates select="tmk:MarkEventBag/tmk:MarkEvent"/>
<xsl:apply-templates select="tmk:AssignmentBag/tmk:Assignment"/>
</xsl:template>

<xsl:template match="tmk:MarkRepresentation/tmk:MarkReproduction/tmk:WordMarkSpecification">
MarkVerbalElementText,"<xsl:value-of select="tmk:MarkVerbalElementText"/>"<xsl:text/>
</xsl:template>

<xsl:template match="tmk:NationalTrademarkInformation">
MarkCurrentStatusExternalDescriptionText,"<xsl:value-of select="tmk:MarkCurrentStatusExternalDescriptionText"/>"<xsl:text/>
<!-- kludge: ST.96 format uses "Primary" instead of "Principal" for the Principal Register -->
<xsl:choose>
	<xsl:when test="tmk:RegisterCategory = 'Primary'">
RegisterCategory,"Principal"<xsl:text/>
	</xsl:when>
	<xsl:otherwise>
RegisterCategory,"<xsl:value-of select="tmk:RegisterCategory"/>"<xsl:text/>
	</xsl:otherwise>
</xsl:choose>
RenewalDate,"<xsl:value-of select="tmk:RenewalDate"/>"<xsl:text/>
RenewalDateTruncated,"<xsl:value-of select="substring(tmk:RenewalDate,1,10)"/>"<xsl:text/>
<xsl:apply-templates select="tmk:NationalCaseLocation"/>
</xsl:template>

<xsl:template match="tmk:NationalCaseLocation">
LawOfficeAssignedText,"<xsl:value-of select="tmk:LawOfficeAssignedText"/>"<xsl:text/>
CurrentLocationCode,"<xsl:value-of select="tmk:CurrentLocationCode"/>"<xsl:text/>
CurrentLocationText,"<xsl:value-of select="tmk:CurrentLocationText"/>"<xsl:text/>
CurrentLocationDate,"<xsl:value-of select="tmk:CurrentLocationDate"/>"<xsl:text/>
CurrentLocationDateTruncated,"<xsl:value-of select="substring(tmk:CurrentLocationDate,1,10)"/>"<xsl:text/>
</xsl:template>

<xsl:template match="tmk:AssociatedMarkBag/tmk:AssociatedMark">
<xsl:if test="tmk:AssociationCategory = 'International application or registration'">
InternationalApplicationNumber,"<xsl:value-of select="com:ApplicationNumber/com:ApplicationNumberText"/>"<xsl:text/>
InternationalRegistrationNumber,"<xsl:value-of select="tmk:InternationalRegistrationNumber"/>"<xsl:text/>
</xsl:if>
</xsl:template>

<xsl:template match="tmk:PublicationBag/tmk:Publication">
PublicationDate,"<xsl:value-of select="com:PublicationDate"/>"<xsl:text/>
PublicationDateTruncated,"<xsl:value-of select="substring(com:PublicationDate,1,10)"/>"<xsl:text/>
</xsl:template>

<xsl:template match="tmk:NationalCorrespondent/com:Contact">
CorrespondentName,"<xsl:value-of select="com:Name/com:PersonName/com:PersonFullName"/>"<xsl:text/>
CorrespondentOrganization,"<xsl:value-of select="com:Name/com:OrganizationName/com:OrganizationStandardName"/>"<xsl:text/>
<xsl:apply-templates select="com:PostalAddressBag/com:PostalAddress/com:PostalStructuredAddress" mode="CorrespondentAddress"/>
CorrespondentPhoneNumber,"<xsl:value-of select="com:PhoneNumberBag/com:PhoneNumber"/>"<xsl:text/>
CorrespondentFaxNumber,"<xsl:value-of select="com:FaxNumberBag/com:FaxNumber"/>"<xsl:text/>
CorrespondentEmailAddress,"<xsl:value-of select="com:EmailAddressBag/com:EmailAddressText"/>"<xsl:text/>
</xsl:template>

<xsl:template match="com:PostalAddressBag/com:PostalAddress/com:PostalStructuredAddress" mode="CorrespondentAddress">
CorrespondentAddressLine01,"<xsl:value-of select="com:AddressLineText[@com:sequenceNumber='1']"/>"<xsl:text/>
CorrespondentAddressLine02,"<xsl:value-of select="com:AddressLineText[@com:sequenceNumber='2']"/>"<xsl:text/>
CorrespondentAddressCity,"<xsl:value-of select="com:CityName"/>"<xsl:text/>
CorrespondentAddressGeoRegion,"<xsl:value-of select="com:GeographicRegionName"/>"<xsl:text/>
CorrespondentPostalCode,"<xsl:value-of select="com:PostalCode"/>"<xsl:text/>
CorrespondentCountryCode,"<xsl:value-of select="com:CountryCode"/>"<xsl:text/>
<xsl:value-of select="concat($NL, 'CorrespondentCombinedAddress,&quot;', 
	com:AddressLineText[@com:sequenceNumber='1'], '/',
	com:AddressLineText[@com:sequenceNumber='2'], '/',
	com:CityName, '/',
	com:GeographicRegionName, '/',
	com:PostalCode, '/',
	com:CountryCode, '&quot;'
 	)"/>
</xsl:template>

<xsl:template match="tmk:Applicant">
BeginRepeatedField,"Applicant"<xsl:text/>
<xsl:choose>
	<xsl:when test="com:Contact/com:Name/com:EntityName != ''">
ApplicantName,"<xsl:value-of select="com:Contact/com:Name/com:EntityName"/>"<xsl:text/>
	</xsl:when>
	<xsl:otherwise>
ApplicantName,"<xsl:value-of select="com:Contact/com:Name/com:OrganizationName/com:OrganizationStandardName"/>"<xsl:text/>
	</xsl:otherwise>
</xsl:choose>
<xsl:choose>
	<xsl:when test="com:Version/com:CommentText != ''">
ApplicantDescription,"<xsl:value-of select="com:Version/com:CommentText"/>"<xsl:text/>
	</xsl:when>
	<xsl:otherwise>
ApplicantDescription,"<xsl:value-of select="com:CommentText"/>"<xsl:text/>
	</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="com:Contact/com:PostalAddressBag/com:PostalAddress/com:PostalStructuredAddress" mode="ApplicantAddress"/>
EndRepeatedField,"Applicant"<xsl:text/>
</xsl:template>

<xsl:template match="com:StaffBag/com:Staff">
StaffName,"<xsl:value-of select="com:StaffName"/>"<xsl:text/>
StaffOfficialTitle,"<xsl:value-of select="com:OfficialTitleText"/>"<xsl:text/><xsl:text/>
</xsl:template>

<!-- 
Note, this address-parsing template was (but no longer is) used for both Applicant and Representative addresses.
Now limited to just ApplicantAddress.  "mode=" usage no longer required, but retained for clarity. 
-->
<xsl:template match="com:Contact/com:PostalAddressBag/com:PostalAddress/com:PostalStructuredAddress" mode="ApplicantAddress">
ApplicantAddressLine01,"<xsl:value-of select="com:AddressLineText[@com:sequenceNumber='1']"/>"<xsl:text/>
ApplicantAddressLine02,"<xsl:value-of select="com:AddressLineText[@com:sequenceNumber='2']"/>"<xsl:text/>
ApplicantAddressCity,"<xsl:value-of select="com:CityName"/>"<xsl:text/>
ApplicantAddressGeoRegion,"<xsl:value-of select="com:GeographicRegionName"/>"<xsl:text/>
ApplicantPostalCode,"<xsl:value-of select="com:PostalCode"/>"<xsl:text/>
ApplicantCountryCode,"<xsl:value-of select="com:CountryCode"/>"<xsl:text/>
<xsl:value-of select="concat($NL, 'ApplicantCombinedAddress,&quot;', 
	com:AddressLineText[@com:sequenceNumber='1'], '/',
	com:AddressLineText[@com:sequenceNumber='2'], '/',
	com:CityName, '/',
	com:GeographicRegionName, '/',
	com:PostalCode, '/',
	com:CountryCode, '&quot;'
 	)"/>
</xsl:template>

<xsl:template match="tmk:MarkEvent">
BeginRepeatedField,"MarkEvent"<xsl:text/>
MarkEventDate,"<xsl:value-of select="substring(tmk:MarkEventDate,1,10)"/>"<xsl:text/>
MarkEventDateTruncated,"<xsl:value-of select="tmk:MarkEventDate"/>"<xsl:text/>
MarkEventDescription,"<xsl:value-of select="tmk:NationalMarkEvent/tmk:MarkEventDescriptionText"/>"<xsl:text/>
MarkEventEntryNumber,"<xsl:value-of select="tmk:NationalMarkEvent/tmk:MarkEventEntryNumber"/>"<xsl:text/>
EndRepeatedField,"MarkEvent"<xsl:text/>
</xsl:template>


<xsl:template match="tmk:Assignment">
BeginRepeatedField,"Assignment"<xsl:text/>
AssignmentIdentifier,"<xsl:value-of select="tmk:AssignmentIdentifier"/>"<xsl:text/>
AssignmentConveyanceCategory,"<xsl:value-of select="tmk:AssignmentConveyanceCategory"/>"<xsl:text/>
AssignmentGroupCategory,"<xsl:value-of select="tmk:AssignmentGroupCategory"/>"<xsl:text/>
AssignmentRecordedDate,"<xsl:value-of select="tmk:AssignmentRecordedDate"/>"<xsl:text/>
AssignmentRecordedDateTruncated,"<xsl:value-of select="substring(tmk:AssignmentRecordedDate,1,10)"/>"<xsl:text/>
AssignmentExecutedDate,"<xsl:value-of select="tmk:AssignmentExecutedDate"/>"<xsl:text/>
AssignmentExecutedDateTruncated,"<xsl:value-of select="substring(tmk:AssignmentExecutedDate,1,10)"/>"<xsl:text/>
<xsl:choose>
	<xsl:when test="tmk:Assignor/com:Contact/com:Name/com:EntityName != ''">
AssignorEntityName,"<xsl:value-of select="tmk:Assignor/com:Contact/com:Name/com:EntityName"/>"<xsl:text/>
	</xsl:when>
	<xsl:otherwise>
AssignorEntityName,"<xsl:value-of select="tmk:Assignor/com:Contact/com:Name/com:OrganizationName/com:OrganizationStandardName"/>"<xsl:text/>
	</xsl:otherwise>
</xsl:choose>
<xsl:choose>
	<xsl:when test="tmk:Assignee/com:Contact/com:Name/com:EntityName != ''">
AssigneeEntityName,"<xsl:value-of select="tmk:Assignee/com:Contact/com:Name/com:EntityName"/>"<xsl:text/>
	</xsl:when>
	<xsl:otherwise>
AssigneeEntityName,"<xsl:value-of select="tmk:Assignee/com:Contact/com:Name/com:OrganizationName/com:OrganizationStandardName"/>"<xsl:text/>
	</xsl:otherwise>
</xsl:choose>
AssignmentDocumentURL,"<xsl:value-of select="tmk:AssignmentDocumentBag/tmk:TrademarkDocument/com:DocumentIdentifier"/>"<xsl:text/>
EndRepeatedField,"Assignment"<xsl:text/>
</xsl:template>
 
</xsl:stylesheet>

