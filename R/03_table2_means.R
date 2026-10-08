# ==============================================================================
# Card & Krueger (1994) Replication 
# 03_table2_means.R: Table 2 - Means of Key Variables
# ==============================================================================

# 1. Load Packages -------------------------------------------------------------
library(tidyverse)

# 2. Load cleaned data --------------------------------------------------------
clean_data <- readRDS("data/clean/ck_clean.rds")

# 3. Check expected sample size 
stopifnot(nrow(clean_data) == 410)

# 4. Table 2 -------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Panel 1: Distribution of store types 
# ------------------------------------------------------------------------------

# Burger King percentage 
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_BK = mean(BK, na.rm = TRUE) * 100,
    se_BK = sd(BK, na.rm = TRUE) /
      sqrt(sum(!is.na(BK))) * 100
  )

# KFC percentage 
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_KFC = mean(KFC, na.rm = TRUE) * 100,
    se_KFC = sd(KFC, na.rm = TRUE) /
      sqrt(sum(!is.na(KFC))) * 100
  )

# Roy Rogers percentage 
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_ROYS = mean(ROYS, na.rm = TRUE) * 100,
    se_ROYS = sd(ROYS, na.rm = TRUE) /
      sqrt(sum(!is.na(ROYS))) * 100
  )

# Wendy's percentage 
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_WENDYS = mean(WENDYS, na.rm = TRUE) * 100,
    se_WENDYS = sd(WENDYS, na.rm = TRUE) /
      sqrt(sum(!is.na(WENDYS))) * 100
  )

# Company owned percentage
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_CO_OWNED = mean(CO_OWNED, na.rm = TRUE) * 100,
    se_CO_OWNED = sd(CO_OWNED, na.rm = TRUE) /
      sqrt(sum(!is.na(CO_OWNED))) * 100
  )

# ------------------------------------------------------------------------------
# Panel 2: Wave 1
# ------------------------------------------------------------------------------

# FTE employment 
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_FTE = mean(FTE, na.rm = TRUE),
    se_FTE = sd(FTE, na.rm = TRUE) /
      sqrt(sum(!is.na(FTE)))
  )

# percentage full-time employees
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_FRACFT = mean(FRACFT, na.rm = TRUE) * 100,
    se_FRACFT = sd(FRACFT, na.rm = TRUE) /
      sqrt(sum(!is.na(FRACFT))) * 100
  )

# Starting wage 
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_WAGE = mean(WAGE_ST, na.rm = TRUE),
    se_WAGE = sd(WAGE_ST, na.rm = TRUE) /
      sqrt(sum(!is.na(WAGE_ST)))
  )

# Percentage with starting wage = $4.25
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_ATMIN = mean(ATMIN) * 100,
    se_ATMIN = sd(ATMIN) /
      sqrt(n()) * 100
  )

# Price of full meal
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_PMEAL = mean(PMEAL, na.rm = TRUE),
    se_PMEAL = sd(PMEAL, na.rm = TRUE) /
      sqrt(sum(!is.na(PMEAL)))
  )

# Hours open on a weekday
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_HRSOPEN = mean(HRSOPEN, na.rm = TRUE),
    se_HRSOPEN = sd(HRSOPEN, na.rm = TRUE) /
      sqrt(sum(!is.na(HRSOPEN)))
  )

# Recruiting bonus
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_BONUS = mean(BONUS, na.rm = TRUE) * 100,
    se_BONUS = sd(BONUS, na.rm = TRUE) /
      sqrt(sum(!is.na(BONUS))) * 100
  )

# ------------------------------------------------------------------------------
# Panel 3: Wave 2
# ------------------------------------------------------------------------------

# FTE2 employment 
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_FTE2 = mean(FTE2, na.rm = TRUE),
    se_FTE2 = sd(FTE2, na.rm = TRUE) /
      sqrt(sum(!is.na(FTE2)))
  )

# percentage full-time employees 
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_FRACFT2 = mean(FRACFT2, na.rm = TRUE) * 100,
    se_FRACFT2 = sd(FRACFT2, na.rm = TRUE) /
      sqrt(sum(!is.na(FRACFT2))) * 100
  )

# Starting wage 
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_WAGE2 = mean(WAGE_ST2, na.rm = TRUE),
    se_WAGE2 = sd(WAGE_ST2, na.rm = TRUE) /
      sqrt(sum(!is.na(WAGE_ST2)))
  )

