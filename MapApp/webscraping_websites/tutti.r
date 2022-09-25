library(rvest)
library(purrr)

url_base <- "https://www.tutti.ch/fr/li/geneve?q=colocation"

map_df(1:1, function(i) {
  
  # simple but effective progress indicator
  cat(".")
  
  pg <- read_html(sprintf(url_base, i))
  
  data.frame(desc=gsub("Chez.*", "", html_text(html_nodes(pg, "div.p78z0m-9.eFjaxZ > a"))),
             lieu=html_text(html_nodes(pg, "span.p78z0m-6.btqBLH")),
             prix=gsub(" CHF", "", html_text(html_nodes(pg, "div > div.p78z0m-12.beZjFt"))),
             link=paste("https://www.tutti.ch", html_nodes(pg, "div.p78z0m-9.eFjaxZ > a")%>%html_attr("href"),sep = ""),
             stringsAsFactors=FALSE)
}) -> dat


tutti <- as.data.frame(dat)

save(tutti,file="MapApp/webscraping_websites/tutti.Rda")
