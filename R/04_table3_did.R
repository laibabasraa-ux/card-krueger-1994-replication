# ==============================================================================
# Card & Krueger (1994) Replication
# 04_table3_did.R: reproduce Table 3 - Employment Before and After
# ==============================================================================


# 1. Load packages -------------------------------------------------------------

library(tidyverse)


# 2. Load cleaned data ---------------------------------------------------------

clean_data <- readRDS("data/clean/ck_clean.rds")

stopifnot(nrow(clean_data) == 410)

# 3. Check Table 3 wage groups -------------------------------------------------

clean_data |>
  filter(NJ == 1) |>
  count(WAGE_GROUP)

# ==============================================================================
# 4. Rows 1 and 2: FTE employment before and after
# ==============================================================================

state_fte <- clean_data |>
  group_by(NJ) |>
  summarise(
    
    # Wave 1
    FTE_before = mean(FTE, na.rm = TRUE),
    
    SE_before = sd(FTE, na.rm = TRUE) /
      sqrt(sum(!is.na(FTE))),
    
    # Wave 2
    FTE_after = mean(FTE2, na.rm = TRUE),
    
    SE_after = sd(FTE2, na.rm = TRUE) /
      sqrt(sum(!is.na(FTE2))),
    
    .groups = "drop"
  )

state_fte

# Extract state means
pa_before <- state_fte$FTE_before[state_fte$NJ == 0]
nj_before <- state_fte$FTE_before[state_fte$NJ == 1]

pa_after <- state_fte$FTE_after[state_fte$NJ == 0]
nj_after <- state_fte$FTE_after[state_fte$NJ == 1]


# NJ - PA difference before
diff_before <- nj_before - pa_before

# NJ - PA difference after
diff_after <- nj_after - pa_after


diff_before
diff_after

# ==============================================================================
# 5. Row 3: Change in mean FTE employment
# ==============================================================================

pa_change <- pa_after - pa_before
nj_change <- nj_after - nj_before

pa_change
nj_change

did <- nj_change - pa_change

did

# ==============================================================================
# 6. Employment by initial NJ wage group
# ==============================================================================

nj_wage_fte <- clean_data |>
  filter(
    NJ == 1,
    !is.na(WAGE_GROUP)
  ) |>
  group_by(WAGE_GROUP) |>
  summarise(
    
    FTE_before = mean(FTE, na.rm = TRUE),
    
    SE_before = sd(FTE, na.rm = TRUE) /
      sqrt(sum(!is.na(FTE))),
    
    FTE_after = mean(FTE2, na.rm = TRUE),
    
    SE_after = sd(FTE2, na.rm = TRUE) /
      sqrt(sum(!is.na(FTE2))),
    
    .groups = "drop"
  ) |>
  mutate(
    change = FTE_after - FTE_before
  )

nj_wage_fte

# Extract changes by wage group

low_change <- nj_wage_fte$change[
  nj_wage_fte$WAGE_GROUP == "NJ: $4.25"
]

mid_change <- nj_wage_fte$change[
  nj_wage_fte$WAGE_GROUP == "NJ: $4.26-$4.99"
]

high_change <- nj_wage_fte$change[
  nj_wage_fte$WAGE_GROUP == "NJ: >=$5.00"
]


# Low-wage minus high-wage
low_high <- low_change - high_change

# Mid-wage minus high-wage
mid_high <- mid_change - high_change

pa_change
nj_change
did

# ==============================================================================
# 7. Row 4: Balanced sample
# ==============================================================================

balanced_state <- clean_data |>
  filter(
    !is.na(FTE),
    !is.na(FTE2)
  ) |>
  group_by(NJ) |>
  summarise(
    mean_change = mean(DEMP),
    se_change = sd(DEMP) / sqrt(n()),
    .groups = "drop"
  )

balanced_state

pa_balanced <- balanced_state$mean_change[
  balanced_state$NJ == 0
]

nj_balanced <- balanced_state$mean_change[
  balanced_state$NJ == 1
]

did_balanced <- nj_balanced - pa_balanced

