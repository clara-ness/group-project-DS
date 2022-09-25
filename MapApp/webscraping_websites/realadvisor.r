library(rvest)
library(purrr)

url_base <- "https://realadvisor.ch/fr/louer/canton-geneve/chambre-colocation/page-%d"

map_df(1:4, function(i) {
  
  # simple but effective progress indicator
  cat(".")
  
  pg <- read_html(sprintf(url_base, i))
  
  data.frame(desc=gsub("Chez.*", "", html_text(html_nodes(pg, "div.textLoadingClassname.css-4zv356-AggregatesListingCard"))),
             lieu=html_text(html_nodes(pg, "div.textLoadingClassname.css-r9j9hm-AggregatesListingCard")),
             prix=gsub(" CHF", "", html_text(html_nodes(pg, "div.css-l4xezc-AggregatesListingCard > span"))),
             link=paste("https://realadvisor.ch", html_nodes(pg, "a.css-15smkzd-AggregatesListingCard")%>%html_attr("href"),sep = ""),
             stringsAsFactors=FALSE)
}) -> dat

realadvisor <- as.data.frame(dat)
save(realadvisor,file="MapApp/webscraping_websites/realadvisor.Rda")
