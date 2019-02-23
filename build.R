library(fs)
dir <- "_book"
if (file.exists(dir)){
  dir_delete(dir)
}
dir_create(dir)
for (file in list.files("favicon", full.names = TRUE)) {
  file.copy(file, dir)
}
drake::clean(destroy = TRUE)
bookdown::render_book(input = "index.Rmd", output_format = "bookdown::gitbook")
