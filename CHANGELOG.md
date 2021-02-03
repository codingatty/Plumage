# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [1.4.0](https://github.com/codingatty/Plumage/releases/tag/V1.4.0) - 2021-02-02 (*Experiment IV*)
- Final line in CSV now terminates in NEWLINE. This is consistent with CSV treatment in major spreadsheet programs (e.g. LibreOffice, Apache OpenOffice & Microsoft Excel). Note this requires the "XSL relaxation: accept and ignore blank or empty lines" feature that was added in Plumage-py 1.2.0 and Plumage-dotnet 1.2.0.
- The use of the <xsl:text/> (used to prevent the insertion of blank lines) has been trimmed back, to keep the XSL files more readable 
- Cleaned up Staff info and international application and reg nos. handling
- Improved unit tests
- Change namespace IDs in ST66 to match PTO XML files ("default" for the unnamed one). See discussion at https://github.com/codingatty/Plumage-py/issues/1
- Report international and domestic trademark classes
- Report first-use dates (on per-class basis)
- Plumage-XSLT-metadata.json to enable metadata query without TSDR call

## [1.1.0](https://github.com/codingatty/Plumage/releases/tag/V1.1.0) - 2016-05-23 (*The Big Sky*)
- Support for ST.96 V 2.2.1 (adopted by the US PTO on May 6, 2016)

## [1.0.1](https://github.com/codingatty/Plumage/releases/tag/V1.0.1) - 2016-05-20 
### Bug fix only:
- Definitions for ``MarkEventDate`` and ``MarkEventDateTruncated`` definitions were reversed; the reversal was actually harmless, because in ST96, there's no truncation needed for ``MarkEventDate``, but I just wanted to have a clean ST.96&nbsp;1_D3 version before I add ST.96 V2.2.1 support.

## [1.0.0](https://github.com/codingatty/Plumage/releases/tag/V1.0.0) - 2016-05-12 (*And Dream of Sheep*)
### Added
- Initial release of XSLT transforms used in all implementations of Plumage.
- Support for:
  - ST.66; release level not identified by USPTO
  - ST.96, release 1_D3 
