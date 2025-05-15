/*----------------------------------------------------------------------------------
  Build an ODF file (.zip) from four CSV-files in the Tnternal ODF

    This script shows how to generate Open Data Format Files from four CSV files
	in the Internal Open Data Format containing data and metadata.
	
	The four CSV-files have to consist of:
	data.csv : containing the raw dataset
	dataset.csv : containing the metadata of the dataset
	variables.csv : containing the metadata for the variables
	categories.csv : containing the value labels for variables
	You can find further information about the Open Data Format (ODF) and the 
	Internal ODF for generating ODF-files on GitLab.
	
		
	You need the opendf package version v2.0.0 or higher for this script.
	At this point you can install the package from ssc:
	. ssc install opendf
	
	Author: Tom Hartl
	Date: 03 DEcember 2024

-----------------------------------------------------------------------------------*/

ssc install opendf

* You need to indicate the location of the four csv-files:
local input_folder "..."
* and the location and name for the ODF (.odf.zip)-file output
local output_zip "...\odf_datafile_name.odf.zip"

*convert the four CSVs to ODF
opendf csv2zip, output("`output_zip'") input("`input_folder'")


* check if output file was generated
capture confirm file "`output_zip'"
if (_rc == 0) di as red "Datset successfully saved as ODF to {it: `output_zip'}"
else di as red "Converting dataset to ODF not successful"



* If you encounter any problems you can check the documentation for the function
help opendf csv2zip
