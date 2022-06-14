from db import db
from flask import Flask
import json
import requests
import time
from flask import request

app = Flask(__name__)

# generalized response formats
def success_response(data, code=200):
    return json.dumps(data), code


def failure_response(message, code=404):
    return json.dumps({"error": message}), code

# your routes here
@app.route("/hi")
def apptest():
    return str(db.currentTime <= time.time() - 60)

@app.route("/data")
def test():
    # if currentTime <= time.time() - 60:
    db.updateVariables()
    return success_response(db.response.json())

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=4000, debug=True)


