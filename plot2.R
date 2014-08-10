library(pryr)

## Read few lines in order to calculate the memory needed 
EPC <- read.table("household_power_consumption.txt", nrows = 100, sep = ";", header = TRUE)
FileSize <- object_size(EPC) / nrow(EPC) * 2075259 
print(paste("Total of needed memory:", round(FileSize / 1000 / 1000, 0), 'MB'))

## Read the entire table and select just the data that will be used
EPC <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
EPC$Date <- as.Date(EPC$Date, "%d/%m/%Y")

EPC <- EPC[EPC$Date == as.Date("2007-02-01") | EPC$Date == as.Date("2007-02-02"),]
EPC$Global_active_power <- as.numeric(levels(EPC$Global_active_power))[EPC$Global_active_power]
EPC$Time <- strptime(paste(format(EPC$Date, "%d/%m/%Y"), EPC$Time), "%d/%m/%Y %H:%M:%S")

Plot2Data <- EPC[ ,c(2, 3)]
plot(
    Plot2Data, 
    ylab="Global Active Power (killowats)",
    xlab="",
    type="l")
dev.copy(device = png, file = "plot2.png", width=480, height=480)
dev.off()