# Percentage with Wave 2 starting wage = $4.25
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_ATMIN2 =
      mean(as.integer(!is.na(WAGE_ST2) & WAGE_ST2 == 4.25)) * 100,
    
    se_ATMIN2 =
      sd(as.integer(!is.na(WAGE_ST2) & WAGE_ST2 == 4.25)) /
      sqrt(n()) * 100
  )

# Percentage with Wave 2 starting wage = $5.05
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_NEWMIN = mean(NEWMIN) * 100,
    se_NEWMIN = sd(NEWMIN) /
      sqrt(n()) * 100
  )

# Price of full meal
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_PMEAL2 = mean(PMEAL2, na.rm = TRUE),
    se_PMEAL2 = sd(PMEAL2, na.rm = TRUE) /
      sqrt(sum(!is.na(PMEAL2)))
  )

# Hours open on a weekday
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_HRSOPEN2 = mean(HRSOPEN2, na.rm = TRUE),
    se_HRSOPEN2 = sd(HRSOPEN2, na.rm = TRUE) /
      sqrt(sum(!is.na(HRSOPEN2)))
  )

# Recruiting bonus / special recruitment program
clean_data |>
  group_by(NJ) |>
  summarise(
    mean_SPECIAL2 = mean(SPECIAL2, na.rm = TRUE) * 100,
    se_SPECIAL2 = sd(SPECIAL2, na.rm = TRUE) /
      sqrt(sum(!is.na(SPECIAL2))) * 100
  )

# ==============================================================================
# Table 2: t-statistics
# ==============================================================================

# Create the Wave 2 $4.25 indicator used only for Table 2
table2_data <- clean_data |>
  mutate(
    ATMIN2 = as.integer(
      !is.na(WAGE_ST2) & WAGE_ST2 == 4.25
    )
  )


# ------------------------------------------------------------------------------
# Function to calculate NJ and PA means, standard errors, and t-statistic
# ------------------------------------------------------------------------------

calc_table2 <- function(data, variable, percent = FALSE) {
  
  stats <- data |>
    group_by(NJ) |>
    summarise(
      mean = mean({{ variable }}, na.rm = TRUE),
      se = sd({{ variable }}, na.rm = TRUE) /
        sqrt(sum(!is.na({{ variable }}))),
      .groups = "drop"
    )
  
  # Convert proportions to percentages where required
  if (percent) {
    stats <- stats |>
      mutate(
        mean = mean * 100,
        se = se * 100
      )
  }
  
  # Extract PA and NJ results
  pa_mean <- stats$mean[stats$NJ == 0]
  nj_mean <- stats$mean[stats$NJ == 1]
  
  pa_se <- stats$se[stats$NJ == 0]
  nj_se <- stats$se[stats$NJ == 1]
  
  # NJ - PA t-statistic
  t_stat <- (nj_mean - pa_mean) /
    sqrt(nj_se^2 + pa_se^2)
  
  tibble(
    NJ_mean = nj_mean,
    NJ_se = nj_se,
    PA_mean = pa_mean,
    PA_se = pa_se,
    t_stat = t_stat
  )
}


# ==============================================================================
# Panel 1: Distribution of store types
# ==============================================================================

t2_BK <- calc_table2(table2_data, BK, percent = TRUE)
t2_KFC <- calc_table2(table2_data, KFC, percent = TRUE)
t2_ROYS <- calc_table2(table2_data, ROYS, percent = TRUE)
t2_WENDYS <- calc_table2(table2_data, WENDYS, percent = TRUE)
t2_COOWN <- calc_table2(table2_data, CO_OWNED, percent = TRUE)


# ==============================================================================
# Panel 2: Means in Wave 1
# ==============================================================================

t2_FTE <- calc_table2(table2_data, FTE)

t2_FRACFT <- calc_table2(
  table2_data,
  FRACFT,
  percent = TRUE
)

t2_WAGE1 <- calc_table2(
  table2_data,
  WAGE_ST
)

t2_ATMIN <- calc_table2(
  table2_data,
  ATMIN,
  percent = TRUE
)

t2_PMEAL1 <- calc_table2(
  table2_data,
  PMEAL
)

t2_HRSOPEN1 <- calc_table2(
  table2_data,
  HRSOPEN
)

t2_BONUS <- calc_table2(
  table2_data,
  BONUS,
  percent = TRUE
)


# ==============================================================================
# Panel 3: Means in Wave 2
# ==============================================================================

t2_FTE2 <- calc_table2(
  table2_data,
  FTE2
)

