#Load specific classes in
install.packages("MASS")
library(MASS)
library(ggplot2)
library(ROCR)
library(caTools)
#Assign CSV file, also removes headers so we can assign ourselves later
wine_ds <-read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data",
                   header = TRUE, sep = ",")
#Assigns colum names 
names(wine_ds) <- c("class", "alcohol", "malic_acid", "ash", "alcalinity_of_ash", 
                    "magnesium", "total_phenols", "flavanoids", "nonflavanoid_phenols",
                    "proanthocyanins", "color_intensity", "hue", "OD280_OD315", "proline")
#Look at the table with approprate names
View(wine_ds)

#Alcohol
min(wine_ds[ ,2]);max(wine_ds[ ,2])
#Malic_Acid
min(wine_ds[ ,3]);max(wine_ds[ ,3])
#Ash
min(wine_ds[ ,4]);max(wine_ds[ ,4])
#Alcalinity_of_ash
min(wine_ds[ ,5]);max(wine_ds[ ,5])
#Magnesium
min(wine_ds[ ,6]);max(wine_ds[ ,6])
#Total_Phenois
min(wine_ds[ ,7]);max(wine_ds[ ,7])
#Flavanoids
min(wine_ds[ ,8]);max(wine_ds[ ,8])
#Nonflavanoid_Phenols
min(wine_ds[ ,9]);max(wine_ds[ ,9])
#Proanthocyanins
min(wine_ds[ ,10]);max(wine_ds[ ,10])
#Color_Intensity
min(wine_ds[ ,11]);max(wine_ds[ ,11])
#Hue
min(wine_ds[ ,12]);max(wine_ds[ ,12])
#OD28O_OD315
min(wine_ds[ ,13]);max(wine_ds[ ,13])
#Proline
min(wine_ds[ ,14]);max(wine_ds[ ,14])

#LDA Method
attach(wine_ds)




#Each color is by class; Looking at all the ingredients
plot(wine_ds[ ,c(2,3) ],
     col = wine_ds[ ,1])

plot(wine_ds[ ,c(4,6) ],
     col = wine_ds[ ,1])
plot(wine_ds[ ,c(2,4) ],
     col = wine_ds[ ,1])

#load all the values into the method. 
wine_ds.lda.fit <- lda(class ~ alcohol + malic_acid + ash + alcalinity_of_ash + 
                   magnesium + total_phenols + flavanoids + nonflavanoid_phenols +
                   proanthocyanins + color_intensity + hue + OD280_OD315 + proline,
                 data = wine_ds)
#prints results into console
wine_ds.lda.fit

#PREDICTIONNNNN
wine_ds.lda.fit.p <-predict(wine_ds.lda.fit, 
                 new_dat = wine_ds[ ,c(2,14)])$class
#Prints results into console but it is a bit messy
wine_ds.lda.fit.p

#Organizes the data from previous line into a nice table
table(wine_ds.lda.fit.p, wine_ds[ ,1])

#Cross_Validation
wine_ds.lda.2 <- lda(class ~ alcohol + malic_acid + ash + alcalinity_of_ash + 
                     magnesium + total_phenols + flavanoids + nonflavanoid_phenols +
                     proanthocyanins + color_intensity + hue + OD280_OD315 + proline,
                   data = wine_ds, CV = TRUE)

table(wine_ds.lda.2$class, wine_ds[ ,1])

str(wine_ds)

names(wine_ds)

#Exploring
#Checks Dimensions
dim(wine_ds)
#Set the seed so test results remain the same
set.seed(300)

wine_ds$class<-as.factor(wine_ds$class)
#Splits wine data into 2 sets, 1 to train the other to test

spl = sample.split(wine_ds$class, SplitRatio = 0.8)
train <- wine_ds[spl==TRUE, ]
test <- wine_ds[spl == FALSE, ]


#Uses LDA function with all variables 
wine_ds.lda.fit <- lda(class ~ alcohol + malic_acid + ash + alcalinity_of_ash + 
                         magnesium + total_phenols + flavanoids + nonflavanoid_phenols +
                         proanthocyanins + color_intensity + hue + OD280_OD315 + proline,
                       data = train)
#Displays object into console
wine_ds.lda.fit

#Provides a visual representation 
plot(wine_ds.lda.fit)

#Applys cross validation check
wine_ds.lda.fit.2 <- lda(class ~ alcohol + malic_acid + ash + alcalinity_of_ash + 
                         magnesium + total_phenols + flavanoids + nonflavanoid_phenols +
                         proanthocyanins + color_intensity + hue + OD280_OD315 + proline,
                       data = train, CV = TRUE)
#Displays Results into a table
table(wine_ds.lda.2$class, wine_ds[ ,1])

library(ROCR)
library(pROC)

myROC <- roc(wine_ds$class, wine_ds$alcohol )
