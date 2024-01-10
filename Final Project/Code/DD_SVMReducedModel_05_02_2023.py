# -*- coding: utf-8 -*-
"""
Created on Sun May  7 16:23:18 2023

@author: ddinh
"""

#%%===== Load Appropriate Libraries ===============================================================================
import pandas as pd  
#import numpy as np 
#import os
#import matplotlib.pyplot as plt  
from sklearn.model_selection import train_test_split  
from sklearn.svm import SVC  
from sklearn.metrics import classification_report, confusion_matrix  
#from sklearn.model_selection import StratifiedShuffleSplit
#from sklearn.model_selection import GridSearchCV
from sklearn.model_selection import cross_val_score, cross_val_predict
#from sklearn.model_selection import KFold
#%%===== Loading data pre-processing and re arranging   ===========================================================
df1 = pd.read_csv("C:/Users/ddinh/OneDrive/Documents/EXST 7087/Final Project/Data/DD_ReducedCleanCompetitiveCareer_05_01_2023.csv")

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
