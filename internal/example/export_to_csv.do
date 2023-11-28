global path = "H:/Open Data Format/repositories/specification/internal/example/"
global export = "${path}export/"


* dataset.csv
* https://www.statalist.org/forums/forum/general-stata-discussion/general/1399471-store-note-in-a-local-macro
use "${path}example.dta", clear

local name           = c(filename)
label language en
local label_en       : data label
label language de
local label_de       : data label
local description_en = "`_dta[note1]'"
local description_de = "`_dta[note2]'"
local url            = "`_dta[note3]'"

clear
set obs 1

gen name           = "`name'"
gen label_en       = "`label_en'"
gen label_de       = "`label_de'"
gen description_en = "`description_en'"
gen description_de = "`description_de'"
gen url            = "`url'"

export delimited using "${export}dataset.csv", replace


* data.csv
use "${path}example.dta", clear
label drop _all
export delimited using "${export}data.csv", replace


* variables.csv
* https://stackoverflow.com/questions/30733772/stata-retrieve-variable-label-in-a-macro
* https://stackoverflow.com/questions/30401420/save-in-a-macro-the-storage-type-of-variables-in-a-dta-dataset-without-opening
//TODO//
use "${path}example.dta", clear
quietly describe, varlist
local k    = r(k)
local vars = r(varlist)

di "`k'"
di "`vars'"

clear

set obs `k'

gen variable       = ""
gen label_en       = ""
gen label_de       = ""
gen type           = ""
gen description_en = ""
gen description_de = ""
gen url            = ""

local i = 1
foreach var of local vars {
	replace variable = "`var'" in `i'
	save "${export}variables.dta", replace
	use "${path}example.dta", clear
	label language en
	local label_en : variable label `var'
	label language de
	local label_en : variable label `var'
	local type : type `var'
	local i = `i' + 1
}

erase "${export}variables.dta"
export delimited using "${export}variables.csv", replace


* categories.csv
//TODO//
use "${path}example.dta", clear

levelsof bap87, local(levels)
foreach level of local levels {
	di "`level'"
}

export delimited using "${export}categories.csv", replace
