<?xml version="1.0" encoding="utf-8"?>

<!-- 

   Plumage: XSLT to transform USPTO TSDR XML to CSV format
   https://github.com/codingatty/Plumage
   
   ST96.xsl - ST.96 transform
   Version 1.0.0, 2016-04-19
   Copyright 2014-2016 Terry Carroll
   carroll@tjc.com

   This program is licensed under Apache License, version 2.0 (January 2004),
   http://www.apache.org/licenses/LICENSE-2.0

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
</xsl:template>

<xsl:template match="tm:TradeMark">
<xsl:text/>DiagnosticInfoXSLTFilename,"$XSLTFILENAME$"<xsl:text/>
DiagnosticInfoXSLTLocation,"$XSLTLOCATION$"<xsl:text/>
DiagnosticInfoXSLTVersion,"1.0.0"<xsl:text/>
DiagnosticInfoXSLTDate,"2016-04-19"<xsl:text/>
DiagnosticInfoXSLTFormat,"ST.66"<xsl:text/>
DiagnosticInfoXSLTAuthor,"Terry Carroll"<xsl:text/>
DiagnosticInfoXSLTURL,"https://github.com/codingatty/Plumage"<xsl:text/>
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
DiagnosticInfoImplementationLicense,"$IMPLEMENTATIONLICENSE$"<xsl:text/>
DiagnosticInfoImplementationSPDXLicenseIdentifier,"$IMPLEMENTATIONSPDXLID$"<xsl:text/>
DiagnosticInfoImplementationLicenseURL,"$IMPLEMENTATIONLICENSEURL$"<xsl:text/>
DiagnosticInfoExecutionDateTime,"$EXECUTIONDATETIME$"<xsl:text/>
DiagnosticInfoXMLSource,"$XMLSOURCE$"<xsl:text/>
DiagnosticInfoXSLProcessorVersion,"<xsl:value-of select="system-property('xsl:version')"/>"<xsl:text/>
DiagnosticInfoXSLProcessorVendor,"<xsl:value-of select="system-property('xsl:vendor')"/>"<xsl:text/>
DiagnosticInfoXSLProcessorVendorURL,"<xsl:value-of select="system-property('xsl:vendor-url')"/>"<xsl:text/>
MarkCurrentStatusDate,"<xsl:value-of select="tm:MarkCurrentStatusDate"/>"<xsl:text/>
MarkCurrentStatusDateTruncated,"<xsl:value-of select="substring(tm:MarkCurrentStatusDate,1,10)"/>"<xsl:text/>
ApplicationNumber,"<xsl:value-of select="tm:ApplicationNumber"/>"<xsl:text/>
ApplicationDate,"<xsl:value-of select="tm:ApplicationDate"/>"<xsl:text/>
ApplicationDateTruncated,"<xsl:value-of select="substring(tm:ApplicationDate,1,10)"/>"<xsl:text/>
RegistrationNumber,"<xsl:value-of select="tm:RegistrationNumber"/>"<xsl:text/>
RegistrationDate,"<xsl:value-of select="tm:RegistrationDate"/>"<xsl:text/>
RegistrationDateTruncated,"<xsl:value-of select="substring(tm:RegistrationDate,1,10)"/>"<xsl:text/>
<xsl:apply-templates select="tm:WordMarkSpecification"/>
<xsl:apply-templates select="tm:TradeMarkExt"/>
<xsl:apply-templates select="tm:PublicationDetails"/>
<xsl:apply-templates select="tm:RepresentativeDetails"/>
<xsl:apply-templates select="tm:StaffDetails"/>
</xsl:template>

<xsl:template match="tm:WordMarkSpecification">
MarkVerbalElementText,"<xsl:value-of select="tm:MarkVerbalElementText"/>"<xsl:text/>
</xsl:template>

