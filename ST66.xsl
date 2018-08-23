<?xml version="1.0" encoding="utf-8"?>

<!-- 

   Plumage: XSLT to transform USPTO TSDR XML to CSV format
   https://github.com/codingatty/Plumage
   
   ST66.xsl - ST.66 transform
   Version 1.1.1, 2017-03-15
   Copyright 2014-2017 Terry Carroll
   carroll@tjc.com

   This program is licensed under Apache License, version 2.0 (January 2004);
   see http://www.apache.org/licenses/LICENSE-2.0
   SPX-License-Identifier: Apache-2.0

   Anyone who makes use of, or who modifies, this code is encouraged
   (but not required) to notify the author.

-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tm="http://www.wipo.int/standards/XMLSchema/trademarks" xmlns:pto="urn:us:gov:doc:uspto:trademark:status">
<xsl:output method="text" encoding="utf-8"/>
<xsl:variable name='NL'><xsl:text>&#10;</xsl:text></xsl:variable><!-- NL = newline character X'0A' -->

<xsl:template match="tm:Transaction">
<xsl:apply-templates select=".//tm:TradeMark"/>
<xsl:apply-templates select=".//tm:Applicant"/>
<xsl:apply-templates select=".//tm:MarkEvent"/>
<xsl:apply-templates select=".//tm:AssignmentBagExt"/>
<xsl:text/>DiagnosticInfoXSLTFilename,"$XSLTFILENAME$"
DiagnosticInfoXSLTLocation,"$XSLTLOCATION$"
DiagnosticInfoXSLTVersion,"1.1.1"
DiagnosticInfoXSLTDate,"2018-08-21"
DiagnosticInfoXSLTFormat,"ST.66"
DiagnosticInfoXSLTAuthor,"Terry Carroll"
DiagnosticInfoXSLTURL,"https://github.com/codingatty/Plumage"
DiagnosticInfoXSLTCopyright,"Copyright 2014-2017 Terry Carroll"
DiagnosticInfoXSLTLicense,"Apache License, version 2.0 (January 2004)"
DiagnosticInfoXSLTSPDXLicenseIdentifier,"Apache-2.0"
DiagnosticInfoXSLTLicenseURL,"http://www.apache.org/licenses/LICENSE-2.0"
DiagnosticInfoImplementationName,"$IMPLEMENTATIONNAME$"
DiagnosticInfoImplementationVersion,"$IMPLEMENTATIONVERSION$"
DiagnosticInfoImplementationDate,"$IMPLEMENTATIONDATE$"
DiagnosticInfoImplementationAuthor,"$IMPLEMENTATIONAUTHOR$"
DiagnosticInfoImplementationURL,"$IMPLEMENTATIONURL$"
DiagnosticInfoImplementationCopyright,"$IMPLEMENTATIONCOPYRIGHT$"
DiagnosticInfoImplementationLicense,"$IMPLEMENTATIONLICENSE$"
DiagnosticInfoImplementationSPDXLicenseIdentifier,"$IMPLEMENTATIONSPDXLID$"
DiagnosticInfoImplementationLicenseURL,"$IMPLEMENTATIONLICENSEURL$"
DiagnosticInfoExecutionDateTime,"$EXECUTIONDATETIME$"
DiagnosticInfoXMLSource,"$XMLSOURCE$"
DiagnosticInfoXSLProcessorVersion,"<xsl:value-of select="system-property('xsl:version')"/>"
DiagnosticInfoXSLProcessorVendor,"<xsl:value-of select="system-property('xsl:vendor')"/>"
DiagnosticInfoXSLProcessorVendorURL,"<xsl:value-of select="system-property('xsl:vendor-url')"/>"
</xsl:template>

<xsl:template match="tm:TradeMark">
<xsl:text/>MarkCurrentStatusDate,"<xsl:value-of select="tm:MarkCurrentStatusDate"/>"
MarkCurrentStatusDateTruncated,"<xsl:value-of select="substring(tm:MarkCurrentStatusDate,1,10)"/>"
ApplicationNumber,"<xsl:value-of select="tm:ApplicationNumber"/>"
ApplicationDate,"<xsl:value-of select="tm:ApplicationDate"/>"
ApplicationDateTruncated,"<xsl:value-of select="substring(tm:ApplicationDate,1,10)"/>"
RegistrationNumber,"<xsl:value-of select="tm:RegistrationNumber"/>"
RegistrationDate,"<xsl:value-of select="tm:RegistrationDate"/>"
RegistrationDateTruncated,"<xsl:value-of select="substring(tm:RegistrationDate,1,10)"/>"
<xsl:apply-templates select="tm:WordMarkSpecification"/>
<xsl:apply-templates select="tm:TradeMarkExt"/>
<xsl:apply-templates select="tm:PublicationDetails"/>
<xsl:apply-templates select="tm:RepresentativeDetails"/>
<xsl:apply-templates select="tm:StaffDetails"/>
</xsl:template>

