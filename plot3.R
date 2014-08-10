## Data Exploration by Ron Collins
## assignment #1, plot number 3

## Read in download zipped txt file, Unzip file and read it Using ? as missing data symbol
## and ";" as the seperation character

# Create temp file
temp <- tempfile()
#download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_cons##umption.zip"household_power_consumption1.zip,)

# Download zipp file from internet into temp file
download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip", temp)

Read and unzip file from temp folder
proj1_data <- read.table(unz(temp, "household_power_consumption.txt"),sep=";", header=TRUE,na.strings = "?")

# convert date vector from character to date
proj1_data$Date <- strptime(proj1_data$Date, format = "%d/%m/%Y")
proj1_data$Date <- as.Date(proj1_data$Date, format = "%d/%m/%Y")

# save data whose date is greater or equal to 2/1/2007
df <- proj1_data[proj1_data$Date >="2007-2-01",]
# save data whose date is less than 2/3/20077
df2 <- df[df$Date < "2007-2-03",]

# replace the missing data symbol"?" with NA
for (i in 1:length(df2[,6])){
    if(df2[i,7] == "?"){
        df2[i,7] <- NA
    } 
}


##create vector with numbers 1-2880 for ploting
date_order <- 1:2880 #date-time vector

# add date_time vector to df2 dataframe
df3 <- cbind(date_order,df2)


## Plot histogram of global Activity poser with number sequence
# open plotting device
windows()

#set plotting margins
par(oma=c(4,1,4.5,0) )
par(mar=c(4,4,4,0))

plot(df3$date_order, df3$Sub_metering_1, col = "black", ylab = "Energy sub metering", xlab = " ", type = "l",xaxt='n')

axis(side = 1, at = c(1, 1440, 2880), labels = c("Thu", "Fri", "Sat"), tcl = -0.2)

lines(df3$date_order, df3$Sub_metering_2, col = "red",  type = "l")

lines(df3$date_order, df3$Sub_metering_3, col = "blue",  type = "l")

legend('topright',  col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty =1)

mtext("Plot 3", side=3, line=3, cex=2, col="black", outer=TRUE, adj = 0) 


dev.copy(png,'plot3.png')
dev.off()