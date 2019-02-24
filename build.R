library(fs)
dir <- "_book"
if (file.exists(dir)){
  dir_delete(dir)
}
dir_create(dir)
dir_copy("images", dir)
drake::clean(destroy = TRUE)
bookdown::render_book(input = "index.Rmd", output_format = "bookdown::gitbook")
