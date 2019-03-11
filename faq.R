is_faq <- function(label){
  identical(label$name, "type: faq")
}

any_faq_label <- function(issue){
  any(vapply(issue$labels, is_faq, logical(1)))
}

combine_fields <- function(lst, field){
  map_chr(lst, function(x){
    x[[field]]
  })
}

build_faq <- function(){
  library(tidyverse)
  library(gh)
  faq <- gh(
    "GET /repos/ropensci/drake/issues?state=all",
    .limit = Inf
  ) %>%
    Filter(f = any_faq_label)
  titles <- combine_fields(faq, "title")
  urls <- combine_fields(faq, "html_url")
  links <- paste0("- [", titles, "](", urls, ")")
  con <- file("faq.Rmd", "a")
  writeLines(c("", links), con)
  close(con)
}

if (nzchar(Sys.getenv("GITHUB_PAT"))){
  build_faq()
}
