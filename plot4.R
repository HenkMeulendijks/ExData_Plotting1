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
powerdates <- power[newdate>="2007-02-01" & newdate<="2007-02-02"]
powerdates$newtime <- as.POSIXct(strptime(paste(powerdates$Date,powerdates$Time,sep="*"),format="%d/%m/%Y*%H:%M:%S"))

## plot 4
par(mfrow=c(2,2))
## plot 4 a
plot(powerdates$newtime,powerdates$Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(powerdates$newtime,powerdates$Global_active_power)
## plot 4 b
plot(powerdates$newtime,powerdates$Voltage, type="n", xlab="datetime", ylab="Voltage")
lines(powerdates$newtime,powerdates$Voltage)
## plot 4 c
plot(powerdates$newtime,powerdates$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(powerdates$newtime,powerdates$Sub_metering_1, col="black")
lines(powerdates$newtime,powerdates$Sub_metering_2, col="red")
lines(powerdates$newtime,powerdates$Sub_metering_3, col="blue")
legend("topright", lty=1, lwd=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
## plot 4 d
plot(powerdates$newtime,powerdates$Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power")
lines(powerdates$newtime,powerdates$Global_reactive_power)
FileName <- file.path(DefaultFolder, "plot4.png")
dev.copy(png, file=FileName, width=480, height=480)
print("Graph plotted")
dev.off()