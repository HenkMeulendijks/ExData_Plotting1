##Week 1 Assignment

#Define folders and download locations. Download if file does not exist. Unzip if file is not already unzipped. Install packages if not installed
DefaultFolder <- file.path(getwd(), "ExploratoryDataAnalysis/Week1")
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
FileName <- file.path(DefaultFolder, "hpc.zip")
if (!file.exists(DefaultFolder )) dir.create(DefaultFolder)
if (!file.exists(FileName)) download.file(URL, FileName, mode = "wb") else print("File to download already existing")
UnzipFile <- file.path(DefaultFolder, "household_power_consumption.txt")
if (!file.exists(UnzipFile)) unzip(FileName, exdir = DefaultFolder) else print("Unzipped file already existing")
if (!require("data.table")) install.packages("data.table") else print("data.table already installed")

library(data.table)
power<-fread(UnzipFile,header=TRUE,sep=";",na.strings="?")
power$newdate <- as.Date(power$Date,format="%d/%m/%Y")
powerdates <- power[newdate>="2007-02-01" & newdate<="2007-02-02"]
## plot 1
par(mfrow=c(1,1))
hist(powerdates$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
FileName <- file.path(DefaultFolder, "plot1.png")
dev.copy(png, file=FileName, width=480, height=480)
print("plot1.png has been saved")
dev.off()