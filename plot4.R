pow<-read.table("household_power_consumption.txt", header=TRUE, sep=";")
str(pow)

#make combined date/time variable
pow$newdate <- with(pow, as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))
head(pow$newdate)
class(pow$newdate)

#converting Date column to correct date format and date class
pow$Date<-strptime(as.character(pow$Date), "%d/%m/%Y")
pow$Date<- format(pow$Date, "%Y-%m-%d")
pow$Date<-as.Date(pow$Date)

#convert to numeric
pow$Global_active_power<-as.numeric(as.character(pow$Global_active_power))
pow$Global_reactive_power<-as.numeric(as.character(pow$Global_reactive_power))
pow$Voltage<-as.numeric(as.character(pow$Voltage))
pow$Global_intensity<-as.numeric(as.character(pow$Global_intensity))
pow$Sub_metering_1<-as.numeric(as.character(pow$Sub_metering_1))
pow$Sub_metering_2<-as.numeric(as.character(pow$Sub_metering_2))
pow$Sub_metering_3<-as.numeric(as.character(pow$Sub_metering_3))

#subset data for only 2007-02-01 and 2007-02-02
powdat<-subset(pow, Date=="2007-02-01"|Date=="2007-02-02")

par(mfrow=c(2,2)) # 2 rows, 2 columns

#1st panel
plot(powdat$newdate,powdat$Global_active_power,type="l",
     ylab="Global Active Power (kilowatts)", xlab="",
     cex.lab=0.75)

#2nd panel
plot(powdat$newdate,powdat$Voltage,type="l",xlab="datetime",
     ylab="Voltage (volts)",cex.lab=0.75)

#3rd panel
plot(powdat$newdate,powdat$Sub_metering_1,type="n",
     ylab="Energy sub metering",xlab="",cex.lab=0.75)
lines(powdat$newdate,powdat$Sub_metering_1)
lines(powdat$newdate,powdat$Sub_metering_2,col="red")
lines(powdat$newdate,powdat$Sub_metering_3,col="blue")
legend(1170400000,39,c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","blue","red"),cex=0.5,lty=c(1,1,1),bty="n")

#4th panel
plot(powdat$newdate,powdat$Global_reactive_power,type="l",
     ylab="Global Reactive Power (kilowatts)", 
     xlab="datetime",cex.lab=0.75)


#copy to png file 480 x 480 pixels
dev.copy(png,"plot4.png",height=480,width=480)
dev.off()