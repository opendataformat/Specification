External Open Data Format (External\_OpenDF)
================

-   [Data](#data)
    -   [Organization](#organization)
        -   [File Format](#file-format)
        -   [Structure](#structure)
        -   [Variable Types](#variable-types)
-   [Metadata](#metadata)
    -   [Organization](#organization-1)
        -   [File Format](#file-format-1)
        -   [Structure](#structure-1)
        -   [Validation](#validation)
-   [Multilingual Feature](#multilingual-feature)

Author: Xiaoyao Han, Claudia Saalbach, Knut Wenzig  
Affiliation: DIW Berlin  
Created: 2022-03-01  
Version: v1.0.0  
Last modified: 2022-05-01 Claudia Saalbach  
Licence: This repository is issued under a CC by licence
(<https://creativecommons.org/licenses/by/4.0/>)

------------------------------------------------------------------------

The External Open Data Format (External\_OpenDF) is intended to be a zip
file that contains the raw data as a CSV file and the metadata as a XML
file. The metadata specification of the External-OpenDF is based on the
[DDI-Codebook 2.5
schema](https://ddialliance.org/Specification/DDI-Codebook/2.5/). Since
the External\_OpenDF holds a data and a metadata component, this
document describes the specification in two main sections: [Data](#data)
and [Metadata](#metadata). First, there will be information about how
the data and the metadata component are organized by describing the used
file format, structure, and variable types. The last section describes
how the External\_OpenDF implements the [Multilingual
Feature](#multilingual-feature) regarding label and description
attributes, e.g. for providing information on variables or the dataset.

To make it easier to follow the specification of the External\_OpenDF,
take a look at the (meta)data [example](example). There you will find a
CSV file holding the raw data and XML file including the metadata. A
README guides you through the example.

# Data

## Organization

### File Format

The External\_OpenDF stores the data in a comma-separated values file.
CSV files are both human- and machine-readable. For opening a CSV file a
simple text editor or a conventional spreadsheet program is enough. The
following example shows the first five rows of the example data set
[data.csv](example/data.csv) once in the view of a text editor and once
in the view of a table program.

    bap87,bap9201,bap9001,bap9002,bap9003,bap96,name
    4,-2,1,-1,2,-2,Jakob
    3,5,-2,1,4,1.57,Luca
    ,-1,-1,2,-1,1.92,Emilia
    1,9,-2,2,4,1.85,Charlotte

Code 1: First rows of the data.csv file in a text editor view.

| bap87 | bap9201 | bap9001 | bap9002 | bap9003 | bap96 | name      |
|:------|:--------|:--------|:--------|:--------|:------|:----------|
| 4     | -2      | 1       | -1      | 2       | -2    | Jakob     |
| 3     | 5       | -2      | 1       | 4       | 1.57  | Luca      |
|       | -1      | -1      | 2       | -1      | 1.92  | Emilia    |
| 1     | 9       | -2      | 2       | 4       | 1.85  | Charlotte |

Table 1: First rows of the data.csv file in a spreadsheet program view

### Structure

The data structure within the CSV file needs to be “tidy” that is, one
variable forms a column, and one observation forms a row (see [Wickham,
2014](https://www.jstatsoft.org/article/view/v059i10)). For automatic
processing of the dataset, the file name of the raw data set cannot be
flexible and must always be `data.csv`. However, the column names can
differ since the columns within the data.csv file are the variable
names.

### Variable Types

The raw data can only contain numeric and character variables. However,
in some disciplines, especially in the social sciences, one variables
can hold both, numeric and character values. For example, so-called
categorical variables can contain numeric values assigned to predefined
descriptive categories (character) or vice versa. To deal with
categorical variables metadata is required.

<!-- ------------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------------- -->

# Metadata

## Organization

The External\_OpenDF organizes the metadata in one XML file by using
different tags for structuring the dataset, variable, and value level.

-   Metadata describing the dataset itself is contained in the
    `<fileDscr>` tag.
-   Metadata describing a variable of the dataset is hold by the `<var>`
    tag.
-   Metadata describing the categories of a variable is included within
    the `<catgry>` tag that is a sub-tag of the `<var>` tag. are stored
    in the categories.csv file.

Code 2 provides a view on how metadata describing a dataset is organized
within a XML file following the specification of the External\_OpenDF.

``` xml
    <fileDscr>
        <fileTxt>
            <fileName>bap</fileName>
            <fileCont xml:lang="en">The data were collected as part of the SOEP-Core study using the questionnaire "Living in Germany - Survey 2010 on the social situation - Personal questionnaire for all. This questionnaire is addressed to the individual persons in the household. A view of the survey instrument can be found here: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf</fileCont>
            <fileCont xml:lang="de">Die Daten wurden im Rahmen der Studie SOEP-Core mittels des Fragebogens „Leben in Deutschland – Befragung 2010 zur sozialen Lage - Personenfragebogen für alle“ erhoben. Dieser Fragebogen richtet sich an die einzelnen Personen im Haushalt. Eine Ansicht des Erhebungsinstrumentes finden Sie hier: https://www.diw.de/documents/dokumentenarchiv/17/diw_01.c.369781.de/soepfrabo_personen_2010.pdf</fileCont>
            <fileCitation>
                <titlStmt>
                    <titl xml:lang="en">Data from individual questionnaires 2010</titl>
                    <titl xml:lang="de">Daten vom Personenfragebogen 2010</titl>
                </titlStmt>
            </fileCitation>
        </fileTxt>   
        <notes>
            <ExtLink URI="https://paneldata.org/soep-core/data/bap"/>   
        </notes>   
    </fileDscr>
```

Code 2: XML code for providing metadata at the dataset level.

The `<fileDscr>` tag for describing the dataset holds several sub-tags:

-   dataset name (tag: `<fileName>`)
-   dataset label (tag: `<titl>`)
-   dataset description (tag: `<fileCont>`)
-   dataset url (tag: `<ExtLink URI="">`)

Code 3 provides a view on how metadata describing a variable is
organized within a XML file following the specification of the
External\_OpenDF.

``` xml
<var name="bap87">
            <labl xml:lang="en">Current Health</labl>
            <labl xml:lang="de">Gesundheitszustand gegenwärtig</labl>
            <txt xml:lang="en">Question: How would you describe your current health?</txt>
            <txt xml:lang="de">Frage: Wie würden Sie Ihren gegenwärtigen Gesundheitszustand beschreiben?</txt>
            <notes>
                <ExtLink URI="https://paneldata.org/soep-core/data/bap/bap87"/>
            </notes>        
            <varFormat type="numeric"/>
            <catgry>
                <catValu>-1</catValu>
                <labl xml:lang="en">No Answer</labl>
                <labl xml:lang="de">keine Angabe</labl>         
            </catgry>
            <catgry>
                <catValu>1</catValu>
                <labl xml:lang="en">Very good</labl>
                <labl xml:lang="de">Sehr gut</labl>         
            </catgry>
            <catgry>
                <catValu>2</catValu>
                <labl xml:lang="en">Good</labl>
                <labl xml:lang="de">Gut</labl>          
            </catgry>           
...
        </var>  
```

Code 3: XML code for providing metadata at the variable level.

The `<var>` tag for describing a variable holds the following sub-tags:

-   variable name (tag: `<var name="">`)
-   variable label (tag: `<labl>`)
-   variable description (tag: `<txt>`)
-   variable url (tag: `<ExtLink URI="">`)
-   variable type (tag: `<varFormat type="">`)
-   variable category (tag: `<catgry>`) includes several sub-tags for
    describing the
    -   variable value (tag: `<catValu>`), and the
    -   value label (`<labl>`).

If you are interested in the complete XPaths take a look at the [profile
view](profile/profile_view.csv).

|     | element.label | element.description                                                                                                                                                       | external\_xml                    | xml\_classification                   |
|:----|:--------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------|:--------------------------------------|
| 19  | variable      | This element describes all of the features of a single variable in a social science data file.                                                                            | //codeBook/dataDscr/var          | mandatory                             |
| 20  | variable name | The attribute “name” usually contains the so-called “short label” for the variable, limited to eight characters in many statistical analysis systems such as SAS or SPSS. | //codeBook/dataDscr/var\[@name\] | mandatory if ‚var‘ element is present |

Table 2: Preview of the metadata profile specified for the
External\_OpenDF.

### File Format

The External\_OpenDF consolidates the metadata into a single XML file.

### Structure

The metadata XML file organizes the metadata’s elements and attributes
hierarchically yet contently identical to those stated in the
specification of the [Internal Open Data Format](../internal) and
mutually mappable. The basis for the specification of External\_OpenDF’s
metadata components is the [DDI Codebook 2.5
Schema](https://ddialliance.org/Specification/DDICodebook/2.5/XMLSchema/field_level_documentation.html).

### Validation

If you create an XML metadata file in the External\_OpenDF format
yourself you can validate it. For this purpose you can use the [XML
profile](profile/profile.xml) from this repository and upload it,
together with your [XML metadata file](example/metadata.xml) (e. g.,
from the [example](example) folder) to the website of the [CESSDA
Metadata Validator](https://cmv.cessda.eu/#!validation). Fore more
information about the profile from this specification, take a look at
the [profile](profile) folder.

# Multilingual Feature

The External\_OpenDF allows multilingual labels and descriptions by
using the `xml:lang` attribute (for more information see the [W3C
documentation](https://www.w3.org/International/questions/qa-when-xmllang)).
This attribute holds the language code defined by the ISO 639-1
(<https://de.wikipedia.org/wiki/Liste_der_ISO-639-1-Codes>). For
example, if a label is specified in English and in German, there will be
both a XML line `<labl xml:lang="en">Current Health</labl>` declaring
the English Version of the label and a XML line declaring the German
version `<labl xml:lang="de">Gesundheitszustand gegenwärtig</labl>`. In
this way, labels and descriptions can be specified in a variety of
languages. The XML file expands in length.
