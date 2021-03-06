#### ---- Project: APHRC Verbal Autopsy Data ----
#### ---- Task: Descriptives ----
#### ---- Sub-Task: Demographics ----
#### ---- By: Steve and Jonathan ----
#### ---- Date: 2019 Jan 29 (Tue) ----

library(tidyr)
library(dplyr)
library(expss)
library(ggplot2)
library(scales)

load("demographicFunc.rda")
load("globalFunctions.rda")
load("completeVA.rda")

theme_set(theme_bw()+
theme(panel.spacing=grid::unit(0,"lines")))

#### ---- 1. Deaths per year ----

tab_vars <- c("slumarea", "yeardeath")
legend_title <- "EA"
xaxis_order <- as.character(c(2002:2016))

deathyear_summary <- demographCounts(df = working_df
  	, tab_vars = tab_vars
  	, legend_title = legend_title
	, xaxis_order
)
deathyear_plot <- deathyear_summary[["count_plot"]]

deathyear_plot <- (deathyear_plot 
	+ xlab("Years")
)
deathyear_plot

#### ---- 2. Age groups ----

tab_vars <- c("slumarea", "agegroupdeath")
y_limits <- c(0, 0.2)
legend_title <- "EA"
xaxis_order <- pull(working_df, agegroupdeath) %>% levels()

age_group_summary <- demographProps(df = working_df
  	, tab_vars = tab_vars
  	, legend_title = legend_title
  	, y_limits = y_limits
	, xaxis_order
)
age_group_plot <- age_group_summary[["prop_plot"]]
age_group_plot <- (age_group_plot 
	+ theme(axis.text.x=element_text(angle=90))
	+ xlab("Age groups")
)
age_group_plot


#### ---- 3. Absolute ages -----

xvar <- "yeardeath"
yvar <- "agedeath_years"
colvar <- "slumarea"
abs_age_summary <- demographicMean(df = working_df
	, xvar = xvar 
	, yvar = yvar
	, colvar = colvar
)

abs_age_plot <- abs_age_summary[["mean_plot"]]
abs_age_plot <- abs_age_plot + xlab("Year of death") + ylab("Age at death")
abs_age_plot

# Save objects

demographic_saved_plots <- sapply(grep("_plot$", ls(), value = TRUE), get)
save(file = "demographics.rda", demographic_saved_plots)
