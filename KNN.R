
R version 4.1.2 (2021-11-01) -- "Bird Hippie"
Copyright (C) 2021 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[Previously saved workspace restored]

> #Project Requirements: Choose a real world dataset in the area you are interested, in the UCI Machine Learning repository
> #Choose at least two different (our group opted for three) machine learning methods to conduct a thorough analysis in R language
> #Write a Project Report following the project template and samples provided
> #Official beginning of KNN R code (Mario Valdez's contribution) (QDA - Bat Erdene) (LDA - Erik Trujillo)
> #To start off we need a dataset, and it must from the UCI Machine Learning repository, our group decided to go with the Wine dataset
> #Wine dataset description: The data is focusing on the results of a chemical analysis of wine grown in the same region in Italy but derived from three different cultivars
> #The analysis determined the quantities of 13 constituents found in each of the three types of wines
> #In a classification context, this a well posed problem with "well behaved" class structures. A good data set for first testing of a new classifier, but not very difficult
> #There are about 13 attributes, but originally the dataset had around 30 variables. The author of the dataset claims to have lost the original 30 variables. The current 13 are:
> #alcohol, malic acid, ash, alcalinity of ash, magnesium, total phenols, flavanoids, nonflavanoid phenols, proanthocyanins, color intensity, hue, OD280/0D315, and finally proline
> #As for class distribution: class 1 has 59 instances, class 2 has 71 instances, and class 3 has 48 instances
> #Now that the dataset has been described clearly, I am going to load the wine project dataset in order to get started
>  test <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data")test <- read.
Error: unexpected symbol in " test <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data")test"
>  test <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data")
> View(test)
> View(test)
> #Now the data has been loaded, but it is raw so there's definitely some cleaning we can do, such as actually adding the names of the 13 attributes, also it's 177 instead of 178 instances which isn't ideal
> remove(test)
> wine_ds <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data")
> View(wine_ds)
> cn <- c("class", "alcohol", "malic_acid", "ash", "alcalinity_of_ash", "magnesium", "total_phenols", "flavonoids",
+ "nonflavanoid_phenols","proanthocyanins", "color_intensity", "hue", "OD28O_OD315", "proline")
> cn
 [1] "class"                "alcohol"              "malic_acid"          
 [4] "ash"                  "alcalinity_of_ash"    "magnesium"           
 [7] "total_phenols"        "flavonoids"           "nonflavanoid_phenols"
[10] "proanthocyanins"      "color_intensity"      "hue"                 
[13] "OD28O_OD315"          "proline"             
> colnames(wine_ds) <- cn
> View(wine_ds)
> #An improvement over the last chart, but we are still missing the 178th instance, but we can fix that with this next code
> read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data", header = FALSE)
    V1    V2   V3   V4   V5  V6   V7   V8   V9  V10       V11   V12  V13  V14
