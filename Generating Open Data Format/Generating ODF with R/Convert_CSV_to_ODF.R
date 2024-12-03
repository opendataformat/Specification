#Convert csv to  ODF and load ODF dataset

#Install the opendataformat and the opendataformat.tools packages
install.packages("opendataformat")
devtools::install_git("https://git.soep.de/opendata/r-package-opendataformat.tools.git")

# Load the packages
library(opendataformat)
library(opendataformat.tools)


#Define the path where the four csv-Files are
csv_folder_path<-"C:/.../"

#Define the path where to store the ODF zip-File
opendf_output_path<-"C:/.../"

#Define the Dataset name for the ODF-Zip-File
datasetname<-"..."  #without ".zip"

#Use the convert_opendf function from the opendataformat.tools packages with the respective parameters
convert_opendf(format="csv2xml", input=csv_folder_path, output=paste0(opendf_output_path, datasetname), languages="all", variables="yes", export_data="yes")


# Test if the dataset was converted properly
df<-read_odf(file=paste0(opendf_output_path, datasetname, ".zip"))

#you can use the docu_opendf() function to see if metadata is correctly assigned
#for the dataset:
docu_odf(df)

#for a variable
docu_odf(df$variablename)
