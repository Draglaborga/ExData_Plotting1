plot4 <- function(){
  library(data.table)
  library(dplyr)
  library(bit64)
  library(xtable)
  
  
  data <- fread("data/household_power_consumption.txt", 
                verbose=F, header = T, sep=';', na.strings='?', 
                colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
  data <- data %>% filter (grepl('^1/2/2007|^2/2/2007', Date)) %>% 
    mutate(date_time=paste(Date, Time, sep=' '),
           Global_active_power=as.numeric(Global_active_power)) 
  
  x <- strptime(data$date_time, format="%d/%m/%Y %H:%M:%S")
  
  
  print(tail(data))
  
    
  png("plot4.png", width=480, height=480)
  
  par(mfrow=c(2,2), oma = c(0,0,0,0))
  plot(x, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  plot(x, data$Voltage, type="l", xlab="datetime", ylab="Voltage")
  plot(x, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black")
  lines(x, data$Sub_metering_2, type="l", col="red")
  lines(x, data$Sub_metering_3, type="l", col="blue")
  legend("topright", lty=1, bty="n", col=c("black", "blue","red"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(x, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
 dev.off()
  
}
