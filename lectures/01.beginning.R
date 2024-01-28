# Here I can write anything I want
# part of the exam is actually manner of how much you comment your code because the comments help to understand what the code is running.

# R as a calculator
2+3

# Assign to an object
zima <- 2+3

duccio <- 5+3
duccio

zima*duccio

final <- zima*duccio
final
final^2

# Array
sophi <- c(10, 20, 30, 50, 70) # microplastics 
#to concatenate all the numbers and allow R to read an array we use the function c()
#inside the functions there are the arguments

paula <- c(100, 500, 600, 1000, 2000) # people

plot(paula, sophi)
plot(paula, sophi, xlab="number of people", ylab="microplastics")

people <- paula
microplastics <- sophi

plot(people, microplastics, pch=19, cex=2, col="blue")
#pch = point character https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6gmJapH_j6E3zWbTCOuDKJDUrH80VvTYdgCNVMh16OA&s
#cex = character exageration, it defines the dimensions of the points
#col = color
