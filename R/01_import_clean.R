# ==============================================================================
# Card & Krueger (1994) Replication
# 01_import_clean.R: import survey data, name variables, check against codebook,
#                     create variables, save
# ==============================================================================

# 1. Load Packages -------------------------------------------------------------
library(tidyverse)

# Check project working directory 
getwd()

# 2. Import the original NJ-PA survey data -------------------------------------
raw_data <- read.table(
  "data/raw/public.dat",
  header = FALSE,
  na.strings = "."
)

dim(raw_data)  #should be printing 410 46

# 3. Assign variable names from the original codebook (in order) ---------------
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


# 4. Error checks --------------------------------------------------------------
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


# 5. Construct analysis variables ----------------------------------------------

clean_data <- raw_data|>
  mutate(
    
    # --------------------------------------------------------------------------
    # a. Employment measures 
    # --------------------------------------------------------------------------
    
    # Full-time equivalent employment, Wave 1
    FTE = EMPFT + 0.5 * EMPPT + NMGRS,
    
    # Full-time equivalent employment, Wave 2
    # Permanently closed stores are treated as having zero employment
    FTE2 = if_else(
      STATUS2 == 3,
      0,
      EMPFT2 + 0.5 * EMPPT2 + NMGRS2
    ),
    
    # Change in FTE employment
    DEMP = FTE2 - FTE,
    
    # Proportional change in employment 
    # Authors set this equal  to -1 when Wave 2 employment is zero
    PCHEMPC = case_when(
      is.na(FTE) | is.na(FTE2) ~ NA_real_,
      FTE2 == 0 ~ -1,
      TRUE ~ 2 * (DEMP) / (FTE2 + FTE)
    ), 
    
    # Full-time share of FTE employment 
    FRACFT = if_else(
      !is.na(FTE) & FTE > 0,
      EMPFT / FTE,
      NA_real_
    ),
    
    FRACFT2 = if_else(
      !is.na(FTE2) & FTE2 > 0,
      EMPFT2 / FTE2,
      NA_real_
    ),
    
    # Change in full-time share
    DFRACFT = FRACFT2 - FRACFT,
    
    
    # --------------------------------------------------------------------------
    # b. Treatment and minimum-wage exposure
    # --------------------------------------------------------------------------
    
    # New Jersey treatment indicator
    # STATE is already coded 1 = NJ, 0 = PA
    NJ = STATE,
    
    # Store initially paying the old $4.25 minimum wage
    ATMIN = as.integer(WAGE_ST == 4.25),
    
    # Store paying exactly the new $5.05 NJ minimum wage in Wave 2
    NEWMIN = as.integer(WAGE_ST2 == 5.05),
    
    # Initial wage gap
    # PA stores have no exposure to the NJ minimum-wage increase
    # NJ stores already paying >= $5.05 also have GAP = 0
    GAP = case_when(
      NJ == 0 ~ 0,
      is.na(WAGE_ST) | WAGE_ST <= 0 ~ NA_real_,
      WAGE_ST >= 5.05 ~ 0,
      TRUE ~ (5.05 - WAGE_ST) / WAGE_ST
    ),
    
    
    # --------------------------------------------------------------------------
    # c. Wage changes 
    # --------------------------------------------------------------------------
    
    # Absolute change in starting wage
    DWAGE = WAGE_ST2 - WAGE_ST,
    
    # Proportional change in starting wage
    PCHWAGE = case_when(
      is.na(WAGE_ST) | is.na(WAGE_ST2) | WAGE_ST <= 0 ~ NA_real_,
      TRUE ~ (WAGE_ST2 - WAGE_ST) / WAGE_ST
    ),
    
    
    # --------------------------------------------------------------------------
    # d. Chain indicators
    # --------------------------------------------------------------------------
    
    BK     = as.integer(CHAIN == 1),
    KFC    = as.integer(CHAIN == 2),
    ROYS   = as.integer(CHAIN == 3),
    WENDYS = as.integer(CHAIN == 4),
    
    
    # --------------------------------------------------------------------------
    # e. Meal-price measures
    # --------------------------------------------------------------------------
    
    # Price of a standard meal, Wave 1
    PMEAL = PSODA + PFRY + PENTREE,
    
    # Price of a standard meal, Wave 2
    PMEAL2 = PSODA2 + PFRY2 + PENTREE2,
    
    # Change in meal price
    DPMEAL = PMEAL2 - PMEAL,
    
    
    # --------------------------------------------------------------------------
    # f. Closure indicators
    # --------------------------------------------------------------------------
    
    # Permanently closed by Wave 2
    CLOSED = as.integer(STATUS2 == 3),
    
    # Temporarily closed in Wave 2:
    # 2 = renovation
    # 4 = highway construction
    # 5 = mall fire
    TEMP_CLOSED = as.integer(STATUS2 %in% c(2, 4, 5)),
    
    
    # --------------------------------------------------------------------------
    # g. Table 3 employment variants / simple indicators
    # --------------------------------------------------------------------------
    
    # Balanced employment sample:
    # employment observed in both waves
    BALANCED_EMP = as.integer(
      !is.na(FTE) & !is.na(FTE2)
    ),
    
    # Table 3 robustness measure:
    # also treat temporarily closed stores as having zero Wave-2 employment
    FTE2_TEMPO = case_when(
      STATUS2 %in% c(2, 4, 5) ~ 0,
      TRUE ~ FTE2
    ),
    
    DEMP_TEMPO = FTE2_TEMPO - FTE,
    
    
    # --------------------------------------------------------------------------
    # h. Initial-wage groups used in Table 3
    # --------------------------------------------------------------------------
    
    WAGE_GROUP = case_when(
      NJ == 0 ~ "PA",
      NJ == 1 & WAGE_ST == 4.25 ~ "NJ: $4.25",
      NJ == 1 & WAGE_ST > 4.25 & WAGE_ST < 5.00 ~ "NJ: $4.26-$4.99",
      NJ == 1 & WAGE_ST >= 5.00 ~ "NJ: >=$5.00",
      TRUE ~ NA_character_
    ),
    
    # --------------------------------------------------------------------------
    # i. Table 4 regression sample
    # --------------------------------------------------------------------------
    
    # Include stores with an observed employment change and:
    #   - permanently closed stores, OR
    #   - non-permanently-closed stores with an observed wage change
    C1 = as.integer(
      !is.na(DEMP) &
        (
          CLOSED == 1 |
            (CLOSED == 0 & !is.na(DWAGE))
        )
    )
    
    )

# 6. Check constructed variables -----------------------------------------------

# Treatment indicator should reproduce original state coding
stopifnot(all(clean_data$NJ == clean_data$STATE))

# Six stores permanently closed
stopifnot(sum(clean_data$CLOSED, na.rm = TRUE) == 6)

# Four stores temporarily closed 
stopifnot(sum(clean_data$TEMP_CLOSED, na.rm = TRUE) == 4)

# Chain dummies should sum to one for every store
stopifnot(
  all(
    clean_data$BK +
      clean_data$KFC +
      clean_data$ROYS +
      clean_data$WENDYS == 1
  )
)

# Inspect important constructed variables
summary(
  clean_data |>
    select(
      FTE, FTE2, DEMP, PCHEMPC,
      WAGE_ST, WAGE_ST2, DWAGE, GAP,
      PMEAL, PMEAL2, DPMEAL
    )
)

table(clean_data$WAGE_GROUP, useNA = "ifany")
table(clean_data$STATUS2, clean_data$CLOSED)

# 7. Save ---------------------------------------------------------------------
dir.create(
  "data/clean",
  showWarnings = FALSE,
  recursive = TRUE
)

saveRDS(
  clean_data,
  "data/clean/ck_clean.rds"
)
