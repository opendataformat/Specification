# version 2.2.0 (11 March 2025)

# Modules
import csv
import os
import shutil
import zipfile
import xml.etree.ElementTree as ET
import json


#########Inputs:###########
# Pfad zu Ordner mit 4 csvs
input_dir='C:/Users/thartl/AppData/Local/Temp'
# Pfad und Dateiname für ODF-Outputfile, Dateiname mit '.zip' angeben
output_dir='C:/Users/thartl/Documents/datasetname.odf.zip'

#########Parameter:########

#Welche Sprachen ins xml exportieren? E.g.'all' oder ['en', 'de'] 
languages='all'
#Datensatz (data.csv) mitexportieren?
export_data='yes'
#ODF version
odf_version="1.1.0"


############# Functions for conversion to ODF #############
# Modules
import csv
import os
import shutil
import zipfile
import xml.etree.ElementTree as ET
import json

# formatting xml output
def pretty_print(current, parent=None, index=-1, depth=0):
  for i, node in enumerate(current):
    pretty_print(node, current, i, depth + 1)
  if parent is not None:
    if index == 0:
      parent.text = '\n' + ('  ' * depth)
    else:
      parent[index - 1].tail = '\n' + ('  ' * depth)
    if index == len(parent) - 1:
      current.tail = '\n' + ('  ' * (depth - 1))

# get head of csv file              
def header(input_dir,csv_file):
  with open(input_dir+"/"+csv_file,"r", encoding="utf-8") as file:
    dict_reader=csv.DictReader(file)
    header = dict_reader.fieldnames      
  return header

# get language codes of attribute  
def get_lang(input_dir,csv_file, attribute):
  lang = []
  for i in header(input_dir,csv_file):
    if i.startswith(attribute+'_') == True:
      lang_code = i.split('_')
      lang.append(lang_code[1])
  return lang  

# make output directory  
def make_output_dir(temp_output_dir):
  if os.path.exists(temp_output_dir+'/'):
    shutil.rmtree(temp_output_dir+'/')
  os.makedirs(temp_output_dir+'/')

# copy data.csv from input dir to output dir
def copy_data_csv(input_dir, output_dir, export_data):
  if export_data == "yes" :
    shutil.copy(
      input_dir+'/data.csv',
      output_dir)

