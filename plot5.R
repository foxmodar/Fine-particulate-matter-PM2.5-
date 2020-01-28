source("Libraries.R")

if(!exists("SCC") | !exists("NEI")) {
  
  source("LoadData.R")    
}        


# Question :5
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Solution :5     
      
      Baltimore <- SCC %>% subset(fips == "24510")
      
      BaltData <- left_join(Baltimore, NEI, "SCC")
      
      BaltData <- BaltData %>% 
        select(SCC, Pollutant, Emissions, type, year)
      
      OnRoadEm <- BaltData %>% 
                  select(year, Emissions, type) %>%
                  subset(type == "ON-ROAD") 

      BaltOnRoad <- summarise(group_by(OnRoadEm, year), Emissions=sum(Emissions))
      
      setwd("Images/")
      png("plot5.png", width = 480, height = 480)

      plot5  <-   ggplot(BaltOnRoad, aes(x=factor(year), y=Emissions, fill= as.factor(year) , label = round(Emissions,2))) +
                  geom_bar(stat="identity") +
                  xlab("year") +
                  ylim(0,400)+
                  ylab(expression("PM"[2.5]*" Emission in Metric Tons - Baltimore")) +
                  ggtitle(expression("PM"[2.5]*paste("Emission -",
                                                     " Motor Vehicle Related-Baltimore", sep="")))+
                  geom_label(aes(fill = as.factor(year)), colour = "white", fontface = "bold", size = 3.0) +
                  scale_fill_brewer(palette="Set1", name="Baltimore")+
                  theme_economist()
      print(plot5)
      setwd("..")
      dev.off()