library(fs)
if (file.exists("docs")){
  dir_delete("docs")
}
dir_create("docs")
dir_copy("images", "docs")

bookdown::render_book(
  input = "index.Rmd", 
  output_format = "bookdown::gitbook",
  output_dir = "docs"
)
