source("Libraries.R")

if(!exists("SCC") | !exists("NEI")) {
        
        source("LoadData.R")    
}        


# # Question 2 : Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.

# Solution : 2

#Extract Baltiomre data from SCC

        Baltimore <- SCC[SCC$fips == 24510, ]
# sammarize data and group by year, add the sum of the emission per year divided by 1000
        
        BaltByYear <- summarise(group_by(Baltimore, year), Emissions = sum(Emissions))
        
        BarCol <- c("red", "orange", "yellow", "green")
        
       # range(BaltByYear$Emissions) # To verify the range to use in y
        
# step in images dir to save png there
        
        setwd("Images/")
        png("plot2.png", width = 480 , height = 480)
                
# The Plot for Baltimore City
          p2<-       barplot(height=BaltByYear$Emissions,
                     names.arg = BaltByYear$year,
                     xlab="years - (3Y Range)",
                     ylab=expression('Baltimore PM-2.5 Emission (metric tonne)'),
                     ylim=c(0,4000),
                     main=expression('Baltimore PM-2.5 Emission (metric tonne)'),
                     col=BarCol)
# Add emission values labels to bars 
                     text(x = p2, y=round(BaltByYear$Emissions, 2), labels = round(BaltByYear$Emissions, 2), pos = 3, cex = 0.8, col = "black")
                     
         setwd("..")
                     
         dev.off()