global path = "H:/Open Data Format/repositories/specification/internal/example/"
global export = "${path}export/"

version 17
set more off, permanently
clear all


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
	local label_de : variable label `var'
	local type : type `var'
	local description_en = "``var'[note1]'"
	local description_de = "``var'[note2]'"
	local url = "``var'[note3]'"
	use "${export}variables.dta", clear
	replace label_en = "`label_en'" in `i'
	replace label_de = "`label_de'" in `i'
	replace type = "`type'" in `i'
	replace description_en = "`description_en'" in `i'
	replace description_de = "`description_de'" in `i'
	replace url = "`url'" in `i'
	save "${export}variables.dta", replace
	local i = `i' + 1
}

replace type = "numeric" if inlist(type, "byte", "int", "long", "float", "double")
replace type = "character" if substr(type, 1, 3) == "str"

erase "${export}variables.dta"
export delimited using "${export}variables.csv", replace


* categories.csv
//TODO// -> IT DOESN'T MAKE ANY SENSE TO GO THROUGH LEVELS HERE, NEED TO GO THROUGH LABELS INSTEAD
use "${path}example.dta", clear

local n = 0
foreach var of local vars {
	levelsof `var'
	local n = `n' + r(r)
}

clear

set obs `n'
gen variable = ""
gen value    = ""
gen label_en = ""
gen label_de = ""

save "${export}categories.dta", replace

local i = 1
foreach var of local vars {
	use "${path}example.dta", clear
	levelsof `var', local(levels)
	local r = r(r)
	label language en
	local lab_en : value label `var'
	label language de
	local lab_de : value label `var'
	* go through levels
	foreach level of local levels {
		use "${export}categories.dta", clear
		replace variable = "`var'" in `i'
		replace value = "`level'" in `i'
		save "${export}categories.dta", replace
		use "${path}example.dta", clear
		if ("`lab_en'" == "dd" && "`lab_de'" == "dd") {
			local lab_en : label `lab_en' `level'
			local lab_de : label `lab_de' `level'
		}
		else {
			local lab_en = ""
			local lab_de = ""
		}
		use "${export}categories.dta", clear
		replace label_en = "`lab_en'" in `i'
		replace label_de = "`lab_de'" in `i'
		local i = `i' + 1
		save "${export}categories.dta", replace
	}
}

/*
use "${path}example.dta", clear


levelsof bap87, local(levels)
local lab : value label bap87

foreach l of local levels {
    local all `all' `: label `lab' `l''
}

display "`all'"
*/

erase "${export}categories.dta"
export delimited using "${export}categories.csv", replace
