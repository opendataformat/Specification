Open Data Format: Profile
================

-   [Introduction](#introduction)
-   [Explanation](#explanation)
    -   [Mandatory Constraint](#mandatory-constraint)
    -   [Optional Constraint](#optional-constraint)
    -   [Mandatory if parent element is present
        Constraint](#mandatory-if-parent-element-is-present-constraint)
-   [Complete Profile View](#complete-profile-view)

Author: Xiaoyao Han, Claudia Saalbach, Knut Wenzig  
Affiliation: DIW Berlin  
Created: 2022-03-01  
Version: v1.0.0  
Last modified: 2022-04-29 Claudia Saalbach  
Licence: This repository is issued under a CC by licence
(<https://creativecommons.org/licenses/by/4.0/>)

------------------------------------------------------------------------

# Introduction

The Open Data Format (ODF) profile gives an overview of the metadata 
elements’ and attributes’ semantic definition and constraints. The 
documentation of the metadata specification is the basis for the 
internal programming work of the project. It is also necessary 
concerning interoperability. For example, external developers
may want to adapt the metadata specification developed here for their
projects. Besides the documentary function, a profile is a handy tool
for validating a metadata file. Data producers can check upfront whether
their data product will work with the technical solutions developed in
this project. For example, if you create an XML metadata file in the
ODF-specification yourself, you can validate it. For this purpose you can
use the [XML profile](profile.xml) from this repository and upload it,
together with your XML metadata file (e. g., from the
[example](../example/metadata.xml) folder) to the website of the [CESSDA
Metadata Validator](https://cmv.cessda.eu/#!validation).

The metadata component of the Open Data Format follows the DDI-Codebook
2.5 schema. As mentioned on the [DDI Alliance
website](https://ddialliance.org/learn/resources/ddi-profiles), “DDI is
a very flexible and complex standard that may be used by various
projects or organizations in ‘customized’ ways that best answer specific
needs. DDI profiles allow different agents or agencies to specify
exactly how they use the DDI XML format, and thus help achieve seamless
transfer and interoperability of DDI instances. A DDI profile describes
the subset of valid DDI objects used by an agency for a specified
purpose. This is documented in a DDI-XML format, which allows a set of
declarations to be made, identifying specific fields in the DDI which
are ‘Used’ or ‘Not Used’. Various other qualifications can be made to
restrict or default permitted values for specific elements, and
human-readable documentation can be added” (Source:
<https://ddialliance.org/learn/resources/ddi-profiles>).

The template for the development and documentation of the
Open Data Format profile is the DDI-Codebook
2.5 schema. The description text is mostly taken from the “Linked Field-Level
documentation” of the DDI-Codebook 2.5 schema
(<https://ddialliance.org/Specification/DDI-Codebook/2.5/>). Some text
passages we have adapted or supplemented and made the changes notable by
marking them with the characters &lt;*modyfied text*&gt;.

# Explanation

The ODF profile holds a set of constrains that use Xpath
syntax to define the usage of elements and attributes. The Xpath syntax
uses a path notation, like those used in URLs, for addressing parts of
an XML document. There are three types of constrains for the usage of
the nodes: `mandatory`, `optional`, and
`mandatory if parent element is present`.

Using some examples, we explain the implementation of the three
constraints within the XML profile file, which is necessary for
validating the actual XML file that stores the dataset’s metadata
component. For a complete human-readable view of the profile, skip to
the section [Overview](#overview) or take a look at the [XML profile CSV
file](profile_view.csv). The XML file of the ODF metadata
profile, you can find under [profile.xml](profile.xml) in this
directory.

## Mandatory Constraint

The function of the `var` node is to hold multiple pieces of information
describing a variable at different hierarchical levels. Since a dataset
without variables is not a dataset by definition, it makes sense that
the `var` node is a mandatory element of the Open Data Format
metadata specification.

|     | element.label | element.description                                                                            | xml file                | xml\_classification |
|:----|:--------------|:-----------------------------------------------------------------------------------------------|:------------------------|:--------------------|
| 19  | variable      | This element describes all of the features of a single variable in a social science data file. | //codeBook/dataDscr/var | mandatory           |

Table 1: Example for an mandatory constraint within the ODF Profile.

``` xml
    <pr:Used xpath="/codeBook/dataDscr/var" isRequired="true">
        <r:Description>
            <r:Content>Required: Mandatory</r:Content>
            <r:Content>ElementType: Content element</r:Content>                             
            <r:Content>Usage: This element describes all of the features of a single variable in a 
            social science data file. 
            </r:Content>            
        </r:Description>
    </pr:Used>  
```

Code 1: Respective XML Code for the example presented in Table 1.

<!-- -------------------- -->

## Optional Constraint

The metadata specification of the External\_OpenDF allows providing a
lengthier description of a variable that goes beyond the variable label.
Since an extended variable description may not always be necessary, the
profile declares the Xpath `//codeBook/dataDscr/var/txt` optional.

|     | element.label        | element.description                    | xml file                    | xml\_classification |
|:----|:---------------------|:---------------------------------------|:----------------------------|:--------------------|
| 23  | variable description | Lengthier description of the variable. | //codeBook/dataDscr/var/txt | optional            |

Table 2: Example for an optional constraint within the External\_OpenDF
Profile.

``` xml
    <pr:Used xpath="/codeBook/dataDscr/var/txt" isRequired="false">
        <r:Description>
            <r:Content>Required: Optional</r:Content>
            <r:Content>ElementType: Content element</r:Content>         
            <r:Content>Usage: Lengthier description of the parent variable.</r:Content>         
        </r:Description>
    </pr:Used>  
```

Code 2: Respective XML Code for the example presented in Table 2.

<!-- -------------------- -->

## Mandatory if parent element is present Constraint

The metadata specification of the External Open Data Format supports
multi-lingual labels and descriptions for several dataset elements like
variables or values, which makes it necessary to declare the language of
the text element using the attribute `@xml:lang`. For example, if a
variable description exists (even if it is optional), the declaration of
the language is mandatory.

|     | element.label | element.description                                                                                                                    | external\_xml                            | xml file                        |
|:----|:--------------|:---------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------|:--------------------------------------|
| 24  | language tag  | Attribute to specify the language of the <variable description>. &lt;Use ISO-639-1-Code for language subtags, e.g. en for English.&gt; | //codeBook/dataDscr/var/txt\[@xml:lang\] | mandatory if ‘txt’ element is present |

Table 3: Example for an “mandotory if parent element is present”
constraint within the External\_OpenDF Profile.

``` xml
    <pr:Used xpath="/codeBook/dataDscr/var/txt/@xml:lang" isRequired="false">
        <r:Description>
            <r:Content>Required: Mandatory if 'txt' element is present.</r:Content>
            <r:Content>ElementType: Attribute element</r:Content>
            <r:Content>Usage: Attribute to specify the language of the variable description>. Use ISO-639-1-Code for language subtags, e.g. en for English.</r:Content>         
        </r:Description>
        <pr:Instructions>
            <r:Content>
                <![CDATA[<Constraints><MandatoryNodeIfParentPresentConstraint/></Constraints>]]>
            </r:Content>
        </pr:Instructions>  
    </pr:Used>  
```

Code 3: Respective XML Code for the example presented in Table 3.

<!-- -------------------- -->

# Complete Profile View

| element.label        | element.description                                                                                                                                                                                                                                                                                                                       | xml file                                                            | xml\_classification                         |
|:---------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------|:--------------------------------------------|
|                      |                                                                                                                                                                                                                                                                                                                                           | /codeBook                                                           | mandatory                                   |
|                      | The top-level element, codeBook, also includes a version attribute to specify the version number of the DDI specification.                                                                                                                                                                                                                | //codeBook\[@version\]                                              | mandatory                                   |
|                      |                                                                                                                                                                                                                                                                                                                                           | //codeBook\[@xmlns\]                                                | mandatory                                   |
|                      |                                                                                                                                                                                                                                                                                                                                           | //codeBook\[@xmlns:xsi\]                                            | mandatory                                   |
|                      |                                                                                                                                                                                                                                                                                                                                           | //codeBook\[@xsi:schemaLocation\]                                   | mandatory                                   |
| study              | Information about the data collection, study, or compilation                                                                                                                                                                                                                                                                           | //codeBook/stdyDscr                                                 | mandatory                                   |
|                      | Provides bibliographic information for the work.                                                                                                                                                                                                                                                                                      | //codeBook/stdyDscr/citation                                         | mandatory                                   |
|                      | Provides title statement for the work.                                                                                                                                                                                                                                                                                     | //codeBook/stdyDscr/citation/titlStmt                                         | mandatory                                   |
|study title                    | Study title                                                                                                                                                                                                                                                                                     | //codeBook/stdyDscr/citation/titlStmt/titl                                         | mandatory                                   |
| language tag                 | Attribute to specify the language of the \<study tile. <Use ISO-639-1-Code for language subtags, e.g. en for English.>                                                                                                                                                                                                                                                                                     | //codeBook/stdyDscr/citation/titlStmt/titl\[@xml:lang\]                                      | optional                                   |
|parallel study title                    | Title translated into another language.                                                                                                                                                                                                                                                                                    | //codeBook/stdyDscr/citation/titlStmt/parTitl                                         | optional                                   |
| language tag                 | Attribute to specify the language of the study title. <Use ISO-639-1-Code for language subtags, e.g. en for English.>                                                                                                                                                                                                                                                                                     | //codeBook/stdyDscr/citation/titlStmt/parTitl\[@xml:lang\]                                      | optional                                   |
| dataset              | Information about the data file(s) that comprises a collection.                                                                                                                                                                                                                                                                           | //codeBook/fileDscr                                                 | mandatory                                   |
|                      | Provides descriptive information about the data file.                                                                                                                                                                                                                                                                                     | //codeBook/fileDscr/fileTxt                                         | mandatory                                   |
| dataset name         | Contains a short title that will be used to distinguish a particular file/part from other files/parts in the data collection.                                                                                                                                                                                                             | //codeBook/fileDscr/fileTxt/fileName                                | mandatory                                   |
|                      | The complex element fileCitation provides for a full bibliographic citation option for each data file described in fileDscr. To support accurate citation of a data file the minimum element set includes: titl, IDNo, authEnty, producer, and prodDate.                                                                                  | //codeBook/fileDscr/fileTxt/fileCitation                            | optional                                    |
|                      | Title statement for the work.                                                                                                                                                                                                                                                                                                             | //codeBook/fileDscr/fileTxt/fileCitation/titlStmt                   | optional                                    |
| dataset label        | Full authoritative title for the work (…) A full title should indicate the geographic scope of the data collection as well as the time period covered.                                                                                                                                                                                    | //codeBook/fileDscr/fileTxt/fileCitation/titlStmt/titl              | optional                                    |
| language tag         | Attribute to specify the language of the <dataset label>. &lt;Use ISO-639-1-Code for language subtags, e.g. en for English.&gt;                                                                                                                                                                                                           | //codeBook/fileDscr/fileTxt/fileCitation/titlStmt/titl\[@xml:lang\] | mandatory if ‚titl‘ element is present      |
| parallel dataset label        | Title translated into another language.                                                                                                                                                                                    | //codeBook/fileDscr/fileTxt/fileCitation/titlStmt/parTitl              | optional                                    |
| language tag         | Attribute to specify the language of the <dataset label>. &lt;Use ISO-639-1-Code for language subtags, e.g. en for English.&gt;                                                                                                                                                                                                           | //codeBook/fileDscr/fileTxt/fileCitation/titlStmt/parTitl\[@xml:lang\] | mandatory if ‚parTitl‘ element is present      |
| dataset description  | Abstract or description of the file. A summary describing the purpose, nature, and scope of the data file, special characteristics of its contents, major subject areas covered, and what questions the PIs attempted to answer when they created the file.                                                                               | //codeBook/fileDscr/fileTxt/fileCont                                | optional                                    |
| language tag         | Attribute to specify the language of the <dataset description>. &lt;Use ISO-639-1-Code for language subtags, e.g. en for English.&gt;                                                                                                                                                                                                     | //codeBook/fileDscr/fileTxt/fileCont\[@xml:lang\]                   | mandatory if ‘fileCont’ element is present  |
|                      | For clarifying information/annotation regarding the <dataset>.                                                                                                                                                                                                                                                                            | //codeBook/fileDscr/fileTxt/notes                                   | optional                                    |
|                      | This element permits encoders to provide links from any arbitrary element containing ExtLink as a subelement to electronic resources outside the codebook.                                                                                                                                                                                | //codeBook/fileDscr/fileTxt/notes/ExtLink                           | optional                                    |
| dataset url          | Attribute to provide an URL for more detailed information on the dataset.                                                                                                                                                                                                                                                                 | //codeBook/fileDscr/fileTxt/notes/ExtLink\[@URI\]                   | mandatory if ‘ExtLink’ element is present   |
| variables            | Description of variables.                                                                                                                                                                                                                                                                                                                 | //codeBook/dataDscr                                                 | mandatory                                   |
| variable             | This element describes all of the features of a single variable in a social science data file.                                                                                                                                                                                                                                            | //codeBook/dataDscr/var                                             | mandatory                                   |
| variable name        | The attribute “name” usually contains the so-called “short label” for the variable, limited to eight characters in many statistical analysis systems such as SAS or SPSS.                                                                                                                                                                 | //codeBook/dataDscr/var\[@name\]                                    | mandatory if ‚var‘ element is present       |
| variable label       | A short description of the variable. In the variable label, the length of this phrase may depend on the statistical analysis system used (e.g., some versions of SAS permit 40-character labels, while some versions of SPSS permit 120 characters), although the DDI itself imposes no restrictions on the number of characters allowed. | //codeBook/dataDscr/var/labl                                        | optional                                    |
| language tag         | Attribute to specify the language of the <variable label>. &lt;Use ISO-639-1-Code for language subtags, e.g. en for English.&gt;                                                                                                                                                                                                          | //codeBook/dataDscr/var/labl\[@xml:lang\]                           | mandatory if ‚labl‘ element is present      |
| variable description | Lengthier description of the variable.                                                                                                                                                                                                                                                                                                    | //codeBook/dataDscr/var/txt                                         | optional                                    |
| language tag         | Attribute to specify the language of the <variable description>. &lt;Use ISO-639-1-Code for language subtags, e.g. en for English.&gt;                                                                                                                                                                                                    | //codeBook/dataDscr/var/txt\[@xml:lang\]                            | mandatory if ‘txt’ element is present       |
| category             | A description of a particular response.                                                                                                                                                                                                                                                                                                   | //codeBook/dataDscr/var/catgry                                      | optional                                    |
| category values      | The explicit response.                                                                                                                                                                                                                                                                                                                    | //codeBook/dataDscr/var/catgry/catValue                             | mandatory if ‘catgry’ element is present    |
| category labels      | A short description of the <category values>.                                                                                                                                                                                                                                                                                             | //codeBook/dataDscr/var/catgry/labl                                 | optional                                    |
| language tag         | Attribute to specify the language of the <category labels>. &lt;Use ISO-639-1-Code for language subtags, e.g. en for English.&gt;                                                                                                                                                                                                         | //codeBook/dataDscr/var/catgry/labl\[@xml:lang\]                    | mandatory if ‘labl’ element is present      |
|                      | The technical format of the variable in question.                                                                                                                                                                                                                                                                                         | //codeBook/dataDscr/var/varFormat                                   | optional                                    |
| variable type        | Attributes for this element include: “type,” which indicates if the variable is character or numeric;                                                                                                                                                                                                                                     | //codeBook/dataDscr/var/varFormat\[@type\]                          | mandatory if ‚varFormat‘ element is present |
|                      | For clarifying information/annotation regarding the <variable>.                                                                                                                                                                                                                                                                           | //codeBook/dataDscr/var/notes                                       | optional                                    |
|                      | This element permits encoders to provide links from any arbitrary element containing ExtLink as a subelement to electronic resources outside the codebook.                                                                                                                                                                                | //codeBook/dataDscr/var/notes/ExtLink                               | optional                                    |
| variable url         | Attribute to provide an URL for more detailed information on the variable.                                                                                                                                                                                                                                                                | //codeBook/dataDscr/var/notes/ExtLink\[@URI\]                       | mandatory if ‘ExtLink’ element is present   |