1    1 14.23 1.71 2.43 15.6 127 2.80 3.06 0.28 2.29  5.640000 1.040 3.92 1065
2    1 13.20 1.78 2.14 11.2 100 2.65 2.76 0.26 1.28  4.380000 1.050 3.40 1050
3    1 13.16 2.36 2.67 18.6 101 2.80 3.24 0.30 2.81  5.680000 1.030 3.17 1185
4    1 14.37 1.95 2.50 16.8 113 3.85 3.49 0.24 2.18  7.800000 0.860 3.45 1480
5    1 13.24 2.59 2.87 21.0 118 2.80 2.69 0.39 1.82  4.320000 1.040 2.93  735
6    1 14.20 1.76 2.45 15.2 112 3.27 3.39 0.34 1.97  6.750000 1.050 2.85 1450
7    1 14.39 1.87 2.45 14.6  96 2.50 2.52 0.30 1.98  5.250000 1.020 3.58 1290
8    1 14.06 2.15 2.61 17.6 121 2.60 2.51 0.31 1.25  5.050000 1.060 3.58 1295
9    1 14.83 1.64 2.17 14.0  97 2.80 2.98 0.29 1.98  5.200000 1.080 2.85 1045
10   1 13.86 1.35 2.27 16.0  98 2.98 3.15 0.22 1.85  7.220000 1.010 3.55 1045
11   1 14.10 2.16 2.30 18.0 105 2.95 3.32 0.22 2.38  5.750000 1.250 3.17 1510
12   1 14.12 1.48 2.32 16.8  95 2.20 2.43 0.26 1.57  5.000000 1.170 2.82 1280
13   1 13.75 1.73 2.41 16.0  89 2.60 2.76 0.29 1.81  5.600000 1.150 2.90 1320
14   1 14.75 1.73 2.39 11.4  91 3.10 3.69 0.43 2.81  5.400000 1.250 2.73 1150
15   1 14.38 1.87 2.38 12.0 102 3.30 3.64 0.29 2.96  7.500000 1.200 3.00 1547
16   1 13.63 1.81 2.70 17.2 112 2.85 2.91 0.30 1.46  7.300000 1.280 2.88 1310
17   1 14.30 1.92 2.72 20.0 120 2.80 3.14 0.33 1.97  6.200000 1.070 2.65 1280
18   1 13.83 1.57 2.62 20.0 115 2.95 3.40 0.40 1.72  6.600000 1.130 2.57 1130
19   1 14.19 1.59 2.48 16.5 108 3.30 3.93 0.32 1.86  8.700000 1.230 2.82 1680
20   1 13.64 3.10 2.56 15.2 116 2.70 3.03 0.17 1.66  5.100000 0.960 3.36  845
21   1 14.06 1.63 2.28 16.0 126 3.00 3.17 0.24 2.10  5.650000 1.090 3.71  780
22   1 12.93 3.80 2.65 18.6 102 2.41 2.41 0.25 1.98  4.500000 1.030 3.52  770
23   1 13.71 1.86 2.36 16.6 101 2.61 2.88 0.27 1.69  3.800000 1.110 4.00 1035
24   1 12.85 1.60 2.52 17.8  95 2.48 2.37 0.26 1.46  3.930000 1.090 3.63 1015
25   1 13.50 1.81 2.61 20.0  96 2.53 2.61 0.28 1.66  3.520000 1.120 3.82  845
26   1 13.05 2.05 3.22 25.0 124 2.63 2.68 0.47 1.92  3.580000 1.130 3.20  830
27   1 13.39 1.77 2.62 16.1  93 2.85 2.94 0.34 1.45  4.800000 0.920 3.22 1195
28   1 13.30 1.72 2.14 17.0  94 2.40 2.19 0.27 1.35  3.950000 1.020 2.77 1285
29   1 13.87 1.90 2.80 19.4 107 2.95 2.97 0.37 1.76  4.500000 1.250 3.40  915
30   1 14.02 1.68 2.21 16.0  96 2.65 2.33 0.26 1.98  4.700000 1.040 3.59 1035
31   1 13.73 1.50 2.70 22.5 101 3.00 3.25 0.29 2.38  5.700000 1.190 2.71 1285
32   1 13.58 1.66 2.36 19.1 106 2.86 3.19 0.22 1.95  6.900000 1.090 2.88 1515
33   1 13.68 1.83 2.36 17.2 104 2.42 2.69 0.42 1.97  3.840000 1.230 2.87  990
34   1 13.76 1.53 2.70 19.5 132 2.95 2.74 0.50 1.35  5.400000 1.250 3.00 1235
35   1 13.51 1.80 2.65 19.0 110 2.35 2.53 0.29 1.54  4.200000 1.100 2.87 1095
36   1 13.48 1.81 2.41 20.5 100 2.70 2.98 0.26 1.86  5.100000 1.040 3.47  920
37   1 13.28 1.64 2.84 15.5 110 2.60 2.68 0.34 1.36  4.600000 1.090 2.78  880
38   1 13.05 1.65 2.55 18.0  98 2.45 2.43 0.29 1.44  4.250000 1.120 2.51 1105
39   1 13.07 1.50 2.10 15.5  98 2.40 2.64 0.28 1.37  3.700000 1.180 2.69 1020
40   1 14.22 3.99 2.51 13.2 128 3.00 3.04 0.20 2.08  5.100000 0.890 3.53  760
41   1 13.56 1.71 2.31 16.2 117 3.15 3.29 0.34 2.34  6.130000 0.950 3.38  795
42   1 13.41 3.84 2.12 18.8  90 2.45 2.68 0.27 1.48  4.280000 0.910 3.00 1035
43   1 13.88 1.89 2.59 15.0 101 3.25 3.56 0.17 1.70  5.430000 0.880 3.56 1095
44   1 13.24 3.98 2.29 17.5 103 2.64 2.63 0.32 1.66  4.360000 0.820 3.00  680
45   1 13.05 1.77 2.10 17.0 107 3.00 3.00 0.28 2.03  5.040000 0.880 3.35  885
46   1 14.21 4.04 2.44 18.9 111 2.85 2.65 0.30 1.25  5.240000 0.870 3.33 1080
47   1 14.38 3.59 2.28 16.0 102 3.25 3.17 0.27 2.19  4.900000 1.040 3.44 1065
48   1 13.90 1.68 2.12 16.0 101 3.10 3.39 0.21 2.14  6.100000 0.910 3.33  985
49   1 14.10 2.02 2.40 18.8 103 2.75 2.92 0.32 2.38  6.200000 1.070 2.75 1060
50   1 13.94 1.73 2.27 17.4 108 2.88 3.54 0.32 2.08  8.900000 1.120 3.10 1260
51   1 13.05 1.73 2.04 12.4  92 2.72 3.27 0.17 2.91  7.200000 1.120 2.91 1150
52   1 13.83 1.65 2.60 17.2  94 2.45 2.99 0.22 2.29  5.600000 1.240 3.37 1265
53   1 13.82 1.75 2.42 14.0 111 3.88 3.74 0.32 1.87  7.050000 1.010 3.26 1190
54   1 13.77 1.90 2.68 17.1 115 3.00 2.79 0.39 1.68  6.300000 1.130 2.93 1375
55   1 13.74 1.67 2.25 16.4 118 2.60 2.90 0.21 1.62  5.850000 0.920 3.20 1060
56   1 13.56 1.73 2.46 20.5 116 2.96 2.78 0.20 2.45  6.250000 0.980 3.03 1120
57   1 14.22 1.70 2.30 16.3 118 3.20 3.00 0.26 2.03  6.380000 0.940 3.31  970
58   1 13.29 1.97 2.68 16.8 102 3.00 3.23 0.31 1.66  6.000000 1.070 2.84 1270
59   1 13.72 1.43 2.50 16.7 108 3.40 3.67 0.19 2.04  6.800000 0.890 2.87 1285
60   2 12.37 0.94 1.36 10.6  88 1.98 0.57 0.28 0.42  1.950000 1.050 1.82  520
61   2 12.33 1.10 2.28 16.0 101 2.05 1.09 0.63 0.41  3.270000 1.250 1.67  680
62   2 12.64 1.36 2.02 16.8 100 2.02 1.41 0.53 0.62  5.750000 0.980 1.59  450
63   2 13.67 1.25 1.92 18.0  94 2.10 1.79 0.32 0.73  3.800000 1.230 2.46  630
64   2 12.37 1.13 2.16 19.0  87 3.50 3.10 0.19 1.87  4.450000 1.220 2.87  420
65   2 12.17 1.45 2.53 19.0 104 1.89 1.75 0.45 1.03  2.950000 1.450 2.23  355
66   2 12.37 1.21 2.56 18.1  98 2.42 2.65 0.37 2.08  4.600000 1.190 2.30  678
67   2 13.11 1.01 1.70 15.0  78 2.98 3.18 0.26 2.28  5.300000 1.120 3.18  502
68   2 12.37 1.17 1.92 19.6  78 2.11 2.00 0.27 1.04  4.680000 1.120 3.48  510
69   2 13.34 0.94 2.36 17.0 110 2.53 1.30 0.55 0.42  3.170000 1.020 1.93  750
70   2 12.21 1.19 1.75 16.8 151 1.85 1.28 0.14 2.50  2.850000 1.280 3.07  718
71   2 12.29 1.61 2.21 20.4 103 1.10 1.02 0.37 1.46  3.050000 0.906 1.82  870
72   2 13.86 1.51 2.67 25.0  86 2.95 2.86 0.21 1.87  3.380000 1.360 3.16  410
73   2 13.49 1.66 2.24 24.0  87 1.88 1.84 0.27 1.03  3.740000 0.980 2.78  472
74   2 12.99 1.67 2.60 30.0 139 3.30 2.89 0.21 1.96  3.350000 1.310 3.50  985
75   2 11.96 1.09 2.30 21.0 101 3.38 2.14 0.13 1.65  3.210000 0.990 3.13  886
76   2 11.66 1.88 1.92 16.0  97 1.61 1.57 0.34 1.15  3.800000 1.230 2.14  428
77   2 13.03 0.90 1.71 16.0  86 1.95 2.03 0.24 1.46  4.600000 1.190 2.48  392
78   2 11.84 2.89 2.23 18.0 112 1.72 1.32 0.43 0.95  2.650000 0.960 2.52  500
79   2 12.33 0.99 1.95 14.8 136 1.90 1.85 0.35 2.76  3.400000 1.060 2.31  750
80   2 12.70 3.87 2.40 23.0 101 2.83 2.55 0.43 1.95  2.570000 1.190 3.13  463
81   2 12.00 0.92 2.00 19.0  86 2.42 2.26 0.30 1.43  2.500000 1.380 3.12  278
82   2 12.72 1.81 2.20 18.8  86 2.20 2.53 0.26 1.77  3.900000 1.160 3.14  714
83   2 12.08 1.13 2.51 24.0  78 2.00 1.58 0.40 1.40  2.200000 1.310 2.72  630
84   2 13.05 3.86 2.32 22.5  85 1.65 1.59 0.61 1.62  4.800000 0.840 2.01  515
85   2 11.84 0.89 2.58 18.0  94 2.20 2.21 0.22 2.35  3.050000 0.790 3.08  520
86   2 12.67 0.98 2.24 18.0  99 2.20 1.94 0.30 1.46  2.620000 1.230 3.16  450
87   2 12.16 1.61 2.31 22.8  90 1.78 1.69 0.43 1.56  2.450000 1.330 2.26  495
88   2 11.65 1.67 2.62 26.0  88 1.92 1.61 0.40 1.34  2.600000 1.360 3.21  562
89   2 11.64 2.06 2.46 21.6  84 1.95 1.69 0.48 1.35  2.800000 1.000 2.75  680
90   2 12.08 1.33 2.30 23.6  70 2.20 1.59 0.42 1.38  1.740000 1.070 3.21  625
91   2 12.08 1.83 2.32 18.5  81 1.60 1.50 0.52 1.64  2.400000 1.080 2.27  480
92   2 12.00 1.51 2.42 22.0  86 1.45 1.25 0.50 1.63  3.600000 1.050 2.65  450
93   2 12.69 1.53 2.26 20.7  80 1.38 1.46 0.58 1.62  3.050000 0.960 2.06  495
94   2 12.29 2.83 2.22 18.0  88 2.45 2.25 0.25 1.99  2.150000 1.150 3.30  290
95   2 11.62 1.99 2.28 18.0  98 3.02 2.26 0.17 1.35  3.250000 1.160 2.96  345
96   2 12.47 1.52 2.20 19.0 162 2.50 2.27 0.32 3.28  2.600000 1.160 2.63  937
97   2 11.81 2.12 2.74 21.5 134 1.60 0.99 0.14 1.56  2.500000 0.950 2.26  625
98   2 12.29 1.41 1.98 16.0  85 2.55 2.50 0.29 1.77  2.900000 1.230 2.74  428
99   2 12.37 1.07 2.10 18.5  88 3.52 3.75 0.24 1.95  4.500000 1.040 2.77  660
100  2 12.29 3.17 2.21 18.0  88 2.85 2.99 0.45 2.81  2.300000 1.420 2.83  406
101  2 12.08 2.08 1.70 17.5  97 2.23 2.17 0.26 1.40  3.300000 1.270 2.96  710
102  2 12.60 1.34 1.90 18.5  88 1.45 1.36 0.29 1.35  2.450000 1.040 2.77  562
103  2 12.34 2.45 2.46 21.0  98 2.56 2.11 0.34 1.31  2.800000 0.800 3.38  438
104  2 11.82 1.72 1.88 19.5  86 2.50 1.64 0.37 1.42  2.060000 0.940 2.44  415
105  2 12.51 1.73 1.98 20.5  85 2.20 1.92 0.32 1.48  2.940000 1.040 3.57  672
106  2 12.42 2.55 2.27 22.0  90 1.68 1.84 0.66 1.42  2.700000 0.860 3.30  315
107  2 12.25 1.73 2.12 19.0  80 1.65 2.03 0.37 1.63  3.400000 1.000 3.17  510
108  2 12.72 1.75 2.28 22.5  84 1.38 1.76 0.48 1.63  3.300000 0.880 2.42  488
109  2 12.22 1.29 1.94 19.0  92 2.36 2.04 0.39 2.08  2.700000 0.860 3.02  312
110  2 11.61 1.35 2.70 20.0  94 2.74 2.92 0.29 2.49  2.650000 0.960 3.26  680
111  2 11.46 3.74 1.82 19.5 107 3.18 2.58 0.24 3.58  2.900000 0.750 2.81  562
112  2 12.52 2.43 2.17 21.0  88 2.55 2.27 0.26 1.22  2.000000 0.900 2.78  325
113  2 11.76 2.68 2.92 20.0 103 1.75 2.03 0.60 1.05  3.800000 1.230 2.50  607
114  2 11.41 0.74 2.50 21.0  88 2.48 2.01 0.42 1.44  3.080000 1.100 2.31  434
115  2 12.08 1.39 2.50 22.5  84 2.56 2.29 0.43 1.04  2.900000 0.930 3.19  385
116  2 11.03 1.51 2.20 21.5  85 2.46 2.17 0.52 2.01  1.900000 1.710 2.87  407
117  2 11.82 1.47 1.99 20.8  86 1.98 1.60 0.30 1.53  1.950000 0.950 3.33  495
118  2 12.42 1.61 2.19 22.5 108 2.00 2.09 0.34 1.61  2.060000 1.060 2.96  345
119  2 12.77 3.43 1.98 16.0  80 1.63 1.25 0.43 0.83  3.400000 0.700 2.12  372
120  2 12.00 3.43 2.00 19.0  87 2.00 1.64 0.37 1.87  1.280000 0.930 3.05  564
121  2 11.45 2.40 2.42 20.0  96 2.90 2.79 0.32 1.83  3.250000 0.800 3.39  625
122  2 11.56 2.05 3.23 28.5 119 3.18 5.08 0.47 1.87  6.000000 0.930 3.69  465
123  2 12.42 4.43 2.73 26.5 102 2.20 2.13 0.43 1.71  2.080000 0.920 3.12  365
124  2 13.05 5.80 2.13 21.5  86 2.62 2.65 0.30 2.01  2.600000 0.730 3.10  380
125  2 11.87 4.31 2.39 21.0  82 2.86 3.03 0.21 2.91  2.800000 0.750 3.64  380
126  2 12.07 2.16 2.17 21.0  85 2.60 2.65 0.37 1.35  2.760000 0.860 3.28  378
127  2 12.43 1.53 2.29 21.5  86 2.74 3.15 0.39 1.77  3.940000 0.690 2.84  352
128  2 11.79 2.13 2.78 28.5  92 2.13 2.24 0.58 1.76  3.000000 0.970 2.44  466
129  2 12.37 1.63 2.30 24.5  88 2.22 2.45 0.40 1.90  2.120000 0.890 2.78  342
130  2 12.04 4.30 2.38 22.0  80 2.10 1.75 0.42 1.35  2.600000 0.790 2.57  580
131  3 12.86 1.35 2.32 18.0 122 1.51 1.25 0.21 0.94  4.100000 0.760 1.29  630
132  3 12.88 2.99 2.40 20.0 104 1.30 1.22 0.24 0.83  5.400000 0.740 1.42  530
133  3 12.81 2.31 2.40 24.0  98 1.15 1.09 0.27 0.83  5.700000 0.660 1.36  560
134  3 12.70 3.55 2.36 21.5 106 1.70 1.20 0.17 0.84  5.000000 0.780 1.29  600
135  3 12.51 1.24 2.25 17.5  85 2.00 0.58 0.60 1.25  5.450000 0.750 1.51  650
136  3 12.60 2.46 2.20 18.5  94 1.62 0.66 0.63 0.94  7.100000 0.730 1.58  695
137  3 12.25 4.72 2.54 21.0  89 1.38 0.47 0.53 0.80  3.850000 0.750 1.27  720
138  3 12.53 5.51 2.64 25.0  96 1.79 0.60 0.63 1.10  5.000000 0.820 1.69  515
139  3 13.49 3.59 2.19 19.5  88 1.62 0.48 0.58 0.88  5.700000 0.810 1.82  580
140  3 12.84 2.96 2.61 24.0 101 2.32 0.60 0.53 0.81  4.920000 0.890 2.15  590
141  3 12.93 2.81 2.70 21.0  96 1.54 0.50 0.53 0.75  4.600000 0.770 2.31  600
142  3 13.36 2.56 2.35 20.0  89 1.40 0.50 0.37 0.64  5.600000 0.700 2.47  780
143  3 13.52 3.17 2.72 23.5  97 1.55 0.52 0.50 0.55  4.350000 0.890 2.06  520
144  3 13.62 4.95 2.35 20.0  92 2.00 0.80 0.47 1.02  4.400000 0.910 2.05  550
145  3 12.25 3.88 2.20 18.5 112 1.38 0.78 0.29 1.14  8.210000 0.650 2.00  855
146  3 13.16 3.57 2.15 21.0 102 1.50 0.55 0.43 1.30  4.000000 0.600 1.68  830
147  3 13.88 5.04 2.23 20.0  80 0.98 0.34 0.40 0.68  4.900000 0.580 1.33  415
148  3 12.87 4.61 2.48 21.5  86 1.70 0.65 0.47 0.86  7.650000 0.540 1.86  625
149  3 13.32 3.24 2.38 21.5  92 1.93 0.76 0.45 1.25  8.420000 0.550 1.62  650
150  3 13.08 3.90 2.36 21.5 113 1.41 1.39 0.34 1.14  9.400000 0.570 1.33  550
151  3 13.50 3.12 2.62 24.0 123 1.40 1.57 0.22 1.25  8.600000 0.590 1.30  500
152  3 12.79 2.67 2.48 22.0 112 1.48 1.36 0.24 1.26 10.800000 0.480 1.47  480
153  3 13.11 1.90 2.75 25.5 116 2.20 1.28 0.26 1.56  7.100000 0.610 1.33  425
154  3 13.23 3.30 2.28 18.5  98 1.80 0.83 0.61 1.87 10.520000 0.560 1.51  675
155  3 12.58 1.29 2.10 20.0 103 1.48 0.58 0.53 1.40  7.600000 0.580 1.55  640
156  3 13.17 5.19 2.32 22.0  93 1.74 0.63 0.61 1.55  7.900000 0.600 1.48  725
157  3 13.84 4.12 2.38 19.5  89 1.80 0.83 0.48 1.56  9.010000 0.570 1.64  480
158  3 12.45 3.03 2.64 27.0  97 1.90 0.58 0.63 1.14  7.500000 0.670 1.73  880
159  3 14.34 1.68 2.70 25.0  98 2.80 1.31 0.53 2.70 13.000000 0.570 1.96  660
160  3 13.48 1.67 2.64 22.5  89 2.60 1.10 0.52 2.29 11.750000 0.570 1.78  620
161  3 12.36 3.83 2.38 21.0  88 2.30 0.92 0.50 1.04  7.650000 0.560 1.58  520
162  3 13.69 3.26 2.54 20.0 107 1.83 0.56 0.50 0.80  5.880000 0.960 1.82  680
163  3 12.85 3.27 2.58 22.0 106 1.65 0.60 0.60 0.96  5.580000 0.870 2.11  570
164  3 12.96 3.45 2.35 18.5 106 1.39 0.70 0.40 0.94  5.280000 0.680 1.75  675
165  3 13.78 2.76 2.30 22.0  90 1.35 0.68 0.41 1.03  9.580000 0.700 1.68  615
166  3 13.73 4.36 2.26 22.5  88 1.28 0.47 0.52 1.15  6.620000 0.780 1.75  520
167  3 13.45 3.70 2.60 23.0 111 1.70 0.92 0.43 1.46 10.680000 0.850 1.56  695
168  3 12.82 3.37 2.30 19.5  88 1.48 0.66 0.40 0.97 10.260000 0.720 1.75  685
169  3 13.58 2.58 2.69 24.5 105 1.55 0.84 0.39 1.54  8.660000 0.740 1.80  750
170  3 13.40 4.60 2.86 25.0 112 1.98 0.96 0.27 1.11  8.500000 0.670 1.92  630
171  3 12.20 3.03 2.32 19.0  96 1.25 0.49 0.40 0.73  5.500000 0.660 1.83  510
172  3 12.77 2.39 2.28 19.5  86 1.39 0.51 0.48 0.64  9.899999 0.570 1.63  470
173  3 14.16 2.51 2.48 20.0  91 1.68 0.70 0.44 1.24  9.700000 0.620 1.71  660
174  3 13.71 5.65 2.45 20.5  95 1.68 0.61 0.52 1.06  7.700000 0.640 1.74  740
175  3 13.40 3.91 2.48 23.0 102 1.80 0.75 0.43 1.41  7.300000 0.700 1.56  750
176  3 13.27 4.28 2.26 20.0 120 1.59 0.69 0.43 1.35 10.200000 0.590 1.56  835
177  3 13.17 2.59 2.37 20.0 120 1.65 0.68 0.53 1.46  9.300000 0.600 1.62  840
178  3 14.13 4.10 2.74 24.5  96 2.05 0.76 0.56 1.35  9.200000 0.610 1.60  560
> wine_ds <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data", header = FALSE)
> nrow(wine_ds)
[1] 178
>  cn <- c("class", "alcohol", "malic_acid", "ash", "alcalinity_of_ash", "magnesium", "total_phenols", "flavanoids",
+  "nonflavanoid_phenols","proanthocyanins", "color_intensity", "hue", "OD28O_OD315", "proline")
> colnames(wine_ds) <- cn
> View(wine_ds)
> # Above was the prologue to the data analysis methods, we have our table, our attributes, and a great deal of background. We can now begin the official main bulk of our code, which involves at least two different machine learning methods to conduct a thorough analysis. Our group opted for 3 machine learning methods and those three machine learning method are quadratic discriminant analysis, linear discrimininant analysis, and KNN. (end of comment)
> head(wine_ds)
  class alcohol malic_acid  ash alcalinity_of_ash magnesium total_phenols
