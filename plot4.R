#plot 4
#Gather and Transform Data
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="power.zip")
PowerConsumption = read.table(unz("power.zip","household_power_consumption.txt"),sep=";", header=TRUE, stringsAsFactors=FALSE)
DateTimeFunction=function(x,y) {paste(x,y,sep=" ")}

#Process Data
PowerConsumption$Date_Time1=mapply(DateTimeFunction,PowerConsumption$Date,PowerConsumption$Time)
PowerConsumption$Date_Time=strptime(PowerConsumption$Date_Time1,format="%d/%m/%Y %H:%M:%S")
PowerConsumption$Date=strptime(PowerConsumption$Date, format="%d/%m/%Y")
PowerConsumption$Global_active_power=as.numeric(PowerConsumption$Global_active_power)
PowerConsumption$Global_intensity=as.numeric(PowerConsumption$Global_intensity)
PowerConsumption$Global_reactive_power=as.numeric(PowerConsumption$Global_reactive_power)
PowerConsumption$Sub_metering_1=as.numeric(PowerConsumption$Sub_metering_1)
PowerConsumption$Sub_metering_2=as.numeric(PowerConsumption$Sub_metering_2)
PowerConsumption$Sub_metering_3=as.numeric(PowerConsumption$Sub_metering_3)
PowerConsumption$Voltage=as.numeric(PowerConsumption$Voltage)

#Subset Data
PowerConsumption=subset(PowerConsumption,PowerConsumption$Date>as.POSIXlt("2007-01-31") & PowerConsumption$Date<as.POSIXlt("2007-02-03"))

#Create Plot
png(file="plot4.png",width=480,height=480)
par(mfrow=c(2,2))
#Top left plot
plot(PowerConsumption$Date_Time,PowerConsumption$Global_active_power, type="l", xlab="",ylab="Global Active Power")
#Top right plot
plot(PowerConsumption$Date_Time,PowerConsumption$Voltage, type="l", xlab="datetime",ylab="Voltage")
#Bottom left plot
plot(PowerConsumption$Date_Time,PowerConsumption$Sub_metering_1, type="l", xlab="",ylab="Energy sub metering")
lines(PowerConsumption$Date_Time,PowerConsumption$Sub_metering_2,col="red")
lines(PowerConsumption$Date_Time,PowerConsumption$Sub_metering_3,col="blue")
legend("topright",lty=1,col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#Bottom right plot
plot(PowerConsumption$Date_Time,PowerConsumption$Global_reactive_power, type="l", xlab="datetime",ylab="Global_reactive_power")
dev.off()