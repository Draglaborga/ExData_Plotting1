plot1 <- function(){
  library(data.table)
  library(dplyr)
  library(bit64)
  library(xtable)
  
  
  data <- fread("data/household_power_consumption.txt", 
                verbose=F, header = T, sep=';', na.strings='?', 
                colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
  data <- data %>% filter (grepl('^1/2/2007|^2/2/2007', Date)) %>% 
    mutate(Date=as.Date(Date,"%d/%m/%Y"), Global_active_power=as.numeric(Global_active_power)) 
  
  with(data, hist(data$Global_active_power, 
                  col="red",
                  main="Global Active Power", xlab="Global Active Power (kilowatts)"))
  dev.copy(png, file="plot1.png", width = 480, height = 480)
  dev.off()
  
}
