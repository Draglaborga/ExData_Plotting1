plot2 <- function(){
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
  plot(x, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  dev.copy(png, file="plot2.png", width = 480, height = 480)
  dev.off()
  
}
