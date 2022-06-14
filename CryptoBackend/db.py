from urllib import response
from flask import Flask
import json
import requests
import time
from flask import request
class db:
    response = requests.get("https://rest.coinapi.io/v1/exchangerate/USD?apikey=2538BC37-2458-49AC-82A8-772B98788B29&invert=true")
    currentTime = time.time()

    def updateVariables():
        if db.currentTime <= time.time() - 1800:
            db.response = requests.get("https://rest.coinapi.io/v1/exchangerate/USD?apikey=2538BC37-2458-49AC-82A8-772B98788B29&invert=true")
            db.currentTime = time.time()