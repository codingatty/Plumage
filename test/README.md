This is a poor but better-than-nothing unit test for the XSL files. I use Python and its `unittest` module to do this.

A typical test is:
```Python
def test_id_numbers(self):
    self.confirm_content(["regno", "appno"], ["rn2178784", "rn2713476"])
```
This will check two fields ("regno" and "appno", i.e. the registration number and application number) against XML files for two trademarks ("rn2178784" and "rn2713476").

In order to support this, the `testdata` directory must contain one or more XML files for each of the listed trademarks, named in the form `TM-FORMAT.xml`, where `TM` corresponds to the same trademark number as in the list, and `FORMAT` is the XML format ("ST66" or "ST96"). In the above example, there are four XML files:

* `rn2178784-ST66.xml`
* `rn2178784-ST96.xml`
* `rn2713476-ST66.xml`
* `rn2713476-ST96.xml`

In addition, the trademarks forming the testbed are kept in the `test_tms` list in the unittest `setUp` method. (maybe someday I'll make this self-discovering, but it's probably not worth the effort.)

For each of the fields, the `expected` directory must contain a file, named in the form `FIELD-TM.txt` that contains the text expected to be found for that field. For example, for the above example, with two fields being checked against two trademarks, there are four (2 × 2) files, one for each field-trademark combination:

* `appno-rn2178784.txt`
* `appno-rn2713476.txt`
* `regno-rn2178784.txt`
* `regno-rn2713476.txt`

Each of the files contains the text expected to be found in the XSL-transformed CSV file. For example, `regno-rn2178784.txt` contains the string `RegistrationNumber,"2178784"`.

A test is deemed passed when the string from the applicable `examples` file is found in the specified CSV file.

At the end of the test, the CSV files, as well as the standard output and standard error from each XSL transform, are kept in the `working` directory, which is destroyed and recreated each time the test is run.

This is, as noted above, a pretty simplistic test, and there's a limit to how much it can really do, but it is better than nothing.