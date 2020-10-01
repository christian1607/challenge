import os
import random
from flask import Flask,jsonify

HOSTNAME = os.getenv('HOSTNAME')

app = Flask(__name__)

@app.route('/')
def index():
    return "Welcome to Pythom app"

@app.route('/greetings', methods=['GET'])
def greetings():
    return "Hello World from " + HOSTNAME

@app.route('/square', methods=['GET'])
def square():
    value = random.randint(2, 9)
    return jsonify({'resp': 'number: ' + str(value) + ', square: ' + str(pow(value,2))})

if __name__ == "__main__":
    app.run(host='0.0.0.0')