<xsl:template match="tm:WordMarkSpecification">
<xsl:text/>MarkVerbalElementText,"<xsl:value-of select="tm:MarkVerbalElementText"/>"
</xsl:template>

<xsl:template match="tm:TradeMarkExt">
<xsl:text/>MarkCurrentStatusExternalDescriptionText,"<xsl:value-of select="pto:MarkCurrentStatusExternalDescriptionText"/>"
RegisterCategory,"<xsl:value-of select="pto:RegisterCategory"/>"
RenewalDate,"<xsl:value-of select="pto:AdditionalMarkDetails/pto:RenewalDate"/>"
RenewalDateTruncated,"<xsl:value-of select="substring(pto:AdditionalMarkDetails/pto:RenewalDate,1,10)"/>"
<xsl:if test="pto:RelatedMarkDetails/pto:InternationalApplicationNumber != ''">
InternationalApplicationNumber,"<xsl:value-of select="pto:RelatedMarkDetails/pto:InternationalApplicationNumber"/>"
</xsl:if>
<xsl:if test="pto:RelatedMarkDetails/pto:InternationalRegistrationNumber != ''">
InternationalRegistrationNumber,"<xsl:value-of select="pto:RelatedMarkDetails/pto:InternationalRegistrationNumber"/>"
</xsl:if>
<xsl:apply-templates select="pto:OfficeDetails"/>
</xsl:template>

<xsl:template match="pto:OfficeDetails">
<xsl:text/>LawOfficeAssignedText,"<xsl:value-of select="pto:LawOfficeAssignedText"/>"
CurrentLocationCode,"<xsl:value-of select="pto:CurrentLocationCode"/>"
CurrentLocationText,"<xsl:value-of select="pto:CurrentLocationText"/>"
CurrentLocationDate,"<xsl:value-of select="pto:CurrentLocationDate"/>"
CurrentLocationDateTruncated,"<xsl:value-of select="substring(pto:CurrentLocationDate,1,10)"/>"
</xsl:template>

<xsl:template match="tm:Applicant">
<xsl:text/>BeginRepeatedField,"Applicant"
ApplicantName,"<xsl:value-of select="tm:ApplicantAddressBook/tm:FormattedNameAddress/tm:Name/tm:FreeFormatName/tm:FreeFormatNameDetails/tm:FreeFormatNameLine"/>"
ApplicantDescription,"<xsl:value-of select="tm:ApplicantExt/pto:PartyTypeDescriptionText"/>"
<xsl:apply-templates select="tm:ApplicantAddressBook/tm:FormattedNameAddress/tm:Address/tm:FormattedAddress"/>
EndRepeatedField,"Applicant"
</xsl:template>

<xsl:template match="tm:ApplicantAddressBook/tm:FormattedNameAddress/tm:Address/tm:FormattedAddress">
<xsl:text/>ApplicantAddressLine01,"<xsl:value-of select="tm:AddressRoom"/>"
ApplicantAddressLine02,""
ApplicantAddressCity,"<xsl:value-of select="tm:AddressCity"/>"
ApplicantAddressGeoRegion,"<xsl:value-of select="tm:AddressState"/>"
ApplicantPostalCode,"<xsl:value-of select="tm:AddressPostcode"/>"
ApplicantCountryCode,"<xsl:value-of select="tm:FormattedAddressCountryCode"/>"<xsl:text/>
<xsl:value-of select="concat($NL, 'ApplicantCombinedAddress,&quot;', 
  tm:AddressRoom, '/',
  '/',
  tm:AddressCity, '/',
  tm:AddressState, '/',
  tm:AddressPostcode, '/',
  tm:FormattedAddressCountryCode, '&quot;'
  )"/>
</xsl:template>

<xsl:template match="tm:MarkEvent">
<xsl:text/>BeginRepeatedField,"MarkEvent"
MarkEventDate,"<xsl:value-of select="tm:MarkEventDate"/>"
MarkEventDateTruncated,"<xsl:value-of select="substring(tm:MarkEventDate,1,10)"/>"
MarkEventDescription,"<xsl:value-of select="tm:MarkEventExt/pto:MarkEventInternalDescriptionText"/>"
MarkEventEntryNumber,"<xsl:value-of select="tm:MarkEventExt/pto:MarkEventEntryNumber"/>"
EndRepeatedField,"MarkEvent"
</xsl:template>

