library(rvest)
library(purrr)

url_base <- "https://www.anibis.ch/fr/c/immobilier-immobilier-locations/geneve?fts=colocation"

map_df(1:1, function(i) {
  
  # simple but effective progress indicator
  cat(".")
  
  pg <- read_html(sprintf(url_base, i))
  
  data.frame(desc=gsub("Chez.*", "", html_text(html_nodes(pg, "div.sc-10azyvw-0.ixpvun"))),
             lieu=gsub("·.*","",html_text(html_nodes(pg, "div.sc-1k353ht-0.cSDQkw > div"))),
             prix=gsub(" CHF", "", html_text(html_nodes(pg, "div.sc-1hmmkgo-0.bKatmi"))),
             link=paste("https://www.anibis.ch", html_nodes(pg, "#card_38881165 > a")%>%html_attr("href"),sep = ""),
             stringsAsFactors=FALSE)
}) -> dat

anibis2 <- as.data.frame(dat)

anibis2 = anibis2[-1,]
save(anibis2,file="MapApp/webscraping_websites/anibis2.Rda")
