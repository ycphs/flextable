context("check errors")


test_that("rows selections", {
  dummy_df <- data.frame( my_col = rep(letters[1:3], each = 2),
                          row.names = letters[21:26],
                          stringsAsFactors = FALSE )
  ft <- flextable(dummy_df)
  expect_error(bold(ft, i = ~ my_col %in% "a", part = "header" ), "cannot adress part 'header'")
  expect_error(bold(ft, i = 1L:8L ), "invalid row selection")
  expect_error(bold(ft, i = -9 ), "invalid row selection")
  expect_error(bold(ft, i = rep(TRUE, 10) ), "invalid row selection")
  expect_error(bold(ft, i = c("m", "n") ), "invalid row selection")
})

test_that("columns selections", {
  ft <- flextable(iris)
  expect_error(bold(ft, j = ~ Sepalsd.Length + Species ), "unknown variables:\\[Sepalsd.Length\\]")
  expect_error(bold(ft, j = 1:6 ), "invalid columns selection")
  expect_error(bold(ft, j = c("Sepalsd.Length") ), "invalid columns selection")
})



test_that("display usage", {
  ft <- flextable(head( mtcars, n = 10))
  expect_error(display(ft, col_key = "carb", pattern = "# {{carb}}",
                       fprops = list(carb = fp_text(color="orange") ) ),
               "missing definition for display")
  expect_error(display(ft, col_key = "carb", pattern = "# {{carb}}",
                       formatters = list(carb ~ sprintf("%.1f", carb)),
                       fprops = list(carb = "sdf" ) ),
               "argument fprops should be a list of fp_text")
})

test_that("part=header and formula selection for rows", {
  ft <- flextable(head( mtcars, n = 10))
  def_cell <- fp_cell(border = fp_border(color="#00FFFF"))
  def_par <- fp_par(text.align = "center")
  expect_error(style( ft, i = ~ mpg < 20 ,pr_c = def_cell, pr_p = def_par, part = "all"),
               "formula in argument i cannot adress part 'header'.")
  expect_error(bg( ft, i = ~ mpg < 20 , bg = "#DDDDDD", part = "header"),
               "formula in argument i cannot adress part 'header'.")
  expect_error(bold( ft, i = ~ mpg < 20 , bold = TRUE, part = "header"),
               "formula in argument i cannot adress part 'header'.")
  expect_error(fontsize( ft, i = ~ mpg < 20 , size = 10, part = "header"),
               "formula in argument i cannot adress part 'header'.")
  expect_error(italic( ft, i = ~ mpg < 20 , italic = TRUE, part = "header"),
               "formula in argument i cannot adress part 'header'.")
  expect_error(color( ft, i = ~ mpg < 20 , color = "red", part = "header"),
               "formula in argument i cannot adress part 'header'.")
  expect_error(padding( ft, i = ~ mpg < 20 , padding = 3, part = "header"),
               "formula in argument i cannot adress part 'header'.")
  expect_error(align( ft, i = ~ mpg < 20 , align = "center", part = "header"),
               "formula in argument i cannot adress part 'header'.")
  expect_error(border( ft, i = ~ mpg < 20 , border = fp_border(color = "orange"), part = "header"),
               "formula in argument i cannot adress part 'header'.")
  expect_error(rotate( ft, i = ~ mpg < 20 , rotation = "lrtb", align = "top", part = "header"),
               "formula in argument i cannot adress part 'header'.")
})

