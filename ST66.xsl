<?xml version="1.0" encoding="utf-8"?>

<!-- 

   Plumage: XSLT to transform USPTO TSDR XML to CSV format
   https://github.com/codingatty/Plumage
   
   ST66.xsl - ST.66 transform
   Version 1.2.0 (pre-release), 2018-09-25
   Copyright 2014-2018 Terry Carroll
   carroll@tjc.com

   This program is licensed under Apache License, version 2.0 (January 2004);
   see http://www.apache.org/licenses/LICENSE-2.0
   SPX-License-Identifier: Apache-2.0

   Anyone who makes use of, or who modifies, this code is encouraged
   (but not required) to notify the author.

-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:default="http://www.wipo.int/standards/XMLSchema/trademarks" xmlns:ns2="urn:us:gov:doc:uspto:trademark:status">
<xsl:output method="text" encoding="utf-8"/>
<xsl:variable name='NL'><xsl:text>&#10;</xsl:text></xsl:variable><!-- NL = newline character X'0A' -->

<xsl:template match="default:Transaction">
<xsl:apply-templates select=".//default:TradeMark"/>
<xsl:apply-templates select=".//default:Applicant"/>
<xsl:apply-templates select=".//default:MarkEvent"/>
<xsl:apply-templates select=".//default:AssignmentBagExt"/>
<xsl:text/>MetaInfoXSLTName,"Plumage"
MetaInfoXSLTVersion,"1.4.0-pre"
MetaInfoXSLTDate,"2020-10-03"
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
MetaInfoExecXSLTFormat,"ST.66"
MetaInfoExecExecutionDateTime,"$EXECUTIONDATETIME$"
MetaInfoExecTSDRStartTimestamp,"$TSDRSTARTDATETIME$"
MetaInfoExecTSDRCompleteTimestamp,"$TSDRCOMPLETEDATETIME$"
MetaInfoExecXMLSource,"$XMLSOURCE$"
MetaInfoExecXSLProcessorVersion,"<xsl:value-of select="system-property('xsl:version')"/>"
MetaInfoExecXSLProcessorVendor,"<xsl:value-of select="system-property('xsl:vendor')"/>"
MetaInfoExecXSLProcessorVendorURL,"<xsl:value-of select="system-property('xsl:vendor-url')"/>"
</xsl:template>

<xsl:template match="default:TradeMark">
<xsl:text/>MarkCurrentStatusDate,"<xsl:value-of select="default:MarkCurrentStatusDate"/>"
MarkCurrentStatusDateTruncated,"<xsl:value-of select="substring(default:MarkCurrentStatusDate,1,10)"/>"
ApplicationNumber,"<xsl:value-of select="default:ApplicationNumber"/>"
ApplicationDate,"<xsl:value-of select="default:ApplicationDate"/>"
ApplicationDateTruncated,"<xsl:value-of select="substring(default:ApplicationDate,1,10)"/>"
RegistrationNumber,"<xsl:value-of select="default:RegistrationNumber"/>"
RegistrationDate,"<xsl:value-of select="default:RegistrationDate"/>"
RegistrationDateTruncated,"<xsl:value-of select="substring(default:RegistrationDate,1,10)"/>"
<xsl:apply-templates select="default:WordMarkSpecification"/>
<xsl:apply-templates select="default:TradeMarkExt"/>
<xsl:apply-templates select="default:GoodsServicesDetails/default:GoodsServices/default:ClassDescriptionDetails/default:ClassDescription"/>
<xsl:apply-templates select="default:GoodsServicesDetails/default:GoodsServices/default:ClassDescriptionDetails/default:ClassDescription/default:ClassDescriptionExt/ns2:DomesticClassNumbers"/>
<xsl:apply-templates select="default:GoodsServicesDetails/default:GoodsServices/default:ClassDescriptionDetails/default:ClassDescription/default:ClassDescriptionExt/ns2:FilingBasisDetails"/>
<xsl:apply-templates select="default:PublicationDetails"/>
<xsl:apply-templates select="default:RepresentativeDetails"/>
<xsl:apply-templates select="default:StaffDetails"/>
</xsl:template>

<xsl:template match="default:WordMarkSpecification">
<xsl:text/>MarkVerbalElementText,"<xsl:value-of select="default:MarkVerbalElementText"/>"
</xsl:template>

<xsl:template match="default:TradeMarkExt">
<xsl:text/>MarkCurrentStatusExternalDescriptionText,"<xsl:value-of select="ns2:MarkCurrentStatusExternalDescriptionText"/>"
RegisterCategory,"<xsl:value-of select="ns2:RegisterCategory"/>"
RenewalDate,"<xsl:value-of select="ns2:AdditionalMarkDetails/ns2:RenewalDate"/>"
RenewalDateTruncated,"<xsl:value-of select="substring(ns2:AdditionalMarkDetails/ns2:RenewalDate,1,10)"/>"
<xsl:if test="ns2:RelatedMarkDetails/ns2:InternationalApplicationNumber != ''">
    <xsl:text/>InternationalApplicationNumber,"<xsl:value-of select="ns2:RelatedMarkDetails/ns2:InternationalApplicationNumber"/>"
