library(shiny)
library(shinyjs)
library(leaflet)
library(rgdal)
library(DT)
library(tidyverse)

#We load the main geojson file

genevaOrigin <- geojsonio::geojson_read("geojson_manipulation/main.geojson", what = "sp")

#We simplify the polygon shapes for faster rendering

geneva <- rmapshaper::ms_simplify(genevaOrigin, keep = 0.01, keep_shapes = FALSE)

ui <- fluidPage(
    
    useShinyjs(),
    tags$head(#Style des boutons a
        tags$style(
            HTML(
                "
               a.button {
                    -webkit-appearance: button;
                    -moz-appearance: button;
                    appearance: button;
                    text-decoration: none;
                    color: initial;
                    padding : 5px;
                }
           "
            )
        )),
    titlePanel(
        h1("Find roomates to live with in the perfect place !"),
    ),
    title = "Find roomates to live with in the perfect place !",
    sidebarLayout(
        sidebarPanel(
            checkboxGroupInput(
                "variable",
                "What parameters are you interested in?",
                c(
                    "Restaurants" = "Restaurant",
                    "Bars" = "Bars",
                    "Fitness" = "Fitness",
                    "Parks" = "Park",
                    "Criminal Offences" = "Penal",
                    "Bakery" = "Bakery",
                    "PDC" = "CVP",
                    "UDC" = "SVP",
                    "PS" = "SP",
                    "Green" = "GPS",
                    "Communists" = "PdA.Sol.",
                    "PLR" = "FDP.PLR.2.",
                    "Young" = "age_0_19.x",
                    "Middle age" = "age_20_64.x",
                    "Retired" = "age_65_plus.x",
                    "All supermarkets" = "Total",
                    "Coop" = "Coop",
                    "Migros" = "Migros",
                    "Aldi" = "Aldi",
                    "Lidl" = "Lidl"
                ),
                selected = c("Restaurant")
            ),
            br(),
            actionButton("btn2", "Show / hide commune info"),
            #actionButton("btn", "Show / hide commune description"),
        ),
        
        mainPanel(leafletOutput("mymap"),
                  p(),
                  fluidRow(
                      column(2, hidden(htmlOutput("picture")), align = "left"),
                      column(8, h1(hidden(textOutput("communeName"))), align = "center"),
                      column(2, hidden(htmlOutput("picture2")), align = "right")
                  ),
                  p(),
                  hidden(textOutput("communeDesc")),
                  p(),
                  fluidRow(column(
                      12,
                      DT::dataTableOutput("mytable")
                  )))
    ),
    br(),
    br(),
    fluidPage(helpText(
        p(
            style = "text-align: justify;",
            "Note: You can also find more information on the quality of life in Geneva, in particular the air quality published live on the airCHeck application (",
            tags$a(href = "https://apps.apple.com/ch/app/aircheck/id577766644?l=en&ls=1",
                   "link 1"),
            ") or the noise level for each building on the interactive SITG map (",
            tags$a(href = "https://www.etat.ge.ch/geoportail/pro/?portalresources=SPBR_BRUIT_ROUTIER_FACADE",
                   "link 2"),
            ").",
            sep = "",
            style="color:white"
        ),
        style="background-color: black;"
    ))
)