1     1   14.23       1.71 2.43              15.6       127          2.80
2     1   13.20       1.78 2.14              11.2       100          2.65
3     1   13.16       2.36 2.67              18.6       101          2.80
4     1   14.37       1.95 2.50              16.8       113          3.85
5     1   13.24       2.59 2.87              21.0       118          2.80
6     1   14.20       1.76 2.45              15.2       112          3.27
  flavanoids nonflavanoid_phenols proanthocyanins color_intensity  hue
1       3.06                 0.28            2.29            5.64 1.04
2       2.76                 0.26            1.28            4.38 1.05
3       3.24                 0.30            2.81            5.68 1.03
4       3.49                 0.24            2.18            7.80 0.86
5       2.69                 0.39            1.82            4.32 1.04
6       3.39                 0.34            1.97            6.75 1.05
  OD28O_OD315 proline
1        3.92    1065
2        3.40    1050
3        3.17    1185
4        3.45    1480
5        2.93     735
6        2.85    1450
> summary(wine_ds) #this is also visible in the project report
     class          alcohol        malic_acid         ash       
 Min.   :1.000   Min.   :11.03   Min.   :0.740   Min.   :1.360  
 1st Qu.:1.000   1st Qu.:12.36   1st Qu.:1.603   1st Qu.:2.210  
 Median :2.000   Median :13.05   Median :1.865   Median :2.360  
 Mean   :1.938   Mean   :13.00   Mean   :2.336   Mean   :2.367  
 3rd Qu.:3.000   3rd Qu.:13.68   3rd Qu.:3.083   3rd Qu.:2.558  
 Max.   :3.000   Max.   :14.83   Max.   :5.800   Max.   :3.230  
 alcalinity_of_ash   magnesium      total_phenols     flavanoids   
 Min.   :10.60     Min.   : 70.00   Min.   :0.980   Min.   :0.340  
 1st Qu.:17.20     1st Qu.: 88.00   1st Qu.:1.742   1st Qu.:1.205  
 Median :19.50     Median : 98.00   Median :2.355   Median :2.135  
 Mean   :19.49     Mean   : 99.74   Mean   :2.295   Mean   :2.029  
 3rd Qu.:21.50     3rd Qu.:107.00   3rd Qu.:2.800   3rd Qu.:2.875  
 Max.   :30.00     Max.   :162.00   Max.   :3.880   Max.   :5.080  
 nonflavanoid_phenols proanthocyanins color_intensity       hue        
 Min.   :0.1300       Min.   :0.410   Min.   : 1.280   Min.   :0.4800  
 1st Qu.:0.2700       1st Qu.:1.250   1st Qu.: 3.220   1st Qu.:0.7825  
 Median :0.3400       Median :1.555   Median : 4.690   Median :0.9650  
 Mean   :0.3619       Mean   :1.591   Mean   : 5.058   Mean   :0.9574  
 3rd Qu.:0.4375       3rd Qu.:1.950   3rd Qu.: 6.200   3rd Qu.:1.1200  
 Max.   :0.6600       Max.   :3.580   Max.   :13.000   Max.   :1.7100  
  OD28O_OD315       proline      
 Min.   :1.270   Min.   : 278.0  
 1st Qu.:1.938   1st Qu.: 500.5  
 Median :2.780   Median : 673.5  
 Mean   :2.612   Mean   : 746.9  
 3rd Qu.:3.170   3rd Qu.: 985.0  
 Max.   :4.000   Max.   :1680.0  
