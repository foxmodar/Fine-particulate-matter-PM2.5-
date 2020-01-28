
source("Libraries.R")

if(!exists("SCC") | !exists("NEI")) {
        
        source("LoadData.R")    
}        


# Question 3 :In four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions- 
# from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

# Solution : 3

# Get Baltimore City Data
        
        Baltimore <- SCC %>% subset(fips == "24510")

# sammarize baltimore data and group by year, add the sum of the emission per year divided by 1000

        BaltByType <- as.tbl(summarise(group_by(Baltimore, year,type), Emissions=sum(Emissions)/1000))

        # step in images dir to save png there
        
        setwd("Images/")
        png("plot3.png", width = 900, height = 700)

        plot3 <-      ggplot(BaltByType, aes(x=factor(year), y=Emissions, fill=type , label = round(Emissions,2))) +
                      geom_bar(stat="identity") +
                      facet_grid(. ~ type) +
                      facet_wrap(. ~ type, ncol = 2)+
                      xlab("year") +
                      ylab(expression("Total PM"[2.5]*" Emission in Kilotons")) +
                      ggtitle(expression(" -- PM"[2.5]*paste(" Baltimore ",
                                                             "City Emission --", sep="")))+
                      geom_label(aes(fill = type), colour = "black", fontface = "bold", size = 3.0) +
                      #scale_fill_discrete(name="Source Type") +
                      scale_fill_brewer(palette="Paired", name="Source")+
                      theme_tufte()
        print(plot3)
       
         setwd("..")
        
         dev.off()