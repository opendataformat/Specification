/*----------------------------------------------------------------------------------
  Build an Stata dataframe enriched with metadata in the Open data Format and 
  save it as ODF-file (.zip)

    This script is an example to enrich a dataframe with metadata in the Open 
	Data Format (ODF) and save it as an ODF file, which has the format of a 
	zipped folder.
		
	You need the opendf package version v2.0.0 or higher for this script.
	At this point you can install the development version from github:
	. net install opendf, from (https://thartl-diw.github.io/opendf/) replace
	
	Author: Tom Hartl
	Date: 12 August 2024

-----------------------------------------------------------------------------------*/
version 16
clear all


******** Import raw Data *******

* Import data CSV without any
* Replace "C:\[...]\data.csv" with path to CSV-file with raw data
import delimited using "C:\[...]\data.csv", varnames(1) encoding(utf-8)



********** Define dataset metadata **********

* Define languages for metadata
label language en, rename
label language de, new

* Define dataset labels for all languages
label language en
label data "Data from individual questionnaires 2010"
label language de
label data "Daten vom Personenfragebogen 2010"

* Define study name
char _dta[study] https://paneldata.org/soep-core/data/bap

* Define dataset name
char _dta[datset] bap

* Define data description for all languages
#delim ;
char _dta[description_en] The data were collected as part of the SOEP-Core study using the questionnaire 
'Living in Germany - Survey 2010 on the social situation - Personal questionnaire for all'. 
This questionnaire is addressed to the individual persons in the household. 
A view of the survey instrument can be found here: 
https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf;
#delim cr

#delim ;
char _dta[description_de] Die Daten wurden im Rahmen der Studie SOEP-Core mittels des Fragebogens 
'Leben in Deutschland – Befragung 2010 zur sozialen Lage - Personenfragebogen 
für alle' erhoben. Dieser Fragebogen richtet sich an die einzelnen Personen im 
Haushalt. Eine Ansicht des Erhebungsinstrumentes finden Sie hier: 
https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf;
#delim cr

* Define data URL
char _dta[url] https://paneldata.org/soep-core/data/bap



********** Define dataset metadata **********

* Define variable labels for all variables and languages
label language en
label variable bap87   "Current Health"
label variable bap9201 "Hours Of Sleep, Normal Workday"
label variable bap9001 "Pressed For Time Last 4 Weeks"
label variable bap9002 "Run-down, Melancholy Last 4 Weeks"
label variable bap9003 "Well-balanced Last 4 Weeks"
label variable bap96   "Height"
label variable name    "First Name"

label language de
label variable bap87   "Gesundheitszustand gegenwärtig"
label variable bap9201 "Stunden Schlaf, normaler Werktag"
label variable bap9001 "Eile, Zeitdruck letzten 4 Wochen"
label variable bap9002 "Niedergeschlagen letzten 4 Wochen"
label variable bap9003 "Ausgeglichen letzten 4 Wochen"
label variable bap96   "Körpergröße"
label variable name    "Vorname"

* Define variable descriptions for al languages, types and URLs
char bap87[description_en] Question: How would you describe your current health?
char bap87[description_de] Frage: Wie würden Sie Ihren gegenwärtigen Gesundheitszustand beschreiben?
char bap87[url] https://paneldata.org/soep-core/data/bap/bap87
char bap87[type] "numeric"

char bap9201[description_en] Sleep hours per weekday
char bap9201[description_de] Schlafstunden pro Wochentag
char bap9201[url] https://paneldata.org/soep-core/data/bap/bap9201
char bap9201[type] "numeric"

char bap9001[description_en] Frequency of feeling time pressure in the past 4 weeks
char bap9001[description_de] Häufigkeit des Gefühls von Zeitdruck in den letzten 4 Wochen
char bap9001[url] https://paneldata.org/soep-core/data/bap/bap9001
char bap9001[type] "numeric"

char bap9002[description_en] Frequency of feeling a sad and depressed state
char bap9002[description_de] Häufigkeit der Niedergeschlagenheit
char bap9002[url] https://paneldata.org/soep-core/data/bap/bap9002
char bap9002[type] "numeric"

char bap9003[description_en] Frequency of feeling balance
char bap9003[description_de] Häufigkeit der Ausgeglichenheit
char bap9003[url] https://paneldata.org/soep-core/data/bap/bap9003
char bap9003[type] "numeric"

char bap96[description_en] Body size
char bap96[description_de] Körpergröße
char bap96[url] https://paneldata.org/soep-core/data/bap/bap96
char bap96[type] "numeric"

char name[description_en] First name
char name[description_de] Vorname
char name[type] "character"


* Define value labels for all variables
label language de

label define bap87_de -2 "trifft nicht zu" ///
                      -1 "keine Angabe" ///
					   1 "Sehr gut" ///
					   2 "Gut" ///
					   3 "Zufriedenstellend" ///
					   4 "Weniger gut" ///
					   5 "Schlecht"

label values bap87 bap87_de

label define bap9201_de -2 "trifft nicht zu" ///
                        -1 "keine Angabe"

label values bap9201 bap9201_de

label define bap9001_de -2 "trifft nicht zu" ///
                        -1 "keine Angabe" ///
						 1 "Immer" ///
						 2 "Oft" ///
						 3 "Manchmal" ///
						 4 "Fast nie" ///
						 5 "Nie"

label values bap9001 bap9001_de

label copy bap9001_de bap9002_de
label values bap9002 bap9002_de

label copy bap9001_de bap9003_de
label values bap9003 bap9003_de

label copy bap9201_de bap96_de
label values bap96 bap96_de


label language en

label define bap87_en -2 "Does not apply" ///
                      -1 "No Answer" ///
					   1 "Very good" ///
					   2 "Good" ///
					   3 "Satisfactory" ///
					   4 "Good" ///
					   5 "Poor"

label values bap87 bap87_en

label define bap9201_en -2 "Does not apply" ///
                        -1 "No Answer" ///

label values bap9201 bap9201_en

label define bap9001_en -2 "Does not apply" ///
                        -1 "No Answer" ///
						 1 "Always" ///
						 2 "Often" ///
						 3 "Sometimes" ///
						 4 "Almost Never" ///
						 5 "Never"

label values bap9001 bap9001_en

label copy bap9001_en bap9002_en
label values bap9002 bap9002_en

label copy bap9001_en bap9003_en
label values bap9003 bap9003_en

label copy bap9201_en bap96_en
label values bap96 bap96_en

**** Value Labels for Numeric Variables ****
* Unlike Stata, ODF supports Value LAbels for non-numeric variables (character variables)
* To save value labels for character variables, value labels are saved to the characteristics
* Values and Value Labels for each language are stored in one string as a characteristic.
* The unique values and labels are seperated by <;> The three seperating characters ensure 
* that the seperator is not by chance in any value label.
char name[labelled_values] "-2<;>-1"
char name[value_labels_en] "Does not apply<;>No Answer"
char name[value_labels_de] "trifft nicht zu<;>keine Angabe"


* Save stata dataset
save "example.dta", replace

* Save dataset as ODF file
opendf write "example.zip"