> plot(wine_ds) #This will assist with the sampling approach to the Wine classification dataset
> #Now it is a good time to check each summary of the 13 attributes
> summary(wine_ds$alcohol)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  11.03   12.36   13.05   13.00   13.68   14.83 
> summary(wine_ds$malic_acid)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.740   1.603   1.865   2.336   3.083   5.800 
> summary(wine_ds$ash)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  1.360   2.210   2.360   2.367   2.558   3.230 
> #As one can see, the summary command works as there is consistency, and the values match
> #What we are interested in figuring out the answer to our research question, which is what attributes are more commonly found in one wine type over the other
> #Since we have three wine types, let's start with c;ass 1 which can be considered wine type 1, it has 59 instances
> onewine <- subset(wine_ds, wine_ds$class = 1)
Error: unexpected '=' in "onewine <- subset(wine_ds, wine_ds$class ="
> onewine <- subset(wine_ds, wine_ds$class == 1)
> summary(onewine)
     class      alcohol        malic_acid         ash        alcalinity_of_ash
 Min.   :1   Min.   :12.85   Min.   :1.350   Min.   :2.040   Min.   :11.20    
 1st Qu.:1   1st Qu.:13.40   1st Qu.:1.665   1st Qu.:2.295   1st Qu.:16.00    
 Median :1   Median :13.75   Median :1.770   Median :2.440   Median :16.80    
 Mean   :1   Mean   :13.74   Mean   :2.011   Mean   :2.456   Mean   :17.04    
 3rd Qu.:1   3rd Qu.:14.10   3rd Qu.:1.935   3rd Qu.:2.615   3rd Qu.:18.70    
 Max.   :1   Max.   :14.83   Max.   :4.040   Max.   :3.220   Max.   :25.00    
   magnesium     total_phenols    flavanoids    nonflavanoid_phenols
 Min.   : 89.0   Min.   :2.20   Min.   :2.190   Min.   :0.170       
 1st Qu.: 98.0   1st Qu.:2.60   1st Qu.:2.680   1st Qu.:0.255       
 Median :104.0   Median :2.80   Median :2.980   Median :0.290       
 Mean   :106.3   Mean   :2.84   Mean   :2.982   Mean   :0.290       
 3rd Qu.:114.0   3rd Qu.:3.00   3rd Qu.:3.245   3rd Qu.:0.320       
 Max.   :132.0   Max.   :3.88   Max.   :3.930   Max.   :0.500       
 proanthocyanins color_intensity      hue         OD28O_OD315   
 Min.   :1.250   Min.   :3.520   Min.   :0.820   Min.   :2.510  
 1st Qu.:1.640   1st Qu.:4.550   1st Qu.:0.995   1st Qu.:2.870  
 Median :1.870   Median :5.400   Median :1.070   Median :3.170  
 Mean   :1.899   Mean   :5.528   Mean   :1.062   Mean   :3.158  
 3rd Qu.:2.090   3rd Qu.:6.225   3rd Qu.:1.130   3rd Qu.:3.420  
 Max.   :2.960   Max.   :8.900   Max.   :1.280   Max.   :4.000  
    proline      
 Min.   : 680.0  
 1st Qu.: 987.5  
 Median :1095.0  
 Mean   :1115.7  
 3rd Qu.:1280.0  
 Max.   :1680.0  
