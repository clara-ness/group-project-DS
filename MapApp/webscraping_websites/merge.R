
load(file = "MapApp/webscraping_websites/anibis2.rda")
load(file = "MapApp/webscraping_websites/realadvisor.rda")
load(file = "MapApp/webscraping_websites/comparis.rda")
load(file = "MapApp/webscraping_websites/colocataire.rda")
load(file = "MapApp/webscraping_websites/petitesannonces.rda")
load(file = "MapApp/webscraping_websites/roomlala.rda")
load(file = "MapApp/webscraping_websites/tutti.rda")
load(file = "MapApp/webscraping_websites/students.rda")
load(file = "MapApp/webscraping_websites/sharehome.rda")
load(file = "MapApp/webscraping_websites/amanet.rda")


main_file = dplyr::bind_rows(anibis2,realadvisor,comparis, petitesannonces_data, colocataire_data, roomlala, tutti, students_data2,sharehome_data, amanet_data)
main_file = main_file[,c(-5)]
save(main_file,file="MapApp/webscraping_websites/main.Rda")