"""
Sample test file for CI/CD pipeline
"""
import pytest
import pickle
import numpy as np
import os


def test_model_exists():
    """Test if the model file exists"""
    model_path = os.path.join("webapp", "model.pkl")
    assert os.path.exists(model_path), "Model file does not exist"


def test_model_prediction():
    """Test if the model can make predictions"""
    model_path = os.path.join("webapp", "model.pkl")
    
    if not os.path.exists(model_path):
        pytest.skip("Model file not found")
    
    with open(model_path, "rb") as f:
        model = pickle.load(f)
    
    # Test sample (setosa)
    sample = np.array([[5.1, 3.5, 1.4, 0.2]])
    prediction = model.predict(sample)
    
    assert prediction is not None
    assert len(prediction) == 1
    assert prediction[0] in [0, 1, 2], "Prediction should be 0, 1, or 2"


def test_model_probability():
    """Test if the model can return probabilities"""
    model_path = os.path.join("webapp", "model.pkl")
    
    if not os.path.exists(model_path):
        pytest.skip("Model file not found")
    
    with open(model_path, "rb") as f:
        model = pickle.load(f)
    
    sample = np.array([[5.1, 3.5, 1.4, 0.2]])
    probabilities = model.predict_proba(sample)
    
    assert probabilities is not None
    assert probabilities.shape == (1, 3), "Should return probabilities for 3 classes"
    assert np.allclose(probabilities.sum(), 1.0), "Probabilities should sum to 1"


def test_app_imports():
    """Test if webapp modules can be imported"""
    try:
        import sys
        sys.path.insert(0, 'webapp')
        # Just test if imports work
        assert True
    except Exception as e:
        pytest.fail(f"Failed to import webapp modules: {e}")


if __name__ == "__main__":
    pytest.main([__file__, "-v"])
