Codebook File
========

List and description of the variables used in the tidy dataset
--------------------------------------------------------------

*  subject: Identification of the subject that performed the activity for each observation,
 listed as an integer of range 1-30.
*  activity: The name of the activity being performed, listed as "WALKING","WALKING_UPSTAIRS"
, "WALKING_DOWNSTAIRS", "SITTING", "STANDING", or "LAYING".
*  featDomain: Time domain or frequency domain, listed as "Time" or "Frequency".
*  featAcceleration: Acceleration input, listed as "Body", "Gravity" or "NA".
*  featInstrument: Instrument of measurement used, listed as "Accelerometer" or "Gyroscope".
*  featJerk: Jerk Input signal, listed as "Jerk" or "NA".
*  featMagnitude: Calculated magnitude of the input signal, listed as "Magnitude" or "NA".
*  featVariable: Mathmatical variable used, listed as "Mean" or "StandDev".
*  featAxis: Denotes three axial signal in the directions X, Y and Z, listed as "X", "Y", 
 "Z" or "NA".
*  count: Integer indicating a count of the number of data points used in the computation 
 of the variable 'average'.
*  average: Number indicating the average of each variable for each activity and each 
 subject.
 
 
 
Details of the tidy dataset data_table_Tidy
========



Dimensions of the dataset
-------------------------
 
```r
dim(data_table_Tidy)
```
 
```
## [1] 11880    11
```



Structure of the dataset
------------------------

```r
str(data_table_Tidy)
```

```
## Classes 'data.table' and 'data.frame':	11880 obs. of  11 variables:
##  $ subject         : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ activity        : Factor w/ 6 levels "LAYING","SITTING",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ featDomain      : Factor w/ 2 levels "Time","Frequency": 1 1 1 1 1 1 1 1 1 1 ...
##  $ featAcceleration: Factor w/ 3 levels NA,"Body","Gravity": 1 1 1 1 1 1 1 1 1 1 ...
##  $ featInstrument  : Factor w/ 2 levels "Accelerometer",..: 2 2 2 2 2 2 2 2 2 2 ...
##  $ featJerk        : Factor w/ 2 levels NA,"Jerk": 1 1 1 1 1 1 1 1 2 2 ...
##  $ featMagnitude   : Factor w/ 2 levels NA,"Magnitude": 1 1 1 1 1 1 2 2 1 1 ...
##  $ featVariable    : Factor w/ 2 levels "Mean","StandDev": 1 1 1 2 2 2 1 2 1 1 ...
##  $ featAxis        : Factor w/ 4 levels NA,"X","Y","Z": 2 3 4 2 3 4 1 1 2 3 ...
##  $ count           : int  50 50 50 50 50 50 50 50 50 50 ...
##  $ average         : num  -0.0166 -0.0645 0.1487 -0.8735 -0.9511 ...
##  - attr(*, "sorted")= chr  "subject" "activity" "featDomain" "featAcceleration" ...
##  - attr(*, ".internal.selfref")=<externalptr>
```



Summary of the dataset
----------------------
 
```r
summary(data_table_Tidy)
```

```
##     subject                   activity        featDomain   featAcceleration
##  Min.   : 1.0   LAYING            :1980   Time     :7200   NA     :4680    
##  1st Qu.: 8.0   SITTING           :1980   Frequency:4680   Body   :5760    
##  Median :15.5   STANDING          :1980                    Gravity:1440    
##  Mean   :15.5   WALKING           :1980                                    
##  3rd Qu.:23.0   WALKING_DOWNSTAIRS:1980                                    
##  Max.   :30.0   WALKING_UPSTAIRS  :1980                                    
##        featInstrument featJerk      featMagnitude    featVariable  featAxis       
##  Accelerometer:7200   NA  :7200   NA       :8640   Mean    :5940   NA:3240   
##  Gyroscope    :4680   Jerk:4680   Magnitude:3240   StandDev:5940   X :2880   
##                                                                    Y :2880   
##                                                                    Z :2880   
##      count          average        
##  Min.   :36.00   Min.   :-0.99767  
##  1st Qu.:49.00   1st Qu.:-0.96205  
##  Median :54.50   Median :-0.46989  
##  Mean   :57.22   Mean   :-0.48436  
##  3rd Qu.:63.25   3rd Qu.:-0.07836  
##  Max.   :95.00   Max.   : 0.97451
```



First six rows of the dataset
-----------------------------

```r
head(data_table_Tidy)
```

```
##    subject activity featDomain featAcceleration featInstrument featJerk featMagnitude
## 1:       1   LAYING       Time               NA      Gyroscope       NA            NA
## 2:       1   LAYING       Time               NA      Gyroscope       NA            NA
## 3:       1   LAYING       Time               NA      Gyroscope       NA            NA
## 4:       1   LAYING       Time               NA      Gyroscope       NA            NA
## 5:       1   LAYING       Time               NA      Gyroscope       NA            NA
## 6:       1   LAYING       Time               NA      Gyroscope       NA            NA
##    featVariable featAxis count     average
## 1:         Mean        X    50 -0.01655309
## 2:         Mean        Y    50 -0.06448612
## 3:         Mean        Z    50  0.14868944
## 4:     StandDev        X    50 -0.87354387
## 5:     StandDev        Y    50 -0.95109044
## 6:     StandDev        Z    50 -0.90828466
```