<xsl:template match="tm:TradeMarkExt">
MarkCurrentStatusExternalDescriptionText,"<xsl:value-of select="pto:MarkCurrentStatusExternalDescriptionText"/>"<xsl:text/>
RegisterCategory,"<xsl:value-of select="pto:RegisterCategory"/>"<xsl:text/>
RenewalDate,"<xsl:value-of select="pto:AdditionalMarkDetails/pto:RenewalDate"/>"<xsl:text/>
RenewalDateTruncated,"<xsl:value-of select="substring(pto:AdditionalMarkDetails/pto:RenewalDate,1,10)"/>"<xsl:text/>
<xsl:if test="pto:RelatedMarkDetails/pto:InternationalApplicationNumber != ''">
InternationalApplicationNumber,"<xsl:value-of select="pto:RelatedMarkDetails/pto:InternationalApplicationNumber"/>"<xsl:text/>
</xsl:if>
<xsl:if test="pto:RelatedMarkDetails/pto:InternationalRegistrationNumber != ''">
InternationalRegistrationNumber,"<xsl:value-of select="pto:RelatedMarkDetails/pto:InternationalRegistrationNumber"/>"<xsl:text/>
</xsl:if>
<xsl:apply-templates select="pto:OfficeDetails"/>
</xsl:template>

<xsl:template match="pto:OfficeDetails">
LawOfficeAssignedText,"<xsl:value-of select="pto:LawOfficeAssignedText"/>"<xsl:text/>
CurrentLocationCode,"<xsl:value-of select="pto:CurrentLocationCode"/>"<xsl:text/>
CurrentLocationText,"<xsl:value-of select="pto:CurrentLocationText"/>"<xsl:text/>
CurrentLocationDate,"<xsl:value-of select="pto:CurrentLocationDate"/>"<xsl:text/>
CurrentLocationDateTruncated,"<xsl:value-of select="substring(pto:CurrentLocationDate,1,10)"/>"<xsl:text/>
</xsl:template>

<xsl:template match="tm:Applicant">
BeginRepeatedField,"Applicant"<xsl:text/>
ApplicantName,"<xsl:value-of select="tm:ApplicantAddressBook/tm:FormattedNameAddress/tm:Name/tm:FreeFormatName/tm:FreeFormatNameDetails/tm:FreeFormatNameLine"/>"<xsl:text/>
ApplicantDescription,"<xsl:value-of select="tm:ApplicantExt/pto:PartyTypeDescriptionText"/>"<xsl:text/>
<xsl:apply-templates select="tm:ApplicantAddressBook/tm:FormattedNameAddress/tm:Address/tm:FormattedAddress"/>
EndRepeatedField,"Applicant"<xsl:text/>
</xsl:template>

<xsl:template match="tm:ApplicantAddressBook/tm:FormattedNameAddress/tm:Address/tm:FormattedAddress">
ApplicantAddressLine01,"<xsl:value-of select="tm:AddressRoom"/>"<xsl:text/>
ApplicantAddressLine02,""<xsl:text/>
ApplicantAddressCity,"<xsl:value-of select="tm:AddressCity"/>"<xsl:text/>
ApplicantAddressGeoRegion,"<xsl:value-of select="tm:AddressState"/>"<xsl:text/>
ApplicantPostalCode,"<xsl:value-of select="tm:AddressPostcode"/>"<xsl:text/>
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
BeginRepeatedField,"MarkEvent"<xsl:text/>
MarkEventDate,"<xsl:value-of select="tm:MarkEventDate"/>"<xsl:text/>
MarkEventDateTruncated,"<xsl:value-of select="substring(tm:MarkEventDate,1,10)"/>"<xsl:text/>
MarkEventDescription,"<xsl:value-of select="tm:MarkEventExt/pto:MarkEventInternalDescriptionText"/>"<xsl:text/>
MarkEventEntryNumber,"<xsl:value-of select="tm:MarkEventExt/pto:MarkEventEntryNumber"/>"<xsl:text/>
EndRepeatedField,"MarkEvent"<xsl:text/>
</xsl:template>

<xsl:template match="tm:PublicationDetails">
PublicationDate,"<xsl:value-of select="tm:Publication/tm:PublicationDate"/>"<xsl:text/>
PublicationDateTruncated,"<xsl:value-of select="substring(tm:Publication/tm:PublicationDate,1,10)"/>"<xsl:text/> 
</xsl:template>

