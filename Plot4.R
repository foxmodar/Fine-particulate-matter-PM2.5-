source("Libraries.R")

if(!exists("SCC") | !exists("NEI")) {
  
  source("LoadData.R")    
}        


# Question : 4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# Solution : 4

      #head(NEI)
      Joined <- left_join(SCC, NEI, "SCC")
      Joined <- Joined %>% 
        select(SCC, Pollutant, Emissions, type, year,EI.Sector)

      # test <- grepl("coal")
      CoalIndX <- grepl("coal|Coal", Joined$EI.Sector)

      Coal <- Joined[CoalIndX,]


      CoalEm <- Coal %>% select(year,  Emissions)

      CoalEmSum <- as.tbl(summarise(group_by(CoalEm, year), Emissions=sum(Emissions)/1000))
      # step in images dir to save png there      
      setwd("Images/")
      png("plot4.png", width = 480, height = 480)
      
      
         plot4<-  ggplot(CoalEmSum, aes(x=factor(year), y=Emissions, fill= as.factor(year) , label = round(Emissions,2))) +
                  geom_bar(stat="identity") +
                  xlab("year") +
                  ylim(0,700)+
                  ylab(expression("PM"[2.5]*" Emission in Metric Kilotons")) +
                  ggtitle(expression("PM"[2.5]*paste("Emission -",
                                                     " Coal Combustion Related - USA", sep="")))+
                  geom_label(aes(fill = as.factor(year)), colour = "white", fontface = "bold", size = 3.0) +
                  scale_fill_brewer(palette="Set1", name="Periods")+
                  theme_economist()
         print(plot4)
          
      setwd("..")    
      dev.off()