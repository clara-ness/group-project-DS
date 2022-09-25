<p align="center">

  <img width="300px" height="300px" src="https://github.com/juustcrnt/group-project-DS/blob/master/logo/logo-4.png"/>
  <h3 align="center">The CollocMap</h3>

  <p align="center">
    Welcome to the CollocMap !
    <br />
    <a href="https://github.com/juustcrnt/group-project-DS/blob/master/README.md><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/juustcrnt/group-project-DS/issues">Report Bug</a>
    ·
    <a href="https://github.com/juustcrnt/group-project-DS/issues">Request Feature</a>
    ·
    <a href="https://data-science-geneva.shinyapps.io/mapapp/">View Demo</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

When a student arrives at a new university, he or she usually knows little or nothing about the city. This asymmetry of information can generate a real obstacle in the search for the most appropriate collocation. With this in mind, we decided to create the CollocMap. This web app allows you to find in a few clicks the flatshare offers that correspond the most to your quality of life criteria: public transportation services, the offer of food supermarkets, the number of bars and parks nearby or even the political affiliation of your neighborhood.

### Built With

The tool is built in several parts, each dealing with a part of the data science course: 

Webscraping, Matrix Data Processing, Shiny, and the many other technologies: Leaflet, Dplyr, etc.
                                   
* [Shiny](https://shiny.rstudio.com)
* [Shinyapps.io](https://shinyapps.io)
* [Dplyr](https://dplyr.tidyverse.org)
* [Leaflet](https://rstudio.github.io/leaflet/)
* [DT](https://cran.r-project.org/web/packages/DT/DT.pdf)
* [Deeplr](https://cran.r-project.org/web/packages/deeplr/index.html)
* [Rvest](https://github.com/tidyverse/rvest)
                                   
<!-- GETTING STARTED -->
## Getting Started

Here are the instructions on setting up the CollocMap.
To get a local copy up and running follow these simple example steps.

### Prerequisites

The project can either be run locally or pushed online using [shinyapps.io](https://www.shinyapps.io)

### Installation

1. Install R-Studio on your computer
2. Clone the repo
   ```sh
   git clone https://github.com/juustcrnt/group-project-DS.git
   ```
3. Open the repo
4. Source or command+all+enter all lines of [main.r](MapApp/webscraping_websites/MAIN.R)
5. Run [app.R](MapApp/app.R)
                                   
<!-- USAGE EXAMPLES -->
## Usage

The tool is built in several parts, each dealing with a part of the data science course: 

Webscraping, Matrix Data Processing, Shiny, and the many other technologies: Leaflet, Dplyr, etc.

The project consists of three parts: 

1) The [webscraping_websites](MapApp/webscraping_websites) folder, which is used to fetch information about collocations in Geneva, via sourcing from the central [main.r](MapApp/webscraping_websites/main.r) file, which will launch all our crawlers, then merge the data with merge.R and finally return main.Rda

2) The [geojson_manipulation](MapApp/geojson_manipulation), which is used to combine the data of our geojson file containing the polygons of each commune, with the information of each commune that we have gathered in the csv file
                                   
3) The [Communes.R](MapApp/webscraping_websites/Communes.R) file, which webscrapes in 1500 lines of code the different informations from the communes in the canton of Geneva, translate it using [Deepl.com](deepl.com) and save it into [communes.Rda](MapApp/webscraping_websites/communes.Rda)

4) The [Map](MapApp/app.R), which displays the communes and, when clicked, the table of all the collocations available in the commune
                                   
5) The sidebar-panel displaying live informations about each commune in French, coming from our 1500 lines of code webscraping-script [Communes.R](MapApp/webscraping_websites/Communes.R)       
                                   
6) The n-dimensional filtering system of the interest parameters of the future tenants, which updates the attractiveness indexes (from 1 to 100) of each commune according to all the selected checkboxes.   
                                   
When you arrive on the CollocMap, click on a commune to see all available collocations. They can be sorted by price or by keywords, and the button on each line allows you to go to the desired ad. If a commune does not contain any collocations, the table will remain on the collocations of the previous commune kept in memory. For each clicked commune, a button in the sidebar allows you to load the description of the commune. When you click on each blason you get redirected to the current commune's [Wikipedia](https://wikipedia.org) page.

The filter system calculates a satisfaction ratio from 1 to 100 per commune, the total sum of the ratios in the whole canton being 100. The ratios are calculated by taking the weighted average of each of the data selected by checkbox. The system thus calculates a dynamic ratio according to the choices, preferences and profiles of the user. 

Particular attention has been paid to the accessibility of the tool. The site is fully responsive, the colors are adapted to color-blinded people, and the data reloads each time a user arrives on the map. The site is online and has been speciically thought to adapt on mobile.

_For more examples, please refer to the [Live Version](https://data-science-geneva.shinyapps.io/mapapp/)_

<!-- DATA USED -->
## Data Used

The following websites were used to webscrape the collocations : 
                                   
1. [Amanet.ch](MapApp/webscraping_websites/amanet.R)
2. [Anibis.ch](MapApp/webscraping_websites/annibis2.R)
3. [Colocataire.ch](MapApp/webscraping_websites/colocataire_v2.R)
4. [Comparis.ch](MapApp/webscraping_websites/comparis.r)
5. [Realadvisor.ch](https://github.com/juustcrnt/group-project-DS/blob/master/MapApp/webscraping_websites/realadvisor.r)
6. [Roomgo.ch](MapApp/webscraping_websites/roomgo.R)
7. [Roomlala.com](MapApp/webscraping_websites/roomlala.R)                 
8. [Sharehome.ch](MapApp/webscraping_websites/sharehome.R)
9. [Students.ch](MapApp/webscraping_websites/students.R)
10. [Tutti.ch](MapApp/webscraping_websites/tutti.r)                                   
11. [PetitesAnnonces.ch](MapApp/webscraping_websites/Petites%20Annonces.R)
                                   
All these scripts are runned using [main.r](MapApp/webscraping_websites/MAIN.R) which calls [merge.r](MapApp/webscraping_websites/merge.R) to output [main.Rda](MapApp/webscraping_websites/main.Rda). To update the data live, add a source() function to the [CollocMap](MapApp/app.R) server function, or add an external [Cron Job](https://cran.r-project.org/web/packages/cronR/vignettes/cronR.html) to update the main.Rda file on a timely basis.

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<!-- CONTACT -->
## Contact
                                   
If you have any question feel free to contact us at [jacs.geneva@gmail.com](mailto:jacs.geneva@gmail.com)            

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
*  Prof. Stéphane Guerrier, Assistant Yuming Zhang, Assistant Lionel Voirol, and the [SMAC Group](https://github.com/SMAC-Group) for their tremendous knowledge shared with us                         
* [GE SITG](https://ge.ch/sitg/sitg_catalog/sitg_donnees?keyword=&distribution=tous&datatype=tous&topic=boundaries&service=tous) for the polygonal geoshapes
* [GE.ch](https://www.ge.ch/document/statistique-policiere-criminalite-2019) for the crime records
* [BFS ADMIN](https://www.bfs.admin.ch/bfs/fr/home/statistiques/statistique-regions/portraits-regionaux-chiffres-cles/communes.assetdetail.15864461.html) for the population demographic statistics

