library(rvest)
library(purrr)

url_base <- "https://fr-ch.roomlala.com/colocation/CH-Suisse/geneve/%d"

map_df(1:4, function(i) {
  
  # simple but effective progress indicator
  cat(".")
  
  pg <- read_html(sprintf(url_base, i))
  
  data.frame(lieu=gsub("Chez.*", "", html_text(html_nodes(pg, "page, .ad-landlord"))),
             prix=gsub(" CHF / mois", "", html_text(html_nodes(pg, ".ad-price-banner"))),
             desc=html_text(html_nodes(pg, "p.ad-description.no-wrap")),
             link=paste("https://fr-ch.roomlala.com", html_nodes(pg, "h2 >.grey")%>%html_attr("href"),sep = ""),
             stringsAsFactors=FALSE)
}) -> dat

roomlala <- as.data.frame(dat)
save(roomlala,file="MapApp/webscraping_websites/roomlala.Rda")
