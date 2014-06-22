Collect, Work with, and Clean a Data Set
========================================================

This is an R Markdown document which shows the scenario of collecting, cleaning, and working with a data set step by step.
DataSet is collected from accelerometers of the Sumsung Galaxy S smartphone.

# Collect the dataset
getting the zipped file from internet


```r
url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url=url, destfile="dataset.zip")
unzip(zipfile="dataset.zip")
```

reading train and test data and their corresponding labels into memory


```r
traindata<-read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
testdata<-read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
trainsubject<-read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)
testsubject<-read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
trainlabels<-read.table("UCI HAR Dataset/train/Y_train.txt", header=FALSE)
testlabels<-read.table("UCI HAR Dataset/test/Y_test.txt", header=FALSE)
```

# Merge the training and test sets to create one data set


```r
totaltrain<-cbind(trainsubject, traindata, trainlabels)
totaltest<-cbind(testsubject, testdata, testlabels)
totaldata<-rbind(totaltrain, totaltest)

dim(totaldata)
```

```
## [1] 10299   563
```

totaldata is a data.frame with 10299 rows and 563 columns or in other word attributes.


```r
totaldata[1, 1:5]
```

```
##   V1   V1.1       V2      V3      V4
## 1  1 0.2886 -0.02029 -0.1329 -0.9953
```

as you can see, the attributes still have no names.

removing extra data after using them


```r
rm(list=c("traindata", "testdata", "trainsubject", "testsubject", 
          "trainlabels", "testlabels",
          "totaltrain", "totaltest"))
```

# Name each column of data set including the label column

first read the features from the corresponding file


```r
features<-read.table("UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
```

replace any punctuation from names so they can be fetched using $,
then add two other names, subject_id and activity_id at the beginning and end of this list of names.


```r
names(totaldata)<-c("subject_id", gsub(x=features[,2], pattern="[[:punct:]]", replacement="_"), 
                    "activity_id")
names(totaldata)
```