</xsl:if>
<xsl:if test="ns2:RelatedMarkDetails/ns2:InternationalRegistrationNumber != ''">
    <xsl:text/>InternationalRegistrationNumber,"<xsl:value-of select="ns2:RelatedMarkDetails/ns2:InternationalRegistrationNumber"/>"
</xsl:if>
<xsl:apply-templates select="ns2:OfficeDetails"/>
</xsl:template>

<xsl:template match="ns2:OfficeDetails">
<xsl:text/>LawOfficeAssignedText,"<xsl:value-of select="ns2:LawOfficeAssignedText"/>"
CurrentLocationCode,"<xsl:value-of select="ns2:CurrentLocationCode"/>"
CurrentLocationText,"<xsl:value-of select="ns2:CurrentLocationText"/>"
CurrentLocationDate,"<xsl:value-of select="ns2:CurrentLocationDate"/>"
CurrentLocationDateTruncated,"<xsl:value-of select="substring(ns2:CurrentLocationDate,1,10)"/>"
</xsl:template>

<xsl:template match="default:Applicant">
<xsl:text/>BeginRepeatedField,"Applicant"
ApplicantName,"<xsl:value-of select="default:ApplicantAddressBook/default:FormattedNameAddress/default:Name/default:FreeFormatName/default:FreeFormatNameDetails/default:FreeFormatNameLine"/>"
ApplicantDescription,"<xsl:value-of select="default:ApplicantExt/ns2:PartyTypeDescriptionText"/>"
<xsl:apply-templates select="default:ApplicantAddressBook/default:FormattedNameAddress/default:Address/default:FormattedAddress"/>
EndRepeatedField,"Applicant"
</xsl:template>

<xsl:template match="default:ApplicantAddressBook/default:FormattedNameAddress/default:Address/default:FormattedAddress">
<xsl:text/>ApplicantAddressLine01,"<xsl:value-of select="default:AddressRoom"/>"
ApplicantAddressLine02,""
ApplicantAddressCity,"<xsl:value-of select="default:AddressCity"/>"
ApplicantAddressGeoRegion,"<xsl:value-of select="default:AddressState"/>"
ApplicantPostalCode,"<xsl:value-of select="default:AddressPostcode"/>"
ApplicantCountryCode,"<xsl:value-of select="default:FormattedAddressCountryCode"/>"<xsl:text/>
<xsl:value-of select="concat($NL, 'ApplicantCombinedAddress,&quot;', 
  default:AddressRoom, '/',
  '/',
  default:AddressCity, '/',
  default:AddressState, '/',
  default:AddressPostcode, '/',
  default:FormattedAddressCountryCode, '&quot;'
  )"/>
</xsl:template>

<xsl:template match="default:MarkEvent">
<xsl:text/>BeginRepeatedField,"MarkEvent"
MarkEventDate,"<xsl:value-of select="default:MarkEventDate"/>"
MarkEventDateTruncated,"<xsl:value-of select="substring(default:MarkEventDate,1,10)"/>"
MarkEventDescription,"<xsl:value-of select="default:MarkEventExt/ns2:MarkEventInternalDescriptionText"/>"
MarkEventEntryNumber,"<xsl:value-of select="default:MarkEventExt/ns2:MarkEventEntryNumber"/>"
EndRepeatedField,"MarkEvent"
</xsl:template>

<xsl:template match="default:GoodsServicesDetails/default:GoodsServices/default:ClassDescriptionDetails/default:ClassDescription">
<xsl:text/>BeginRepeatedField,"InternationalClassDescription"
InternationalClassNumber,"<xsl:value-of select="default:ClassNumber"/>"
GoodsServicesDescription,"<xsl:value-of select="default:GoodsServicesDescription"/>"
EndRepeatedField,"InternationalClassDescription"
</xsl:template>

<xsl:template match="default:GoodsServicesDetails/default:GoodsServices/default:ClassDescriptionDetails/default:ClassDescription/default:ClassDescriptionExt/ns2:DomesticClassNumbers">
<xsl:text/>BeginRepeatedField,"DomesticClassDescription"
PrimaryClassNumber,"<xsl:value-of select="../ns2:PrimeClassText"/>"
NationalClassNumber,"<xsl:value-of select="."/>"
EndRepeatedField,"DomesticClassDescription"
</xsl:template>

<xsl:template match="default:GoodsServicesDetails/default:GoodsServices/default:ClassDescriptionDetails/default:ClassDescription/default:ClassDescriptionExt/ns2:FilingBasisDetails">
<xsl:text/>BeginRepeatedField,"FirstUseDates"
PrimaryClassNumber,"<xsl:value-of select="../ns2:PrimeClassText"/>"
FirstUseDateNumber,"<xsl:value-of select="ns2:FirstUseDateNumber"/>"
FirstUseInCommerceDate,"<xsl:value-of select="ns2:FirstUseInCommerceDate"/>"
EndRepeatedField,"FirstUseDates"
</xsl:template>

