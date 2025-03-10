require(DSI)
require(DSLite)
require(dplyr)
require(dsBase)
require(dsBaseClient)

data("mtcars")
mtcars_group <- mtcars %>% group_by(cyl)
login_data <- .prepare_dslite("selectDS", NULL, list(mtcars = mtcars))
conns <- datashield.login(logins = login_data)
datashield.assign.table(conns, "mtcars", "mtcars")

good_select_arg <- "mpg, cyl, starts_with('g'), ends_with('b')"

test_that("selectDS passes where data and column exist", {
  good_select_cally <- .make_tidyverse_call("mtcars", "select", good_select_arg)
  expected <- c("mpg", "cyl", "gear", "carb")
  expect_equal(
    colnames(eval(good_select_cally)),
    expected
  )
})

call_no_data <- .make_tidyverse_call("data_not_there", "select", good_select_arg)

test_that("selectDS fails with correct message when data doesn't exist", {
  select_cally_no_data <- .make_tidyverse_call("doesntexist", "select", good_select_arg)
  expect_error(
    eval(select_cally_no_data),
    "object 'doesntexist' not found"
  )
})

test_that(".execute_tidyverse_function fails with correct message when unrecognised function passed", {
  select_random_arg <- "filter('mpg'), mpg, cyl, starts_with('g'), ends_with('b')"
  random_select_cally <- .make_tidyverse_call("mtcars", "select", select_random_arg)
  expect_error(
    eval(random_select_cally),
    "`selectDS`\\s+returned\\s+the\\s+following\\s+error:|no\\s+applicable\\s+method\\s+for\\s+'filter'"
  )
})

test_that("select passes when called directly", {
  skip_if_not_installed("dsBaseClient")
  cally <- call(
    "selectDS", "mpg$COMMA$$SPACE$starts_with$LB$$QUOTE$m$QUOTE$$RB$$COMMA$$SPACE$ends_with$LB$$QUOTE$t$QUOTE$$RB$",
    "mtcars"
  )
  datashield.assign(conns, "test", cally)

  expect_equal(
    ds.class("test", datasources = conns)[[1]],
    "data.frame"
  )

  expect_equal(
    ds.colnames("test", datasources = conns)[[1]],
    c("mpg", "drat", "wt")
  )
})

test_that("select passes strings that included 'c'", {
  good_arg_1 <- "any_of(c(mpg, cyl, drat))"
  expect_silent(
    .check_tidy_disclosure("mtcars", good_arg_1)
  )
})
