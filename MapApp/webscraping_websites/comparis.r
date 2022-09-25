library(rvest)
library(purrr)

url_base <- "https://fr.comparis.ch/immobilien/marktplatz/geneve/wg-zimmer/mieten"

map_df(1:1, function(i) {
  
  # simple but effective progress indicator
  cat(".")
  
  pg <- read_html(sprintf(url_base, i))
  
  data.frame(desc=gsub("Chez.*", "", html_text(html_nodes(pg, "p.css-ejje9.excbu0j2"))),
             lieu=html_text(html_nodes(pg, "p.css-a7uk28.excbu0j2")),
             prix=gsub(" CHF", "", html_text(html_nodes(pg, "span.css-1ladu04.excbu0j2"))),
             link=paste("https://fr.comparis.ch/immobilien/marktplatz/geneve/wg-zimmer/mieten", html_nodes(pg, "a.css-a0dqn4 excbu0j1")%>%html_attr("href"),sep = ""),
             stringsAsFactors=FALSE)
}) -> dat




comparis <- as.data.frame(dat)

comparis = comparis[-1,]
save(comparis,file="MapApp/webscraping_websites/comparis.Rda")
