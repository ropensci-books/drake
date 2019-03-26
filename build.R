library(fs)
dir <- "_book"
if (file.exists(dir)){
  dir_delete(dir)
}
dir_create(dir)
dir_copy("images", dir)
options(drake_make_menu = FALSE)
drake::clean(destroy = TRUE)
bookdown::render_book(
  input = "index.Rmd",
  output_format = "bookdown::gitbook"
)
try({
  drake::clean(destroy = TRUE)
  bookdown::render_book(
    input = "index.Rmd",
    output_format = "bookdown::pdf_book",
    output_dir = "_pdfbook"
  )
  file.copy(
    from = "_pdfbook/ropensci-dev-guide.pdf",
    to = "_book/ropensci-dev-guide.pdf"
  )
})