t2_FRACFT2 <- calc_table2(
  table2_data,
  FRACFT2,
  percent = TRUE
)

t2_WAGE2 <- calc_table2(
  table2_data,
  WAGE_ST2
)

t2_ATMIN2 <- calc_table2(
  table2_data,
  ATMIN2,
  percent = TRUE
)

t2_NEWMIN <- calc_table2(
  table2_data,
  NEWMIN,
  percent = TRUE
)

t2_PMEAL2 <- calc_table2(
  table2_data,
  PMEAL2
)

t2_HRSOPEN2 <- calc_table2(
  table2_data,
  HRSOPEN2
)

t2_SPECIAL2 <- calc_table2(
  table2_data,
  SPECIAL2,
  percent = TRUE
)


# ==============================================================================
# Combine into one Table 2
# ==============================================================================

table2_results <- bind_rows(
  
  # Store types
  t2_BK |> mutate(variable = "Burger King"),
  t2_KFC |> mutate(variable = "KFC"),
  t2_ROYS |> mutate(variable = "Roy Rogers"),
  t2_WENDYS |> mutate(variable = "Wendy's"),
  t2_COOWN |> mutate(variable = "Company-owned"),
  
  # Wave 1
  t2_FTE |> mutate(variable = "FTE employment - Wave 1"),
  t2_FRACFT |> mutate(variable = "% full-time - Wave 1"),
  t2_WAGE1 |> mutate(variable = "Starting wage - Wave 1"),
  t2_ATMIN |> mutate(variable = "Wage = $4.25 - Wave 1"),
  t2_PMEAL1 |> mutate(variable = "Meal price - Wave 1"),
  t2_HRSOPEN1 |> mutate(variable = "Hours open - Wave 1"),
  t2_BONUS |> mutate(variable = "Recruiting bonus - Wave 1"),
  
  # Wave 2
  t2_FTE2 |> mutate(variable = "FTE employment - Wave 2"),
  t2_FRACFT2 |> mutate(variable = "% full-time - Wave 2"),
  t2_WAGE2 |> mutate(variable = "Starting wage - Wave 2"),
  t2_ATMIN2 |> mutate(variable = "Wage = $4.25 - Wave 2"),
  t2_NEWMIN |> mutate(variable = "Wage = $5.05 - Wave 2"),
  t2_PMEAL2 |> mutate(variable = "Meal price - Wave 2"),
  t2_HRSOPEN2 |> mutate(variable = "Hours open - Wave 2"),
  t2_SPECIAL2 |> mutate(variable = "Recruiting bonus - Wave 2")
  
) |>
  select(
    variable,
    NJ_mean,
    NJ_se,
    PA_mean,
    PA_se,
    t_stat
  ) |>
  mutate(
    across(
      c(NJ_mean, NJ_se, PA_mean, PA_se, t_stat),
      ~ round(.x, 2)
    )
  )


# View completed Table 2 results
table2_results <- table2_results |>
  mutate(
    t_stat = if_else(
      variable == "Wage = $4.25 - Wave 2",
      NA_real_,
      t_stat
    )
  )

# Diagnose remaining Table 2 differences ---------------------------------------

clean_data |>
  group_by(NJ) |>
  summarise(
    
    # Wave 2 starting wage
    total_stores = n(),
    wage2_observed = sum(!is.na(WAGE_ST2)),
    number_505 = sum(WAGE_ST2 == 5.05, na.rm = TRUE),
    pct_505_total = number_505 / total_stores * 100,
    pct_505_observed = number_505 / wage2_observed * 100,
    
    # Wave 2 hours
    hrs2_observed = sum(!is.na(HRSOPEN2)),
    mean_hrs2 = mean(HRSOPEN2, na.rm = TRUE),
    
    .groups = "drop"
  )

clean_data |>
  filter(NJ == 1, WAGE_ST2 == 5.05) |>
  summarise(n = n())

table2_results

# ==============================================================================
# Replication notes
# ==============================================================================

# Table 2 is reproduced closely using the public Card-Krueger data.
#
# One small discrepancy remains:
# - Wave 2 share of NJ stores paying exactly $5.05:
#     Replication: 85.5% (283 / 331 stores)
#     Published:   85.2%
#
# The public data contain 283 NJ stores with WAGE_ST2 == 5.05.
# The original observations are retained rather than altered to force the
# published percentage.
#
# Wave 2 hours-open means reproduce the published values:
#     NJ = 14.4
#     PA = 14.7
