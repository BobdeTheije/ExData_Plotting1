library(sqldf)

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"


#Download if not already available
if(!file.exists("./household_power_consumption.zip"))
{
    download.file(fileUrl,destfile="./household_power_consumption.zip")
}


# Unzip if not already available
if (!file.exists("household_power_consumption.txt")) 
{ 
    unzip("./household_power_consumption.zip") 
}

# read the data
# hhpowercon_all <-read.csv2 ("./household_power_consumption.txt", na.strings = "?", dec=".")

#subset the data needed
# hhpowercon <- subset(hhpowercon_all, Date == "1/2/2007"|Date =="2/2/2007")

# other option only read the subset
hhpowercon <- read.csv.sql("./household_power_consumption.txt", "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", sep=";")

closeAllConnections()


# convert Date and Time column to date and datetime columns
hhpowercon$Time <-strptime(paste(hhpowercon$Date,hhpowercon$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
hhpowercon$Date <- as.Date(hhpowercon$Date, "%d/%m/%Y") 
 
# Create png file

png(file = "plot2.png", width = 480, height = 480)

with(hhpowercon, plot(Time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

dev.off()