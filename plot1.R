## Data Exploration by Ron Collins
## assignment #1, Plot number 1

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
   
## Plot histogram of global Activity poser
# Open graphic device
windows()
#plot Histogram
par(oma=c(4,1,4.5,0) )
par(mar=c(4,4,4,0))

hist(df2$Global_active_power, col = "red", main = "Global Active Power",xlab = "Global Active Power (kilowatts)")
# Box around plot
mtext("Plot 1", side=3, line=3, cex=2, col="black", outer=TRUE, adj = 0) 
 
dev.copy(png,'plot1.png')
dev.off()
