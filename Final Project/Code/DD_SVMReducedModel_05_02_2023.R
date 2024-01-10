library(e1071)
library(caret)
library(kernlab)


df= read.csv("C:/Users/ddinh/OneDrive/Documents/EXST 7087/Final Project/Data/DD_ReducedCleanCompetitiveCareer_05_01_2023.csv")

# Split the data into training and testing sets
set.seed(123)  # Set a seed for reproducibility
train_indices <- sample(nrow(df), nrow(df) * 0.8)  # 70% for training
train_data <- df[train_indices, ]
test_data <- df[-train_indices, ]

# Train the SVM model with all columns except the first as predictors
svm_model <- svm(Results ~ ., data = train_data, type = "C-classification", kernel = "linear")

# Make predictions on the test data
svm_pred <- predict(svm_model, newdata = test_data)

# Evaluate the SVM model
accuracy <- sum(svm_pred == test_data$Results) / length(svm_pred)
print(paste("Accuracy:", accuracy))


# Perform cross-validation
svm_cv <- train(Results ~ ., data = df, method = "svmLinear", trControl = trainControl(method = "cv", number = 5))

# View the cross-validated results
print(svm_cv)

# Lower RMSE values indicate better model performance, as it means the model's predictions are closer to the actual values on average.


# Confusion matrix after cross validating
test_data[, 1] <- factor(test_data[, 1], levels = levels(svm_pred))

# Create the confusion matrix
con_mat <- confusionMatrix(svm_pred, test_data[, 1])

# Print the confusion matrix
print(con_mat)