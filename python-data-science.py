import numpy as np
import pandas as pd

# arguments
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--a', required=True)
parser.add_argument('--b', required=False, default=10, type=int)
args = parser.parse_args()


# serialization
import joblib
data = joblib.load('file')
joblib.dump(data, 'file')

df = pd.read_csv('file', sep='\t', header=None)


# printing
import sys
from __future__ import print_function # for python2
def log(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)
log("data", data)
print("data", data)

pd.set_option('display.max_rows', 1000)


# sub sampling
np_arr = np.random.choice(np_arr, int(len(np_arr) * 0.1), replace=False) # sample 10% without replacement
np_matrix = np_matrix[indices]


# preprocessing
# http://scikit-learn.org/stable/modules/preprocessing.html
# http://www.bogotobogo.com/python/scikit-learn/scikit_machine_learning_Data_Preprocessing-Missing-Data-Categorical-Data.php
StandardScaler  

# OneHot encoding
# https://stackoverflow.com/questions/30071918/classification-with-sk-learn-handle-missing-categorical-features-at-prediction
pd.get_dummies
OneHotEncoder


# python basics
[f(x) for x in arr] # map on array
itertools.permutations(arr, r=2) # all permuations of length=2, including different ordering, e.g. (1, 2) and (2, 1)
itertools.combinations(arr, r=2) # all combinations of length=2, without repetition of order, e.g. only (1, 2)
map(func, arr) # map, python 2
list(map(func, arr)) # map, python 3
random.sample(arr, n) # sample n elements of array 

# numpy

# data generation
np.ones(10)
np.zeros(10)


# pandas

# loading data
df = pd.read_csv("file", sep='\t', header=None) # loader header-less TSV
df.columns = ["n", "feature", "type"] # set header names
df.set_index("feature", inplace=True) # set index
# sorting
df.sort_values(by="A", axis=0, inplace=True, ascending=False)
# formatting options
pd.set_option('display.max_rows', 1000)
pd.set_option('max_colwidth', 800)
pd.set_option('display.width', 1000)
# selecting
df.head(10) # first 10 rows
df["A"] # select column A
df.loc[(df.index.str.startswith(value)) | (df.index == value), "A"] # col A where index startswith/equals value
