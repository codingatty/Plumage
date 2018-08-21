import unittest
import subprocess
import os, os.path
import shutil

WORKING="working"
UTILS="utils"
EXPECTED="expected"
TESTDATA="testdata"
XSLS=".."
MSXML_filename = os.path.join(UTILS, "MSXSL.exe")
CMD_TEMPLATE = "{cmd} {{xmlfile}} {{xslfile}} -o {{outfile}}".format(cmd=MSXML_filename)

CSV_file_info = {}

class TestUM(unittest.TestCase):

    def setUp(self):
        shutil.rmtree(WORKING, ignore_errors=True)
        os.makedirs(WORKING)
        test_tms= ["rn2713476",     # MySQL
                   "rn2178784"]     # Java
        XSLs = ["ST66", "ST96"]
        for tm in test_tms:
            CSVs={}
            for xsl in XSLs:
                XML_filename = os.path.join(TESTDATA, "{tm}-{xsl}.xml".format(tm=tm, xsl=xsl))
                XSL_filename =  os.path.join(XSLS, "{xsl}.xsl".format(xsl=xsl))
                csv_filename = os.path.join(WORKING, "{tm}-{xsl}.csv".format(tm=tm, xsl=xsl))
                stdout_filename = os.path.join(WORKING, "{tm}-{xsl}-stdout.txt".format(tm=tm, xsl=xsl))
                stderr_filename = os.path.join(WORKING, "{tm}-{xsl}-stderr.txt".format(tm=tm, xsl=xsl))
                command = CMD_TEMPLATE.format(xmlfile=XML_filename,
                                              xslfile=XSL_filename,
                                              outfile=csv_filename)
                stdout=open(stdout_filename, "w")
                stderr=open(stderr_filename, "w")
                subprocess.call(command, stdin=None, stdout=stdout, stderr=stderr)
                stdout.close()
                stderr.close()
                CSVs[xsl] = csv_filename
            CSV_file_info[tm] = CSVs            

    def confirm_extract(self, field, tm, XSLformats=None):
        field_filename = os.path.join(EXPECTED, "{field}-{tm}.txt".format(field=field, tm=tm))
        CSV_file_table = CSV_file_info[tm]
        all_xsl_formats = list(CSV_file_table.keys())
        with open(field_filename) as extract_file:
            extract = extract_file.read()
            if XSLformats is None:
                formats_to_check = all_xsl_formats
            else:
                formats_to_check = XSLformats
            for xsl_format in formats_to_check:
                CSVfilename = CSV_file_table[xsl_format]
                with open(CSVfilename) as CSV_file:
                    CSV_content = CSV_file.read()
            self.assertTrue(extract in CSV_content,
                            msg="Content for field \"{field}\" does not match in CSV file {tm}/{format}".format(
                                field=field, tm=tm, format=xsl_format))

    def confirm_content(self, field_list, tmlist, XSLformats=None):
        for field in field_list:
            for tm in tmlist:
                self.confirm_extract(field, tm, XSLformats=XSLformats)

    def test_A000_dummy(self):
        pass

    def test_B001_ID_numbers(self):
        self.confirm_content(["appno", "regno"], ["rn2178784", "rn2713476"])

    def test_B002_app_dates(self):
        self.confirm_content(["appdates"], ["rn2178784", "rn2713476"])

    def test_B003_reg_date_times(self): # Only ST.66 uses time on reg date
        self.confirm_content(["regdatetimes"], ["rn2178784", "rn2713476"], XSLformats=["ST66"])

    def test_B004_reg_date_only(self): # ST.96 does not use time  
        self.confirm_content(["regdatesonly"], ["rn2178784", "rn2713476"], XSLformats=["ST96"]) 
       
if __name__ == '__main__':
    unittest.main(verbosity=5)