# make xml file from csv files          
def csv2xml(input_dir, output_dir, odf_version):
  schema_name=ET.QName("http://www.w3.org/2001/XMLSchema-instance","schemaLocation")
  root = ET.Element("codeBook",
  {schema_name:"ddi:codebook:2_5 http://www.ddialliance.org/Specification/DDI-Codebook/2.5/XMLSchema/codebook.xsd",
  'xmlns':"ddi:codebook:2_5",},version='2.5',)
  # check if location output directory exists/is valid
  dir_name = output_dir.replace('\\','/')
  dir_name = output_dir.split('/')
  root_dir=dir_name
  del(root_dir[len(root_dir)-1])
  root_dir = '/'.join(root_dir)
  if os.access(root_dir, os.W_OK) == False:
    raise ValueError('Invalid output directory: No writing permission for '+root_dir)
  # dataset
  # check if dataset.csv exists
  if os.path.exists(input_dir+"/dataset.csv") == True :
    #study description
    stdyDscr=ET.SubElement(root,'stdyDscr')
    citation=ET.SubElement(stdyDscr,'citation')
    titlStmt=ET.SubElement(citation,'titlStmt')
    
    #file description
    fileDscr=ET.SubElement(root,'fileDscr')
    fileTxt=ET.SubElement(fileDscr,'fileTxt')
    with open(input_dir+"/dataset.csv",mode="r",encoding="utf-8") as file:
      dict_reader=csv.DictReader(file)
      for row in dict_reader:
        
        # dataset name
        fileName=ET.SubElement(fileTxt,'fileName')
        fileName.text=row['dataset']
        
        titl=ET.SubElement(titlStmt,'titl')
        titl.text=row['study']
        # get keys
        list_keys = row.keys()

      # dataset label
      fileCitation=ET.SubElement(fileTxt,'fileCitation')
      titlStmt=ET.SubElement(fileCitation,'titlStmt')
      first_label=0
      if 'label' in list_keys:
        titl=ET.SubElement(titlStmt,'titl')
        titl.text=row['label']
        first_label=1
      if any(item.startswith('label_') for item in list_keys):
        for lang in get_lang(input_dir,"dataset.csv","label"):
          if first_label==0:
            titl=ET.SubElement(titlStmt,'titl')
            titl.attrib['{http://www.w3.org/XML/1998/namespace}lang'] = lang
            titl.text=row['label_'+lang]
            first_label=1
          else:
            parTitl=ET.SubElement(titlStmt,'parTitl')
            parTitl.attrib['{http://www.w3.org/XML/1998/namespace}lang'] = lang
            parTitl.text=row['label_'+lang]
      # dataset description
      if 'description' in list_keys:
        fileCont=ET.SubElement(fileTxt,'fileCont')
        fileCont.text=row['description']
      if any(item.startswith('description_') for item in list_keys) == True:
        for lang in get_lang(input_dir,"dataset.csv","description"):
          fileCont=ET.SubElement(fileTxt,'fileCont')
          fileCont.attrib['{http://www.w3.org/XML/1998/namespace}lang'] = lang
          fileCont.text=row['description_'+lang]
      # url
      if 'url' in list_keys:
        notes=ET.SubElement(fileDscr,'notes')
        extlink=ET.SubElement(notes,'ExtLink')
        extlink.attrib['URI']=row['url']
  

  if os.path.exists(input_dir+"/categories.csv") == True :
    list_categories=[]
    categories=open(input_dir+"/categories.csv", mode="r", encoding="utf-8")
    dict_categories = csv.DictReader(categories)
    for i in dict_categories:
      list_categories.append(i)
  
    if os.path.exists(input_dir+"/variables.csv") == True :
      # variables
      dataDscr=ET.SubElement(root,'dataDscr')
      with open(input_dir+"/variables.csv", mode="r", encoding="utf-8") as file:
        dict_reader=csv.DictReader(file)
        for row in dict_reader:
          var = ET.SubElement(dataDscr, 'var')
          var.attrib['name'] = row['variable']
          # get keys
          list_keys = row.keys()
          # variable label
          if 'label' in list_keys:
            labl = ET.SubElement(var, 'labl')
            labl.text = row['label']
          if any(item.startswith('label_') for item in list_keys):
            for lang in get_lang(input_dir,"variables.csv","label"):
              labl = ET.SubElement(var, 'labl')
              labl.attrib['{http://www.w3.org/XML/1998/namespace}lang'] = lang
              labl.text = row['label_'+lang]
          # variable description    
          if 'description' in list_keys:
            txt = ET.SubElement(var, 'txt')
            txt.text = row['description']        
          if any(item.startswith('description_') for item in list_keys):  
            for lang in get_lang(input_dir,"variables.csv","description"):
              txt = ET.SubElement(var, 'txt')
              txt.attrib['{http://www.w3.org/XML/1998/namespace}lang'] = lang
              txt.text = row['description_'+lang]
          #variable categories        
          varname = row['variable']
          for line in list_categories:
            # get keys
            list_keys2 = line.keys()
            if line['variable'] == varname:
              catgry = ET.SubElement(var, 'catgry')
              # value
              catValu = ET.SubElement(catgry, 'catValu')
              catValu.text = line['value']
              # value label
              if 'label' in list_keys2:
                    labl = ET.SubElement(catgry, 'labl')
                    labl.text = line['label']
              if any(item.startswith('label_') for item in list_keys2):  
                    for lang in get_lang(input_dir,"categories.csv","label"):
                      labl = ET.SubElement(catgry, 'labl')
                      labl.attrib['{http://www.w3.org/XML/1998/namespace}lang'] = lang
                      labl.text = line['label_'+lang]   
          # Variable type
          if 'type' in list_keys:
            if not row['type'] == '':
                  varFormat = ET.SubElement(var, 'varFormat')
                  varFormat.attrib['type'] = row['type']                
          # Variable URL
          if 'url' in list_keys:    
                notes = ET.SubElement(var, 'notes')
                ExtLink = ET.SubElement(notes, 'ExtLink')
                ExtLink.attrib['URI'] = row['url']
            
  # write xml
  pretty_print(root)
  tree = ET.ElementTree(root)
  tree.write(input_dir+"/metadata.xml", xml_declaration=True, encoding="utf-8")
  version_file = {
    "fileType": "opendataformat",
    "version": odf_version,
    "files": {
      "data": "data.csv",
      "metadata": "metadata.xml"
    }
  }
  # Write version file
  with open(input_dir + '/odf-version.json', "w") as f:
    json.dump(version_file, f, indent=2)  # Pretty formatting with indent
  export_files = ["metadata.xml"]
  if export_data == "yes":
    export_files.append("data.csv")
  if (odf_version.split('.')[0] == '1' and int(odf_version.split('.')[1]) >=1 or int(odf_version.split('.')[0]) > 2):
    export_files.append("odf-version.json")
  print(input_dir)
  print(output_dir)
  # Zip the output directory with all files
  with zipfile.ZipFile(output_dir, "w") as zipf:
    for file in export_files:
      file_path = os.path.join(input_dir, file)
      if os.path.isfile(file_path):  # Ensure it's a file, not a directory
          zipf.write(file_path, arcname=file)  # Add to ZIP without full path




############## Convert CSVs to ODF #############
csv2xml(input_dir, output_dir, odf_version)