<xsl:template match="tm:PublicationDetails">
<xsl:text/>PublicationDate,"<xsl:value-of select="tm:Publication/tm:PublicationDate"/>"
PublicationDateTruncated,"<xsl:value-of select="substring(tm:Publication/tm:PublicationDate,1,10)"/>"
</xsl:template>

<xsl:template match="tm:RepresentativeDetails">
<xsl:if test="tm:Representative/tm:Comment = 'Domestic Correspondent'">
<xsl:text/>CorrespondentName,"<xsl:value-of select="tm:Representative/tm:RepresentativeAddressBook/tm:FormattedNameAddress/tm:Name/tm:FreeFormatName/tm:FreeFormatNameDetails/tm:FreeFormatNameLine[1]"/>"
CorrespondentOrganization,"<xsl:value-of select="tm:Representative/tm:RepresentativeAddressBook/tm:FormattedNameAddress/tm:Name/tm:FreeFormatName/tm:FreeFormatNameDetails/tm:FreeFormatNameLine[2]"/>"
<xsl:apply-templates select=".//tm:FormattedAddress"/>
<xsl:apply-templates select=".//tm:ContactInformationDetails"/>
</xsl:if>
</xsl:template>

<xsl:template match="tm:FormattedAddress">
<xsl:text/>CorrespondentAddressLine01,"<xsl:value-of select="normalize-space(tm:AddressBuilding)"/>"
CorrespondentAddressLine02,"<xsl:value-of select="normalize-space(tm:AddressStreet)"/>"
CorrespondentAddressCity,"<xsl:value-of select="normalize-space(tm:AddressCity)"/>"
CorrespondentAddressGeoRegion,"<xsl:value-of select="normalize-space(tm:AddressState)"/>"
CorrespondentPostalCode,"<xsl:value-of select="normalize-space(tm:AddressPostcode)"/>"
CorrespondentCountryCode,"<xsl:value-of select="normalize-space(tm:FormattedAddressCountryCode)"/>"<xsl:text/> 
<xsl:value-of select="concat($NL, 'CorrespondentCombinedAddress,&quot;', 
  normalize-space(tm:AddressBuilding), '/',
  normalize-space(tm:AddressStreet), '/',
  normalize-space(tm:AddressCity), '/',
  normalize-space(tm:AddressState), '/',
  normalize-space(tm:AddressPostcode), '/',
  normalize-space(tm:FormattedAddressCountryCode),
  '&quot;'
  )"/>
</xsl:template>

<xsl:template match="tm:ContactInformationDetails">
<xsl:text/>CorrespondentPhoneNumber,"<xsl:value-of select="tm:Phone"/>"
CorrespondentFaxNumber,"<xsl:value-of select="tm:Fax"/>"
CorrespondentEmailAddress,"<xsl:value-of select="tm:Email"/>"
</xsl:template>

<xsl:template match="tm:StaffDetails">
<xsl:text/>StaffName,"<xsl:value-of select="tm:Staff/tm:StaffName"/>"
StaffOfficialTitle,"<xsl:value-of select="tm:Staff/tm:OfficialTitle"/>"
</xsl:template>

<xsl:template match="tm:AssignmentBagExt">
<xsl:apply-templates select="pto:Assignment"/>
</xsl:template>

<xsl:template match="pto:Assignment">
<xsl:text/>BeginRepeatedField,"Assignment"
AssignmentIdentifier,"<xsl:value-of select="pto:AssignmentIdentifier"/>"
AssignmentConveyanceCategory,"<xsl:value-of select="pto:AssignmentConveyanceCategory"/>"
AssignmentGroupCategory,"<xsl:value-of select="pto:AssignmentGroupCategory"/>"
AssignmentRecordedDate,"<xsl:value-of select="pto:AssignmentRecordedDate"/>"
AssignmentRecordedDateTruncated,"<xsl:value-of select="substring(pto:AssignmentRecordedDate,1,10)"/>"
AssignmentExecutedDate,"<xsl:value-of select="pto:Assignor/pto:AssignmentExecutionDate"/>"
AssignmentExecutedDateTruncated,"<xsl:value-of select="substring(pto:Assignor/pto:AssignmentExecutionDate,1,10)"/>"
AssignorEntityName,"<xsl:value-of select="pto:Assignor/pto:Contact/pto:Name/pto:EntityName"/>"
AssigneeEntityName,"<xsl:value-of select="pto:Assignee/pto:Contact/pto:Name/pto:EntityName"/>"
AssignmentDocumentURL,"<xsl:value-of select="pto:AssignmentDocumentBag"/>"
EndRepeatedField,"Assignment"
</xsl:template>


</xsl:stylesheet>
