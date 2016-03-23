##Week 1 Assignment

#Define folders and download locations
DefaultFolder <- file.path(getwd(), "ExploratoryDataAnalysis/Week1")
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
FileName <- file.path(DefaultFolder, "hpc.zip")
if (!file.exists(DefaultFolder )) dir.create(DefaultFolder)
if (!file.exists(FileName)) download.file(URL, FileName, mode = "wb") else cat("File to download already existing")
UnzipFile <- file.path(DefaultFolder, "household_power_consumption.txt")
if (!file.exists(UnzipFile)) unzip(FileName, exdir = DefaultFolder) else cat("Unzipped file already existing")
if (!require("data.table")) install.packages("data.table") else cat("data.table already installed")

library(data.table)
power<-fread(UnzipFile,header=TRUE,sep=";",na.strings="?")
power$newdate <- as.Date(power$Date,format="%d/%m/%Y") 
powerdates <- power[newdate>="2007-02-01" & newdate<="2007-02-02"] #use subset
powerdates$newtime <- as.POSIXct(strptime(paste(powerdates$Date,powerdates$Time,sep="*"),format="%d/%m/%Y*%H:%M:%S"))

## plot 2
plot(powerdates$newtime,powerdates$Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(powerdates$newtime,powerdates$Global_active_power)
FileName <- file.path(DefaultFolder, "plot2.png")
dev.copy(png, file=FileName, width=480, height=480)
print("Graph plotted")
dev.off()