```
##   [1] "subject_id"                          
##   [2] "tBodyAcc_mean___X"                   
##   [3] "tBodyAcc_mean___Y"                   
##   [4] "tBodyAcc_mean___Z"                   
##   [5] "tBodyAcc_std___X"                    
##   [6] "tBodyAcc_std___Y"                    
##   [7] "tBodyAcc_std___Z"                    
##   [8] "tBodyAcc_mad___X"                    
##   [9] "tBodyAcc_mad___Y"                    
##  [10] "tBodyAcc_mad___Z"                    
##  [11] "tBodyAcc_max___X"                    
##  [12] "tBodyAcc_max___Y"                    
##  [13] "tBodyAcc_max___Z"                    
##  [14] "tBodyAcc_min___X"                    
##  [15] "tBodyAcc_min___Y"                    
##  [16] "tBodyAcc_min___Z"                    
##  [17] "tBodyAcc_sma__"                      
##  [18] "tBodyAcc_energy___X"                 
##  [19] "tBodyAcc_energy___Y"                 
##  [20] "tBodyAcc_energy___Z"                 
##  [21] "tBodyAcc_iqr___X"                    
##  [22] "tBodyAcc_iqr___Y"                    
##  [23] "tBodyAcc_iqr___Z"                    
##  [24] "tBodyAcc_entropy___X"                
##  [25] "tBodyAcc_entropy___Y"                
##  [26] "tBodyAcc_entropy___Z"                
##  [27] "tBodyAcc_arCoeff___X_1"              
##  [28] "tBodyAcc_arCoeff___X_2"              
##  [29] "tBodyAcc_arCoeff___X_3"              
##  [30] "tBodyAcc_arCoeff___X_4"              
##  [31] "tBodyAcc_arCoeff___Y_1"              
##  [32] "tBodyAcc_arCoeff___Y_2"              
##  [33] "tBodyAcc_arCoeff___Y_3"              
##  [34] "tBodyAcc_arCoeff___Y_4"              
##  [35] "tBodyAcc_arCoeff___Z_1"              
##  [36] "tBodyAcc_arCoeff___Z_2"              
##  [37] "tBodyAcc_arCoeff___Z_3"              
##  [38] "tBodyAcc_arCoeff___Z_4"              
##  [39] "tBodyAcc_correlation___X_Y"          
##  [40] "tBodyAcc_correlation___X_Z"          
##  [41] "tBodyAcc_correlation___Y_Z"          
##  [42] "tGravityAcc_mean___X"                
##  [43] "tGravityAcc_mean___Y"                
##  [44] "tGravityAcc_mean___Z"                
##  [45] "tGravityAcc_std___X"                 
##  [46] "tGravityAcc_std___Y"                 
##  [47] "tGravityAcc_std___Z"                 
##  [48] "tGravityAcc_mad___X"                 
##  [49] "tGravityAcc_mad___Y"                 
##  [50] "tGravityAcc_mad___Z"                 
##  [51] "tGravityAcc_max___X"                 
##  [52] "tGravityAcc_max___Y"                 
##  [53] "tGravityAcc_max___Z"                 
##  [54] "tGravityAcc_min___X"                 
##  [55] "tGravityAcc_min___Y"                 
##  [56] "tGravityAcc_min___Z"                 
##  [57] "tGravityAcc_sma__"                   
##  [58] "tGravityAcc_energy___X"              
##  [59] "tGravityAcc_energy___Y"              
##  [60] "tGravityAcc_energy___Z"              
##  [61] "tGravityAcc_iqr___X"                 
##  [62] "tGravityAcc_iqr___Y"                 
##  [63] "tGravityAcc_iqr___Z"                 
##  [64] "tGravityAcc_entropy___X"             
##  [65] "tGravityAcc_entropy___Y"             
##  [66] "tGravityAcc_entropy___Z"             
##  [67] "tGravityAcc_arCoeff___X_1"           
##  [68] "tGravityAcc_arCoeff___X_2"           
##  [69] "tGravityAcc_arCoeff___X_3"           
##  [70] "tGravityAcc_arCoeff___X_4"           
##  [71] "tGravityAcc_arCoeff___Y_1"           
##  [72] "tGravityAcc_arCoeff___Y_2"           
##  [73] "tGravityAcc_arCoeff___Y_3"           
##  [74] "tGravityAcc_arCoeff___Y_4"           
##  [75] "tGravityAcc_arCoeff___Z_1"           
##  [76] "tGravityAcc_arCoeff___Z_2"           
##  [77] "tGravityAcc_arCoeff___Z_3"           
##  [78] "tGravityAcc_arCoeff___Z_4"           
##  [79] "tGravityAcc_correlation___X_Y"       
##  [80] "tGravityAcc_correlation___X_Z"       
##  [81] "tGravityAcc_correlation___Y_Z"       
##  [82] "tBodyAccJerk_mean___X"               
##  [83] "tBodyAccJerk_mean___Y"               
##  [84] "tBodyAccJerk_mean___Z"               
##  [85] "tBodyAccJerk_std___X"                
##  [86] "tBodyAccJerk_std___Y"                
##  [87] "tBodyAccJerk_std___Z"                
##  [88] "tBodyAccJerk_mad___X"                
##  [89] "tBodyAccJerk_mad___Y"                
##  [90] "tBodyAccJerk_mad___Z"                
##  [91] "tBodyAccJerk_max___X"                
##  [92] "tBodyAccJerk_max___Y"                
##  [93] "tBodyAccJerk_max___Z"                
##  [94] "tBodyAccJerk_min___X"                
##  [95] "tBodyAccJerk_min___Y"                
##  [96] "tBodyAccJerk_min___Z"                
##  [97] "tBodyAccJerk_sma__"                  
##  [98] "tBodyAccJerk_energy___X"             
##  [99] "tBodyAccJerk_energy___Y"             
## [100] "tBodyAccJerk_energy___Z"             
## [101] "tBodyAccJerk_iqr___X"                
## [102] "tBodyAccJerk_iqr___Y"                
## [103] "tBodyAccJerk_iqr___Z"                
## [104] "tBodyAccJerk_entropy___X"            
## [105] "tBodyAccJerk_entropy___Y"            
## [106] "tBodyAccJerk_entropy___Z"            
## [107] "tBodyAccJerk_arCoeff___X_1"          
## [108] "tBodyAccJerk_arCoeff___X_2"          
## [109] "tBodyAccJerk_arCoeff___X_3"          
## [110] "tBodyAccJerk_arCoeff___X_4"          
## [111] "tBodyAccJerk_arCoeff___Y_1"          
## [112] "tBodyAccJerk_arCoeff___Y_2"          
## [113] "tBodyAccJerk_arCoeff___Y_3"          
## [114] "tBodyAccJerk_arCoeff___Y_4"          
## [115] "tBodyAccJerk_arCoeff___Z_1"          
## [116] "tBodyAccJerk_arCoeff___Z_2"          
## [117] "tBodyAccJerk_arCoeff___Z_3"          
## [118] "tBodyAccJerk_arCoeff___Z_4"          
## [119] "tBodyAccJerk_correlation___X_Y"      
## [120] "tBodyAccJerk_correlation___X_Z"      
## [121] "tBodyAccJerk_correlation___Y_Z"      
## [122] "tBodyGyro_mean___X"                  
## [123] "tBodyGyro_mean___Y"                  
## [124] "tBodyGyro_mean___Z"                  
## [125] "tBodyGyro_std___X"                   
## [126] "tBodyGyro_std___Y"                   
## [127] "tBodyGyro_std___Z"                   
## [128] "tBodyGyro_mad___X"                   
## [129] "tBodyGyro_mad___Y"                   
## [130] "tBodyGyro_mad___Z"                   
## [131] "tBodyGyro_max___X"                   
## [132] "tBodyGyro_max___Y"                   
## [133] "tBodyGyro_max___Z"                   
## [134] "tBodyGyro_min___X"                   
## [135] "tBodyGyro_min___Y"                   
## [136] "tBodyGyro_min___Z"                   
## [137] "tBodyGyro_sma__"                     
## [138] "tBodyGyro_energy___X"                
## [139] "tBodyGyro_energy___Y"                
## [140] "tBodyGyro_energy___Z"                
## [141] "tBodyGyro_iqr___X"                   
## [142] "tBodyGyro_iqr___Y"                   
## [143] "tBodyGyro_iqr___Z"                   
## [144] "tBodyGyro_entropy___X"               
## [145] "tBodyGyro_entropy___Y"               
## [146] "tBodyGyro_entropy___Z"               
## [147] "tBodyGyro_arCoeff___X_1"             
## [148] "tBodyGyro_arCoeff___X_2"             
## [149] "tBodyGyro_arCoeff___X_3"             
## [150] "tBodyGyro_arCoeff___X_4"             
## [151] "tBodyGyro_arCoeff___Y_1"             
## [152] "tBodyGyro_arCoeff___Y_2"             
## [153] "tBodyGyro_arCoeff___Y_3"             
## [154] "tBodyGyro_arCoeff___Y_4"             
## [155] "tBodyGyro_arCoeff___Z_1"             
## [156] "tBodyGyro_arCoeff___Z_2"             
## [157] "tBodyGyro_arCoeff___Z_3"             
## [158] "tBodyGyro_arCoeff___Z_4"             
## [159] "tBodyGyro_correlation___X_Y"         
## [160] "tBodyGyro_correlation___X_Z"         
## [161] "tBodyGyro_correlation___Y_Z"         
## [162] "tBodyGyroJerk_mean___X"              
## [163] "tBodyGyroJerk_mean___Y"              
## [164] "tBodyGyroJerk_mean___Z"              
## [165] "tBodyGyroJerk_std___X"               
## [166] "tBodyGyroJerk_std___Y"               
## [167] "tBodyGyroJerk_std___Z"               
## [168] "tBodyGyroJerk_mad___X"               
## [169] "tBodyGyroJerk_mad___Y"               
## [170] "tBodyGyroJerk_mad___Z"               
## [171] "tBodyGyroJerk_max___X"               
## [172] "tBodyGyroJerk_max___Y"               
## [173] "tBodyGyroJerk_max___Z"               
## [174] "tBodyGyroJerk_min___X"               
## [175] "tBodyGyroJerk_min___Y"               
## [176] "tBodyGyroJerk_min___Z"               
## [177] "tBodyGyroJerk_sma__"                 
## [178] "tBodyGyroJerk_energy___X"            
## [179] "tBodyGyroJerk_energy___Y"            
## [180] "tBodyGyroJerk_energy___Z"            
## [181] "tBodyGyroJerk_iqr___X"               
## [182] "tBodyGyroJerk_iqr___Y"               
## [183] "tBodyGyroJerk_iqr___Z"               
## [184] "tBodyGyroJerk_entropy___X"           
## [185] "tBodyGyroJerk_entropy___Y"           
## [186] "tBodyGyroJerk_entropy___Z"           
## [187] "tBodyGyroJerk_arCoeff___X_1"         
## [188] "tBodyGyroJerk_arCoeff___X_2"         
## [189] "tBodyGyroJerk_arCoeff___X_3"         
## [190] "tBodyGyroJerk_arCoeff___X_4"         
## [191] "tBodyGyroJerk_arCoeff___Y_1"         
## [192] "tBodyGyroJerk_arCoeff___Y_2"         
## [193] "tBodyGyroJerk_arCoeff___Y_3"         
## [194] "tBodyGyroJerk_arCoeff___Y_4"         
## [195] "tBodyGyroJerk_arCoeff___Z_1"         
## [196] "tBodyGyroJerk_arCoeff___Z_2"         
## [197] "tBodyGyroJerk_arCoeff___Z_3"         
## [198] "tBodyGyroJerk_arCoeff___Z_4"         
## [199] "tBodyGyroJerk_correlation___X_Y"     
## [200] "tBodyGyroJerk_correlation___X_Z"     
## [201] "tBodyGyroJerk_correlation___Y_Z"     
## [202] "tBodyAccMag_mean__"                  
## [203] "tBodyAccMag_std__"                   
## [204] "tBodyAccMag_mad__"                   
## [205] "tBodyAccMag_max__"                   
## [206] "tBodyAccMag_min__"                   
## [207] "tBodyAccMag_sma__"                   
## [208] "tBodyAccMag_energy__"                
## [209] "tBodyAccMag_iqr__"                   
## [210] "tBodyAccMag_entropy__"               
## [211] "tBodyAccMag_arCoeff__1"              
## [212] "tBodyAccMag_arCoeff__2"              
## [213] "tBodyAccMag_arCoeff__3"              
## [214] "tBodyAccMag_arCoeff__4"              
## [215] "tGravityAccMag_mean__"               
## [216] "tGravityAccMag_std__"                
## [217] "tGravityAccMag_mad__"                
## [218] "tGravityAccMag_max__"                
## [219] "tGravityAccMag_min__"                
## [220] "tGravityAccMag_sma__"                
## [221] "tGravityAccMag_energy__"             
## [222] "tGravityAccMag_iqr__"                
## [223] "tGravityAccMag_entropy__"            
## [224] "tGravityAccMag_arCoeff__1"           
## [225] "tGravityAccMag_arCoeff__2"           
## [226] "tGravityAccMag_arCoeff__3"           
## [227] "tGravityAccMag_arCoeff__4"           
## [228] "tBodyAccJerkMag_mean__"              
## [229] "tBodyAccJerkMag_std__"               
## [230] "tBodyAccJerkMag_mad__"               
## [231] "tBodyAccJerkMag_max__"               
## [232] "tBodyAccJerkMag_min__"               
## [233] "tBodyAccJerkMag_sma__"               
## [234] "tBodyAccJerkMag_energy__"            
## [235] "tBodyAccJerkMag_iqr__"               
## [236] "tBodyAccJerkMag_entropy__"           
## [237] "tBodyAccJerkMag_arCoeff__1"          
## [238] "tBodyAccJerkMag_arCoeff__2"          
## [239] "tBodyAccJerkMag_arCoeff__3"          
## [240] "tBodyAccJerkMag_arCoeff__4"          
## [241] "tBodyGyroMag_mean__"                 
## [242] "tBodyGyroMag_std__"                  
## [243] "tBodyGyroMag_mad__"                  
## [244] "tBodyGyroMag_max__"                  
## [245] "tBodyGyroMag_min__"                  
## [246] "tBodyGyroMag_sma__"                  
## [247] "tBodyGyroMag_energy__"               
## [248] "tBodyGyroMag_iqr__"                  
## [249] "tBodyGyroMag_entropy__"              
## [250] "tBodyGyroMag_arCoeff__1"             
## [251] "tBodyGyroMag_arCoeff__2"             
## [252] "tBodyGyroMag_arCoeff__3"             
## [253] "tBodyGyroMag_arCoeff__4"             
## [254] "tBodyGyroJerkMag_mean__"             
## [255] "tBodyGyroJerkMag_std__"              
## [256] "tBodyGyroJerkMag_mad__"              
## [257] "tBodyGyroJerkMag_max__"              
## [258] "tBodyGyroJerkMag_min__"              
## [259] "tBodyGyroJerkMag_sma__"              
## [260] "tBodyGyroJerkMag_energy__"           
## [261] "tBodyGyroJerkMag_iqr__"              
## [262] "tBodyGyroJerkMag_entropy__"          
## [263] "tBodyGyroJerkMag_arCoeff__1"         
## [264] "tBodyGyroJerkMag_arCoeff__2"         
## [265] "tBodyGyroJerkMag_arCoeff__3"         
## [266] "tBodyGyroJerkMag_arCoeff__4"         
## [267] "fBodyAcc_mean___X"                   
## [268] "fBodyAcc_mean___Y"                   
## [269] "fBodyAcc_mean___Z"                   
## [270] "fBodyAcc_std___X"                    
## [271] "fBodyAcc_std___Y"                    
## [272] "fBodyAcc_std___Z"                    
## [273] "fBodyAcc_mad___X"                    
## [274] "fBodyAcc_mad___Y"                    
## [275] "fBodyAcc_mad___Z"                    
## [276] "fBodyAcc_max___X"                    
## [277] "fBodyAcc_max___Y"                    
## [278] "fBodyAcc_max___Z"                    
## [279] "fBodyAcc_min___X"                    
## [280] "fBodyAcc_min___Y"                    
## [281] "fBodyAcc_min___Z"                    
## [282] "fBodyAcc_sma__"                      
## [283] "fBodyAcc_energy___X"                 
## [284] "fBodyAcc_energy___Y"                 
## [285] "fBodyAcc_energy___Z"                 
## [286] "fBodyAcc_iqr___X"                    
## [287] "fBodyAcc_iqr___Y"                    
## [288] "fBodyAcc_iqr___Z"                    
## [289] "fBodyAcc_entropy___X"                
## [290] "fBodyAcc_entropy___Y"                
## [291] "fBodyAcc_entropy___Z"                
## [292] "fBodyAcc_maxInds_X"                  
## [293] "fBodyAcc_maxInds_Y"                  
## [294] "fBodyAcc_maxInds_Z"                  
## [295] "fBodyAcc_meanFreq___X"               
## [296] "fBodyAcc_meanFreq___Y"               
## [297] "fBodyAcc_meanFreq___Z"               
## [298] "fBodyAcc_skewness___X"               
## [299] "fBodyAcc_kurtosis___X"               
## [300] "fBodyAcc_skewness___Y"               
## [301] "fBodyAcc_kurtosis___Y"               
## [302] "fBodyAcc_skewness___Z"               
## [303] "fBodyAcc_kurtosis___Z"               
## [304] "fBodyAcc_bandsEnergy___1_8"          
## [305] "fBodyAcc_bandsEnergy___9_16"         
## [306] "fBodyAcc_bandsEnergy___17_24"        
## [307] "fBodyAcc_bandsEnergy___25_32"        
## [308] "fBodyAcc_bandsEnergy___33_40"        
## [309] "fBodyAcc_bandsEnergy___41_48"        
## [310] "fBodyAcc_bandsEnergy___49_56"        
## [311] "fBodyAcc_bandsEnergy___57_64"        
## [312] "fBodyAcc_bandsEnergy___1_16"         
## [313] "fBodyAcc_bandsEnergy___17_32"        
## [314] "fBodyAcc_bandsEnergy___33_48"        
## [315] "fBodyAcc_bandsEnergy___49_64"        
## [316] "fBodyAcc_bandsEnergy___1_24"         
## [317] "fBodyAcc_bandsEnergy___25_48"        
## [318] "fBodyAcc_bandsEnergy___1_8"          
## [319] "fBodyAcc_bandsEnergy___9_16"         
## [320] "fBodyAcc_bandsEnergy___17_24"        
## [321] "fBodyAcc_bandsEnergy___25_32"        
## [322] "fBodyAcc_bandsEnergy___33_40"        
## [323] "fBodyAcc_bandsEnergy___41_48"        
## [324] "fBodyAcc_bandsEnergy___49_56"        
## [325] "fBodyAcc_bandsEnergy___57_64"        
## [326] "fBodyAcc_bandsEnergy___1_16"         
## [327] "fBodyAcc_bandsEnergy___17_32"        
## [328] "fBodyAcc_bandsEnergy___33_48"        
## [329] "fBodyAcc_bandsEnergy___49_64"        
## [330] "fBodyAcc_bandsEnergy___1_24"         
## [331] "fBodyAcc_bandsEnergy___25_48"        
## [332] "fBodyAcc_bandsEnergy___1_8"          
## [333] "fBodyAcc_bandsEnergy___9_16"         
## [334] "fBodyAcc_bandsEnergy___17_24"        
## [335] "fBodyAcc_bandsEnergy___25_32"        
## [336] "fBodyAcc_bandsEnergy___33_40"        
## [337] "fBodyAcc_bandsEnergy___41_48"        
## [338] "fBodyAcc_bandsEnergy___49_56"        
## [339] "fBodyAcc_bandsEnergy___57_64"        
## [340] "fBodyAcc_bandsEnergy___1_16"         
## [341] "fBodyAcc_bandsEnergy___17_32"        
## [342] "fBodyAcc_bandsEnergy___33_48"        
## [343] "fBodyAcc_bandsEnergy___49_64"        
## [344] "fBodyAcc_bandsEnergy___1_24"         
## [345] "fBodyAcc_bandsEnergy___25_48"        
## [346] "fBodyAccJerk_mean___X"               
## [347] "fBodyAccJerk_mean___Y"               
## [348] "fBodyAccJerk_mean___Z"               
## [349] "fBodyAccJerk_std___X"                
## [350] "fBodyAccJerk_std___Y"                
## [351] "fBodyAccJerk_std___Z"                
## [352] "fBodyAccJerk_mad___X"                
## [353] "fBodyAccJerk_mad___Y"                
## [354] "fBodyAccJerk_mad___Z"                
## [355] "fBodyAccJerk_max___X"                
## [356] "fBodyAccJerk_max___Y"                
## [357] "fBodyAccJerk_max___Z"                
## [358] "fBodyAccJerk_min___X"                
## [359] "fBodyAccJerk_min___Y"                
## [360] "fBodyAccJerk_min___Z"                
## [361] "fBodyAccJerk_sma__"                  
## [362] "fBodyAccJerk_energy___X"             
## [363] "fBodyAccJerk_energy___Y"             
## [364] "fBodyAccJerk_energy___Z"             
## [365] "fBodyAccJerk_iqr___X"                
## [366] "fBodyAccJerk_iqr___Y"                
## [367] "fBodyAccJerk_iqr___Z"                
## [368] "fBodyAccJerk_entropy___X"            
## [369] "fBodyAccJerk_entropy___Y"            
## [370] "fBodyAccJerk_entropy___Z"            
## [371] "fBodyAccJerk_maxInds_X"              
## [372] "fBodyAccJerk_maxInds_Y"              
## [373] "fBodyAccJerk_maxInds_Z"              
## [374] "fBodyAccJerk_meanFreq___X"           
## [375] "fBodyAccJerk_meanFreq___Y"           
## [376] "fBodyAccJerk_meanFreq___Z"           
## [377] "fBodyAccJerk_skewness___X"           
## [378] "fBodyAccJerk_kurtosis___X"           
## [379] "fBodyAccJerk_skewness___Y"           
## [380] "fBodyAccJerk_kurtosis___Y"           
## [381] "fBodyAccJerk_skewness___Z"           
## [382] "fBodyAccJerk_kurtosis___Z"           
## [383] "fBodyAccJerk_bandsEnergy___1_8"      
## [384] "fBodyAccJerk_bandsEnergy___9_16"     
## [385] "fBodyAccJerk_bandsEnergy___17_24"    
## [386] "fBodyAccJerk_bandsEnergy___25_32"    
## [387] "fBodyAccJerk_bandsEnergy___33_40"    
## [388] "fBodyAccJerk_bandsEnergy___41_48"    
## [389] "fBodyAccJerk_bandsEnergy___49_56"    
## [390] "fBodyAccJerk_bandsEnergy___57_64"    
## [391] "fBodyAccJerk_bandsEnergy___1_16"     
## [392] "fBodyAccJerk_bandsEnergy___17_32"    
## [393] "fBodyAccJerk_bandsEnergy___33_48"    
## [394] "fBodyAccJerk_bandsEnergy___49_64"    
## [395] "fBodyAccJerk_bandsEnergy___1_24"     
## [396] "fBodyAccJerk_bandsEnergy___25_48"    
## [397] "fBodyAccJerk_bandsEnergy___1_8"      
## [398] "fBodyAccJerk_bandsEnergy___9_16"     
## [399] "fBodyAccJerk_bandsEnergy___17_24"    
## [400] "fBodyAccJerk_bandsEnergy___25_32"    
## [401] "fBodyAccJerk_bandsEnergy___33_40"    
## [402] "fBodyAccJerk_bandsEnergy___41_48"    
## [403] "fBodyAccJerk_bandsEnergy___49_56"    
## [404] "fBodyAccJerk_bandsEnergy___57_64"    
## [405] "fBodyAccJerk_bandsEnergy___1_16"     
## [406] "fBodyAccJerk_bandsEnergy___17_32"    
## [407] "fBodyAccJerk_bandsEnergy___33_48"    
## [408] "fBodyAccJerk_bandsEnergy___49_64"    
## [409] "fBodyAccJerk_bandsEnergy___1_24"     
## [410] "fBodyAccJerk_bandsEnergy___25_48"    
## [411] "fBodyAccJerk_bandsEnergy___1_8"      
## [412] "fBodyAccJerk_bandsEnergy___9_16"     
## [413] "fBodyAccJerk_bandsEnergy___17_24"    
## [414] "fBodyAccJerk_bandsEnergy___25_32"    
## [415] "fBodyAccJerk_bandsEnergy___33_40"    
## [416] "fBodyAccJerk_bandsEnergy___41_48"    
## [417] "fBodyAccJerk_bandsEnergy___49_56"    
## [418] "fBodyAccJerk_bandsEnergy___57_64"    
## [419] "fBodyAccJerk_bandsEnergy___1_16"     
## [420] "fBodyAccJerk_bandsEnergy___17_32"    
## [421] "fBodyAccJerk_bandsEnergy___33_48"    
## [422] "fBodyAccJerk_bandsEnergy___49_64"    
## [423] "fBodyAccJerk_bandsEnergy___1_24"     
## [424] "fBodyAccJerk_bandsEnergy___25_48"    
## [425] "fBodyGyro_mean___X"                  
## [426] "fBodyGyro_mean___Y"                  
## [427] "fBodyGyro_mean___Z"                  
## [428] "fBodyGyro_std___X"                   
## [429] "fBodyGyro_std___Y"                   
## [430] "fBodyGyro_std___Z"                   
## [431] "fBodyGyro_mad___X"                   
## [432] "fBodyGyro_mad___Y"                   
## [433] "fBodyGyro_mad___Z"                   
## [434] "fBodyGyro_max___X"                   
## [435] "fBodyGyro_max___Y"                   
## [436] "fBodyGyro_max___Z"                   
## [437] "fBodyGyro_min___X"                   
## [438] "fBodyGyro_min___Y"                   
## [439] "fBodyGyro_min___Z"                   
## [440] "fBodyGyro_sma__"                     
## [441] "fBodyGyro_energy___X"                
## [442] "fBodyGyro_energy___Y"                
## [443] "fBodyGyro_energy___Z"                
## [444] "fBodyGyro_iqr___X"                   
## [445] "fBodyGyro_iqr___Y"                   
## [446] "fBodyGyro_iqr___Z"                   
## [447] "fBodyGyro_entropy___X"               
## [448] "fBodyGyro_entropy___Y"               
## [449] "fBodyGyro_entropy___Z"               
## [450] "fBodyGyro_maxInds_X"                 
## [451] "fBodyGyro_maxInds_Y"                 
## [452] "fBodyGyro_maxInds_Z"                 
## [453] "fBodyGyro_meanFreq___X"              
## [454] "fBodyGyro_meanFreq___Y"              
## [455] "fBodyGyro_meanFreq___Z"              
## [456] "fBodyGyro_skewness___X"              
## [457] "fBodyGyro_kurtosis___X"              
## [458] "fBodyGyro_skewness___Y"              
## [459] "fBodyGyro_kurtosis___Y"              
## [460] "fBodyGyro_skewness___Z"              
## [461] "fBodyGyro_kurtosis___Z"              
## [462] "fBodyGyro_bandsEnergy___1_8"         
## [463] "fBodyGyro_bandsEnergy___9_16"        
## [464] "fBodyGyro_bandsEnergy___17_24"       
## [465] "fBodyGyro_bandsEnergy___25_32"       
## [466] "fBodyGyro_bandsEnergy___33_40"       
## [467] "fBodyGyro_bandsEnergy___41_48"       
## [468] "fBodyGyro_bandsEnergy___49_56"       
## [469] "fBodyGyro_bandsEnergy___57_64"       
## [470] "fBodyGyro_bandsEnergy___1_16"        
## [471] "fBodyGyro_bandsEnergy___17_32"       
## [472] "fBodyGyro_bandsEnergy___33_48"       
## [473] "fBodyGyro_bandsEnergy___49_64"       
## [474] "fBodyGyro_bandsEnergy___1_24"        
## [475] "fBodyGyro_bandsEnergy___25_48"       
## [476] "fBodyGyro_bandsEnergy___1_8"         
## [477] "fBodyGyro_bandsEnergy___9_16"        
## [478] "fBodyGyro_bandsEnergy___17_24"       
## [479] "fBodyGyro_bandsEnergy___25_32"       
## [480] "fBodyGyro_bandsEnergy___33_40"       
## [481] "fBodyGyro_bandsEnergy___41_48"       
## [482] "fBodyGyro_bandsEnergy___49_56"       
## [483] "fBodyGyro_bandsEnergy___57_64"       
## [484] "fBodyGyro_bandsEnergy___1_16"        
## [485] "fBodyGyro_bandsEnergy___17_32"       
## [486] "fBodyGyro_bandsEnergy___33_48"       
## [487] "fBodyGyro_bandsEnergy___49_64"       
## [488] "fBodyGyro_bandsEnergy___1_24"        
## [489] "fBodyGyro_bandsEnergy___25_48"       
## [490] "fBodyGyro_bandsEnergy___1_8"         
## [491] "fBodyGyro_bandsEnergy___9_16"        
## [492] "fBodyGyro_bandsEnergy___17_24"       
## [493] "fBodyGyro_bandsEnergy___25_32"       
## [494] "fBodyGyro_bandsEnergy___33_40"       
## [495] "fBodyGyro_bandsEnergy___41_48"       
## [496] "fBodyGyro_bandsEnergy___49_56"       
## [497] "fBodyGyro_bandsEnergy___57_64"       
## [498] "fBodyGyro_bandsEnergy___1_16"        
## [499] "fBodyGyro_bandsEnergy___17_32"       
## [500] "fBodyGyro_bandsEnergy___33_48"       
## [501] "fBodyGyro_bandsEnergy___49_64"       
## [502] "fBodyGyro_bandsEnergy___1_24"        
## [503] "fBodyGyro_bandsEnergy___25_48"       
## [504] "fBodyAccMag_mean__"                  
## [505] "fBodyAccMag_std__"                   
## [506] "fBodyAccMag_mad__"                   
## [507] "fBodyAccMag_max__"                   
## [508] "fBodyAccMag_min__"                   
## [509] "fBodyAccMag_sma__"                   
## [510] "fBodyAccMag_energy__"                
## [511] "fBodyAccMag_iqr__"                   
## [512] "fBodyAccMag_entropy__"               
## [513] "fBodyAccMag_maxInds"                 
## [514] "fBodyAccMag_meanFreq__"              
## [515] "fBodyAccMag_skewness__"              
## [516] "fBodyAccMag_kurtosis__"              
## [517] "fBodyBodyAccJerkMag_mean__"          
## [518] "fBodyBodyAccJerkMag_std__"           
## [519] "fBodyBodyAccJerkMag_mad__"           
## [520] "fBodyBodyAccJerkMag_max__"           
## [521] "fBodyBodyAccJerkMag_min__"           
## [522] "fBodyBodyAccJerkMag_sma__"           
## [523] "fBodyBodyAccJerkMag_energy__"        
## [524] "fBodyBodyAccJerkMag_iqr__"           
## [525] "fBodyBodyAccJerkMag_entropy__"       
## [526] "fBodyBodyAccJerkMag_maxInds"         
## [527] "fBodyBodyAccJerkMag_meanFreq__"      
## [528] "fBodyBodyAccJerkMag_skewness__"      
## [529] "fBodyBodyAccJerkMag_kurtosis__"      
## [530] "fBodyBodyGyroMag_mean__"             
## [531] "fBodyBodyGyroMag_std__"              
## [532] "fBodyBodyGyroMag_mad__"              
## [533] "fBodyBodyGyroMag_max__"              
## [534] "fBodyBodyGyroMag_min__"              
## [535] "fBodyBodyGyroMag_sma__"              
## [536] "fBodyBodyGyroMag_energy__"           
## [537] "fBodyBodyGyroMag_iqr__"              
## [538] "fBodyBodyGyroMag_entropy__"          
## [539] "fBodyBodyGyroMag_maxInds"            
## [540] "fBodyBodyGyroMag_meanFreq__"         
## [541] "fBodyBodyGyroMag_skewness__"         
## [542] "fBodyBodyGyroMag_kurtosis__"         
## [543] "fBodyBodyGyroJerkMag_mean__"         
## [544] "fBodyBodyGyroJerkMag_std__"          
## [545] "fBodyBodyGyroJerkMag_mad__"          
## [546] "fBodyBodyGyroJerkMag_max__"          
## [547] "fBodyBodyGyroJerkMag_min__"          
## [548] "fBodyBodyGyroJerkMag_sma__"          
## [549] "fBodyBodyGyroJerkMag_energy__"       
## [550] "fBodyBodyGyroJerkMag_iqr__"          
## [551] "fBodyBodyGyroJerkMag_entropy__"      
## [552] "fBodyBodyGyroJerkMag_maxInds"        
## [553] "fBodyBodyGyroJerkMag_meanFreq__"     
## [554] "fBodyBodyGyroJerkMag_skewness__"     
## [555] "fBodyBodyGyroJerkMag_kurtosis__"     
## [556] "angle_tBodyAccMean_gravity_"         
## [557] "angle_tBodyAccJerkMean__gravityMean_"
## [558] "angle_tBodyGyroMean_gravityMean_"    
## [559] "angle_tBodyGyroJerkMean_gravityMean_"
## [560] "angle_X_gravityMean_"                
## [561] "angle_Y_gravityMean_"                
## [562] "angle_Z_gravityMean_"                
## [563] "activity_id"
```

