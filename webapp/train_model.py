"""
Script to train and save the Iris classification model
"""
from sklearn.datasets import load_iris
from sklearn.ensemble import RandomForestClassifier
import pickle

# Load the iris dataset
iris = load_iris()
X, y = iris.data, iris.target

# Train a simple Random Forest model
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X, y)

# Save the model
with open("model.pkl", "wb") as f:
    pickle.dump(model, f)

print("Model trained and saved as model.pkl")
print(f"Model accuracy on training data: {model.score(X, y):.2%}")