<xsl:template match="default:PublicationDetails">
<xsl:text/>PublicationDate,"<xsl:value-of select="default:Publication/default:PublicationDate"/>"
PublicationDateTruncated,"<xsl:value-of select="substring(default:Publication/default:PublicationDate,1,10)"/>"
</xsl:template>

<xsl:template match="default:RepresentativeDetails">
<xsl:if test="default:Representative/default:Comment = 'Domestic Correspondent'">
<xsl:text/>CorrespondentName,"<xsl:value-of select="default:Representative/default:RepresentativeAddressBook/default:FormattedNameAddress/default:Name/default:FreeFormatName/default:FreeFormatNameDetails/default:FreeFormatNameLine[1]"/>"
CorrespondentOrganization,"<xsl:value-of select="default:Representative/default:RepresentativeAddressBook/default:FormattedNameAddress/default:Name/default:FreeFormatName/default:FreeFormatNameDetails/default:FreeFormatNameLine[2]"/>"
<xsl:apply-templates select=".//default:FormattedAddress"/>
<xsl:apply-templates select=".//default:ContactInformationDetails"/>
</xsl:if>
</xsl:template>

<xsl:template match="default:FormattedAddress">
<xsl:text/>CorrespondentAddressLine01,"<xsl:value-of select="normalize-space(default:AddressBuilding)"/>"
CorrespondentAddressLine02,"<xsl:value-of select="normalize-space(default:AddressStreet)"/>"
CorrespondentAddressCity,"<xsl:value-of select="normalize-space(default:AddressCity)"/>"
CorrespondentAddressGeoRegion,"<xsl:value-of select="normalize-space(default:AddressState)"/>"
CorrespondentPostalCode,"<xsl:value-of select="normalize-space(default:AddressPostcode)"/>"
CorrespondentCountryCode,"<xsl:value-of select="normalize-space(default:FormattedAddressCountryCode)"/>"<xsl:text/> 
<xsl:value-of select="concat($NL, 'CorrespondentCombinedAddress,&quot;', 
  normalize-space(default:AddressBuilding), '/',
  normalize-space(default:AddressStreet), '/',
  normalize-space(default:AddressCity), '/',
  normalize-space(default:AddressState), '/',
  normalize-space(default:AddressPostcode), '/',
  normalize-space(default:FormattedAddressCountryCode),
  '&quot;'
  )"/>
</xsl:template>

<xsl:template match="default:ContactInformationDetails">
CorrespondentPhoneNumber,"<xsl:value-of select="default:Phone"/>"
CorrespondentFaxNumber,"<xsl:value-of select="default:Fax"/>"
CorrespondentEmailAddress,"<xsl:value-of select="default:Email"/>"
</xsl:template>

<xsl:template match="default:StaffDetails">
<xsl:if test="default:Staff/default:StaffName != ''">
    <xsl:text/>StaffName,"<xsl:value-of select="default:Staff/default:StaffName"/>"
</xsl:if>
<xsl:if test="default:Staff/default:OfficialTitle != ''">
    <xsl:text/>StaffOfficialTitle,"<xsl:value-of select="default:Staff/default:OfficialTitle"/>"
</xsl:if>
</xsl:template>

<xsl:template match="default:AssignmentBagExt">
<xsl:apply-templates select="ns2:Assignment"/>
</xsl:template>

<xsl:template match="ns2:Assignment">
<xsl:text/>BeginRepeatedField,"Assignment"
AssignmentIdentifier,"<xsl:value-of select="ns2:AssignmentIdentifier"/>"
AssignmentConveyanceCategory,"<xsl:value-of select="ns2:AssignmentConveyanceCategory"/>"
AssignmentGroupCategory,"<xsl:value-of select="ns2:AssignmentGroupCategory"/>"
AssignmentRecordedDate,"<xsl:value-of select="ns2:AssignmentRecordedDate"/>"
AssignmentRecordedDateTruncated,"<xsl:value-of select="substring(ns2:AssignmentRecordedDate,1,10)"/>"
AssignmentExecutedDate,"<xsl:value-of select="ns2:Assignor/ns2:AssignmentExecutionDate"/>"
AssignmentExecutedDateTruncated,"<xsl:value-of select="substring(ns2:Assignor/ns2:AssignmentExecutionDate,1,10)"/>"
AssignorEntityName,"<xsl:value-of select="ns2:Assignor/ns2:Contact/ns2:Name/ns2:EntityName"/>"
AssigneeEntityName,"<xsl:value-of select="ns2:Assignee/ns2:Contact/ns2:Name/ns2:EntityName"/>"
AssignmentDocumentURL,"<xsl:value-of select="ns2:AssignmentDocumentBag"/>"
EndRepeatedField,"Assignment"
</xsl:template>


</xsl:stylesheet>
