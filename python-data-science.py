import numpy as np

# arguments
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--a', required=True)
parser.add_argument('--b', required=False, default=10, type=int)
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