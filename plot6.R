source("Libraries.R")

if(!exists("SCC") | !exists("NEI")) {
  
  source("LoadData.R")    
}        


# Question :6
                  # Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
                  # California [fips == "06037"]. Which city has seen greater changes over time in motor vehicle emissions?
# Solution :6
                  # Baltimore data in Q5, Next get los angeles data
                  
                  Baltimore <- SCC %>% subset(fips == "24510" & type == "ON-ROAD") ; Baltimore$City <- "Baltimore City"
                  
                  Baltimore <- summarise(group_by(Baltimore, City, year), Emissions = sum(Emissions))
                  
                  
                  
                  
                  LA <- SCC %>% subset(fips == "06037" & type == "ON-ROAD") ; LA$City <- "Los Angeles"
                  
                  LA <- summarise(group_by(LA, City,  year), Emissions = sum(Emissions))
                  
                  setwd("Images/")
                  png("plot6.png", width = 600, height = 600) 
                  
                  plotB  <-   ggplot(Baltimore, aes(x=factor(year), y=Emissions, fill= as.factor(year) , label = round(Emissions,2))) +
                              geom_bar(stat="identity") +
                              xlab("year") +
                              #ylim(0,400)+
                              ylab(expression("PM"[2.5]*" Emission in Metric Tons - Baltimore")) +
                              ggtitle(expression("PM"[2.5]*paste("Emission -",
                                                                 " Motor Vehicle Related", sep="")))+
                              geom_label(aes(fill = as.factor(year)), colour = "white", fontface = "bold", size = 3.0) +
                              scale_fill_brewer(palette="Set1", name="Baltimore")+
                              theme_economist()
                  
                  
                  plotL  <-   ggplot(LA, aes(x=factor(year), y=Emissions, fill= as.factor(year) , label = round(Emissions,2))) +
                              geom_bar(stat="identity") +
                              xlab("year") +
                              #ylim(0,400)+
                              ylab(expression("PM"[2.5]*" Emission in Metric Tons - Los Angeles")) +
                              ggtitle(expression("PM"[2.5]*paste("Emission -",
                                                                 " Motor Vehicle Related", sep="")))+
                              geom_label(aes(fill = as.factor(year)), colour = "white", fontface = "bold", size = 3.0) +
                              scale_fill_brewer(palette="Set1", name="Los Angeles")+
                              theme_economist()
                  
                 plot6 <-  grid.arrange(plotB, plotL, nrow = 2)
        
                 print(plot6)
                 setwd("..")
                 dev.off()
                 
                  