<xsl:template match="tm:RepresentativeDetails">
<xsl:if test="tm:Representative/tm:Comment = 'Domestic Correspondent'">
CorrespondentName,"<xsl:value-of select="tm:Representative/tm:RepresentativeAddressBook/tm:FormattedNameAddress/tm:Name/tm:FreeFormatName/tm:FreeFormatNameDetails/tm:FreeFormatNameLine[1]"/>"<xsl:text/>
CorrespondentOrganization,"<xsl:value-of select="tm:Representative/tm:RepresentativeAddressBook/tm:FormattedNameAddress/tm:Name/tm:FreeFormatName/tm:FreeFormatNameDetails/tm:FreeFormatNameLine[2]"/>"<xsl:text/>
<xsl:apply-templates select=".//tm:FormattedAddress"/>
<xsl:apply-templates select=".//tm:ContactInformationDetails"/>
</xsl:if>
</xsl:template>

<xsl:template match="tm:FormattedAddress">
CorrespondentAddressLine01,"<xsl:value-of select="normalize-space(tm:AddressBuilding)"/>"<xsl:text/>
CorrespondentAddressLine02,"<xsl:value-of select="normalize-space(tm:AddressStreet)"/>"<xsl:text/>
CorrespondentAddressCity,"<xsl:value-of select="normalize-space(tm:AddressCity)"/>"<xsl:text/>
CorrespondentAddressGeoRegion,"<xsl:value-of select="normalize-space(tm:AddressState)"/>"<xsl:text/>
CorrespondentPostalCode,"<xsl:value-of select="normalize-space(tm:AddressPostcode)"/>"<xsl:text/>
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
CorrespondentPhoneNumber,"<xsl:value-of select="tm:Phone"/>"<xsl:text/>
CorrespondentFaxNumber,"<xsl:value-of select="tm:Fax"/>"<xsl:text/>
CorrespondentEmailAddress,"<xsl:value-of select="tm:Email"/>"<xsl:text/>
</xsl:template>

<xsl:template match="tm:StaffDetails">
StaffName,"<xsl:value-of select="tm:Staff/tm:StaffName"/>"<xsl:text/>
StaffOfficialTitle,"<xsl:value-of select="tm:Staff/tm:OfficialTitle"/>"<xsl:text/>
</xsl:template>

<xsl:template match="tm:AssignmentBagExt">
<xsl:apply-templates select="pto:Assignment"/>
</xsl:template>

<xsl:template match="pto:Assignment">
BeginRepeatedField,"Assignment"<xsl:text/>
AssignmentIdentifier,"<xsl:value-of select="pto:AssignmentIdentifier"/>"<xsl:text/>
AssignmentConveyanceCategory,"<xsl:value-of select="pto:AssignmentConveyanceCategory"/>"<xsl:text/>
AssignmentGroupCategory,"<xsl:value-of select="pto:AssignmentGroupCategory"/>"<xsl:text/>
AssignmentRecordedDate,"<xsl:value-of select="pto:AssignmentRecordedDate"/>"<xsl:text/>
AssignmentRecordedDateTruncated,"<xsl:value-of select="substring(pto:AssignmentRecordedDate,1,10)"/>"<xsl:text/>
AssignmentExecutedDate,"<xsl:value-of select="pto:Assignor/pto:AssignmentExecutionDate"/>"<xsl:text/>
AssignmentExecutedDateTruncated,"<xsl:value-of select="substring(pto:Assignor/pto:AssignmentExecutionDate,1,10)"/>"<xsl:text/>
AssignorEntityName,"<xsl:value-of select="pto:Assignor/pto:Contact/pto:Name/pto:EntityName"/>"<xsl:text/>
AssigneeEntityName,"<xsl:value-of select="pto:Assignee/pto:Contact/pto:Name/pto:EntityName"/>"<xsl:text/>
AssignmentDocumentURL,"<xsl:value-of select="pto:AssignmentDocumentBag"/>"<xsl:text/>
EndRepeatedField,"Assignment"<xsl:text/>
</xsl:template>


</xsl:stylesheet>
