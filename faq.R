library(tidyverse)
library(gh)

is_faq <- function(label){
  identical(label$name, "frequently asked question")
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

if (!identical(Sys.getenv("TRAVIS_PULL_REQUEST"), "true")){
  build_faq()
}
