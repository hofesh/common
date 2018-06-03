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


########## python basics ##############
[f(x) for x in arr] # map on array
itertools.permutations(arr, r=2) # all permuations of length=2, including different ordering, e.g. (1, 2) and (2, 1)
itertools.combinations(arr, r=2) # all combinations of length=2, without repetition of order, e.g. only (1, 2)
map(func, arr) # map, python 2
list(map(func, arr)) # map, python 3

# random
random.randint(0, 10)
random.sample(arr, n) # sample n elements of array 

# groupby
for device_id, device_records in groupby(records, lambda r: r.device_id):
    pass

# shuffle
random.shuffle(array)


# parallel
# https://wltrimbl.github.io/2014-06-10-spelman/intermediate/python/04-multiprocessing.html
import multiprocessing
pool = multiprocessing.Pool( args.numProcessors )
results = [pool.apply_async( plotData, t ) for t in tasks]
for result in results:
    print(result.get())
#https://docs.python.org/dev/library/concurrent.futures.html#processpoolexecutor-example
import concurrent.futures
PRIMES = range(1, 100)
with concurrent.futures.ProcessPoolExecutor() as executor:
    for number, prime in zip(PRIMES, executor.map(is_prime, PRIMES)):
        print('%d is prime: %s' % (number, prime))

################ numpy ###################

# numpy access different column in each row by index
x = np.array([[1, 2, 3], [6, 5, 4]])
i = x.argsort()
x[range(len(x)), i[:, -1]] # get max values of each row by index

# data generation
np.ones(10)
np.zeros(10)

# 

################ pandas ##################

# explorations
df.describe()

# loading data
df = pd.read_csv("file", sep='\t', header=None, nrows=1000) # loader header-less TSV | 1000 rows
df.columns = ["n", "feature", "type"] # set header names
df.set_index("feature", inplace=True) # set index

# missing values
df = df.replace("None", np.nan) # remove fixed string missing values
df = df.replace("_null$", np.nan, regex=True) # remove based on regex

# convert types
df[f] = df[f].astype(float)

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
# sub-data by index
sdf = df.loc[key] # this sometimes returns a Series (single key match) and sometimes a DataFrame (multilpe key matches)
sdf = df[df.index==key] # this always returns a series


# drop columns
df = df[df.columns.drop(list(df.filter(like=f)))] # drop list of columns
df = df.drop(columns=["A", "B"])

# drop rows
df = df[np.isfinite(df[target_label])] # drop rows without labels
df = df[pd.notnull(df[new_target_label_str])]


# one-hot
df = pd.get_dummies(df, columns=to_onehot) # this is one directional, and cannot be used to unexpected new values in test time

# extract X,y
y = df[target_label] # select target feature
X = df[df.columns.drop(list(df.filter(regex='_label$')))] # remove all "target" labels from features data
X = X.as_matrix() # needed for subsampling

# subsampling (utils methods)
X, y      = balanced_subsample   (X, y, random_state=random_state)
X, y, idx = balanced_sample_maker(X, y, random_state=random_state, sample_size=10)

# columns difference
uniq = df1.columns.difference(df2.columns)

# transform - we apply a function that transforms the values of all cells, without changing the shape (like calc a zscor)
df.transform(lambda x: (x - x.mean()) / x.std())

# groupby
gby = df.groupby("user_gender")
for key, group in gby:
    print(key)
    print(group["click_probability"].mean())

gby["click_probability"].mean()

############ scikit ###############
# train/test split
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=random_state)

# grid search
from sklearn.model_selection import GridSearchCV
from sklearn.metrics import classification_report
cv = GridSearchCV(model, param_grid={'A': [1, 3, 4], 'B': ['1'], 'C': range(20)}, scoring='neg_log_loss', n_jobs=4, cv=3, verbose=2)
cv.fit(X_train, y_train)
# best params/model
print('Best parameters:', cv.best_params_)
best_model = validator.best_estimator_
# Grid scores on development set
means = clf.cv_results_['mean_test_score']
stds = clf.cv_results_['std_test_score']
for mean, std, params in zip(means, stds, clf.cv_results_['params']):
    print("%0.3f (+/-%0.03f) for %r" % (mean, std * 2, params))
# classification_report
y_true, y_pred = y_test, clf.predict(X_test)
print(classification_report(y_true, y_pred))


############ Keras  ##########

# notes
# - Keras works only with numpy data, not pandas data (as scikit)
# - don't forget to normalize data (zero mean and unit variance)
# - We can interop with scikit using KerasClassifier / KerasRegressor: https://keras.io/scikit-learn-api/

# onehot encoding
y_train = keras.utils.to_categorical(y_train, num_classes)


############# matplotlib #############

import matplotlib.pyplot as plt
%matplotlib inline 

plt.twinx() # make a new axes that shares the "X" axis, but with a new "Y" axis