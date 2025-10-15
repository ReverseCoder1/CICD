from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
import os

app = Flask(__name__)

# Database (SQLite for demo, could be Postgres/MySQL in real use)
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_DIR = os.path.join(BASE_DIR, "data")
os.makedirs(DATA_DIR, exist_ok=True)

db_path = os.path.join(DATA_DIR, "iris.db")
db_uri = f"sqlite:///{db_path.replace(os.sep, '/')}"
app.config['SQLALCHEMY_DATABASE_URI'] = db_uri
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

class Iris(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    sl = db.Column(db.Float)
    sw = db.Column(db.Float)
    pl = db.Column(db.Float)
    pw = db.Column(db.Float)
    prediction = db.Column(db.String(50))

@app.route('/records', methods=['GET'])
def get_records():
    data = Iris.query.all()
    return jsonify([{
        "id": r.id,
        "sl": r.sl,
        "sw": r.sw,
        "pl": r.pl,
        "pw": r.pw,
        "prediction": r.prediction
    } for r in data])

@app.route('/records', methods=['POST'])
def add_record():
    data = request.json
    record = Iris(
        sl=data['sl'], sw=data['sw'],
        pl=data['pl'], pw=data['pw'],
        prediction=data['prediction']
    )
    db.session.add(record)
    db.session.commit()
    return jsonify({"message": "Record added"}), 201

if __name__ == "__main__":
    with app.app_context():
        db.create_all()
    app.run(host="0.0.0.0", port=5001)
