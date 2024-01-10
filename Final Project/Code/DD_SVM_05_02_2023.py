# -*- coding: utf-8 -*-
"""
Created on Sat May  6 13:05:17 2023

@author: ddinh
"""

#%%===== Load Appropriate Libraries ===============================================================================
import pandas as pd  
import numpy as np 
#import os
#import matplotlib.pyplot as plt  
from sklearn.model_selection import train_test_split  
from sklearn.svm import SVC  
from sklearn.metrics import classification_report, confusion_matrix  
from sklearn.model_selection import StratifiedShuffleSplit
from sklearn.model_selection import GridSearchCV
from sklearn.model_selection import cross_val_score, cross_val_predict
#from sklearn.model_selection import KFold
#%%===== Loading data pre-processing and re arranging   ===========================================================
df1 = pd.read_csv("C:/Users/ddinh/OneDrive/Documents/EXST 7087/Final Project/Data/DD_CleanCompetitiveCareer_05_01_2023.csv")

X = df1.drop('Results', axis=1)  
y = df1['Results'] 

#%%===============Using Linear Kernel ===============================================================
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.20)  
svclassifier = SVC(kernel='linear')  
svclassifier.fit(X_train, y_train)

y_pred = svclassifier.predict(X_test)  
print(y_pred)
print(confusion_matrix(y_test,y_pred))  
print(classification_report(y_test,y_pred))  

#%%===================================== Using a gamma kernel ===========================================

C_range = np.logspace(-3, 10, 3)
gamma_range = np.logspace(-2, 3, 2)
param_grid = dict(gamma=gamma_range, C=C_range)
cv = StratifiedShuffleSplit(n_splits=5, test_size=0.2, random_state=42)
grid = GridSearchCV(SVC(), param_grid=param_grid, cv=cv)
grid.fit(X_train, y_train)
print("The best parameters are %s with a score of %0.2f"
      % (grid.best_params_, grid.best_score_))

svclassifier2 = SVC(C=3162.2776601683795,gamma=0.01)  
svclassifier2.fit(X_train, y_train) 
y_pred = svclassifier2.predict(X_test)  
print(confusion_matrix(y_test,y_pred))  
print(classification_report(y_test,y_pred)) 

# Using the linear kernel provided better accuracy than the gamma bc the relationship between the response and predictor variables are more linear

#%%========================= Cross Validating =====================================================
cross_val_scores = cross_val_score(svclassifier, X_train, y_train, cv=5)


# View the cross-validated scores
print("Cross-Validated Accuracy Scores:", cross_val_scores)
print("Mean Accuracy:", cross_val_scores.mean())

# Get cross-validated predictions
cross_val_predictions = cross_val_predict(svclassifier, X_train, y_train, cv=5)

# Calculate the confusion matrix
conf_mat = confusion_matrix(y_train, cross_val_predictions)

# Print the confusion matrix
print("Confusion Matrix:", conf_mat)
