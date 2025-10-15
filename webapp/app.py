from flask import Flask, render_template, request, redirect, url_for
import requests
import pickle
import numpy as np
import os

app = Flask(__name__)

# Load ML model
MODEL_PATH = os.path.join(os.path.dirname(__file__), "model.pkl")
with open(MODEL_PATH, "rb") as f:
    model = pickle.load(f)

DB_APP_URL = os.getenv("DB_APP_URL", "http://db_app:5001")  # Docker service name for db_app

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        sl = float(request.form['sl'])
        sw = float(request.form['sw'])
        pl = float(request.form['pl'])
        pw = float(request.form['pw'])
        features = np.array([sl, sw, pl, pw]).reshape(1, -1)
        prediction = int(model.predict(features)[0])

        # Call db_app to store record
        try:
            requests.post(f"{DB_APP_URL}/records", json={
                "sl": sl, "sw": sw, "pl": pl, "pw": pw,
                "prediction": str(prediction)
            })
        except Exception as e:
            print(f"Error saving to database: {e}")
        
        return redirect(url_for('records'))
    return render_template('index.html')

@app.route('/records')
def records():
    try:
        resp = requests.get(f"{DB_APP_URL}/records")
        data = resp.json()
    except Exception as e:
        print(f"Error fetching records: {e}")
        data = []
    return render_template('display_records.html', data=data)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