did_balanced

# NJ wage-group results for the balanced sample
balanced_wage <- clean_data |>
  filter(
    NJ == 1,
    !is.na(WAGE_GROUP),
    !is.na(FTE),
    !is.na(FTE2)
  ) |>
  group_by(WAGE_GROUP) |>
  summarise(
    mean_change = mean(DEMP),
    se_change = sd(DEMP) / sqrt(n()),
    .groups = "drop"
  )

balanced_wage

low_bal <- balanced_wage$mean_change[
  balanced_wage$WAGE_GROUP == "NJ: $4.25"
]

mid_bal <- balanced_wage$mean_change[
  balanced_wage$WAGE_GROUP == "NJ: $4.26-$4.99"
]

high_bal <- balanced_wage$mean_change[
  balanced_wage$WAGE_GROUP == "NJ: >=$5.00"
]

low_high_bal <- low_bal - high_bal
mid_high_bal <- mid_bal - high_bal

low_high_bal
mid_high_bal

# ==============================================================================
# 8. Row 5: Treat temporarily closed stores as zero employment
# ==============================================================================

temp0_state <- clean_data |>
  filter(
    !is.na(FTE),
    !is.na(FTE2_TEMPO)
  ) |>
  group_by(NJ) |>
  summarise(
    mean_change = mean(DEMP_TEMPO),
    se_change = sd(DEMP_TEMPO) / sqrt(n()),
    .groups = "drop"
  )

temp0_state

# NJ-PA difference
pa_temp0 <- temp0_state$mean_change[
  temp0_state$NJ == 0
]

nj_temp0 <- temp0_state$mean_change[
  temp0_state$NJ == 1
]

did_temp0 <- nj_temp0 - pa_temp0

did_temp0

#NJ wage-group results
temp0_wage <- clean_data |>
  filter(
    NJ == 1,
    !is.na(WAGE_GROUP),
    !is.na(FTE),
    !is.na(FTE2_TEMPO)
  ) |>
  group_by(WAGE_GROUP) |>
  summarise(
    mean_change = mean(DEMP_TEMPO),
    se_change = sd(DEMP_TEMPO) / sqrt(n()),
    .groups = "drop"
  )

temp0_wage

low_temp0 <- temp0_wage$mean_change[
  temp0_wage$WAGE_GROUP == "NJ: $4.25"
]

mid_temp0 <- temp0_wage$mean_change[
  temp0_wage$WAGE_GROUP == "NJ: $4.26-$4.99"
]

high_temp0 <- temp0_wage$mean_change[
  temp0_wage$WAGE_GROUP == "NJ: >=$5.00"
]

low_high_temp0 <- low_temp0 - high_temp0
mid_high_temp0 <- mid_temp0 - high_temp0

low_high_temp0
mid_high_temp0

# ==============================================================================
# 9. Assemble Table 3 results
# ==============================================================================

# Create named vectors for the three NJ wage groups
wage_before <- setNames(
  nj_wage_fte$FTE_before,
  nj_wage_fte$WAGE_GROUP
)

wage_after <- setNames(
  nj_wage_fte$FTE_after,
  nj_wage_fte$WAGE_GROUP
)

wage_change <- setNames(
  nj_wage_fte$change,
  nj_wage_fte$WAGE_GROUP
)

balanced_change <- setNames(
  balanced_wage$mean_change,
  balanced_wage$WAGE_GROUP
)

temp0_change <- setNames(
  temp0_wage$mean_change,
  temp0_wage$WAGE_GROUP
)


