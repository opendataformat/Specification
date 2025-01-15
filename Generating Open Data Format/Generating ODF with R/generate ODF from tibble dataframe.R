############ generate ODF with R

install.packages("opendataformat")

# Load necessary libraries
library(tibble)
library(dplyr)
library(opendataformat)

# Load the dataset (replace "path_to_data.csv" with your file path)
#data <- read.csv("path_to_data.csv", stringsAsFactors = FALSE, encoding = "UTF-8")
data <- read.csv("C:/Users/thartl/OneDrive - DIW Berlin/Open Data Format Project/R/SOEP opendf generations/Testdaten/csv/data.csv", stringsAsFactors = FALSE, encoding = "UTF-8")

# Convert the dataset to a tibble
df <- as_tibble(data)

# ********** Define dataset metadata **********

# Adding dataset metadata
attr(df, "study") <- "soep-core v.X"
attr(df, "dataset") <- "bap"
attr(df, "label_en") <- "Data from individual questionnaires 2010"
attr(df, "label_de") <- "Daten vom Personenfragebogen 2010"




# Adding detailed descriptions for the dataset
attr(df, "description_en") <- "The data were collected as part of the SOEP-Core study using the questionnaire 
         'Living in Germany - Survey 2010 on the social situation - Personal questionnaire for all'. 
         This questionnaire is addressed to the individual persons in the household."
attr(df, "description_de") <- "Die Daten wurden im Rahmen der Studie SOEP-Core mittels des Fragebogens 
         'Leben in Deutschland – Befragung 2010 zur sozialen Lage - Personenfragebogen 
         für alle' erhoben. Dieser Fragebogen richtet sich an die einzelnen Personen im 
         Haushalt."


# Adding the dataset URL
attr(df, "url") <- "https://paneldata.org/soep-core/data/bap"






# ********** Define variable metadata **********

# Define value labels for bap87
labels_en_bap87 <- c(-2, -1, 1, 2, 3, 4, 5)
names(labels_en_bap87) <- c("Does not apply", "No Answer", "Very good", "Good", 
                            "Satisfactory", "Less Good", "Poor")

labels_de_bap87 <- c(-2, -1, 1, 2, 3, 4, 5)
names(labels_de_bap87) <- c("trifft nicht zu", "keine Angabe", "Sehr gut", "Gut", 
                            "Zufriedenstellend", "Weniger gut", "Schlecht")

# Define value labels for bap9201
labels_en_bap9201 <- c(-2, -1)
names(labels_en_bap9201) <- c("Does not apply", "No Answer")

labels_de_bap9201 <- c(-2, -1)
names(labels_de_bap9201) <- c("trifft nicht zu", "keine Angabe")

# Define value labels for bap9001, bap9002, bap9003
labels_en_common <- c(-2, -1, 1, 2, 3, 4, 5)
names(labels_en_common) <- c("Does not apply", "No Answer", "Always", "Often", 
                             "Sometimes", "Almost Never", "Never")

labels_de_common <- c(-2, -1, 1, 2, 3, 4, 5)
names(labels_de_common) <- c("trifft nicht zu", "keine Angabe", "Immer", "Oft", 
                             "Manchmal", "Fast nie", "Nie")

# Define value labels for bap96
labels_en_bap96 <- c(-2, -1)
names(labels_en_bap96) <- c("Does not apply", "No Answer")

labels_de_bap96 <- c(-2, -1)
names(labels_de_bap96) <- c("trifft nicht zu", "keine Angabe")

# Define value labels for name
labels_en_name <- c(-2, -1)
names(labels_en_name) <- c("Does not apply", "No Answer")

labels_de_name <- c(-2, -1)
names(labels_de_name) <- c("trifft nicht zu", "keine Angabe")

# Metadata list for all variables
metadata <- list(
  bap87 = list(
    label_en = "Current Health",
    label_de = "Gesundheitszustand gegenwärtig",
    description_en = "Question: How would you describe your current health?",
    description_de = "Frage: Wie würden Sie Ihren gegenwärtigen Gesundheitszustand beschreiben?",
    labels_en = labels_en_bap87,
    labels_de = labels_de_bap87,
    url = "https://paneldata.org/soep-core/data/bap/bap87",
    type = "numeric"
  ),
  bap9201 = list(
    label_en = "Hours Of Sleep, Normal Workday",
    label_de = "Stunden Schlaf, normaler Werktag",
    description_en = "Sleep hours per weekday",
    description_de = "Schlafstunden pro Wochentag",
    labels_en = labels_en_bap9201,
    labels_de = labels_de_bap9201,
    url = "https://paneldata.org/soep-core/data/bap/bap9201",
    type = "numeric"
  ),
  bap9001 = list(
    label_en = "Pressed For Time Last 4 Weeks",
    label_de = "Eile, Zeitdruck letzten 4 Wochen",
    description_en = "Frequency of feeling time pressure in the past 4 weeks",
    description_de = "Häufigkeit des Gefühls von Zeitdruck in den letzten 4 Wochen",
    labels_en = labels_en_common,
    labels_de = labels_de_common,
    url = "https://paneldata.org/soep-core/data/bap/bap9001",
    type = "numeric"
  ),
  bap9002 = list(
    label_en = "Run-down, Melancholy Last 4 Weeks",
    label_de = "Niedergeschlagen letzten 4 Wochen",
    description_en = "Frequency of feeling a sad and depressed state",
    description_de = "Häufigkeit der Niedergeschlagenheit",
    labels_en = labels_en_common,
    labels_de = labels_de_common,
    url = "https://paneldata.org/soep-core/data/bap/bap9002",
    type = "numeric"
  ),
  bap9003 = list(
    label_en = "Well-balanced Last 4 Weeks",
    label_de = "Ausgeglichen letzten 4 Wochen",
    description_en = "Frequency of feeling balance",
    description_de = "Häufigkeit der Ausgeglichenheit",
    labels_en = labels_en_common,
    labels_de = labels_de_common,
    url = "https://paneldata.org/soep-core/data/bap/bap9003",
    type = "numeric"
  ),
  bap96 = list(
    label_en = "Height",
    label_de = "Körpergröße",
    description_en = "Body size",
    description_de = "Körpergröße",
    labels_en = labels_en_bap96,
    labels_de = labels_de_bap96,
    url = "https://paneldata.org/soep-core/data/bap/bap96",
    type = "numeric"
  ),
  name = list(
    label_en = "First Name",
    label_de = "Vorname",
    description_en = "First name",
    description_de = "Vorname",
    labels_en = labels_en_name,
    labels_de = labels_de_name,
    url = NA,  # No URL provided for this variable
    type = "character"
  )
)

# Assign metadata to columns as attributes
for (var in names(metadata)) {
  if (var %in% colnames(df)) {
    for (meta_name in names(metadata[[var]])) {
      attr(df[[var]], meta_name) <- metadata[[var]][[meta_name]]
    }
  }
}

# convert to ODF tibble
df <- as_odf_tbl(df)

write_odf(df, "odf_dataset.zip")
