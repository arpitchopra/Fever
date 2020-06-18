library(dplyr)
#Copy the data from fever.xlsx
fever_data <- read.table(file = "clipboard", sep = "\t", header=TRUE)
fever_data$Time <- as.POSIXct(strptime(as.character(fever_data$Time), "%d-%b  %I:%M %p"))
fever_data$Temperature <- as.numeric(fever_data$Temperature)

par(mfrow = c(1,2))
cdplot(fever_data$Time, as.factor(fever_data$Crocin), main = "Time vs. Fever Spike", xlab = "Date-Time", ylab = "Fever (No vs. Yes)")

fever <- filter(fever_data, Crocin == 0)
fever <- fever %>% mutate(duration = as.numeric((Time - lag(Time)), units = "hours"))
plot(fever$Time, fever$duration, type = "l", col = "red", main = "Duration Elapsed in Fever Each Day", xlab = "Date-Time", ylab = "Duration Between Fever Spike")