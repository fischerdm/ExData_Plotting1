############################## plot 1 ##############################
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

#############################################################################
# plot
png(file="./../ExData_Plotting1/plot1.png",width=480,height=480, units="px")
hist(data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()