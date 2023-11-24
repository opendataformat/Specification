version 17
set more off, permanently
clear all

import delimited using "H:\Open Data Format\repositories\specification\internal\example\data.csv", varnames(1) encoding(utf-8)

* set languages
label language en, rename
label language de, new

label language en
label data "Data from individual questionnaires 2010"

label language de
label data "Daten vom Personenfragebogen 2010"

* data description
#delim ;
note: The data were collected as part of the SOEP-Core study using the questionnaire 
Living in Germany - Survey 2010 on the social situation - Personal questionnaire for all'. 
This questionnaire is addressed to the individual persons in the household. 
A view of the survey instrument can be found here: 
https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf;
#delim cr

#delim ;
note: Die Daten wurden im Rahmen der Studie SOEP-Core mittels des Fragebogens 
"Leben in Deutschland – Befragung 2010 zur sozialen Lage - Personenfragebogen 
für alle" erhoben. Dieser Fragebogen richtet sich an die einzelnen Personen im 
Haushalt. Eine Ansicht des Erhebungsinstrumentes finden Sie hier: 
https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf;
#delim cr

* variable labels
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

* variable description
note bap87: Question: How would you describe your current health?
note bap87: Frage: Wie würden Sie Ihren gegenwärtigen Gesundheitszustand beschreiben?
note bap87: https://paneldata.org/soep-core/data/bap/bap87

note bap9201: Sleep hours per weekday
note bap9201: Schlafstunden pro Wochentag
note bap9201: https://paneldata.org/soep-core/data/bap/bap9201

note bap9001: Frequency of feeling time pressure in the past 4 weeks
note bap9001: Häufigkeit des Gefühls von Zeitdruck in den letzten 4 Wochen
note bap9001: https://paneldata.org/soep-core/data/bap/bap9001

note bap9002: Frequency of feeling a sad and depressed state
note bap9002: Häufigkeit der Niedergeschlagenheit
note bap9002: https://paneldata.org/soep-core/data/bap/bap9002

note bap9003: Frequency of feeling balance
note bap9003: Häufigkeit der Ausgeglichenheit
note bap9003: https://paneldata.org/soep-core/data/bap/bap9003

note bap96: Body size
note bap96: Körpergröße
note bap96: https://paneldata.org/soep-core/data/bap/bap96

note name: First name
note name: Vorname


* value labels
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

save "H:\Open Data Format\repositories\specification\internal\example\example.dta", replace
