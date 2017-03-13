# run_analysis.R - description

### Description of the algorithm:

1. Activities and features
	1. Loading from files
	2. Convert 2nd column to characters
	3. Subsetting the data (only meands and std devs)
	4. Some prettyfying
2. Datasets
	1. Loading datasets, activities and features for training
	2. Loading datasets, activities and features for testing
	3. Merging the input from the 3 files into 1 via cbind (so adding the columns to the right of the file) - both for train and test
	4. Merge the train and test files
	5. Factorize variables
	6. "Transpose" it using the reshape2 package. "Melt" in R-speak
	7. Get the means in there
3. Export
	1. Write dataset to txt file