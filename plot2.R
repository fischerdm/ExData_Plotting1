############################## plot 2 ##############################
####################################################################

# set working directory to ExData_Plotting1

# create a data directory beside the ExData_Plotting1 directory if there is no such directory
if(!file.exists("./../Data")) {
        dir.create("./../Data")
}

# check if file exists. If not, download the file
if(!file.exists("./../Data/houshold_power_consumption.zip")) {
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url, destfile = "./../Data/houshold_power_consumption.zip", method = "curl")
}

# unzip file and load the first 5 lines to extract the colClasses
d1 <- unz("./../Data/houshold_power_consumption.zip", "household_power_consumption.txt")
data5r <- read.table(d1, sep = ";", header = T, na.strings = "?", nrows = 5)
classes <- sapply(data5r, class)

# read data
d2 <- unz("./../Data/houshold_power_consumption.zip", "household_power_consumption.txt")
data <- read.table(d2, sep = ";", header = T, na.strings = "?", colClasses = classes, nrows = 100000)

# format dates
data$Date <- as.Date(data$Date, '%d/%m/%Y')

# create subset
data <- subset(data, data$Date>="2007-02-01" & data$Date<="2007-02-02")

# create a vector with the weekdays. Later, this vector is used for plotting the x-axis
Sys.setlocale("LC_TIME", "en_US")
weekdays <- unique(weekdays(data$Date, abbreviate = T))
Sys.setlocale("LC_TIME", "de_DE")

# create a vector with the positions of the weekdays. Later, this vector is used for plotting the x-axis
position1 <- which(data$Time == "00:00:00")
position2 <- which(data$Date == "2007-02-02" & data$Time == "23:59:00") + 1

#############################################################################
# plot
png(file="./../ExData_Plotting1/plot2.png", width=480, height=480, units="px")
#plot(data$datetime, data$Global_active_power, data$Date, col="black", ylab="Global Active Power (kilowatts)", xlab = "", main="Global Active Power", type = "l")
plot(data$Global_active_power, col="black", ylab="Global Active Power (kilowatts)", xaxt="n", xlab = "", type = "l")
axis(side=1, at=c(position1, position2), labels=c(weekdays, "Sat"))
dev.off()