> #checking for errors
> dim(onewine)
[1] 59 14
> #On to class number 2
> twowine <- subset(wine_ds, wine_ds$class == 2)
> summary(twowine)
     class      alcohol        malic_acid         ash        alcalinity_of_ash
 Min.   :2   Min.   :11.03   Min.   :0.740   Min.   :1.360   Min.   :10.60    
 1st Qu.:2   1st Qu.:11.91   1st Qu.:1.270   1st Qu.:2.000   1st Qu.:18.00    
 Median :2   Median :12.29   Median :1.610   Median :2.240   Median :20.00    
 Mean   :2   Mean   :12.28   Mean   :1.933   Mean   :2.245   Mean   :20.24    
 3rd Qu.:2   3rd Qu.:12.52   3rd Qu.:2.145   3rd Qu.:2.420   3rd Qu.:22.00    
 Max.   :2   Max.   :13.86   Max.   :5.800   Max.   :3.230   Max.   :30.00    
   magnesium      total_phenols     flavanoids    nonflavanoid_phenols
 Min.   : 70.00   Min.   :1.100   Min.   :0.570   Min.   :0.1300      
 1st Qu.: 85.50   1st Qu.:1.895   1st Qu.:1.605   1st Qu.:0.2700      
 Median : 88.00   Median :2.200   Median :2.030   Median :0.3700      
 Mean   : 94.55   Mean   :2.259   Mean   :2.081   Mean   :0.3637      
 3rd Qu.: 99.50   3rd Qu.:2.560   3rd Qu.:2.475   3rd Qu.:0.4300      
 Max.   :162.00   Max.   :3.520   Max.   :5.080   Max.   :0.6600      
 proanthocyanins color_intensity      hue         OD28O_OD315   
 Min.   :0.410   Min.   :1.280   Min.   :0.690   Min.   :1.590  
 1st Qu.:1.350   1st Qu.:2.535   1st Qu.:0.925   1st Qu.:2.440  
 Median :1.610   Median :2.900   Median :1.040   Median :2.830  
 Mean   :1.630   Mean   :3.087   Mean   :1.056   Mean   :2.785  
 3rd Qu.:1.885   3rd Qu.:3.400   3rd Qu.:1.205   3rd Qu.:3.160  
 Max.   :3.580   Max.   :6.000   Max.   :1.710   Max.   :3.690  
    proline     
 Min.   :278.0  
 1st Qu.:406.5  
 Median :495.0  
 Mean   :519.5  
 3rd Qu.:625.0  
 Max.   :985.0  
