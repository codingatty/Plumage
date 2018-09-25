import unittest
import subprocess
import os, os.path
import shutil
import string

WORKING="working"
UTILS="utils"
EXPECTED="expected"
TESTDATA="testdata"
XSLS=".."
MSXML_filename = os.path.join(UTILS, "MSXSL.exe")
CMD_TEMPLATE = "{cmd} {{xmlfile}} {{xslfile}} -o {{outfile}}".format(cmd=MSXML_filename)

CSV_file_info = {}
all_CSV_filenames = []

class TestUM(unittest.TestCase):

    def setUp(self):
        shutil.rmtree(WORKING, ignore_errors=True)
        os.makedirs(WORKING)
        test_tms= ["rn2713476",     # MySQL
                   "rn2178784",     # Java
                   "sn87881347",    # Burger Addict (not yet registered; has staff info)
                   "sn85334015",    # Ultrabook (has international info)
                   "rn3756727"]     # Bluebook (multiple classes)  
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
                all_CSV_filenames.append(csv_filename)
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

    def split_csv(self, csvfilename):
        with open(csvfilename) as CSV_file:
            CSV_content = CSV_file.read()
            lines = CSV_content.split("\n")
            last_line=lines.pop()
            return(lines, last_line)

    def validate_key(self, k, line, fn, lineoffset):
        valid_key_chars = set(string.ascii_letters + string.digits)
        self.assertTrue(set(k).issubset(valid_key_chars),
                       msg="Invalid character in key <{key}> in line <{line}>, file {fn} line no. {lineno}".format(
                                 key=k, line=line, fn=fn, lineno = lineoffset+1))

    def validate_value(self, v, line, fn, lineoffset):
        #remove first and last characters (quote-marks) and put them back on; should be unchanged 
        reconstituted_v = '"' + v[1:-1] + '"'
        self.assertEqual(v, reconstituted_v,
                         msg="Improperly quoted value <{value}> in line <{line}>, file {fn} line no. {lineno}".format(
                                 value=v, line=line, fn=fn, lineno = lineoffset+1))
    
    # Group A tests: basic
    
    def test_A000_dummy(self):
        pass

    # Group B tests: format-only

    def test_B001_final_line_zero_length(self):
        for fn in all_CSV_filenames:
            (lines, lastline) = self.split_csv(fn)
            self.assertEqual(lastline, "",
                             msg="Non-blank last line <{line}> in file {fn}".format(
                                 line=lastline, fn=fn))
            
    def test_B002_no_blank_lines(self):
        for fn in all_CSV_filenames:
            (lines, lastline) = self.split_csv(fn)
            for i in range(0,len(lines)):
                self.assertFalse(
                    (lines[i].isspace() or lines[i] == ""),
                    msg="Blank or empty line <{line}> in file {fn}, line no. {linenumber}".format(
                        line=lines[i], fn=fn, linenumber=i+1))

    def test_B003_format_check(self):
        for fn in all_CSV_filenames:
            (lines, lastline) = self.split_csv(fn)
            for i in range(0,len(lines)):
                line = lines[i]
                self.assertEqual(line[-1], '"',
                                 msg="extraneous or missing data at end of line <{line}>, in file {fn}, line no. {linenumber}".format(
                        line=line, fn=fn, linenumber=i+1))
                chunks = line.split(',', 1)  # split into key/value pairs
                self.assertEqual(len(chunks), 2,
                        msg="line <{line}> not in KEY,VALUE format, in file {fn}, line no. {linenumber}".format(
                        line=line, fn=fn, linenumber=i+1))
                self.validate_key(chunks[0], line, fn, i)
                self.validate_value(chunks[1], line, fn, i)

    # Group C tests: content-based

    def test_C001_ID_numbers(self):
        self.confirm_content(["appno", "regno"], ["rn2178784", "rn2713476"])

    def test_C002_app_dates(self):
        self.confirm_content(["appdates"], ["rn2178784", "rn2713476"])

    def test_C003_register_category(self):
        self.confirm_content(["register-cat"],
                             ["rn2178784", "rn2713476"])
    
    def test_C004_renewal_date(self):
        self.confirm_content(["renewal-date"],
                             ["rn2178784", "rn2713476"])

    def test_C005_reg_date_times(self): # Only ST.66 uses time on reg date
        self.confirm_content(["regdatetimes"], ["rn2178784", "rn2713476"], XSLformats=["ST66"])

    def test_C006_reg_date_only(self): # ST.96 does not use time  
        self.confirm_content(["regdatesonly"], ["rn2178784", "rn2713476"], XSLformats=["ST96"]) 

    def test_C007_staff(self):  #87/881,347 still in prosecution when data captured; has staff info
        self.confirm_content(["staff"], ["sn87881347"]) 

    def test_C008_international_numbers(self):  #85/334,015 has international application info
        self.confirm_content(["international-numbers"], ["sn85334015"]) 

    def test_C009_international_classes(self):
        self.confirm_content(["international-classes"],
                             ["rn2713476", "rn3756727"])
        
    def test_C010_domestic_classes_ST66(self):
        self.confirm_content(["domestic-classes-ST66"],
                             ["rn2713476", "rn3756727"], ["ST66"])

    def test_C011_domestic_classes_ST96(self):
        self.confirm_content(["domestic-classes-ST96"],
                             ["rn2713476", "rn3756727"], ["ST96"])

    def test_C012_first_used_dates_ST66(self):
        self.confirm_content(["first-used-dates-ST66"],
                             ["rn2713476", "rn3756727"], ["ST66"])

    def test_C013_first_used_dates_ST96(self):
        self.confirm_content(["first-used-dates-ST96"],
                             ["rn2713476", "rn3756727"], ["ST96"])

if __name__ == '__main__':
    unittest.main(verbosity=5)