# Construct final point-estimate table
table3_results <- tibble(
  
  variable = c(
    "1. FTE employment before",
    "2. FTE employment after",
    "3. Change in mean FTE employment",
    "4. Change in FTE - balanced sample",
    "5. Change in FTE - temporary closures = 0"
  ),
  
  PA = c(
    pa_before,
    pa_after,
    pa_change,
    pa_balanced,
    pa_temp0
  ),
  
  NJ = c(
    nj_before,
    nj_after,
    nj_change,
    nj_balanced,
    nj_temp0
  ),
  
  `NJ - PA` = c(
    diff_before,
    diff_after,
    did,
    did_balanced,
    did_temp0
  ),
  
  `NJ $4.25` = c(
    wage_before["NJ: $4.25"],
    wage_after["NJ: $4.25"],
    wage_change["NJ: $4.25"],
    balanced_change["NJ: $4.25"],
    temp0_change["NJ: $4.25"]
  ),
  
  `NJ $4.26-$4.99` = c(
    wage_before["NJ: $4.26-$4.99"],
    wage_after["NJ: $4.26-$4.99"],
    wage_change["NJ: $4.26-$4.99"],
    balanced_change["NJ: $4.26-$4.99"],
    temp0_change["NJ: $4.26-$4.99"]
  ),
  
  `NJ >=$5.00` = c(
    wage_before["NJ: >=$5.00"],
    wage_after["NJ: >=$5.00"],
    wage_change["NJ: >=$5.00"],
    balanced_change["NJ: >=$5.00"],
    temp0_change["NJ: >=$5.00"]
  )
)

# Adding within-NJ comparison columns
table3_results <- table3_results |>
  mutate(
    
    `Low - high` =
      `NJ $4.25` - `NJ >=$5.00`,
    
    `Midrange - high` =
      `NJ $4.26-$4.99` - `NJ >=$5.00`
    
  ) |>
  mutate(
    across(
      where(is.numeric),
      ~ round(.x, 2)
    )
  )

table3_results

# ==============================================================================
# 10. Standard errors for Table 3
# ==============================================================================


# ------------------------------------------------------------------------------
# Diagnostic calculation of Row 3 standard errors
# using covariance-adjusted differences in means
# ------------------------------------------------------------------------------

change_mean_stats <- function(x_before, x_after) {
  
  # Number of available observations in each wave
  n_before <- sum(!is.na(x_before))
  n_after  <- sum(!is.na(x_after))
  
  # Stores observed in both waves
  common <- !is.na(x_before) & !is.na(x_after)
  n_common <- sum(common)
  
  # Means
  mean_before <- mean(x_before, na.rm = TRUE)
  mean_after  <- mean(x_after, na.rm = TRUE)
  
  mean_change <- mean_after - mean_before
  
  # Variance of each sample mean
  var_before <- var(x_before, na.rm = TRUE) / n_before
  var_after  <- var(x_after, na.rm = TRUE) / n_after
  
  # Covariance between Wave 1 and Wave 2 employment
  cov_ba <- cov(
    x_before[common],
    x_after[common]
  )
  
  # Covariance between the two sample means
  cov_means <- n_common * cov_ba /
    (n_before * n_after)
  
  # SE of difference between correlated means
  se_change <- sqrt(
    var_before +
      var_after -
      2 * cov_means
  )
  
  tibble(
    mean_change = mean_change,
    se_change = se_change
  )
}

# ------------------------------------------------------------------------------
# Row 3: Change in mean FTE - all available observations
# ------------------------------------------------------------------------------

row3_pa <- change_mean_stats(
  clean_data$FTE[clean_data$NJ == 0],
  clean_data$FTE2[clean_data$NJ == 0]
)

row3_nj <- change_mean_stats(
  clean_data$FTE[clean_data$NJ == 1],
  clean_data$FTE2[clean_data$NJ == 1]
)

row3_pa
row3_nj

# SE of NJ-PA difference
row3_diff_se <- sqrt(
  row3_pa$se_change^2 +
    row3_nj$se_change^2
)

row3_diff_se

# ------------------------------------------------------------------------------
# Row 3: Changes by initial NJ wage group
# ------------------------------------------------------------------------------

row3_low <- change_mean_stats(
  clean_data$FTE[
    clean_data$WAGE_GROUP == "NJ: $4.25" &
      !is.na(clean_data$WAGE_GROUP)
  ],
  clean_data$FTE2[
    clean_data$WAGE_GROUP == "NJ: $4.25" &
      !is.na(clean_data$WAGE_GROUP)
  ]
)