> #Finally we can conclude with class 3
> dim(twowine) #quick check before moving on
[1] 71 14
> threewine<-subset(wine_ds, wine_ds$class == 3)
> summary(threewine)
     class      alcohol        malic_acid         ash        alcalinity_of_ash
 Min.   :3   Min.   :12.20   Min.   :1.240   Min.   :2.100   Min.   :17.50    
 1st Qu.:3   1st Qu.:12.80   1st Qu.:2.587   1st Qu.:2.300   1st Qu.:20.00    
 Median :3   Median :13.16   Median :3.265   Median :2.380   Median :21.00    
 Mean   :3   Mean   :13.15   Mean   :3.334   Mean   :2.437   Mean   :21.42    
 3rd Qu.:3   3rd Qu.:13.51   3rd Qu.:3.958   3rd Qu.:2.603   3rd Qu.:23.00    
 Max.   :3   Max.   :14.34   Max.   :5.650   Max.   :2.860   Max.   :27.00    
   magnesium      total_phenols     flavanoids     nonflavanoid_phenols
 Min.   : 80.00   Min.   :0.980   Min.   :0.3400   Min.   :0.1700      
 1st Qu.: 89.75   1st Qu.:1.407   1st Qu.:0.5800   1st Qu.:0.3975      
 Median : 97.00   Median :1.635   Median :0.6850   Median :0.4700      
 Mean   : 99.31   Mean   :1.679   Mean   :0.7815   Mean   :0.4475      
 3rd Qu.:106.00   3rd Qu.:1.808   3rd Qu.:0.9200   3rd Qu.:0.5300      
 Max.   :123.00   Max.   :2.800   Max.   :1.5700   Max.   :0.6300      
 proanthocyanins color_intensity       hue          OD28O_OD315   
 Min.   :0.550   Min.   : 3.850   Min.   :0.4800   Min.   :1.270  
 1st Qu.:0.855   1st Qu.: 5.438   1st Qu.:0.5875   1st Qu.:1.510  
 Median :1.105   Median : 7.550   Median :0.6650   Median :1.660  
 Mean   :1.154   Mean   : 7.396   Mean   :0.6827   Mean   :1.684  
 3rd Qu.:1.350   3rd Qu.: 9.225   3rd Qu.:0.7525   3rd Qu.:1.820  
 Max.   :2.700   Max.   :13.000   Max.   :0.9600   Max.   :2.470  
    proline     
 Min.   :415.0  
 1st Qu.:545.0  
 Median :627.5  
 Mean   :629.9  
 3rd Qu.:695.0  
 Max.   :880.0  
