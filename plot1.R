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
##EPC$Time <- strptime(EPC$Time, "%H:%M:%S")


## Plot 1
PlotLabels <- as.character(seq(0, max(EPC$Global_active_power), by = 0.5 ))

EPC$GlobalActivePowerCuts <- cut(EPC$Global_active_power, 
                                 seq(0, max(EPC$Global_active_power) + 0.5, by = 0.5))
Plot1Data <- table(EPC$GlobalActivePowerCuts)
names(Plot1Data) <- PlotLabels
plot(Plot1Data, type="l", lwd=4)
barplot(
    Plot1Data, 
    col="Red", 
    space=0, 
    xlab="Global Active Power (killowats)",
    ylab="Frequency",
    main="Global Active Power",
    axisnames=FALSE)
axis(side=1, at=c(0,4,8,12), labels=c(0,2,4,6)), tck=-0.05)
dev.copy(device = png, file = "plot1.png", width=480, height=480)
dev.off()