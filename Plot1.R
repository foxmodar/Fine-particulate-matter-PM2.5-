source("Libraries.R")

if(!exists("SCC") | !exists("NEI")) {
        
        source("LoadData.R")    
}        


# Question 1 : Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Solution 1

# Cleanup date to summarize SCC by date then by source , then add the sum of emission by year.

        pm2.5 <- summarise(group_by(SCC, year), Emissions =sum(Emissions)/1000)

# Define the colors for the bars      
        
        BarCol <- c("red", "orange", "yellow", "green")
        
# step in images dir to save png there
        
        setwd("Images/")
        png("plot1.png", width = 480 , height = 480)
        
# Plot the data with years on X and Emission on Y.

        p1 <-      barplot(height=pm2.5$Emissions,
                              names.arg = pm2.5$year,
                              xlab="years",
                              ylab=expression('Total PM-2.5 Emission (metric megatonne)'),
                              ylim=c(0,8000),
                              main=expression('Total PM-2.5 Emission (metric megatonne)'),
                              col=BarCol)
        
# Add emission values labels to bars 
        
                              text(x = p1, y = round(pm2.5$Emissions,2), label = round(pm2.5$Emissions,2), pos = 3, cex = 0.8, col = "black")        
                              
        setwd("..")

        dev.off()