> dim(threewine)
[1] 48 14
> # 59 + 71 + 48 = 178 instances, and "14" was listed for 13 attributes plus class. this will be further analyzed in project report
> #In order to create an accurate datasets attributes table, we must know the domain (e.g. numeric, int, binary, nominal,etc.)
> str(wine_ds)
'data.frame':   178 obs. of  14 variables:
 $ class               : int  1 1 1 1 1 1 1 1 1 1 ...
 $ alcohol             : num  14.2 13.2 13.2 14.4 13.2 ...
 $ malic_acid          : num  1.71 1.78 2.36 1.95 2.59 1.76 1.87 2.15 1.64 1.35 ...
 $ ash                 : num  2.43 2.14 2.67 2.5 2.87 2.45 2.45 2.61 2.17 2.27 ...
 $ alcalinity_of_ash   : num  15.6 11.2 18.6 16.8 21 15.2 14.6 17.6 14 16 ...
 $ magnesium           : int  127 100 101 113 118 112 96 121 97 98 ...
 $ total_phenols       : num  2.8 2.65 2.8 3.85 2.8 3.27 2.5 2.6 2.8 2.98 ...
 $ flavanoids          : num  3.06 2.76 3.24 3.49 2.69 3.39 2.52 2.51 2.98 3.15 ...
 $ nonflavanoid_phenols: num  0.28 0.26 0.3 0.24 0.39 0.34 0.3 0.31 0.29 0.22 ...
 $ proanthocyanins     : num  2.29 1.28 2.81 2.18 1.82 1.97 1.98 1.25 1.98 1.85 ...
 $ color_intensity     : num  5.64 4.38 5.68 7.8 4.32 6.75 5.25 5.05 5.2 7.22 ...
 $ hue                 : num  1.04 1.05 1.03 0.86 1.04 1.05 1.02 1.06 1.08 1.01 ...
 $ OD28O_OD315         : num  3.92 3.4 3.17 3.45 2.93 2.85 3.58 3.58 2.85 3.55 ...
 $ proline             : int  1065 1050 1185 1480 735 1450 1290 1295 1045 1045 ...