# Use descriptive activity names to name the activities in the data set
read the activity descriptive labels


```r
activities<-read.table("UCI HAR Dataset/activity_labels.txt")
```

doublecheck for the orders of activities


```r
activities$v2<-factor(activities$V2, c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
totaldata$activity_descriptive_label<-activities$V2[totaldata$activity_id]

levels(totaldata$activity_descriptive_label)
```

```
## [1] "LAYING"             "SITTING"            "STANDING"          
## [4] "WALKING"            "WALKING_DOWNSTAIRS" "WALKING_UPSTAIRS"
```

removing extra data after using them


```r
rm(list=c("activities", "features"))
```

# Extract only the measurements that compute mean or standard deviation
using the names I will extract all columns containing the words "mean" or "std" in their names plus activity_descriptive_label which is the label of each row


```r
totaldata_meanstd<-totaldata[, sort(c(grep("mean", names(totaldata)),
                                    grep("std", names(totaldata)),
                                    grep("activity_descriptive_label", names(totaldata))))]

names(totaldata_meanstd)
```

```
##  [1] "tBodyAcc_mean___X"               "tBodyAcc_mean___Y"              
##  [3] "tBodyAcc_mean___Z"               "tBodyAcc_std___X"               
##  [5] "tBodyAcc_std___Y"                "tBodyAcc_std___Z"               
##  [7] "tGravityAcc_mean___X"            "tGravityAcc_mean___Y"           
##  [9] "tGravityAcc_mean___Z"            "tGravityAcc_std___X"            
## [11] "tGravityAcc_std___Y"             "tGravityAcc_std___Z"            
## [13] "tBodyAccJerk_mean___X"           "tBodyAccJerk_mean___Y"          
## [15] "tBodyAccJerk_mean___Z"           "tBodyAccJerk_std___X"           
## [17] "tBodyAccJerk_std___Y"            "tBodyAccJerk_std___Z"           
## [19] "tBodyGyro_mean___X"              "tBodyGyro_mean___Y"             
## [21] "tBodyGyro_mean___Z"              "tBodyGyro_std___X"              
## [23] "tBodyGyro_std___Y"               "tBodyGyro_std___Z"              
## [25] "tBodyGyroJerk_mean___X"          "tBodyGyroJerk_mean___Y"         
## [27] "tBodyGyroJerk_mean___Z"          "tBodyGyroJerk_std___X"          
## [29] "tBodyGyroJerk_std___Y"           "tBodyGyroJerk_std___Z"          
## [31] "tBodyAccMag_mean__"              "tBodyAccMag_std__"              
## [33] "tGravityAccMag_mean__"           "tGravityAccMag_std__"           
## [35] "tBodyAccJerkMag_mean__"          "tBodyAccJerkMag_std__"          
## [37] "tBodyGyroMag_mean__"             "tBodyGyroMag_std__"             
## [39] "tBodyGyroJerkMag_mean__"         "tBodyGyroJerkMag_std__"         
## [41] "fBodyAcc_mean___X"               "fBodyAcc_mean___Y"              
## [43] "fBodyAcc_mean___Z"               "fBodyAcc_std___X"               
## [45] "fBodyAcc_std___Y"                "fBodyAcc_std___Z"               
## [47] "fBodyAcc_meanFreq___X"           "fBodyAcc_meanFreq___Y"          
## [49] "fBodyAcc_meanFreq___Z"           "fBodyAccJerk_mean___X"          
## [51] "fBodyAccJerk_mean___Y"           "fBodyAccJerk_mean___Z"          
## [53] "fBodyAccJerk_std___X"            "fBodyAccJerk_std___Y"           
## [55] "fBodyAccJerk_std___Z"            "fBodyAccJerk_meanFreq___X"      
## [57] "fBodyAccJerk_meanFreq___Y"       "fBodyAccJerk_meanFreq___Z"      
## [59] "fBodyGyro_mean___X"              "fBodyGyro_mean___Y"             
## [61] "fBodyGyro_mean___Z"              "fBodyGyro_std___X"              
## [63] "fBodyGyro_std___Y"               "fBodyGyro_std___Z"              
## [65] "fBodyGyro_meanFreq___X"          "fBodyGyro_meanFreq___Y"         
## [67] "fBodyGyro_meanFreq___Z"          "fBodyAccMag_mean__"             
## [69] "fBodyAccMag_std__"               "fBodyAccMag_meanFreq__"         
## [71] "fBodyBodyAccJerkMag_mean__"      "fBodyBodyAccJerkMag_std__"      
## [73] "fBodyBodyAccJerkMag_meanFreq__"  "fBodyBodyGyroMag_mean__"        
## [75] "fBodyBodyGyroMag_std__"          "fBodyBodyGyroMag_meanFreq__"    
## [77] "fBodyBodyGyroJerkMag_mean__"     "fBodyBodyGyroJerkMag_std__"     
## [79] "fBodyBodyGyroJerkMag_meanFreq__" "activity_descriptive_label"
```

# Create an independent tidy data set with the average of each variable for each activity and each subject

first I split totaldata based on "subject_id" and "activity_descriptive_label"


```r
spliteddata<-
  split(totaldata, list(totaldata$subject_id, totaldata$activity_descriptive_label))
```

then apply the colmeans function for each of splited list of data


```r
tidydata<-sapply(
  spliteddata, 
  function(x) colMeans(x[, -which(names(totaldata) %in% 
                                    c("subject_id", 
                                      "activity_id",
                                      "activity_descriptive_label"))]))
tidydata[1:3, 1:3]
```

```
##                   1.LAYING 2.LAYING 3.LAYING
## tBodyAcc_mean___X  0.22160  0.28137  0.27552
## tBodyAcc_mean___Y -0.04051 -0.01816 -0.01896
## tBodyAcc_mean___Z -0.11320 -0.10725 -0.10130
```

columns are the combination of subject_id and activity_id.
For exampe, 1.LAYING means subject "1"" with activity "LAYING"
and rows show the attribute names.
value of each cell is the average value of the specified attribute for the specific subject and activity.

save the data in a file


```r
write.table(x=tidydata, file="tidydata.txt")
```
