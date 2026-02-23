

#' Computes basic descriptive statistics (N, non-missing, min, max, mean, SD)
#' for one or more variables in a data frame. Prints a formatted table and
#' invisibly returns the underlying results as a data frame.
#'
#' @param data A data frame.
#' @param ... Unquoted variable names within `data`.
#'
#' @return Invisibly returns a data frame of SPSS-like descriptive statistics. Also prints a table.
#'
#' @examples
#' jdesc(mtcars, mpg)
#' jdesc(mtcars, mpg, hp, wt)
#'
#' @export
#'
jdesc <- function(data, ...) {
  variables <- rlang::enquos(...)
  variable_names <- purrr::map_chr(variables, rlang::quo_name)

  descriptives_list <- lapply(variables, function(var) {
    var_name <- rlang::quo_name(var)
    var_data <- rlang::eval_tidy(var, data)

    total_cases <- length(var_data)
    non_missing_cases <- sum(!is.na(var_data))
    min_val <- round(min(var_data, na.rm = TRUE), 3)
    max_val <- round(max(var_data, na.rm = TRUE), 3)
    mean_val <- round(mean(var_data, na.rm = TRUE), 3)
    sd_val <- round(stats::sd(var_data, na.rm = TRUE), 3)

    data.frame(
      Variable = var_name,
      Total = total_cases,
      Non_missing = non_missing_cases,
      Min = min_val,
      Max = max_val,
      Mean = mean_val,
      SD = sd_val,
      stringsAsFactors = FALSE
    )
  })

  descriptives <- do.call(rbind, descriptives_list)

  # listwise cases (complete across selected variables)
  listwise_cases <- sum(stats::complete.cases(dplyr::select(data, dplyr::all_of(variable_names))))

  listwise_row <- data.frame(
    Variable = "Listwise_N",
    Total = NA,
    Non_missing = listwise_cases,
    Min = NA,
    Max = NA,
    Mean = NA,
    SD = NA,
    stringsAsFactors = FALSE
  )

  descriptives <- rbind(descriptives, listwise_row)

  print(knitr::kable(descriptives, caption = "Descriptive Statistics"))
  invisible(descriptives)
}