> #It is time to begin the final portion of our KNN analysis: cross-validation and ROC curves
> #Let us start with data pre-processing,then move on to cross-validation
> library(class)
Warning message:
package ëclassí was built under R version 4.1.3 
> library(caret)
Loading required package: ggplot2
Loading required package: lattice
Warning messages:
1: package ëcaretí was built under R version 4.1.3 
2: package ëggplot2í was built under R version 4.1.3 
> install.packages("caret")
Warning: package ëcaretí is in use and will not be installed
> library(caret)
> library(e1071)
Warning message:
package ëe1071í was built under R version 4.1.3 
> library(tidyverse)
Error in library(tidyverse) : there is no package called ëtidyverseí
> 
> #cross validation
> knn.pred=knn(wine[-test,2:14], wine[test,2:14],wine[-test,]$class, k = 1)
Error in as.matrix(train) : object 'wine' not found
>  knn.pred=knn(wine_ds[-test,2:14], wine_ds[test,2:14],wine_ds[-test,]$class, k = 1)
Error in `[.data.frame`(wine_ds, -test, 2:14) : object 'test' not found
> attach(wine_ds)
> test = sample(178,59)#being consistent with the observations found in class (instances)
> knn.pred=knn(wine_ds[-test,2:14], wine_ds[test,2:14],wine_ds[-test,]$class, k = 1)
> table(knn.pred,wine_ds[test,]$class)
        
knn.pred  1  2  3
       1 15  1  4
       2  3 15  4
       3  0  9  8
> mean(knn.pred == wine_ds[test,]$class)
[1] 0.6440678
> #repeating this code process gives us a more accurate estimate, and now we can finally insert results into our project report to begin analysis
> Accuracy = rep(0,50)
> for (m in 1:50){
+ test = sample(178,59)
+  knn.pred=knn(wine_ds[-test,2:14], wine_ds[test,2:14],wine_ds[-test,]$class, k = 1)
+ Accuracy[m] = mean(knn.pred==wine_ds[test,]$class)
+ }
> sum(Accuracy)/50
[1] 0.7294915
> #repeat this from k =2 to k = 7
> for (m in 1:50){
+ test = sample(178,59)
+  knn.pred=knn(wine_ds[-test,2:14], wine_ds[test,2:14],wine_ds[-test,]$class, k =2)
+ Accuracy[m] = mean(knn.pred==wine_ds[test,]$class)
+ }
> sum(Accuracy)/50
[1] 0.7
> for (m in 1:50){
+ test = sample(178,59)
+  knn.pred=knn(wine_ds[-test,2:14], wine_ds[test,2:14],wine_ds[-test,]$class, k = 3)
+ Accuracy[m] = mean(knn.pred==wine_ds[test,]$class)
+ }
> sum(Accuracy)/50
[1] 0.7135593
> for (m in 1:50){
+ test = sample(178,59)
+  knn.pred=knn(wine_ds[-test,2:14], wine_ds[test,2:14],wine_ds[-test,]$class, k = 4)
+ Accuracy[m] = mean(knn.pred==wine_ds[test,]$class)
+ }
> sum(Accuracy)/50
[1] 0.6755932
>  for (m in 1:50){
+ test = sample(178,59)
+  knn.pred=knn(wine_ds[-test,2:14], wine_ds[test,2:14],wine_ds[-test,]$class, k = 5)
+ Accuracy[m] = mean(knn.pred==wine_ds[test,]$class)
+ }
> sum(Accuracy)/50
[1] 0.7016949
>  for (m in 1:50){
+ test = sample(178,59)
+ knn.pred=knn(wine_ds[-test,2:14], wine_ds[test,2:14],wine_ds[-test,]$class, k = 6)
+ Accuracy[m] = mean(knn.pred==wine_ds[test,]$class)
+ }
> sum(Accuracy)/50
[1] 0.7047458
> for (m in 1:50){
+ test = sample(178,59)
+ knn.pred=knn(wine_ds[-test,2:14], wine_ds[test,2:14],wine_ds[-test,]$class, k = 7)
+  Accuracy[m] = mean(knn.pred==wine_ds[test,]$class)
+ }
> sum(Accuracy)/50
[1] 0.6871186
> #Now we can normalize the data so that all characteristrics will have the same range of values, one of the major requirements of the rubric
> for (m in 1:50){
+ test = sample(178,59)
+ knn.pred=knn(scale(wine_ds[-test,2:14]), scale(wine_ds[test,2:14]),wine_ds[-test,]$class, k = 1)
+ Accuracy[m] = mean(knn.pred==wine_ds[test,]$class)
+ }
> sum(Accuracy)/50
[1] 0.9488136
> for (m in 1:50){
+ test = sample(178,59)
+  knn.pred=knn(scale(wine_ds[-test,2:14]), scale(wine_ds[test,2:14]),wine_ds[-test,]$class, k =2)
+ Accuracy[m] = mean(knn.pred==wine_ds[test,]$class)
+ }
> sum(Accuracy)/50
[1] 0.9325424
> for (m in 1:50){
+ test = sample(178,59)
+  knn.pred=knn(scale(wine_ds[-test,2:14]), scale(wine_ds[test,2:14]),wine_ds[-test,]$class, k =3)
+  Accuracy[m] = mean(knn.pred==wine_ds[test,]$class)
+ }
> sum(Accuracy)/50
[1] 0.9437288
> for (m in 1:50){
+ test = sample(178,59)
+ knn.pred=knn(scale(wine_ds[-test,2:14]), scale(wine_ds[test,2:14]),wine_ds[-test,]$class, k =7)
+  Accuracy[m] = mean(knn.pred==wine_ds[test,]$class)
+ }
> sum(Accuracy)/50
[1] 0.9461017
> 