row3_mid <- change_mean_stats(
  clean_data$FTE[
    clean_data$WAGE_GROUP == "NJ: $4.26-$4.99" &
      !is.na(clean_data$WAGE_GROUP)
  ],
  clean_data$FTE2[
    clean_data$WAGE_GROUP == "NJ: $4.26-$4.99" &
      !is.na(clean_data$WAGE_GROUP)
  ]
)

row3_high <- change_mean_stats(
  clean_data$FTE[
    clean_data$WAGE_GROUP == "NJ: >=$5.00" &
      !is.na(clean_data$WAGE_GROUP)
  ],
  clean_data$FTE2[
    clean_data$WAGE_GROUP == "NJ: >=$5.00" &
      !is.na(clean_data$WAGE_GROUP)
  ]
)

row3_low
row3_mid
row3_high

# within-NJ difference SEs
row3_low_high_se <- sqrt(
  row3_low$se_change^2 +
    row3_high$se_change^2
)

row3_mid_high_se <- sqrt(
  row3_mid$se_change^2 +
    row3_high$se_change^2
)

row3_low_high_se
row3_mid_high_se

# ==============================================================================
# 11. Difference standard errors for Rows 4 and 5
# ==============================================================================

# Row 4: balanced sample NJ - PA
row4_diff_se <- sqrt(
  balanced_state$se_change[balanced_state$NJ == 0]^2 +
    balanced_state$se_change[balanced_state$NJ == 1]^2
)

# Row 4: within NJ
row4_low_high_se <- sqrt(
  balanced_wage$se_change[
    balanced_wage$WAGE_GROUP == "NJ: $4.25"
  ]^2 +
    balanced_wage$se_change[
      balanced_wage$WAGE_GROUP == "NJ: >=$5.00"
    ]^2
)

row4_mid_high_se <- sqrt(
  balanced_wage$se_change[
    balanced_wage$WAGE_GROUP == "NJ: $4.26-$4.99"
  ]^2 +
    balanced_wage$se_change[
      balanced_wage$WAGE_GROUP == "NJ: >=$5.00"
    ]^2
)


# Row 5: temporary closures = zero, NJ - PA
row5_diff_se <- sqrt(
  temp0_state$se_change[temp0_state$NJ == 0]^2 +
    temp0_state$se_change[temp0_state$NJ == 1]^2
)

# Row 5: within NJ
row5_low_high_se <- sqrt(
  temp0_wage$se_change[
    temp0_wage$WAGE_GROUP == "NJ: $4.25"
  ]^2 +
    temp0_wage$se_change[
      temp0_wage$WAGE_GROUP == "NJ: >=$5.00"
    ]^2
)

row5_mid_high_se <- sqrt(
  temp0_wage$se_change[
    temp0_wage$WAGE_GROUP == "NJ: $4.26-$4.99"
  ]^2 +
    temp0_wage$se_change[
      temp0_wage$WAGE_GROUP == "NJ: >=$5.00"
    ]^2
)


row4_diff_se
row4_low_high_se
row4_mid_high_se

row5_diff_se
row5_low_high_se
row5_mid_high_se

# ==============================================================================
# 12. Replication notes
# ==============================================================================

# Table 3 point estimates are reproduced closely using the public data.
#
# Headline difference-in-differences estimate:
#     Replication: 2.75 FTE
#     Published:   2.76 FTE
#
# Rows 4 and 5 (balanced sample and temporary-closure robustness checks)
# reproduce the published point estimates and standard errors closely.
#
# Row 3 standard errors do not exactly reproduce the published values.
# Using the public data and accounting for covariance between Wave 1 and
# Wave 2 employment produces:
#
#     PA change SE:       1.22   (published 1.25)
#     NJ change SE:       0.47   (published 0.54)
#     NJ-PA change SE:    1.31   (published 1.36)
#
# Similar discrepancies arise for the NJ initial-wage-group comparisons.
# The replicated point estimates are retained rather than modifying the
# calculations to force agreement with the published standard errors.