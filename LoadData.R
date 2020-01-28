# check for data dirictory and create one

        # if (!file.exists("./RawData")) {
        #   dir.create("./RawData")
        # }

# unzip file containing 1999, 2002, 2005, and 2008 data

        # setwd("RawData/")
        # unzip("exdata_data_NEI_data.zip")
        # setwd("..")

# Extract data into environment

        NEI <- readRDS("RawData/Source_Classification_Code.rds")
        SCC <- readRDS("RawData/summarySCC_PM25.rds")

# Convert values to Metric Tonne

        SCC$Emissions <- SCC$Emissions * 0.907185