server <- function(input, output, session) {
    
    #We load main.Rda data (the collocations) each time a user arrives on the website
    
    load("webscraping_websites/main.Rda")
    
    load("webscraping_websites/communes.Rda")
    
    #We initialize our base color palette
    
    pal <- colorNumeric("Blues", NULL, reverse=FALSE)
    
    #We update the map data according to the n-dimensional checkbox filter that we developed
    reactiveData <- reactive({
        
        i = length(input$variable)
        
        perc = 1/i
        
        #We check if at least 1 checkbox is checked
        if(i > 0) {
            xsSUM = sum(sapply(input$variable,
                               function(i){ 
                                   (geneva[[i]]*perc)
                               }))
            
            xs = rowSums(sapply(input$variable,
                                function(i){
                                    xlocalSum = sum(geneva[[i]])
                                    ((geneva[[i]]*perc)/xlocalSum + 0.001) #we add safety value because log10(0) is undefined
                                }))
            
            return(xs*100)
            
        } else {
            #If no checkboxes are checked we return a neutral map
            return(0) 
        }
    })
    
    #We render the map data with polygons
    output$mymap <- renderLeaflet({
        
        leaflet(geneva) %>%
            addTiles() %>%
            addPolygons(stroke = TRUE, layerId= ~commune, weight = 0.7, smoothFactor = 0.3, fillOpacity = 1,
                        fillColor = ~pal(log10(reactiveData())),
                        label = ~paste0(commune, ": ", formatC(round(reactiveData(), 5), big.mark = ","))) %>%
            addLegend(pal = pal, title ="Scale", values = ~log10(reactiveData()), opacity = 1,
                      labFormat = labelFormat(transform = function(x) round(10^x)))
    })
    
    #We initialize DT with "Genève" on map load
    main_dat = main_file %>% filter(str_detect(lieu, "Genève"))
    main_dat$link <- paste0('<a href="',main_dat$link,'" class="button" target="_blank" rel="noopener noreferrer">Voir la Colloc</a>')
    main_dat$prix<-gsub("’|'|\u2013|\u002D|CHF|[.]|,","",as.character(main_dat$prix))
    main_dat$prix <- as.numeric(iconv(main_dat$prix, 'utf-8', 'ascii', sub=''))
    output$mytable = DT::renderDataTable({
        main_dat
    },escape = FALSE,options = list(order = list(list(3, 'asc'))))
    
    #We initialize Commune Desc with "Genève" on map load
    
    commune_dat_filtered = communes_data2 %>% filter(str_detect(Commune, "Genève"))
    
    output$communeName <- renderText({ 
        commune_dat_filtered$Commune
    })
    
    output$communeDesc <- renderText({ 
        commune_dat_filtered$description
    })
    
    output$picture<-renderText({c('<a href="',commune_dat_filtered$link,'" target="_blank"><img src="',commune_dat_filtered$logo,'"></a>')})
    output$picture2<-renderText({c('<a href="',commune_dat_filtered$link,'" target="_blank"><img src="',commune_dat_filtered$logo,'"></a>')})
    
    
    #button to toggle commune logo, name & description
    observeEvent(input$btn2, {
        toggle("communeDesc", anim = TRUE, animType = "slide")})
    observeEvent(input$btn2, {
        toggle("communeName", anim = TRUE, animType = "slide")})
    observeEvent(input$btn2, {
        toggle("picture", anim = TRUE, animType = "slide")})
    observeEvent(input$btn2, {
        toggle("picture2", anim = TRUE, animType = "slide")})
    
    #We update DT with click$id as "lieu" parameter
    observeEvent(input$mymap_shape_click, {
        
        click <- input$mymap_shape_click
        
        main_dat = main_file %>% filter(str_detect(lieu, click$id))
        
        if(count(main_dat) > 0) {
            
            
            #This Cleans the price data
            main_dat$prix<-gsub("’|'|\u2013|\u002D|CHF|[.]|,","",as.character(main_dat$prix))
            
            main_dat$prix <- as.numeric(iconv(main_dat$prix, 'utf-8', 'ascii', sub=''))
            
            main_dat$link <- paste0('<a href="',main_dat$link,'" class="button" target="_blank" rel="noopener noreferrer">Voir la Colloc</a>')
            
            #check if id(commune name) is empty
            if(!is.null(click$id)){
                #output$table <- renderTable(main_dat)
                output$mytable = DT::renderDataTable({
                    main_dat
                },escape = FALSE,options = list(order = list(list(3, 'asc'))))
            } 
            
        }
        
        commune_dat_filtered = communes_data2 %>% filter(str_detect(Commune, click$id))
        view(commune_dat_filtered)
        
        output$communeName <- renderText({ 
            commune_dat_filtered$Commune
        })
        
        output$communeDesc <- renderText({ 
            commune_dat_filtered$description
        })
        
        output$picture<-renderText({c('<a href="',commune_dat_filtered$link,'" target="_blank"><img src="',commune_dat_filtered$logo,'"></a>')})
        output$picture2<-renderText({c('<a href="',commune_dat_filtered$link,'" target="_blank"><img src="',commune_dat_filtered$logo,'"></a>')})
    })
    
}

shinyApp(ui, server)