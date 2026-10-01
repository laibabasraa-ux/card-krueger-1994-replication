# ==============================================================================
# Card & Krueger (1994) Replication
# 01_import_clean.R: import survey data, name variables, check against codebook,
#                     create variables, save
# ==============================================================================

# Load Packages ----------------------------------------------------------------
library(tidyverse)

# Check project working directory 
getwd()

# Step 1: Import the original NJ-PA survey data --------------------------------
raw_data <- read.table(
  "data/raw/public.dat",
  header = FALSE,
  na.strings = "."
)

dim(raw_data)  #should be printing 410 46

# Assign variable names from the original cookbook (in order) ------------------
var_names <- c(
  "SHEET", "CHAIN", "CO_OWNED", "STATE", "SOUTHJ", "CENTRALJ", "NORTHJ", "PA1",
  "PA2", "SHORE", "NCALLS", "EMPFT", "EMPPT", "NMGRS", "WAGE_ST", "INCTIME",
  "FIRSTINC", "BONUS", "PCTAFF", "MEALS", "OPEN", "HRSOPEN", "PSODA", "PFRY",
  "PENTREE", "NREGS", "NREGS11", "TYPE2", "STATUS2", "DATE2", "NCALLS2", "EMPFT2",
  "EMPPT2", "NMGRS2", "WAGE_ST2", "INCTIME2", "FIRSTIN2", "SPECIAL2", "MEALS2",
  "OPEN2R", "HRSOPEN2", "PSODA2", "PFRY2", "PENTREE2", "NREGS2", "NREGS112"
)

stopifnot(length(var_names) == ncol(raw_data)) #one name per column
colnames(raw_data) <- var_names                # assign names to data


# Error checks -----------------------------------------------------------------
# Coded variables only take valid codes
stopifnot(all(raw_data$STATE %in% c(0, 1)),    # 0 = PA, 1 = NJ
          all(raw_data$CHAIN %in% 1:4),        # 1 BK, 2 KFC, 3 Roy Rogers, 4 Wendy's
          all(raw_data$STATUS2 %in% 0:5))

# Sample sizes match paper: 331 NJ, 79 PA
stopifnot(sum(raw_data$STATE == 1) == 331,
          sum(raw_data$STATE == 0) == 79)

# Each store is in exactly one region
region_vars <- c("SOUTHJ", "CENTRALJ", "NORTHJ", "PA1", "PA2")
stopifnot(all(rowSums(raw_data[, region_vars]) == 1))

# No fully duplicated rows
## Note: one SHEET ID appears twice, but rows are different stores (keep both)
stopifnot(sum(duplicated(raw_data)) == 0)


## 5) Create variables ---------------------------------------------------------
clean_data <- raw_data |>
  mutate(FTE  = EMPFT  + 0.5 * EMPPT  + NMGRS,  # full-time equivalent, wave 1
         FTE2 = EMPFT2 + 0.5 * EMPPT2 + NMGRS2) # full-time equivalent, wave 2


## 6) Save ---------------------------------------------------------------------
dir.create("data/clean", showWarnings = FALSE, recursive = TRUE) 
saveRDS(clean_data, "data/clean/ck_clean.rds")
