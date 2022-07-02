from db import db
from flask import Flask
import json
import os
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
@app.route("/")
def apptest():
    db.updateExchangeRates()
    db.updateNewsArticles()
    db.updateMonthlyPriceData()
    timesUpdatedString = "The rates have been updated this many times: " + str(db.timesUpdated)
    return timesUpdatedString

@app.route("/data")
def getExchangeRates():
    db.updateExchangeRates()
    return success_response(db.exchangeRatesResponse.json())

@app.route("/previousData")
def getPreviousExchangeRates():
    db.updateExchangeRates()
    return success_response(db.previousExchangeRatesResponses[0].json())

@app.route("/news")
def getCryptoArticles():
    db.updateNewsArticles()
    return success_response(db.cryptoArticlesResponse.json())

@app.route("/calls")
def callsRemaining():
    url = 'https://www.coinapi.io/api/subscriptions/usage/rest/history'
    headers = {'X-CoinAPI-Key' : '2538BC37-2458-49AC-82A8-772B98788B29'}
    call = requests.get(url, headers=headers)
    return success_response(call.json())

@app.route("/monthly/<int:coin>")
def monthlyData(coin):
    db.updateMonthlyPriceData()
    return success_response(db.monthlyPriceResponse[coin].json())

@app.route("/update")
def updateAll():
    db.updateExchangeRates()
    db.updateNewsArticles()
    db.updateMonthlyPriceData()
    outputString = "All routes have been updated"
    return outputString


if __name__ == "__main__":
    port = os.environ.get("PORT", 4000)
    app.run(host="0.0.0.0", port= port)