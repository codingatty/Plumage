Plumage
=======
**Plumage** is an open source library to obtain trademark status and other information from the United States Patent & Trademark Office's (PTO) [Trademark Status & Document Retrieval](http://tsdr.uspto.gov/) (TSDR) system.  It takes as input either a registration number or application serial number, fetches the corresponding XML data from the PTO's TSDR website, and returns a dictionary of data associated with the specified TSDR entry.

Plumage  currently has two implementations, each independent of the other and each in its own repository:
* [Plumage-py](https://github.com/codingatty/Plumage-py), an implementation in Python (2.7)
* [Plumage-dotnet](https://github.com/codingatty/Plumage-dotnet), a C# implementation for .NET (C#, VisualBasic, etc.)

Pick whichever implementation fits your needs. Both implementations incorporate the ST66.xsl and ST96.xsl XSLT files maintained in this repository.

Plumage provides the following data:
* Status information: dozens of individual data items about the status of the registration application, including application and registration numbers and dates; applicant and representative contact information, historical data on all events recorded in the application; and history of any recorded assignments.  
* Image data: full-size and thumbnail images of the trademark.
* XML data: the full XML data provided by the USPTO, if you application needs to process the XML beyond the data supplied by Plumage.
* ZIP file: all data provided by the USPTO.
* CSV data: the same information provided in the dictionary, represented as comma-separated values, suitable for importation into a spreadsheet program such as Apache OpenOffice, LibreOffice, or Excel, or any other program that processes CSV data.

Plumage supports both ST.66 and ST.96 format files provided by the USPTO.  Most of the extraction logic is performed using XSLT.  By default, it determines the XML format and extracts data using the appropriate supplied XSLT transform.  A developer can override this by supplying her own XSLT file (either a modification of the standard transforms, or a completely new transform).  This may be desirable to adapt to changes made by the USPTO, or to extract additional data elements not currently provided by Plumage.

For documentation, please see the [Plumage wiki](https://github.com/codingatty/Plumage/wiki).

Plumage is open source, licensed under [ASL V2.0](http://www.apache.org/licenses/LICENSE-2.0) (code) and [CC BY-SA 3.0](http://creativecommons.org/licenses/by-sa/3.0/) (documentation).
