library(pryr)

## Read few lines in order to calculate the memory needed 
EPC <- read.table("household_power_consumption.txt", nrows = 100, sep = ";", header = TRUE)
FileSize <- object_size(EPC) / nrow(EPC) * 2075259 
print(paste("Total of needed memory:", round(FileSize / 1000 / 1000, 0), 'MB'))

## Read the entire table and select just the data that will be used
EPC <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
EPC$Date <- as.Date(EPC$Date, "%d/%m/%Y")

EPC <- EPC[EPC$Date == as.Date("2007-02-01") | EPC$Date == as.Date("2007-02-02"),]
EPC$Time <- strptime(paste(format(EPC$Date, "%d/%m/%Y"), EPC$Time), "%d/%m/%Y %H:%M:%S")
EPC$Global_active_power <- 
    as.numeric(levels(EPC$Global_active_power))[EPC$Global_active_power]
EPC$Global_reactive_power <- 
    as.numeric(levels(EPC$Global_reactive_power))[EPC$Global_reactive_power]
EPC$Voltage<- 
    as.numeric(levels(EPC$Voltage))[EPC$Voltage]
EPC$Global_intensity <- 
    as.numeric(levels(EPC$Global_intensity))[EPC$Global_intensity]
EPC$Sub_metering_1 <- 
    as.numeric(levels(EPC$Sub_metering_1))[EPC$Sub_metering_1]
EPC$Sub_metering_2 <- 
    as.numeric(levels(EPC$Sub_metering_2))[EPC$Sub_metering_2]
EPC$Sub_metering_3 <- 
    as.numeric(levels(EPC$Sub_metering_3))[EPC$Sub_metering_3]
class(EPC$Sub_metering_3)


par(mfrow = c(2, 2))
Plot4Data1 <- EPC[, c(2, 3)]
plot(
    Plot4Data1, 
    ylab="Global Active Power",
    xlab="",
    type="l")

Plot4Data2 <- EPC[, c(2, 5)]
plot(
    Plot4Data2, 
    ylab="Voltage",
    xlab="datetime",
    type="l")

Plot4Data3 <- EPC[ ,c(2, 7, 8, 9)]
plot(
    Plot4Data3[, c(1,2)], 
    ylab="Energy sub metering",
    xlab="",
    type="l")
lines(
    Plot4Data3[, c(1,3)],
    col="Red")
lines(
    Plot4Data3[, c(1,4)],
    col="Blue")
legend(
    "topright", 
    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3        "),
    col=c("Black", "Red", "Blue"),
    lty = 1,
    xjust = 1, 
    yjust = 1, 
    pt.cex=1, 
    cex=0.75)

Plot4Data4 <- EPC[, c(2, 4)]
plot(
    Plot4Data4, 
    ylab="Global Reactive Power",
    xlab="datetime",
    type="l")
dev.copy(device = png, file = "plot4.png", width=480, height=480)
dev.off()